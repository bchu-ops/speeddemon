# In-depth File Structure
```text
SpeedDemon/
├── .github/workflows/			# AUTOMATION (CI/CD)
│	├── docs.md						# Describes the workflow CI/CD
│	├── test.yml					# Runs unit tests on every push
│	└── deploy.yml					# Deploys model to production/cloud
├── data/						# Raw and Processed Data --> THE DATA LAKE (Physical Parquet Files) (.gitignored)
│	├── bronze/						# Raw, immutable source mirrors
│	├── silver/						# Cleaned, typed, and deduplicated data
│	└── gold/						# Analytics-ready tables & ML Feature sets
├── docs/						# Architectural decisions (ADRs) & API docs
│	├── data_architecture.md		# Visualizes data flow from source to Gold layer
│	├── file_structure.md			# Defines folder hierarchy and naming conventions
│	├── ml_architecture.md			# Maps model training and feature engineering logic
│	├── naming_conventions.md		# Naming conventions for data, models, notebooks, and reports
│	├── reports.md					# Catalogs generated insights and stakeholder KPIs
│	├── SETUP.md					# Step-by-step local environment installation guide
│	├── to_do.md					# Tasks left to do
│	└── workflows.md				# Documents CI/CD and automated pipeline schedules
├── models/						# Local model registry (git-ignored), Serialized model binaries (.pkl, .onnx, .h5, .hdf5, .pt, .pth)
├── notebooks/					# Research & EDA
│	├── eda/						# Outlier analysis, variance checks, distributions
│	├── prototypes/					# Testing new regularization math/L1 vs L2
│	└── validation/					# Fairness/Bias testing & error analysis
├── reports/					# NEW: THE "INSIGHTS" HUB (Static Outputs)
│	└── figures/					# Saved EDA plots (.png) for stakeholders
├── scripts/					# Setup, migrations, and docker entrypoints
│	└── setup.sh					# setup script for local dev environment
├── src/						# THE SOURCE ROOT (Installable package)
│	├── __init__.py					# Makes src a package
│	├── data_pipeline/				# E-L-T Engine
│	│	├── extract.py					# Pulls from Kafka/APIs/DBs/Caches/LocalData
│	│	├── load.py						# Dumps raw files to Bronze
│	│	└── transform.py				# Complex cleaning (Silver) & Feature prep (Gold)
│	├── warehouse/					# THE SQL LAYER (Analytics & KPIs)
│	│	├── schema.sql					# DuckDB table definitions
│	│	└── models.sql					# SQL-based business logic/joins
│	└── ml/							# THE INTELLIGENCE LAYER (Machine Learning)
│		├── features.py					# Converts Gold data to Tensors/ML-ready arrays
│		├── model_logic.py				# Model architectures (Ridge, Lasso, etc.)
│		└── train.py					# Training loops & Hyperparameter tuning (L1/L2)
├── tests/						# Unit Testing
│	├── data_pipeline/
│	└── ml/
├── .env.example				# example environment variable file
├── .gitignore					# ignore __pycache__, .env, .venv, .DS_Store, /models/
├── main.py						# THE ORCHESTRATOR (Runs ELT -> ML)
├── README.md					# project overview and description
├── requirements.txt			# Imports packages required to run project like: fastf1, polars, duckdb, scikit-learn, pyarrow
└── requirements-dev.txt		# black, mypy, pylint, pytest

```

