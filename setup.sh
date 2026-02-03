#!/bin/bash

# Setup script
# Creates and activates a virtual environment, installs requirements

if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    echo "Virtual environment created."
fi
# Activate for the current script's process to install requirements
source .venv/bin/activate

# Install requirements and log output
pip install -r requirements.txt > .pip.log 2>&1

NEW=$(grep -c "installed" .pip.log)
EXS=$(grep -c "satisfied" .pip.log)
ERR=$(grep -ciE "error|failed|could not" .pip.log)

echo "New: $NEW | Existing: $EXS | Errors: $ERR"
echo "Setup complete. To stay activated, run: source setup.sh"
