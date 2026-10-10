# CASE STUDY 3 — BEIJING MULTI-SITE AIR QUALITY
## Reproducible filtered version

This package is the cleaned scientific state of DEMARCHE_ENCAD3 Case Study 3.

### Final scientific status
The case ends with a **NO-GO before intervention**. The documentary corpus supports detection, flagging/review and consistency checks, but does not provide a sufficiently justified executable retrospective correction. No corrected Dataset_Action, Model_Action, or post-correction comparison is created.

### Definitive computational path
1. Build `Dataset_REF` from the 12 raw station files without correction/imputation.
2. Build the modeling view and frozen temporal/predictive setting.
3. Train/evaluate `Model_REF` (CatBoost).
4. Compute TreeSHAP on validation and freeze `F_IMPORTANT`.
5. Characterize missing values on development data only.
6. Characterize potential outliers using contextual robust statistics; potential outlier != error.
7. Preserve the frozen LLM-A/LLM-B documentary extraction/validation artifacts and terminate at NO-GO.

### Cleaning performed
- removed `.ipynb_checkpoints`, `Untitled.ipynb`, and duplicate nested ZIP archives;
- removed obsolete/duplicated STEP04 SHAP runs and retained the official validation-based SHAP branch;
- flattened/renamed STEP04B artifacts to STEP04;
- renamed documentary knowledge from STEP06 to STEP07 to remove numbering collision with statistical outlier characterization;
- removed the non-executable web/LLM code cell and replaced it with a reproducibility note pointing to frozen LLM artifacts;
- replaced personal absolute Windows paths with `Path.cwd()`;
- added requirements and SHA-256 manifest.

### Reproduction
Open a terminal in the project root, install `requirements.txt`, then run `DEMARCHE_ENCAD3_CASE3_BEIJING_REPRODUCIBLE.ipynb` from top to bottom. The documentary LLM stage is audit-reproducible from frozen prompts/outputs, not bitwise regenerable without the same external LLM environment.

### Epistemic guardrails
Observation != anomaly; anomaly != error; statistical outlier != erroneous value; missing != automatic imputation; environmental threshold != data-validity rule. The EPA corpus is external knowledge and is not claimed to be the historical Beijing acquisition protocol.
