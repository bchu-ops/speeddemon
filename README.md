# kart
Files and Process of Building a Kart, paired with optimizing laptimes using OpenAI Groq Chatbot and PostgreSQL


### Project Structure

```text
project_root/
├── .github/                # AUTOMATION (CI/CD)
│   └── workflows/
│       ├── test.yml        # Runs unit tests on every push
│       └── deploy.yml      # Deploys model to production/cloud
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
├── notebooks/              # EDA and visualization sandboxes
│
├── .gitignore				# ignore __pycache__, .env, .venv, .DS_Store, /models/
├── .env.example			# example environment variable file
│
├── main.py                 # THE ORCHESTRATOR (Runs ELT -> ML)
│
│
├── requirements.txt        # polars, duckdb, scikit-learn, pyarrow
├── requirements-dev.txt	# black, mypy, pylint, pytest
│
├── setup.sh				# setup script for local dev environment
├── SETUP.md				# instructions for setting up local dev environment
├── README.md				# project overview and description

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

### 🏗 Senior Architecture Patterns
*   **Type Hinting:** Mandatory for all signatures: `def train(X: np.ndarray) -> float:`.
*   **Privacy:** Prefix internal-only logic with `_` (e.g., `_calculate_loss()`).
*   **Explicit Imports:** No `import *`. Use `from src.ml import model_logic`.
*   **Immutability:** The `storage/bronze/` layer is read-only; never overwrite raw data.
*   **Environment:** Use `.env` for secrets (DB pass, API keys); never hardcode. (check out .env.example for free API keys 🤣🤣🤣)

### 🧪 CI/CD & Quality
*   **`.github/workflows/`**: Automation for `pytest` and `flake8` linting.
*   **`tests/`**: Mirror the `src/` structure for unit testing components.
*   **`__init__.py`**: Included in all logic folders to enable modular imports.
