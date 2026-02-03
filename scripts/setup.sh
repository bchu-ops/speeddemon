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
pip install -r requirements.txt > ./.venv/.pip.log 2>&1

NEW=$(grep -c "installed" ./.venv/.pip.log)
EXS=$(grep -c "satisfied" ./.venv/.pip.log)
ERR=$(grep -ciE "error|failed|could not" ./.venv/.pip.log)
echo "New: $NEW | Existing: $EXS | Errors: $ERR"
echo "Setup complete, command 'deactivate' to exit the virtual environment."
echo "To reactivate later, run: source scripts/setup.sh"
