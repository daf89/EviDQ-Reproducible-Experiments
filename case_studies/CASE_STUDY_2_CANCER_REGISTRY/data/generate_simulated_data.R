# =============================================================================
# CR-IDA DEMONSTRATION
# generate_simulated_data.R
#
# Purpose:
#   Generate a fully synthetic cancer-registry-style dataset for demonstrating
#   the CR-IDA workflow.
#
# Important:
#   - No real patient or registry records are used.
#   - All identifiers and values are generated computationally.
#   - A fixed random seed makes the dataset reproducible.
# =============================================================================


# -----------------------------------------------------------------------------
# 1. Packages and paths
# -----------------------------------------------------------------------------

required_packages <- c(
  "dplyr",
  "tibble",
  "stringr",
  "lubridate",
  "readr"
)

missing_packages <- required_packages[
  !vapply(
    required_packages,
    requireNamespace,
    quietly = TRUE,
    FUN.VALUE = logical(1)
  )
]

if (length(missing_packages) > 0) {
  stop(
    "Missing packages: ",
    paste(missing_packages, collapse = ", "),
    call. = FALSE
  )
}

suppressPackageStartupMessages({
  library(dplyr)
  library(tibble)
  library(stringr)
  library(lubridate)
  library(readr)
})

project_dir <- normalizePath(
  getwd(),
  winslash = "/",
  mustWork = TRUE
)

output_file <- file.path(
  project_dir,
  "data",
  "simulated_registry_data.csv"
)


# -----------------------------------------------------------------------------
# 2. Reproducibility settings
# -----------------------------------------------------------------------------

set.seed(20260708)

n_patients <- 1800L

diagnosis_start <- as.Date("2011-01-01")
diagnosis_end   <- as.Date("2020-12-31")
followup_end    <- as.Date("2025-12-31")


# -----------------------------------------------------------------------------
# 3. Helper functions
# -----------------------------------------------------------------------------

sample_date <- function(start_date, end_date, n) {
  start_date + sample.int(
    as.integer(end_date - start_date) + 1L,
    size = n,
    replace = TRUE
  ) - 1L
}


bounded_age <- function(n, mean = 68, sd = 11, minimum = 20, maximum = 99) {
  ages <- round(rnorm(n, mean = mean, sd = sd))
  
  ages <- pmax(
    minimum,
    pmin(maximum, ages)
  )
  
  as.numeric(ages)
}


sample_stage <- function(age, diagnosis_year) {
  n <- length(age)
  
  probability_metastatic <- plogis(
    -0.65 +
      0.015 * (age - 65) -
      0.025 * (diagnosis_year - 2011)
  )
  
  probability_localized <- plogis(
    -1.00 -
      0.010 * (age - 65) +
      0.035 * (diagnosis_year - 2011)
  )
  
  probability_missing <- 0.07 +
    0.002 * pmax(age - 75, 0)
  
  result <- character(n)
  
  for (i in seq_len(n)) {
    probabilities <- c(
      Localized = probability_localized[i],
      Regional = 0.30,
      Metastatic = probability_metastatic[i],
      `No data` = probability_missing[i]
    )
    
    probabilities <- probabilities / sum(probabilities)
    
    result[i] <- sample(
      names(probabilities),
      size = 1,
      prob = probabilities
    )
  }
  
  result
}


stage_to_code <- function(stage_name) {
  dplyr::case_when(
    stage_name == "Localized" ~ "1",
    stage_name == "Regional" ~ "2",
    stage_name == "Metastatic" ~ "3",
    stage_name == "No data" ~ "9",
    TRUE ~ NA_character_
  )
}


# -----------------------------------------------------------------------------
# 4. Generate the main patient-level records
# -----------------------------------------------------------------------------

registration_number <- sprintf(
  "SIM-P%05d",
  seq_len(n_patients)
)

disease_id <- sprintf(
  "SIM-D%05d",
  seq_len(n_patients)
)

diag_date <- sample_date(
  diagnosis_start,
  diagnosis_end,
  n_patients
)

diag_year <- lubridate::year(diag_date)

age_diag <- bounded_age(n_patients)

birth_date <- diag_date -
  round(age_diag * 365.25) -
  sample(0:364, n_patients, replace = TRUE)

sex_code <- sample(
  c("1", "2"),
  size = n_patients,
  replace = TRUE,
  prob = c(0.59, 0.41)
)

sex_name <- if_else(
  sex_code == "1",
  "Male",
  "Female"
)

mkb10_code <- sample(
  c(
    "C34.0",
    "C34.1",
    "C34.2",
    "C34.3",
    "C34.8",
    "C34.9",
    "C33"
  ),
  size = n_patients,
  replace = TRUE,
  prob = c(
    0.05,
    0.31,
    0.08,
    0.27,
    0.04,
    0.23,
    0.02
  )
)

mkb10_name <- dplyr::case_when(
  mkb10_code == "C34.0" ~ "Main bronchus",
  mkb10_code == "C34.1" ~ "Upper lobe, bronchus or lung",
  mkb10_code == "C34.2" ~ "Middle lobe, bronchus or lung",
  mkb10_code == "C34.3" ~ "Lower lobe, bronchus or lung",
  mkb10_code == "C34.8" ~ "Overlapping lesion of bronchus and lung",
  mkb10_code == "C34.9" ~ "Bronchus or lung, unspecified",
  mkb10_code == "C33" ~ "Malignant neoplasm of trachea",
  TRUE ~ NA_character_
)

mkb10_3char <- substr(mkb10_code, 1, 3)

histology_category <- sample(
  c(
    "Adenocarcinoma",
    "Squamous cell carcinoma",
    "Small cell carcinoma",
    "Large cell / undifferentiated carcinoma",
    "Carcinoma / neoplasm NOS",
    "Other specified morphology",
    "Missing / unknown"
  ),
  size = n_patients,
  replace = TRUE,
  prob = c(
    0.40,
    0.25,
    0.14,
    0.05,
    0.09,
    0.05,
    0.02
  )
)

icdo3_m_code <- dplyr::case_when(
  histology_category == "Adenocarcinoma" ~
    sample(c("8140/3", "8250/3", "8260/3"), n_patients, replace = TRUE),
  
  histology_category == "Squamous cell carcinoma" ~
    sample(c("8070/3", "8071/3", "8072/3"), n_patients, replace = TRUE),
  
  histology_category == "Small cell carcinoma" ~ "8041/3",
  
  histology_category == "Large cell / undifferentiated carcinoma" ~
    sample(c("8012/3", "8020/3"), n_patients, replace = TRUE),
  
  histology_category == "Carcinoma / neoplasm NOS" ~
    sample(c("8000/3", "8010/3"), n_patients, replace = TRUE),
  
  histology_category == "Other specified morphology" ~
    sample(c("8240/3", "8430/3", "8560/3"), n_patients, replace = TRUE),
  
  TRUE ~ NA_character_
)

icdo3_m_name <- dplyr::case_when(
  icdo3_m_code == "8140/3" ~ "Adenocarcinoma, NOS",
  icdo3_m_code == "8250/3" ~ "Lepidic adenocarcinoma",
  icdo3_m_code == "8260/3" ~ "Papillary adenocarcinoma, NOS",
  icdo3_m_code == "8070/3" ~ "Squamous cell carcinoma, NOS",
  icdo3_m_code == "8071/3" ~ "Squamous cell carcinoma, keratinizing, NOS",
  icdo3_m_code == "8072/3" ~ "Squamous cell carcinoma, nonkeratinizing, NOS",
  icdo3_m_code == "8041/3" ~ "Small cell carcinoma, NOS",
  icdo3_m_code == "8012/3" ~ "Large cell carcinoma, NOS",
  icdo3_m_code == "8020/3" ~ "Carcinoma, undifferentiated, NOS",
  icdo3_m_code == "8000/3" ~ "Neoplasm, malignant",
  icdo3_m_code == "8010/3" ~ "Carcinoma, NOS",
  icdo3_m_code == "8240/3" ~ "Neuroendocrine tumour, NOS",
  icdo3_m_code == "8430/3" ~ "Mucoepidermoid carcinoma",
  icdo3_m_code == "8560/3" ~ "Adenosquamous carcinoma",
  TRUE ~ NA_character_
)

# Retained for compatibility with the current rule catalogue.
histology_code <- icdo3_m_code

registry_stage_name <- sample_stage(
  age = age_diag,
  diagnosis_year = diag_year
)

registry_stage_code <- stage_to_code(
  registry_stage_name
)

stage_definition_code <- if_else(
  diag_year <= 2017,
  "SCR_STAGE_V1",
  "SCR_STAGE_V2"
)

stage_definition_name <- if_else(
  diag_year <= 2017,
  "Registry stage definition, earlier period",
  "Registry stage definition, later period"
)

diagnosis_method_code <- sample(
  c("1", "2", "5", "6", "7"),
  size = n_patients,
  replace = TRUE,
  prob = c(0.04, 0.08, 0.14, 0.09, 0.65)
)

diagnosis_method_name <- dplyr::case_when(
  diagnosis_method_code == "1" ~ "Clinical",
  diagnosis_method_code == "2" ~ "Other diagnostic examinations",
  diagnosis_method_code == "5" ~ "Cytological examination",
  diagnosis_method_code == "6" ~ "Histological examination of metastasis",
  diagnosis_method_code == "7" ~ "Histological examination of primary tumour",
  TRUE ~ "Unknown"
)

finding_code <- sample(
  c("1", "2", "3", "8", "9"),
  size = n_patients,
  replace = TRUE,
  prob = c(0.84, 0.03, 0.08, 0.02, 0.03)
)

finding_name <- dplyr::case_when(
  finding_code == "1" ~ "Clinical signs",
  finding_code == "2" ~ "Autopsy",
  finding_code == "3" ~ "Other",
  finding_code == "8" ~ "Cause-of-death report",
  finding_code == "9" ~ "Unknown",
  TRUE ~ NA_character_
)

administr_unit <- sample(
  c(
    "Ljubljana",
    "Maribor",
    "Celje",
    "Kranj",
    "Koper",
    "Novo mesto",
    "Murska Sobota"
  ),
  size = n_patients,
  replace = TRUE
)

diag_date_valid_name <- "FULL DATE VALID"


# -----------------------------------------------------------------------------
# 5. Generate survival and vital-status information
# -----------------------------------------------------------------------------

stage_hazard_multiplier <- dplyr::case_when(
  registry_stage_name == "Localized" ~ 0.45,
  registry_stage_name == "Regional" ~ 0.90,
  registry_stage_name == "Metastatic" ~ 2.20,
  registry_stage_name == "No data" ~ 1.20,
  TRUE ~ 1.00
)

histology_hazard_multiplier <- dplyr::case_when(
  histology_category == "Small cell carcinoma" ~ 1.55,
  histology_category == "Large cell / undifferentiated carcinoma" ~ 1.30,
  histology_category == "Carcinoma / neoplasm NOS" ~ 1.15,
  TRUE ~ 1.00
)

baseline_rate <- 1 / 1200

simulated_event_time_days <- ceiling(
  rexp(
    n_patients,
    rate = baseline_rate *
      stage_hazard_multiplier *
      histology_hazard_multiplier
  )
)

maximum_observable_followup <- as.integer(
  followup_end - diag_date
)

event_before_followup <- simulated_event_time_days <=
  maximum_observable_followup

death_date <- as.Date(
  rep(NA_real_, n_patients),
  origin = "1970-01-01"
)

death_date[event_before_followup] <-
  diag_date[event_before_followup] +
  simulated_event_time_days[event_before_followup]

vital_status_code <- if_else(
  event_before_followup,
  "9",
  "1"
)

vital_status_name <- if_else(
  vital_status_code == "9",
  "Dead",
  "Alive"
)


# -----------------------------------------------------------------------------
# 6. Introduce selected synthetic data features
# -----------------------------------------------------------------------------

# Unknown vital status: creates unresolved outcome information.
unknown_status_rows <- sample(
  seq_len(n_patients),
  size = 18
)

vital_status_code[unknown_status_rows] <- "8"
vital_status_name[unknown_status_rows] <- "Temporary record / unknown"
death_date[unknown_status_rows] <- as.Date(NA)


# Loss to follow-up: death_date represents the last known system/contact date.
available_rows <- setdiff(
  seq_len(n_patients),
  unknown_status_rows
)

lost_to_followup_rows <- sample(
  available_rows,
  size = 24
)

vital_status_code[lost_to_followup_rows] <- "0"
vital_status_name[lost_to_followup_rows] <- "Lost to follow-up"

last_contact_span <- pmax(
  30L,
  as.integer(followup_end - diag_date[lost_to_followup_rows])
)

death_date[lost_to_followup_rows] <-
  diag_date[lost_to_followup_rows] +
  pmin(
    sample(
      30:1500,
      length(lost_to_followup_rows),
      replace = TRUE
    ),
    last_contact_span
  )


# Zero follow-up records: R21 should exclude these.
eligible_zero_rows <- setdiff(
  available_rows,
  lost_to_followup_rows
)

zero_followup_rows <- sample(
  eligible_zero_rows,
  size = 10
)

vital_status_code[zero_followup_rows] <- "9"
vital_status_name[zero_followup_rows] <- "Dead"
death_date[zero_followup_rows] <- diag_date[zero_followup_rows]


# Missing stage concentrated partly among older cases.
older_rows <- which(age_diag >= 80)

additional_missing_stage <- sample(
  older_rows,
  size = min(35, length(older_rows))
)

registry_stage_code[additional_missing_stage] <- "9"
registry_stage_name[additional_missing_stage] <- "No data"


# Some missing morphology values.
missing_morphology_rows <- sample(
  seq_len(n_patients),
  size = 22
)

icdo3_m_code[missing_morphology_rows] <- NA_character_
icdo3_m_name[missing_morphology_rows] <- NA_character_
histology_code[missing_morphology_rows] <- NA_character_


# -----------------------------------------------------------------------------
# 7. Assemble main synthetic extract
# -----------------------------------------------------------------------------

simulated_registry_data <- tibble(
  registration_number = registration_number,
  disease_id = disease_id,
  
  sex_code = sex_code,
  sex_name = sex_name,
  
  birth_date = birth_date,
  age_diag = age_diag,
  
  vital_status_code = vital_status_code,
  vital_status_name = vital_status_name,
  death_date = death_date,
  
  diag_date = diag_date,
  diag_year = diag_year,
  diag_date_valid_name = diag_date_valid_name,
  
  mkb10_code = mkb10_code,
  mkb10_name = mkb10_name,
  mkb10_3char = mkb10_3char,
  
  histology_code = histology_code,
  icdo3_m_code = icdo3_m_code,
  icdo3_m_name = icdo3_m_name,
  
  registry_stage_code = registry_stage_code,
  registry_stage_name = registry_stage_name,
  stage_definition_code = stage_definition_code,
  stage_definition_name = stage_definition_name,
  
  diagnosis_method_code = diagnosis_method_code,
  diagnosis_method_name = diagnosis_method_name,
  
  finding_code = finding_code,
  finding_name = finding_name,
  
  administr_unit = administr_unit
)


# -----------------------------------------------------------------------------
# 8. Add second-primary records for selected patients
# -----------------------------------------------------------------------------

second_primary_patients <- sample(
  simulated_registry_data$registration_number,
  size = 90
)

second_primary_records <- simulated_registry_data |>
  filter(
    registration_number %in% second_primary_patients
  ) |>
  mutate(
    disease_id = paste0(disease_id, "-B"),
    diag_date = pmin(
      diag_date + sample(
        180:1200,
        n(),
        replace = TRUE
      ),
      diagnosis_end
    ),
    diag_year = lubridate::year(diag_date),
    age_diag = round(
      as.numeric(diag_date - birth_date) / 365.25,
      1
    ),
    death_date = case_when(
      vital_status_code == "9" &
        !is.na(death_date) &
        death_date < diag_date ~ diag_date + 30,
      TRUE ~ death_date
    )
  )


# -----------------------------------------------------------------------------
# 9. Add exact duplicated records for duplicate detection
# -----------------------------------------------------------------------------

duplicate_records <- simulated_registry_data |>
  slice_sample(n = 12)


# -----------------------------------------------------------------------------
# 10. Combine and randomize record order
# -----------------------------------------------------------------------------

simulated_registry_data <- bind_rows(
  simulated_registry_data,
  second_primary_records,
  duplicate_records
) |>
  slice_sample(prop = 1) |>
  arrange(
    registration_number,
    diag_date,
    disease_id
  )


# -----------------------------------------------------------------------------
# 11. Validate the generated file
# -----------------------------------------------------------------------------

required_columns <- c(
  "registration_number",
  "disease_id",
  "sex_code",
  "sex_name",
  "birth_date",
  "age_diag",
  "vital_status_code",
  "vital_status_name",
  "death_date",
  "diag_date",
  "diag_year",
  "mkb10_code",
  "mkb10_name",
  "mkb10_3char",
  "histology_code",
  "icdo3_m_code",
  "icdo3_m_name",
  "registry_stage_code",
  "registry_stage_name",
  "stage_definition_code",
  "diagnosis_method_code",
  "diagnosis_method_name",
  "finding_code",
  "finding_name",
  "administr_unit"
)

missing_columns <- setdiff(
  required_columns,
  names(simulated_registry_data)
)

if (length(missing_columns) > 0) {
  stop(
    "Generated data are missing columns: ",
    paste(missing_columns, collapse = ", "),
    call. = FALSE
  )
}

if (anyDuplicated(simulated_registry_data$disease_id) == 0) {
  warning(
    "No duplicate disease identifiers were generated. ",
    "Check the duplicate-record construction."
  )
}


# -----------------------------------------------------------------------------
# 12. Save true comma-delimited UTF-8 CSV
# -----------------------------------------------------------------------------

readr::write_csv(
  simulated_registry_data,
  output_file,
  na = ""
)

message(
  "Simulated registry data written to: ",
  output_file
)

message(
  "Rows: ",
  nrow(simulated_registry_data)
)

message(
  "Unique patients: ",
  dplyr::n_distinct(
    simulated_registry_data$registration_number
  )
)

message(
  "This file contains fully synthetic data only."
)