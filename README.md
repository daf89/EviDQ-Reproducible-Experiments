# EviDQ: Experimental Reproducibility Package

This package accompanies **EviDQ: Evidence-Guided Data Quality Governance for Responsible Interventions and Explainable Recommendations in Tabular Machine Learning**.

## Case studies

- `case_studies/CASE_STUDY_1_HEALTH/CASE_STUDY_1_HEALTH.ipynb` — health data-quality governance.
- `case_studies/CASE_STUDY_2_CANCER_REGISTRY/CASE_STUDY_2_CANCER_REGISTRY.ipynb` — simulated cancer registry.
- `case_studies/CASE_STUDY_3_BEIJING/CASE_STUDY_3_BEIJING.ipynb` — Beijing air-quality observations.
- `case_studies/CASE_STUDY_4_DIABETES/CASE_STUDY_4_DIABETES.ipynb` — controlled missingness and intervention evaluation.

Each notebook retains the original number and order of cells and its saved outputs, with local user paths anonymized. Run Jupyter **from the corresponding case-study folder**, because relative paths are resolved from the current working directory. The notebooks are provided as research records; this release has not been independently rerun from a clean environment.

## Setup

1. Install Python and JupyterLab in a fresh virtual environment.
2. Install dependencies listed in `requirements.txt`. Version pins should be adjusted to match the original execution environment before a final reproducibility claim.
3. Open a terminal in the appropriate case-study directory, start `jupyter lab`, and run the notebook sequentially.
4. Some steps call external services or use externally prepared language-model outputs. These steps may require additional access, model versions, prompts, or manual review. See the notebook and its result folders for provenance.
5. Verify dataset licenses and third-party documentary redistribution permissions before making this package public.

## Data and research artifacts

Selected datasets, intermediate tables, result files, model files, scripts, and prompts from the provided reproducibility archives are included. Third-party PDF documents, document page images, notebook checkpoints, and redundant notebooks are deliberately excluded pending licensing review. The exact list is in `PACKAGE_MANIFEST.csv`; excluded material is in `EXCLUDED_FILES.csv`.

## Scientific safeguards

These case studies do not imply that an experimentally executable data-quality action is a domain-authorized or human-validated correction. The fuzzy interpretation in the Diabetes case is explanatory and does not establish an automatic global ranking or validated intervention recommendation.

## Sharing

Review this archive for data-sharing rights, hidden identifiers, and repository size before uploading it to GitHub. For long-term citation, tag the final GitHub release and archive it with a persistent DOI service such as Zenodo. Do not treat the presence of recorded notebook outputs as proof that the notebooks execute successfully in a new environment.

## Experimental Provenance and Reproducibility

The original Jupyter notebooks are preserved as records of the experimental workflows, including the executed code, intermediate outputs, evaluation results, and documented interactions with external language models.

Some notebooks contain local filesystem paths reflecting the environment in which the experiments were conducted. These paths are environment-specific and do not constitute methodological dependencies.

Certain experimental stages involved external LLM-assisted processing. Such stages are explicitly distinguished from computations executed directly within the notebooks. Their reproducibility depends on the availability of the corresponding inputs, prompts, model configurations, and recorded outputs.

The notebooks are provided to support scientific transparency, experimental traceability, and independent examination of the reported results. Their availability does not imply that every external processing step can be reproduced by executing the notebooks alone.

## License and Reuse Conditions

The EviDQ reproducibility package contains original research software, scientific documentation, experimental artifacts, and third-party datasets.

### Software License

Original EviDQ software code, including Python scripts and original executable code in Jupyter notebooks, is licensed under the MIT License.

See [LICENSE](LICENSE).

### Documentation License

Original EviDQ documentation and scientific materials explicitly covered by the documentation license are distributed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).

See [LICENSE-DOCUMENTATION.md](LICENSE-DOCUMENTATION.md).

### Third-Party Datasets and Materials

Third-party datasets and other externally sourced materials remain subject to their original licenses and terms of use.

Their inclusion in this reproducibility package does not transfer copyright ownership or grant additional redistribution rights.

Users are responsible for respecting the applicable source licenses when reusing these materials.

### Experimental Artifacts

Experimental outputs, including CSV, JSON, JSONL, model artifacts, and knowledge bases, may incorporate or derive from third-party data. Their reuse must respect applicable source rights and restrictions.

### Scientific Citation

When using this reproducibility package in scientific research, users are requested to cite the associated EviDQ publication and the archived Zenodo record, once available.
