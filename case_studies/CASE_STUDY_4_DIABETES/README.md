# DEMARCHE_ENCAD3 — Case Study 4 Diabetes — Reproducible Release

## Scope
This release contains the filtered, definitive artifacts for the Diabetes case study. It removes superseded code/results and aligns the project with the final methodology used in the article.

## Final methodological policy
- Dataset_REF: upstream controlled-corruption reference only.
- Dataset_DQ: observable baseline for action evaluation.
- Candidate actions: DOC exclusion, MEDIAN, KNN, ITERATIVE.
- Evaluation: predictive performance + SHAP shift + SHAP stability + operational coverage + TreeSHAP additivity gate.
- Fuzzy layer: linguistic presentation only; no global score, no ranking, no recommendation.
- STEP 19: KB_EXPERIENCE stores experimental evidence.
- Similarity mechanism: abandoned and removed.
- Human decision / validation: post-experimental conceptual step, not automated.
- Reuse: only for the same human-validated DQ configuration and operational context; unseen configurations require ABSTAIN/ESCALATE.

## Main notebook
`DEMARCHE_ENCAD3_CASE4.ipynb`

The notebook uses a portable project root based on the current working directory. Open Jupyter in this project directory and run the notebook in order.

## LLM-assisted stages
STEP 06B and STEP 06C are not ordinary deterministic Python computations. Frozen prompts, schemas, 395-chunk inputs, LLM-A outputs, LLM-B validation outputs, and audits are included. For downstream reproducibility, use the included validated outputs.

## Removed as obsolete or redundant
- `.ipynb_checkpoints/`
- all nested ZIP duplicates
- obsolete `step10_predictive_evaluation` (replaced by corrected definitive STEP10)
- obsolete fuzzy global rule-base branch (`results/15_fuzzy_rule_base`)
- superseded STEP15 explanation branch (`results/15_fuzzy_explanations`, replaced by STEP15B)
- `KB_EXPERIENCE_SIMILARITY_PROFILE.json` and notebook similarity mechanism references
- duplicate `Model_ACTIONS/Model_REF`
- duplicate/obsolete notebook cells for earlier STEP10, STEP12, STEP12B, STEP15, and STEP17 drafts

## Canonical final outputs
- `results/17_final_test_evaluation/` — sealed TEST numerical evaluation
- `results/18_final_fuzzy_explanation/` — frozen linguistic interpretation and final figures
- `knowledge/knowledge_base/KB_EXPERIENCE/` — final experimental experience record
- `knowledge/rules/action_rules/` — traceable DQ action rules

## Reproducibility boundary
This package supports computational reproduction of the frozen experiment from the included data and validated documentary outputs. It does not claim deterministic regeneration of LLM semantic judgments without the same external LLM execution environment.
