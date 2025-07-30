# 2025_CSF_Plasma_Proteomics_AI_Classifier

This repository hosts the code and analyses for CSF and Plasma Proteomics AI Classifier: A machine learning framework trained on **cerebrospinal fluid (CSF)** and **plasma** proteomic data to classify major neurodegenerative diseases (AD, PD, FTD, DLB, and controls). The project integrates LightGBM models, differential abundance analysis (DAA), protein co-expression modules, and neuropathological correlations across multiple cohorts including **Knight-ADRC**, **Stanford ADRC**, **MDC**, **Barcelona-1**, **ACE**, **ADNI** and **PPMI** cohorts.

---

## 📂 Repository Structure

```
2025_Xu_CSF_Plasma_AI_Classifier/
│
├── csf_model_output/                          # CSF model outputs and feature lists
├── plasma_model_output/                       # Plasma model outputs and feature lists
│
├── Biomarker_Benchmark_Logistic_Regression_PUB.ipynb   # Baseline logistic regression benchmark
│
├── CSF_Co_Expression_Protein_Selection_PUB.ipynb        # WGCNA and CSF co-expression modules
├── CSF_DAA_PUB.R                                          # DAA for CSF proteins
├── CSF_PCA_PUB.R                                          # PCA of CSF analytes
│
├── Plasma_Co_Expression_Protein_Selection_PUB.ipynb     # WGCNA and plasma co-expression modules
├── Plasma_DAA_PUB.R                                      # DAA for plasma proteins
├── Plasma_PCA_PUB.R                                      # PCA of plasma analytes
│
├── LightGBM.ipynb                     # Model development and SHAP ratio
├── LightGBM_Hagerman_PUB.ipynb        # External validation on Hagerman samples
├── LightGBM_Internal_Test_PUB.ipynb   # Internal cross-validation and performance
├── LightGBM_ROSMAP_PUB.ipynb          # Inference and performance on ROSMAP proteomic data
├── LightGBM_WashU_PUB.ipynb           # Inference and performance on WashU proteomic data
│
├── ROSMAP_Neuro_Correlation_PUB.ipynb    # Correlation of model outputs with neuropathology traits (ROSMAP)
├── WashU_Neuro_Correlation_PUB.ipynb     # Correlation of model outputs with neuropathology traits (WashU)
│
├── README.md
```

---

## 🧠 Study Summary

- **Objective**: To develop and evaluate classifiers predicting neurodegenerative disease probability using CSF and plasma proteomes.
- **Models**: Gradient-boosted decision trees (LightGBM) were trained and interpreted across five disease classes.
- **Cohorts**: Data from **Knight-ADRC**, **Stanford ADRC**, **MDC**, **Barcelona-1**, **ACE**, **ADNI** and **PPMI** cohorts.
- **Outcome**: Models demonstrate generalization across independent cohorts and alignment with neuropathological burden.

---

## ✅ Key Features

- **Multiclass classification**: AD, PD, FTD, DLB, CO
- **Cross-cohort testing**: ROSMAP (brain proteome), WashU (CSF/plasma), Hagerman dataset
- **Differential abundance analysis**: Using DAA and volcano plots (CSF_DAA_PUB.R / Plasma_DAA_PUB.R)
- **PCA and clustering**: Visualize latent protein structure (CSF_PCA_PUB.R / Plasma_PCA_PUB.R)
- **Protein module selection**: Based on co-expression networks and phenotype associations
- **Correlation with neuropathology**: e.g., Braak stage, plaque count, MMSE scores

---

## 📊 Example Outputs

- **Radar plots** of predicted class probabilities per clinical group
- **Volcano plots** showing disease-relevant proteins
- **Forest plots** from Cox regression models (not shown here, but used in context)
- **UpSet plots** identifying consistent analytes across CSF and plasma

---

## 🛠 Requirements

Most notebooks require the following Python packages:

```bash
pandas==2.2.2  
numpy==1.26.4  
matplotlib==3.9.2  
seaborn==0.13.2  
scikit-learn==1.5.1  
lightgbm==4.5.0  
statsmodels==0.14.2  
scipy==1.13.1  
```

R scripts require:

```R
limma
ggplot2
WGCNA
dplyr
pheatmap
```

---

## 📌 Citation

Please cite this work as:

In prep

---

## 📬 Contact

For questions, please contact:  
📧 Fiona Xu – x.ying1@wustl.edu  
🧬 NeuroGenomics & Informatics Lab, Washington University School of Medicine
