# kart
Files and Process of Building a Kart, paired with optimizing laptimes using OpenAI Groq Chatbot and PostgreSQL

Refer to docs/SETUP.md for setup instructions, if using on local computer to start a venv.
Refer to docs/file_structure.md for in-depth documentation.


### Project Structure

```text
SpeedDemon/
├── .github/workflows/       # CI/CD (Test & Deploy)
├── data/                    # Raw and Processed Data (git-ignored)
├── deploy/					 # Infrastructure & Automation
├── docs/                    # Architectural decisions (ADRs) & API docs
├── models/                  # Local model registry (git-ignored)
├── notebooks/               # Research & EDA
├── reports/figures/         # Exported EDA plots for viewing
├── scripts/                 # Setup, migrations, and docker entrypoints
│
├── src/                     # THE SOURCE ROOT (Installable package)
│   ├── __init__.py          # Makes src a package
│   ├── data_pipeline/       # E-L-T Engine/Data Architecture
│   ├── warehouse/           # SQL logic (DuckDB/dbt-style)
│   └── ml/                  # Machine Learning Logic
│
├── tests/                   # Unit Testing
│   ├── data_pipeline/
│   └── ml/
│
├── .env.example
├── .gitignore
├── README.md
├── setup.sh
├── pyproject.toml
└── uv.lock
```

# Naming Conventions
### 📂 Basic Naming Conventions
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
