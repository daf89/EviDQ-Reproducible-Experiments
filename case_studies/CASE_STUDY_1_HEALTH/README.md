# CASE_STUDY_1_HEALTH_REPRODUCIBLE

Filtered reproducibility archive for DEMARCHE_ENCAD3 — Case Study 1 (Health).

## Scientific status
The case study uses the received health dataset without artificial corruption. Statistical observations are treated as observations, not automatically as errors. Documentary/statistical knowledge was constructed and semantically linked. The natural-problem diagnostic branch did **not establish the observed signals as correctable data-quality errors**; the study therefore ends in responsible **ABSTAIN / NO ACTION**, with no fabricated correction dataset.

## Canonical notebook
`DEMARCHE_ENCAD3_CASE1_HEALTH_REPRODUCIBLE.ipynb`

Run the notebook from this project root. Personal absolute Windows paths were replaced by `Path.cwd()`.

## Canonical structure
- `data/clean/`: frozen received/reference data and dictionary.
- `knowledge/documents/official/`: documentary sources.
- `knowledge/documents/extracted/`: extracted page text used to build the corpus.
- `models/`: frozen reference model and preprocessor.
- `results/01_...` through `results/14_...`: retained final experimental artifacts.
- `results/article_figures_case_study_1/`: publication figures.

## Important LLM reproducibility note
Some semantic steps were executed in an external ChatGPT/LLM workflow or have an optional local Ollama reproduction protocol. The frozen inputs, prompts, validated outputs, metadata, and audit artifacts are retained. Re-running a generative model may not reproduce byte-identical semantic outputs unless the same model/runtime is available.

## Removed as non-canonical
- `.ipynb_checkpoints/`
- redundant `.zip`/`.rar` archives of already extracted result folders
- incomplete local STEP07 partial-output folder
- duplicated per-feature LLM package files (the canonical exhaustive feature-block pair files are retained)
- notebook installation/debug/inspection cells and obsolete figure-generation cells superseded by the final corrected figure artifacts

## Folder normalization
- `DEMARCHE_ENCAD3_STEP07_LLM_A_RESULTS` → `results/07_llma_semantic_filtering_results`
- `10B_document_statistical_semantic_alignment` → `results/10A_document_statistical_alignment`

## Integrity
See `PROJECT_MANIFEST_SHA256.csv`.

## Notebook syntax check
Python cells with syntax errors: none.
