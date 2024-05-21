# __Alzheimer's Disease Prediction__

## __OVERVIEW__  

This project leverages MRI data from the OASIS (Open Access Series of Imaging Studies) to develop machine learning models capable of detecting low to moderate Alzheimer's disease in individuals. The primary aim is to aid discoveries in scientific and clinical neuroscience by assembling and publishing MRI datasets openly available to the scientific community. By using this data, we can train and test multiple machine learning algorithms to predict the presence and severity of Alzheimer's disease in individuals of different ages and genders.

Alzheimer’s is a progressive brain disorder characterized by memory loss and cognitive decline. Detecting it early is crucial for managing and potentially mitigating its impact. This project aims to identify Alzheimer's disease and determine its severity through analysis of MRI scans.

## __DATASET__
The dataset used is oasis_longitudinal.csv from OASIS. It contains 371 observations and 15 variables, including demographic information, clinical data, and MRI-derived measures.

# __STRUCTURE OF DATASET__



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


# __DATA CLEANING__
Data cleaning involves locating and eliminating inaccurate or flawed data to ensure the integrity and accuracy of the dataset. The steps taken include:

# __MANAGING MISSING VALUES__

## __Removing unwanted columns__
Converting data to the necessary types
Exploratory Data Analysis and Visualization
Visualizations were conducted between different attributes to understand the relationships between parameters, which helps in feature selection and understanding the data distribution.

# MODELING
The goal is to predict whether a person is positive or negative for Alzheimer's disease. The following machine learning algorithms were used:

# LASSO REGRESSION:
Achieved an accuracy of 81.67%.
'Alpha' tuning parameter held constant at 1.

 # K-NEAREST NEIGHBOR (KNN):
 Highest accuracy achieved was 81.9% with k=1.

 # SUPPORT VECTOR MACHINE (SVM):
 Achieved an accuracy of 85.41%.
'Sigma' tuning parameter held constant at 0.097 and 'C' at 8.

# DECISION TREE:
Achieved an accuracy of 75.87%.


# RANDOM FOREST:

Highest accuracy achieved was 90.62%.
Key features: MMSE, EDUC, nWBV.
Error decreases with an increase in the number of trees.

# CONCLUSION
The Random Forest model emerged as the most accurate, achieving an accuracy of 90.62%. This model can be effectively used for Alzheimer's detection, providing a reliable tool for early diagnosis.

# Installation
To run this project, you'll need R and the following libraries:

1. caret
2. randomForest
3. e1071
4. glmnet
5. ggplot2
6. dplyr

# Usage
Load the dataset and run the preprocessing steps to clean the data. Then, train the models using the provided code and compare their accuracies to select the best model.

# Acknowledgements
This project uses the OASIS dataset. We acknowledge the Open Access Series of Imaging Studies for providing the dataset for scientific and clinical research.



