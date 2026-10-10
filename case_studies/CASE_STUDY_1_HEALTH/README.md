# EviDQ — Case Study 1: Health

## Scientific scope and conclusion
This study examines data-quality evidence in a received health dataset without artificial corruption. Statistical signals are not automatically classified as errors. Documentary and statistical knowledge are linked for diagnosis.

**Recorded outcome: ABSTAIN / NO ACTION.** The observed signals were not established as correctable data-quality errors. No corrected dataset or intervention benefit is claimed.

## Experimental notebook
[Case1_Health.ipynb](Case1_Health.ipynb) contains saved outputs from the deposited experiment. Saved outputs document recorded computations but do not prove independent re-execution. Original Windows paths may appear in the execution record.

## Evidence map
- `data/`: reference data and metadata.
- `knowledge/`: documentary corpus, extracted content and knowledge resources.
- `models/`: reference model and preprocessing artifacts.
- `results/`: retained experimental and diagnostic outputs and publication figures where present.
- `requirements.txt`: study-specific Python dependencies.

## Reproducibility and provenance
Some semantic/documentary stages were performed through external LLM workflows. Frozen inputs, prompts, outputs and audits should be examined where available. These are not deterministic local Python executions, and exact LLM regeneration is not guaranteed.

To review the experiment, inspect the notebook outputs, cross-check numerical claims against `results/` and `data/`, and reconstruct a compatible environment using `requirements.txt`. Adapt machine-specific paths before any rerun, and preserve the original outputs.

**Interpretation boundary:** observation does not imply anomaly; statistical outlier or missingness does not automatically justify correction. This repository documents the original evidence, not a newly executed replication.
