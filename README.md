<img src="images/TU_logo_large.png" alt="TU logo" width="200" align="right"/>

# NCDR Reference Repository
This repository has been created to store standard queries that can be used for extracting data from the main datasets within NCDR and joining to the relevant reference datasets. This will include:

* Admitted Patient Care Episodes (APCE) and Spells (APCS)
* Emergency Care Data Set (ECDS)
* Outpatient Appointments (OPA)

## Repository Structure
The repository currently has the following structure:

``` plaintext

├───images
└───src
    ├───config
    ├───r_scripts
        ├───data
        └───requirements
    └───sql_scripts
    
```

### `images`
Images such as the TU logos and branding to add to the html output.

### `src`
All the code is stored within src. This is subdivided into two sections:

1. `config`: This folder holds the `theme.css` script for the html output.
2. `r_scripts`: This folder contains the R scripts required to produce the handy html output showing how to join to relevant reference datasets.
3. `sql_scripts`: This folder contains the SQL scripts showing how to extract the data for each of the datasets on NCDR and the necessary joins to the reference data.

## Contributors

This repository has been created and developed by:

-   [Andy Wilson](https://github.com/ASW-Analyst)
