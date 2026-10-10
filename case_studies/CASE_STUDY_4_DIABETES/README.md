# EviDQ — Case Study 4: Diabetes

## Scientific scope
This controlled experiment evaluates data-quality actions and their effects on predictive behavior and explanation reliability. `Dataset_REF` is the upstream controlled-corruption reference; `Dataset_DQ` is the observable baseline for action evaluation.

## Experimental notebook
[Case4_Diabete.ipynb](Case4_Diabete.ipynb) preserves the experimental notebook with saved outputs. These outputs support scientific provenance but do not certify independent re-execution.

## Methodology
- **Evaluated actions:** documentary exclusion (`DOC`), median imputation (`MEDIAN`), KNN imputation (`KNN`) and iterative imputation (`ITERATIVE`).
- **Evaluation dimensions:** predictive performance, SHAP shift, SHAP stability, operational coverage and TreeSHAP additivity gate.
- **Fuzzy layer:** linguistic presentation only; no global score, automatic ranking or recommendation.
- **Step 19:** `KB_EXPERIENCE` stores experimental evidence.
- **Human validation:** the decision and validation stage is not automated.
- **Reuse:** only under the same human-validated DQ configuration and operational context; unseen configurations require **ABSTAIN / ESCALATE**.

## Evidence map
- `data/`: datasets and inputs.
- `knowledge/`: documentary knowledge, rules and experience records.
- `models/`: predictive models.
- `results/`: experimental comparisons and final outputs.
- `results/17_final_test_evaluation/`: recorded final TEST evaluation.
- `results/18_final_fuzzy_explanation/`: linguistic interpretations and figures.
- `knowledge/knowledge_base/KB_EXPERIENCE/`: experience evidence.
- `knowledge/rules/action_rules/`: traceable action rules.
- `requirements.txt`: study-specific dependencies.

## LLM-assisted work and reproducibility
Steps **06B** and **06C** involve external LLM-assisted semantic processing, not deterministic Python alone. The release describes 395 input chunks and frozen prompts, schemas, outputs and validation/audit artifacts. Review these records for provenance; exact LLM regeneration is not guaranteed without the original model/service environment.

Inspect saved notebook outputs and cross-check action-level results against the retained artifacts. Reconstruct a compatible environment and review path assumptions before rerunning. Preserve the human-validation and abstention boundaries.

This README documents deposited evidence, not a new independent execution.
