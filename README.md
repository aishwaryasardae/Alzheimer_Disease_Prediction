__Alzheimer's Disease Prediction__

__Overview__
This project leverages MRI data from the OASIS (Open Access Series of Imaging Studies) to develop machine learning models capable of detecting low to moderate Alzheimer's disease in individuals. The primary aim is to aid discoveries in scientific and clinical neuroscience by assembling and publishing MRI datasets openly available to the scientific community. By using this data, we can train and test multiple machine learning algorithms to predict the presence and severity of Alzheimer's disease in individuals of different ages and genders.

Alzheimer’s is a progressive brain disorder characterized by memory loss and cognitive decline. Detecting it early is crucial for managing and potentially mitigating its impact. This project aims to identify Alzheimer's disease and determine its severity through analysis of MRI scans.

Dataset
The dataset used is oasis_longitudinal.csv from OASIS. It contains 371 observations and 15 variables, including demographic information, clinical data, and MRI-derived measures.

Structure of the Dataset

## Dataset Structure

| VARIABLE  | TYPE | DESCRIPTION                                      |
|-----------|------|--------------------------------------------------|
| Subject.ID| char | Identification number                             |
| MRI.ID    | char | Identification number                             |
| Group     | int  | Demented/Non-Demented                             |
| Visit     | int  | Number of visits                                  |
| MR.Delay  | int  | Delay                                             |
| M.F       | chr  | Male/Female                                       |
| Hand      | chr  | Right hand/Left Hand                              |
| Age       | int  | Age in Years                                      |
| EDUC      | int  | Years of Education                                |
| SES       | int  | Socioeconomic Status                              |
| MMSE      | int  | Mini Mental State Examination                     |
| CDR       | num  | Clinical Dementia Rating                          |
| eTIV      | int  | Estimated Total Intracranial Volume               |
| nWBV      | num  | Normalize Whole brain volume                      |
| ASF       | num  | Atlas Scaling Factor                              |


