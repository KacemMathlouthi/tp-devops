import os
import socket
from datetime import datetime, timezone
from pathlib import Path
from string import Template

from fastapi import FastAPI
from fastapi.responses import HTMLResponse

APP_VERSION = os.getenv("APP_VERSION", "dev")
POD_NAME = os.getenv("POD_NAME", socket.gethostname())
REPO_URL = "https://github.com/KacemMathlouthi/tp-devops"

app = FastAPI(title="tp-gitops")

PAGE = Template((Path(__file__).parent / "templates" / "index.html").read_text(encoding="utf-8"))


@app.get("/", response_class=HTMLResponse)
def index():
    rendered = datetime.now(timezone.utc).strftime("%H:%M:%S UTC")
    return PAGE.substitute(version=APP_VERSION, pod=POD_NAME, rendered=rendered, repo=REPO_URL)


@app.get("/version")
def version():
    return {"version": APP_VERSION, "pod": POD_NAME}


@app.get("/healthz")
def healthz():
    return {"status": "ok"}
