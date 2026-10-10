# EviDQ — Case Study 3: Beijing Multi-Site Air Quality

## Scientific scope and conclusion
This case investigates data-quality evidence in Beijing multi-site air-quality measurements without treating every statistical signal as a data error.

**Recorded outcome: NO-GO before intervention.** Documentary evidence supports detection, flagging/review and consistency checks, but not a justified executable retrospective correction. No corrected `Dataset_Action`, intervention `Model_Action`, or post-correction performance comparison is claimed.

## Experimental notebook
[Case3_Beijing.ipynb](Case3_Beijing.ipynb) contains the saved computational outputs. Some paths or results reflect the original execution environment.

## Documented experimental sequence
1. Construct `Dataset_REF` from 12 raw station files without correction or imputation.
2. Define modeling view and temporal/predictive setting.
3. Train/evaluate CatBoost `Model_REF`.
4. Examine validation TreeSHAP and important features.
5. Characterize missingness on development data.
6. Characterize potential outliers using contextual robust statistics, without equating outliers with errors.
7. Review frozen external LLM documentary extraction/validation and record NO-GO.

## Evidence map
- `data/`: source datasets and associated inputs.
- `knowledge/`: documentary sources and knowledge artifacts.
- `models/`: reference-model artifacts.
- `results/`: predictive, SHAP, statistical and documentary outputs.
- `requirements.txt`: study-specific dependencies.

## Reproducibility boundaries
The external documentary LLM stage is auditable through retained prompts, inputs, outputs and validation evidence where available; it is not claimed to be a fully executed local notebook cell. Exact LLM regeneration cannot be guaranteed. Saved notebook outputs do not independently certify a full rerun.

Statistical outlier is not synonymous with error; missingness does not automatically justify imputation; environmental thresholds are not automatically data-validity rules. External EPA documentation is supporting knowledge, not necessarily the original Beijing acquisition protocol.

Review notebook outputs and deposited artifacts; reconstruct dependencies and verify input paths and temporal splits before rerunning. Preserve the NO-GO outcome rather than inventing intervention results.
