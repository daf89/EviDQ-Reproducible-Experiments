# EviDQ — Case Study 2: Cancer Registry

## Scientific scope and conclusion
This case documents reference-data assessment, reference modeling, documentary/statistical knowledge construction and integrated diagnosis.

**Recorded scope:** the deposited evidence reaches integrated diagnosis (**Step 22**) and the executed **Step 23A** feature/missingness characterization. The existence of an action-evaluation directory does **not** establish that later action evaluations were completed.

## Experimental notebook
[Case2_Cancer.ipynb](Case2_Cancer.ipynb) preserves the published experimental notebook and its saved outputs. Saved outputs support traceability, not proof of independent reproduction.

## Evidence map
- `data/`: reference data, dictionary and simulation-related resources.
- `hidden_reference/`: source metadata for the controlled semantic-dictionary stage, not authorized for unrestricted use in later steps.
- `knowledge/documents/`: documentary corpus and extracted material.
- `knowledge/knowledge_base/`: documentary/statistical knowledge and rule artifacts.
- `models/`: reference model artifacts.
- `results/01_reference/`: reference audit, model and SHAP evidence.
- `results/02_knowledge/`: knowledge construction and frozen LLM-assisted evidence.
- `results/03_diagnosis/`: integrated diagnosis.
- `results/04_action_evaluation/`: recorded Step 23A characterization only.
- `requirements.txt`: study-specific dependencies.

## External LLM stages
Certain semantic extraction and validation tasks were carried out externally with an LLM. Preserved prompts, inputs, outputs and metadata enable provenance review where present. Exact regeneration requires compatible external model/service settings and is not an ordinary deterministic notebook run.

## Security and reproducibility
A plaintext API credential in an earlier notebook version was removed; the credential was revoked. Do not commit secrets. Verify any manifest hashes against the files actually deposited.

Inspect notebook outputs and compare them with the relevant artifacts. Reconstruct dependencies using `requirements.txt` and review local path assumptions before rerunning. Do not infer unexecuted later stages from directory names.

This README describes the deposited experimental snapshot, not a new independent execution.
