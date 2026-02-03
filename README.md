# kart
Files and Process of Building a Kart, paired with optimizing laptimes using OpenAI Groq Chatbot and PostgreSQL

Refer to docs/SETUP.md for setup instructions, if using on local computer to start a venv.

├── notebooks/               # Research & EDA (Renamed from research/ for convention)
│   ├── 01_eda.ipynb         # Numbered for chronological order
│   └── 02_prototypes.ipynb
### Project Structure

```text
SpeedDemon/
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
├── .env.example
├── .gitignore
├── main.py
├── README.md
└── requirements.txt


project_root/
├── .github/                # AUTOMATION (CI/CD)
│   └── workflows/
		├── docs.md				# Describes the workflow CI/CD
│       ├── test.yml        	# Runs unit tests on every push
│       └── deploy.yml      	# Deploys model to production/cloud
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
│
│

```

# Naming Conventions
### 📂 Naming Conventions
| Level | Convention | Example |
| :--- | :--- | :--- |
| **Directories** | `snake_case` | `data_pipeline/`, `ml_models/` |
| **Python Files** | `snake_case` | `extract_kafka.py`, `train_v1.py` |
| **Classes** | `PascalCase` | `FeatureSelector`, `RidgeTrainer` |
| **Functions** | `snake_case` | `get_variance()`, `clean_data()` |
| **Constants** | `UPPER_SNAKE` | `ALPHA_VAL = 0.1`, `MAX_RETRIES` |
| **Variables** | `snake_case` | `X_train`, `y_test`, `is_processed` |

<!-- ### 🏗 Senior Architecture Patterns
*   **Type Hinting:** Mandatory for all signatures: `def train(X: np.ndarray) -> float:`.
*   **Privacy:** Prefix internal-only logic with `_` (e.g., `_calculate_loss()`).
*   **Explicit Imports:** No `import *`. Use `from src.ml import model_logic`.
*   **Immutability:** The `storage/bronze/` layer is read-only; never overwrite raw data.
*   **Environment:** Use `.env` for secrets (DB pass, API keys); never hardcode. (check out .env.example for free API keys 🤣🤣🤣)

### 🧪 CI/CD & Quality
*   **`.github/workflows/`**: Automation for `pytest` and `flake8` linting.
*   **`tests/`**: Mirror the `src/` structure for unit testing components.
*   **`__init__.py`**: Included in all logic folders to enable modular imports. 
*   
ADD LATER: 
├── pyproject.toml           # MODERN: Replaces setup.py/requirements-dev


*   -->
