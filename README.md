# 2025_CSF_Plasma_Proteomics_AI_Classifier

This repository hosts the code and analyses for CSF and Plasma Proteomics AI Classifier: A machine learning framework trained on **cerebrospinal fluid (CSF)** and **plasma** proteomic data to classify major neurodegenerative diseases (AD, PD, FTD, DLB, and controls). The project integrates LightGBM models, differential abundance analysis (DAA), protein co-expression modules, and neuropathological correlations across multiple cohorts including **Knight-ADRC**, **Stanford ADRC**, **MDC**, **Barcelona-1**, **ACE**, **ADNI** and **PPMI** cohorts.

---

## 📂 Repository Structure
```
2025_Xu_CSF_Plasma_AI_Classifier/
│
├── Demo/                                   # 50‑sample toy dataset + quick demo
│   ├── csf_demo_data.csv
│   └── LightGBM_DEMO.ipynb
│
├── csf_model_output/                       # CSF model outputs and feature lists
├── plasma_model_output/                    # Plasma model outputs and feature lists
│
├── Biomarker_Benchmark_Logistic_Regression_PUB.ipynb   # Baseline logistic regression
│
├── CSF_Co_Expression_Protein_Selection_PUB.ipynb       # WGCNA for CSF
├── CSF_DAA_PUB.R                                       # DAA for CSF proteins
├── CSF_PCA_PUB.R                                       # PCA of CSF analytes
│
├── Plasma_Co_Expression_Protein_Selection_PUB.ipynb    # WGCNA for plasma
├── Plasma_DAA_PUB.R                                    # DAA for plasma proteins
├── Plasma_PCA_PUB.R                                    # PCA of plasma analytes
│
├── LightGBM.ipynb                       # Model development & SHAP interpretation
├── LightGBM_Hagerman_PUB.ipynb          # External validation (Hagerman)
├── LightGBM_Internal_Test_PUB.ipynb     # Internal cross‑validation
├── LightGBM_ROSMAP_PUB.ipynb            # Inference on ROSMAP proteomic data
├── LightGBM_WashU_PUB.ipynb             # Inference on WashU proteomic data
│
├── ROSMAP_Neuro_Correlation_PUB.ipynb   # Correlation with neuropathology (ROSMAP)
├── WashU_Neuro_Correlation_PUB.ipynb    # Correlation with neuropathology (WashU)
│
├── plasma_significant_rows_0203.csv
├── csf_significant_rows_0205.csv
│
├── environment.yml
└── README.md
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
- **Cross-cohort testing**: ROSMAP (plasma), Indiana ADRC (plasma), GNPC (CSF/plasma)
- **Differential abundance analysis**: Using DAA and volcano plots (CSF_DAA_PUB.R / Plasma_DAA_PUB.R)
- **PCA and clustering**: Visualize latent protein structure (CSF_PCA_PUB.R / Plasma_PCA_PUB.R)
- **Protein module selection**: Based on co-expression networks and phenotype associations
- **Correlation with neuropathology**: e.g., Braak stage, plaque count, MMSE scores

---

## 🖥️ System Requirements

| Component | Tested Versions / Notes |
|-----------|-------------------------|
| **OS**            | Windows 10/11, Ubuntu 22.04, macOS 13+ |
| **Python**        | 3.10 (managed by Conda 23.11) |
| **R**             | 4.3.2 |
| **Hardware**      | No specialised GPU/TPU required. Benchmarks below on Intel i7‑12700 / 16 GB RAM. |

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

## 🔧 Installation

Create a fully reproducible environment from the Conda lock-file:

```bash
# Clone the repository
git clone <repo-url>
cd 2025_Xu_CSF_Plasma_AI_Classifier

# Create & activate Conda env (≈ 2 min)
conda env create -f environment.yml
conda activate proteomics_ai

# Launch Jupyter
jupyter notebook
```

### Additional R packages  
(needed for DAA, PCA, WGCNA)

```r
install.packages(c(
  "limma",
  "WGCNA",
  "ggplot2",
  "dplyr",
  "pheatmap"
))
```

---

## 📊 Example Outputs

- **Radar plots** of predicted class probabilities per clinical group
- **Volcano plots** showing disease-relevant proteins
- **Forest plots** from Cox regression models (not shown here, but used in context)
- **UpSet plots** identifying consistent analytes across CSF and plasma

---

## 🚀 Quick Demo (≤ 30 s)

Open the demo notebook that runs on the 50‑sample toy dataset:

```bash
jupyter notebook Demo/LightGBM_DEMO.ipynb
```

Expected outputs:

- **LightGBM performance metrics** (including confusion matrix, AUC, accuracy)  
- `SHAP_summary_CSF_AD.png` – SHAP summary plot per disease  
- `SHAP_feature_importance_CSF_per_class.csv` – per‑class feature‑importance numerical results  

<sub>*All results are pre‑rendered inside the notebook (shown in the repo root), so reviewers can inspect them without rerunning any code.*</sub>

---


## 🔁 Reproducibility Guide

| Manuscript Result    | Notebook / Script                          | Runtime*  |
|----------------------|--------------------------------------------|-----------|
| Internal Testing     | notebooks/LightGBM_Internal_Test_PUB.ipynb | ~8 min   |
| External Validation  | notebooks/LightGBM_ROSMAP_PUB.ipynb        | ~6 min   |
| CSF DAA              | scripts_R/CSF_DAA_PUB.R                    | ~3 min   |
| Plasma PCA           | scripts_R/Plasma_PCA_PUB.R                 | ~2 min   |

\*Benchmarked on Intel i7-12700, 16 GB RAM, no GPU.

---


## 📌 Citation

Please cite this work as: Xu Y, Western D, Heo G, Nho K, Huang YN, Liu S, Oh HS, Chen Y, Timsina J, Liu M, Tang Y, Gong K, Budde J, Krish V, Imam F, Fuentes RP, Cano A, Marquie M, Boada M; Knight Alzheimer Disease Research Center (Knight-ADRC), Dominantly Inherited Alzheimer Network (DIAN), Alzheimer Disease Neuroimaging Initiative (ADNI), ACE Alzheimer Center Barcelona (ACE), Barcelona-1, Stanford Alzheimer Disease Research Center (Stanford-ADRC), The Global Neurodegeneration Proteomics Consortium (GNPC); Pastor P, Ruiz A, Fernández MV, Bennett D, Wyss-Coray T, Saykin AJ, Ali M, Cruchaga C. Protein-based Diagnosis and Analysis of Co-pathologies Across Neurodegenerative Diseases: Large-Scale AI-Boosted CSF and Plasma Classification. medRxiv [Preprint]. 2025 Jul 10:2025.07.09.25331192. doi: 10.1101/2025.07.09.25331192. PMID: 40672487; PMCID: PMC12265756.

---

## 📬 Contact

For questions, please contact:  
📧 Fiona Xu – x.ying1@wustl.edu  
🧬 Cruchaga Lab, NeuroGenomics & Informatics Center, Washington University School of Medicine


---

_Last updated: 2025-07-30_