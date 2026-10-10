# DEMARCHE_ENCAD3 — Case Study 2: Cancer Registry — Reproducible Snapshot

## Scope
This package is a cleaned reproducible snapshot of the supplied Cancer Registry project. It preserves validated artefacts through integrated diagnosis (Step 22) and the executed Step 23A feature/missingness characterization. It does **not** invent or complete later action-evaluation steps that were not present in the supplied project.

## Main notebook
`DEMARCHE_ENCAD3_CASE2_CANCER_REPRODUCIBLE.ipynb`

The notebook now uses a portable project-root resolver. Run it from the extracted project directory (or its parent).

## Cleaning performed
- Removed empty `Untitled.ipynb` and `.ipynb_checkpoints`.
- Removed duplicate ZIP archives when the corresponding extracted result directory was already present.
- Removed local OpenAI API installation/test cells and the cell containing a plaintext API key.
- Removed the redundant documentary-rule execution cell that duplicated logic already integrated in Step 22.
- Converted external LLM prompt-only steps to Markdown provenance notes; their frozen artefacts remain under `results/02_knowledge/`.
- Replaced user-specific absolute Windows paths with a portable bootstrap.
- Preserved raw official documents, frozen knowledge bases, reference model/results, diagnosis outputs, and Step 23A outputs.

## Important reproducibility boundary
Some semantic knowledge-extraction steps were performed externally with an LLM. The package preserves their prepared inputs, outputs, tables, and metadata, but exact regeneration requires the same external model/service and is not automatically executed.

## Structure
- `data/`: reference data, dictionary, and simulation script.
- `hidden_reference/`: source metadata used by the early controlled semantic-dictionary stage; later steps explicitly restrict its use.
- `knowledge/documents/`: authoritative documentary corpus and extracted chunks.
- `knowledge/knowledge_base/`: frozen documentary/statistical KBs and rule bases.
- `models/`: frozen reference model.
- `results/01_reference/`: reference audit/model/SHAP.
- `results/02_knowledge/`: documentary/statistical knowledge construction and frozen LLM-assisted artefacts.
- `results/03_diagnosis/`: integrated diagnosis.
- `results/04_action_evaluation/`: only the supplied/executed Step 23A characterization.

## Security note
The original uploaded notebook contained a plaintext OpenAI API key. It has been removed from this reproducible copy. The original key should be revoked/rotated by its owner.

## Integrity
See `PROJECT_MANIFEST_SHA256.csv` for file-level SHA-256 hashes.
