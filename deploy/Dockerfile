# Stage 1: Build dependencies & optimize for uv
FROM ghcr.io/astral-sh/uv:latest AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy
WORKDIR /app

# Copy from ROOT into container (../ because Dockerfile is in deploy/)
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project --no-dev

# Stage 2: Final Runtime
FROM python:3.12-slim-bookworm
WORKDIR /app
COPY --from=builder /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# Copy source from project root
COPY . .
# Expose the FastAPI/Backend port
EXPOSE 8000
# Start app (IF src/main.py runs the app. If not, adjust accordingly.)
CMD ["python", "src/main.py"]

