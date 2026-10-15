import os
import socket

from fastapi import FastAPI
from fastapi.responses import HTMLResponse

APP_VERSION = os.getenv("APP_VERSION", "dev")
POD_NAME = os.getenv("POD_NAME", socket.gethostname())

app = FastAPI(title="tp-gitops")

PAGE = """<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>TP GitOps - ArgoCD</title>
  <style>
    body {{ font-family: system-ui, sans-serif; display: grid; place-items: center; min-height: 100vh; margin: 0; background: #0f172a; color: #e2e8f0; }}
    .card {{ text-align: center; padding: 2rem 3rem; border: 1px solid #334155; border-radius: 12px; }}
    .version {{ font-size: 3rem; font-weight: 700; color: #38bdf8; margin: .5rem 0; }}
    .pod {{ font-family: monospace; color: #94a3b8; }}
  </style>
</head>
<body>
  <div class="card">
    <p>TP DevOps Avancé — GitOps avec ArgoCD</p>
    <p class="version">{version}</p>
    <p class="pod">servi par {pod}</p>
  </div>
</body>
</html>
"""


@app.get("/", response_class=HTMLResponse)
def index():
    return PAGE.format(version=APP_VERSION, pod=POD_NAME)


@app.get("/version")
def version():
    return {"version": APP_VERSION, "pod": POD_NAME}


@app.get("/healthz")
def healthz():
    return {"status": "ok"}
