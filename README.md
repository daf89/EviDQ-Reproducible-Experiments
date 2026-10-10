# EviDQ: Experimental Reproducibility Package

This repository accompanies the scientific manuscript:

**EviDQ: Evidence-Guided Data Quality Governance for Responsible Interventions and Explainable Recommendations in Tabular Machine Learning**

EviDQ is a research framework for explainable, traceable, and evidence-guided governance of data-quality interventions in tabular machine learning.

The framework distinguishes data-quality observations, diagnosis, supporting evidence, candidate interventions, admissibility, executability, controlled evaluation, recommendations, and human decision-making.

Its purpose is not to automatically correct every detected anomaly, but to support context-sensitive decisions in which intervention, preservation, non-action, and abstention remain legitimate and auditable outcomes.

This repository provides the experimental materials associated with four case studies, including original Jupyter notebooks, recorded execution outputs, selected datasets, intermediate results, supporting scripts, and research artifacts.

## 1. Case Studies

The reproducibility package contains four case studies:

### Case Study 1 — Health

**Notebook:** `case_studies/CASE_STUDY_1_HEALTH/CASE_STUDY_1_HEALTH.ipynb`

Investigates evidence-guided data-quality governance in a health-related tabular-data context.

### Case Study 2 — Cancer Registry

**Notebook:** `case_studies/CASE_STUDY_2_CANCER_REGISTRY/CASE_STUDY_2_CANCER_REGISTRY.ipynb`

Examines data-quality governance using a simulated cancer-registry setting.

### Case Study 3 — Beijing Multi-Site Air Quality

**Notebook:** `case_studies/CASE_STUDY_3_BEIJING/CASE_STUDY_3_BEIJING.ipynb`

Examines data-quality signals, statistical evidence, documentary knowledge, and the conditions under which an intervention may remain unjustified.

### Case Study 4 — Diabetes

**Notebook:** `case_studies/CASE_STUDY_4_DIABETES/CASE_STUDY_4_DIABETES.ipynb`

Investigates controlled missingness, documentary evidence, rule assessment, candidate data-quality actions, predictive evaluation, and explainability-related consequences.

The Diabetes case includes a controlled evaluation of intervention effects and illustrates that preserving predictive performance does not necessarily imply preserving model explanations.

## 2. Experimental Notebooks

The original Jupyter notebooks are preserved as records of the experimental workflows.

Their original number and order of cells, executed code, and saved outputs have been retained, with local user paths anonymized where applicable.

These notebooks document experimental operations, intermediate computations, evaluation results, and interactions with external language-model-assisted processing.

**Important:** The presence of saved outputs does not establish that all notebooks have been independently rerun successfully in a clean environment.

The notebooks are provided as scientific research records supporting transparency, traceability, and independent examination of the reported experiments.

## 3. Installation and Execution

### 3.1. Requirements

The experimental package uses Python and Jupyter notebooks.

A root-level `requirements.txt` file provides the recorded dependency information.

Users should verify dependency versions and compatibility with the original experimental environment before attempting full reproduction.

### 3.2. Setup

1. Install Python and JupyterLab in a fresh virtual environment.
2. Install the dependencies listed in `requirements.txt`.
3. Navigate to the directory of the selected case study.
4. Start JupyterLab from that directory.
5. Open the corresponding notebook.
6. Execute its cells sequentially, subject to the documented prerequisites and external dependencies.

Example:

```bash
python -m venv .venv
```

Activate the virtual environment and install dependencies:

```bash
python -m pip install -r requirements.txt
```

Then navigate to the relevant case-study directory and launch:

```bash
jupyter lab
```

Relative file paths may depend on the current working directory. Therefore, JupyterLab should be launched from the corresponding case-study folder when executing its notebook.

### 3.3. Execution Limitations

Some experimental stages depend on external services, previously prepared artifacts, language-model interactions, or environment-specific configurations.

These dependencies may prevent complete end-to-end reproduction through notebook execution alone.

Users should consult the corresponding case-study documentation, prompts, input files, result folders, and recorded outputs.

## 4. Data and Research Artifacts

The package includes selected experimental materials, such as:

- Datasets and prepared data tables.
- CSV, JSON, JSONL, and text files.
- Intermediate experimental outputs.
- Statistical and documentary knowledge artifacts.
- Saved model files.
- Supporting scripts and prompts.
- Recorded evaluation results.
- Documentation and provenance information.

The precise included-file inventory is provided in:

`PACKAGE_MANIFEST.csv`

Files deliberately excluded from the distributed package are documented in:

`EXCLUDED_FILES.csv`

Third-party PDF documents, document page images, notebook checkpoints, and redundant notebooks were excluded from the prepared reproducibility package pending applicable redistribution and packaging considerations.

Excluding source documents from the repository does not eliminate the need to preserve their bibliographic references, documentary identifiers, or provenance relationships where these are necessary to audit experimental claims.

## 5. Documentary Knowledge and LLM-Assisted Processing

EviDQ uses documentary knowledge as a potential source of contextual evidence for data-quality diagnosis and intervention governance.

Certain experimental stages involve language-model-assisted documentary processing, including tasks related to semantic examination, relevance assessment, knowledge extraction, structuring, or validation, as applicable to the individual case-study workflows.

These operations must not be assumed to follow an identical protocol across all four case studies.

Where available, the corresponding experimental artifacts provide the original prompts, prepared inputs, structured outputs, intermediate results, and provenance records.

The presence of an LLM-assisted stage does not imply that its output is automatically correct, scientifically validated, or authorized for data intervention.

Documentary source authority remains distinct from language-model-generated interpretations.

Similarly, a validation operation performed by another language model must not automatically be interpreted as independent human validation or as proof of factual correctness.

The specific roles of language-model components, including any extraction and validation stages, must be established from the recorded artifacts of each case study.

### 5.1. Reproducibility of LLM-Assisted Stages

The reproducibility of language-model-assisted processing depends on the availability of relevant information, potentially including:

- Original prompts and output schemas.
- Input documents, chunks, and structured records.
- Model identifiers and configurations.
- Recorded responses and validation outputs.
- Provenance identifiers and source references.
- Execution logs and completeness checks.

Not all such elements are necessarily available or sufficient for exact regeneration of every historical LLM response.

Recorded LLM outputs support inspection and traceability but do not, by themselves, guarantee deterministic reproduction.

## 6. Experimental Provenance and Reproducibility

The reproducibility package distinguishes several complementary properties.

### 6.1. Computational Reproducibility

The ability to execute computational procedures using the available code, dependencies, data, and configuration.

### 6.2. LLM-Stage Reproducibility

The ability to reconstruct or repeat language-model-assisted operations using their documented inputs, prompts, configurations, and recorded outputs.

### 6.3. Documentary Auditability

The ability to trace documentary knowledge claims to identifiable sources, passages, chunks, or other provenance records.

### 6.4. Experimental Traceability

The ability to follow the relationships between experimental inputs, intermediate artifacts, evaluation results, and reported conclusions.

These properties should not be treated as interchangeable.

The repository is intended to support scientific transparency and independent examination without claiming that every external operation can be reproduced automatically.

## 7. Scientific Safeguards

EviDQ distinguishes the detection of a data-quality signal from the justification of a corrective intervention.

A statistically unusual value, missing observation, or documentary warning does not automatically establish that the data are erroneous or that a particular correction is appropriate.

The experimental framework preserves the distinction between:

- Observation and diagnosis.
- Documentary evidence and domain authority.
- Candidate intervention and admissible intervention.
- Executability and authorization.
- Predictive performance and explanation preservation.
- Experimental evaluation and human decision-making.

Preservation, non-action, abstention, and non-authorization may constitute legitimate outcomes when available evidence does not justify an intervention.

In the Diabetes case study, fuzzy interpretation supports the explanation of evaluation dimensions. It does not establish an automatic global ranking, an empirically validated intervention recommendation, or a substitute for human judgment.

The existence of an executable experimental action does not imply that the action has received domain authorization or human validation.

## 8. License and Reuse Conditions

This repository contains original EviDQ software, scientific documentation, experimental artifacts, and materials originating from third-party sources.

Different categories of content are subject to different licensing conditions.

### 8.1. Software License — MIT

Original EviDQ software code, including Python scripts and original executable code in Jupyter notebooks, is licensed under the MIT License.

See [LICENSE](LICENSE).

The MIT License permits use, modification, distribution, and commercial reuse of covered software, subject to its conditions.

This license does not automatically apply to third-party software, datasets, or other materials included in the repository.

### 8.2. Documentation License — CC BY 4.0

Original EviDQ documentation and scientific materials explicitly covered by the documentation license are distributed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).

See [LICENSE-DOCUMENTATION.md](LICENSE-DOCUMENTATION.md).

License information:

https://creativecommons.org/licenses/by/4.0/

Reuse of covered materials requires appropriate attribution and compliance with the applicable license terms.

### 8.3. Third-Party Datasets and Materials

Third-party datasets, documents, software, and other externally sourced materials remain subject to their original licenses, ownership rights, and terms of use.

Their inclusion in this repository does not transfer copyright ownership or grant additional redistribution rights.

Users must verify and comply with the applicable source conditions before redistributing, modifying, or reusing such materials.

### 8.4. Experimental Artifacts

Experimental outputs, including CSV, JSON, JSONL, saved models, and knowledge bases, may incorporate or derive from third-party data or externally sourced materials.

Their reuse must respect any applicable third-party rights and restrictions.

Unless explicitly stated otherwise, no additional license is granted for third-party data or derived materials subject to third-party restrictions.

### 8.5. License Scope

The MIT License applies to original EviDQ software code.

The CC BY 4.0 License applies to original EviDQ documentation and scientific materials explicitly designated as covered.

Neither license overrides the original licensing terms of third-party content.

Users should consult the relevant files, source documentation, and applicable licenses before reuse.

## 9. Sharing, Versioning, and Scientific Archiving

This repository is prepared for public scientific dissemination and long-term archiving through Zenodo, subject to final verification of the applicable redistribution rights.

A tagged GitHub release can be used to identify a stable version of the experimental package.

The corresponding Zenodo archive can provide a persistent Digital Object Identifier (DOI) for scientific citation.

The archived version should correspond to an identifiable repository state, enabling readers and reviewers to determine which experimental artifacts support the associated manuscript.

The availability of recorded notebook outputs does not imply that all experimental stages can be independently rerun without additional dependencies.

## 10. Scientific Citation

When using this reproducibility package in scientific research, users are requested to cite the associated EviDQ scientific publication and the corresponding archived Zenodo record when available.

**Associated manuscript:**

EviDQ: Evidence-Guided Data Quality Governance for Responsible Interventions and Explainable Recommendations in Tabular Machine Learning.

**Zenodo DOI:** To be added after archival publication.

Users should cite the specific archived version employed in their research whenever possible.

## 11. Research Integrity and Scope

The purpose of this repository is to document the experimental evidence supporting the EviDQ framework.

The release does not imply that all candidate data-quality interventions were executed, approved, or recommended.

It does not establish independent human validation where such validation has not been performed.

It does not imply that language-model-generated knowledge constitutes a domain-authoritative source.

It does not claim complete computational reproducibility of externally executed LLM operations solely from the presence of their recorded outputs.

The original experimental notebooks and their recorded results are preserved to maintain traceability between the reported scientific findings and the available research artifacts.

EviDQ promotes evidence-guided data-quality governance in which scientific justification, applicability, reproducibility limitations, and human decision-making remain explicit.
