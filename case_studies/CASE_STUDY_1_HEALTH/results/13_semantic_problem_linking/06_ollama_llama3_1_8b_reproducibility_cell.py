# DEMARCHE_ENCAD3 — PHASE 3 / STEP 02
# Local reproducibility trace with Ollama llama3.1:8b.
# IMPORTANT: this is an equivalent local semantic-review protocol.
# It does not imply that Ollama produced the GPT-5.6 Sol result files delivered separately.

from pathlib import Path
import pandas as pd, json, requests, time

PROJECT_ROOT = Path(r"<LOCAL_PROJECT_ROOT>")
INPUT_DIR = PROJECT_ROOT / "results" / "12_problem_scenario_inventory"
OUTPUT_DIR = PROJECT_ROOT / "results" / "13_semantic_problem_linking_ollama"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

MODEL = "llama3.1:8b"
OLLAMA_URL = "http://localhost:11434/api/generate"
TEMPERATURE = 0
SEED = 42
TIMEOUT = 300
MAX_RETRIES = 3

ERR = pd.read_csv(INPUT_DIR / "02_documented_error_candidates.csv")
DET = pd.read_csv(INPUT_DIR / "03_documented_detection_candidates.csv")
COR = pd.read_csv(INPUT_DIR / "04_documented_correction_candidates.csv")

KEYS = ["knowledge","evidence","document_name","page_start","page_end"]
def dedup(df,prefix):
    x=df.drop_duplicates(KEYS).copy().reset_index(drop=True)
    x["family_id"]=[f"{prefix}_{i:02d}" for i in range(1,len(x)+1)]
    return x

ERR=dedup(ERR,"ERR_FAM")
DET=dedup(DET,"DET_FAM")
COR=dedup(COR,"COR_FAM")

# Candidate triples are restricted to documentary families that share at least
# one feature in Step01. This is only a structural candidate generator; the
# LLM must still decide semantic compatibility.
err_features = {
    r.family_id:set(pd.read_csv(INPUT_DIR/"02_documented_error_candidates.csv")
                    .loc[lambda z: z["knowledge"].eq(r.knowledge),"feature"])
    for _,r in ERR.iterrows()
}
det_features = {
    r.family_id:set(pd.read_csv(INPUT_DIR/"03_documented_detection_candidates.csv")
                    .loc[lambda z: z["knowledge"].eq(r.knowledge),"feature"])
    for _,r in DET.iterrows()
}
cor_features = {
    r.family_id:set(pd.read_csv(INPUT_DIR/"04_documented_correction_candidates.csv")
                    .loc[lambda z: z["knowledge"].eq(r.knowledge),"feature"])
    for _,r in COR.iterrows()
}

candidates=[]
for _,e in ERR.iterrows():
    for _,d in DET.iterrows():
        common_ed=err_features[e.family_id] & det_features[d.family_id]
        if not common_ed: continue
        for _,c in COR.iterrows():
            common=common_ed & cor_features[c.family_id]
            if not common: continue
            candidates.append({
                "error_family_id":e.family_id,
                "detection_family_id":d.family_id,
                "correction_family_id":c.family_id,
                "common_features":";".join(sorted(common)),
                "error_knowledge":e.knowledge,
                "error_evidence":e.evidence,
                "error_document":e.document_name,
                "error_pages":f"{e.page_start}-{e.page_end}",
                "detection_knowledge":d.knowledge,
                "detection_evidence":d.evidence,
                "detection_document":d.document_name,
                "detection_pages":f"{d.page_start}-{d.page_end}",
                "correction_knowledge":c.knowledge,
                "correction_evidence":c.evidence,
                "correction_document":c.document_name,
                "correction_pages":f"{c.page_start}-{c.page_end}",
            })

candidates=pd.DataFrame(candidates)
print("Candidate triples:",len(candidates))

SYSTEM = """You are LLM-C, a strict semantic linker for DEMARCHE_ENCAD3.
Use ONLY the supplied documentary text. No external knowledge.

Task: decide whether ERROR, DETECTION and CORRECTION form one coherent
documentary problem chain.

SUPPORTED_CHAIN only if:
1. ERROR explicitly describes the same underlying problem identified by DETECTION;
2. CORRECTION explicitly addresses that same underlying problem;
3. there is no construct mismatch;
4. mere same feature, same broad topic, same document, or generic missingness is insufficient.

If the documentary chain is coherent but does not directly correspond to the
aggregated dataset feature named in common_features, use
SUPPORTED_CHAIN_BUT_CONSTRUCT_MISMATCH.

Otherwise use NOT_SUPPORTED.

Do NOT decide that a statistical anomaly is an error.
Do NOT invent a detection, correction, threshold, or numerical corruption.
Do NOT select a final experimental scenario.

Return strict JSON only:
{
 "semantic_status":"SUPPORTED_CHAIN|SUPPORTED_CHAIN_BUT_CONSTRUCT_MISMATCH|NOT_SUPPORTED",
 "same_problem":true,
 "construct_match":true,
 "semantic_rationale":"short evidence-grounded explanation",
 "feature_level_injection_ready":false,
 "injection_limitation":"short explanation"
}
"""

def call_ollama(row):
    user = f"""COMMON FEATURES:
{row.common_features}

ERROR:
Knowledge: {row.error_knowledge}
Evidence: {row.error_evidence}
Source: {row.error_document}, pages {row.error_pages}

DETECTION:
Knowledge: {row.detection_knowledge}
Evidence: {row.detection_evidence}
Source: {row.detection_document}, pages {row.detection_pages}

CORRECTION:
Knowledge: {row.correction_knowledge}
Evidence: {row.correction_evidence}
Source: {row.correction_document}, pages {row.correction_pages}
"""
    payload={
        "model":MODEL,
        "prompt":SYSTEM+"\n\n"+user,
        "stream":False,
        "format":"json",
        "options":{"temperature":TEMPERATURE,"seed":SEED}
    }
    last=None
    for attempt in range(MAX_RETRIES):
        try:
            r=requests.post(OLLAMA_URL,json=payload,timeout=TIMEOUT)
            r.raise_for_status()
            obj=json.loads(r.json()["response"])
            if obj.get("semantic_status") not in {
                "SUPPORTED_CHAIN",
                "SUPPORTED_CHAIN_BUT_CONSTRUCT_MISMATCH",
                "NOT_SUPPORTED"
            }:
                raise ValueError("Invalid semantic_status")
            return obj
        except Exception as ex:
            last=ex
            time.sleep(2*(attempt+1))
    raise RuntimeError(last)

resume_path=OUTPUT_DIR/"01_llm_semantic_triple_results.jsonl"
done={}
if resume_path.exists():
    for line in resume_path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            x=json.loads(line)
            done[x["triple_id"]]=x

results=[]
for i,row in candidates.iterrows():
    triple_id=f"TRIPLE_{i+1:05d}"
    if triple_id in done:
        results.append(done[triple_id]); continue
    decision=call_ollama(row)
    rec={"triple_id":triple_id,**row.to_dict(),**decision}
    with resume_path.open("a",encoding="utf-8") as f:
        f.write(json.dumps(rec,ensure_ascii=False)+"\n")
    results.append(rec)
    if (i+1)%25==0: print("Processed",i+1,"/",len(candidates))

results=pd.DataFrame(results)
results.to_csv(OUTPUT_DIR/"02_all_semantic_triple_results.csv",index=False,encoding="utf-8-sig")
results[results.semantic_status.ne("NOT_SUPPORTED")].to_csv(
    OUTPUT_DIR/"03_supported_semantic_chains.csv",index=False,encoding="utf-8-sig")
results[results.semantic_status.eq("NOT_SUPPORTED")].to_csv(
    OUTPUT_DIR/"04_not_supported_semantic_triples.csv",index=False,encoding="utf-8-sig")

meta={
 "model":MODEL,"temperature":TEMPERATURE,"seed":SEED,
 "candidate_triples":len(candidates),
 "supported":int(results.semantic_status.ne("NOT_SUPPORTED").sum()),
 "scenario_selected":False,"problem_injected":False,
 "external_knowledge_used":False
}
(OUTPUT_DIR/"05_metadata.json").write_text(json.dumps(meta,indent=2),encoding="utf-8")
print(json.dumps(meta,indent=2))
print("Saved in:",OUTPUT_DIR)
