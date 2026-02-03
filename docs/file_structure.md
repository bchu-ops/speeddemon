# In-depth File Structure
```text
SpeedDemon/
├── .github/workflows/		# AUTOMATION (CI/CD)
│	├── docs.md					# Describes the workflow CI/CD
│   ├── test.yml        		# Runs unit tests on every push
│   └── deploy.yml      		# Deploys model to production/cloud
├── data/                    # Raw and Processed Data --> THE DATA LAKE (Physical Parquet Files)
│   ├── bronze/             	# Raw, immutable source mirrors
│   ├── silver/             	# Cleaned, typed, and deduplicated data
│   └── gold/               	# Analytics-ready tables & ML Feature sets
├── docs/                    # Architectural decisions (ADRs) & API docs --> Refer to file_structure.md for in-depth documentation
├── models/                  # Local model registry (git-ignored), Serialized model binaries (.pkl, .onnx)
├── notebooks/               # Research & EDA
├── reports/figures/         # Exported EDA plots for viewing
├── scripts/                 # Setup, migrations, and docker entrypoints
├── src/                     # THE SOURCE ROOT (Installable package)
│   ├── __init__.py          	# Makes src a package
│   ├── data_pipeline/       	# E-L-T Engine
│   ├── warehouse/           	# THE SQL LAYER (Analytics & KPIs)
│      ├── schema.sql          		# DuckDB table definitions
│      └── models.sql          		# SQL-based business logic/joins
│  	└── ml/                  	# THE INTELLIGENCE LAYER (Machine Learning)
│      ├── features.py         		# Converts Gold data to Tensors/ML-ready arrays
│      ├── model_logic.py      		# Model architectures (Ridge, Lasso, etc.)
│	   └── train.py            		# Training loops & Hyperparameter tuning (L1/L2)
├── tests/                   # Unit Testing
│   ├── data_pipeline/
│   └── ml/


├── .env.example				# example environment variable file
├── .gitignore					# ignore __pycache__, .env, .venv, .DS_Store, /models/
│
├── main.py                 	# THE ORCHESTRATOR (Runs ELT -> ML)
├── README.md					# project overview and description
├── requirements.txt        	# Imports packages required to run project like: fastf1, polars, duckdb, scikit-learn, pyarrow
├── requirements-dev.txt		# black, mypy, pylint, pytest


├── data_pipeline/          # THE "E-L-T" ENGINE (Data Engineering)
│   ├── extract.py          	# Pulls from Kafka/APIs/DBs
│   ├── load.py             	# Dumps raw files to Bronze
│   └── transform.py        	# Complex cleaning (Silver) & Feature prep (Gold)
├── storage/                # THE DATA LAKE (Physical Parquet Files)
│   ├── bronze/             	# Raw, immutable source mirrors
│   ├── silver/             	# Cleaned, typed, and deduplicated data
│   └── gold/               	# Analytics-ready tables & ML Feature sets
├── warehouse/              # THE SQL LAYER (Analytics & KPIs)
│   ├── schema.sql          	# DuckDB table definitions
│   └── models.sql          	# SQL-based business logic/joins
├── ml/                     # THE INTELLIGENCE LAYER (Machine Learning)
│   ├── features.py         	# Converts Gold data to Tensors/ML-ready arrays
│   ├── model_logic.py      	# Model architectures (Ridge, Lasso, etc.)
│   └── train.py            	# Training loops & Hyperparameter tuning (L1/L2)
├── models/                 # Serialized model binaries (.pkl, .onnx)
├── research/               # NEW: THE "EXPLORATION" HUB
│   ├── eda/                	# Outlier analysis, variance checks, distributions
│   ├── prototypes/         	# Testing new regularization math/L1 vs L2
│   └── validation/         	# Fairness/Bias testing & error analysis
│
├── reports/                # NEW: THE "INSIGHTS" HUB (Static Outputs)
│   └── figures/            	# Saved EDA plots (.png) for stakeholders
│
├── scripts/                # OPERATIONAL SCRIPTS
│
├── .gitignore					# ignore __pycache__, .env, .venv, .DS_Store, /models/
├── .env.example				# example environment variable file
│
├── main.py                 	# THE ORCHESTRATOR (Runs ELT -> ML)
│
│
├── requirements.txt        	# polars, duckdb, scikit-learn, pyarrow
├── requirements-dev.txt		# black, mypy, pylint, pytest
│
├── setup.sh					# setup script for local dev environment
├── SETUP.md					# instructions for setting up local dev environment
├── README.md					# project overview and description


project_root/
├── .github/workflows/       # CI/CD (Test & Deploy)
├── data/                    # Raw and Processed Data
├── docs/                    # Architectural decisions (ADRs) & API docs --> Refer to file_structure.md for in-depth documentation
├── models/                  # Local model registry (git-ignored), Serialized model binaries (.pkl, .onnx)
├── notebooks/               # Research & EDA
├── reports/figures/         # Exported EDA plots for viewing
├── scripts/                 # Setup, migrations, and docker entrypoints
│
├── src/                     # THE SOURCE ROOT (Installable package)
│   ├── __init__.py          # Makes src a package
│   ├── data_pipeline/       # E-L-T Engine
│   ├── warehouse/           # SQL logic (DuckDB/dbt-style)
│   └── ml/                  # Machine Learning Logic
│
├── tests/                   # Unit Testing
│   ├── data_pipeline/
│   └── ml/
│
├── .env.example             # Template for secrets
├── .gitignore               # Updated for /models, .pyc, .env, and .parquet
├── main.py                  # THE ORCHESTRATOR (Imports from src)

├── README.md
└── requirements.txt
```