# NHP SQL

This repository contains the SQL code that is used to clean, filter, and identify rows of data affected by the various activity mitigators in the NHP Demand and Capacity model. 

It is designed to work with HES data extracts. Further information on the various fields available in HES data is available in the [HES Data Dictionary](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics/hospital-episode-statistics-data-dictionary).

A full list of the activity mitigators is [available here](https://connect.strategyunitwm.nhs.uk/nhp/project_information/user_guide/mitigators_lookup.html) and further details on the mitigators are [available here](https://connect.strategyunitwm.nhs.uk/nhp/project_information/modelling_methodology/activity_mitigators/inpatient_activity_mitigators.html).

Please note that some mitigators require access to the national dataset, so running the code on only locally held datasets may not result in the same numbers. Examples of these include:
- `A&E Frequent Attenders`
- `Emergency Readmissions Within 28 Days`

For any queries regarding this repository, please contact [mlcsu.nhpanalytics@nhs.net](mailto:mlcsu.nhpanalytics@nhs.net).