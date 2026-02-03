# kart
Files and Process of Building a Kart, paired with optimizing laptimes using OpenAI Groq Chatbot and PostgreSQL


### File Structure
project_root/
├── data_pipeline/      # THE "E-L-T" ENGINE (Data Engineering)
│   ├── extract.py      # Pulls from Kafka/APIs/DBs
│   ├── load.py         # Dumps raw files to Bronze
│   └── transform.py    # Complex cleaning (Silver) & Feature prep (Gold)
│
├── storage/            # THE DATA LAKE (Physical Parquet Files)
│   ├── bronze/         # Raw, immutable source mirrors
│   ├── silver/         # Cleaned, typed, and deduplicated data
│   └── gold/           # Analytics-ready tables & ML Feature sets
│
├── warehouse/          # THE SQL LAYER (Analytics & KPIs)
│   ├── schema.sql      # DuckDB table definitions
│   └── models.sql      # SQL-based business logic/joins
│
├── ml/                 # THE INTELLIGENCE LAYER (Machine Learning)
│   ├── features.py     # Converts Gold data to Tensors/ML-ready arrays
│   ├── model_logic.py  # Model architectures (Ridge, Lasso, etc.)
│   └── train.py        # Training loops & Hyperparameter tuning (L1/L2)
│
├── models/             # Serialized model binaries (.pkl, .onnx)
├── notebooks/          # EDA and visualization sandboxes
├── main.py             # THE ORCHESTRATOR (Runs ELT -> ML)
└── requirements.txt    # polars, duckdb, scikit-learn, pyarrow

