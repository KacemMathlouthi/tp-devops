FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:0.7.20 /uv /usr/local/bin/uv

ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION} \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-install-project
COPY main.py .
COPY templates templates

RUN useradd --uid 10001 --no-create-home app
USER 10001

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
