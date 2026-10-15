import os
import socket
from datetime import datetime, timezone
from string import Template

from fastapi import FastAPI
from fastapi.responses import HTMLResponse

APP_VERSION = os.getenv("APP_VERSION", "dev")
POD_NAME = os.getenv("POD_NAME", socket.gethostname())
REPO_URL = "https://github.com/KacemMathlouthi/tp-devops"

app = FastAPI(title="tp-gitops")

PAGE = Template("""<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="color-scheme" content="dark">
  <title>tp-devops $version</title>
  <link rel="icon" href="data:,">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Geist:wght@400..600&family=Geist+Mono:wght@400..600&display=swap" rel="stylesheet" referrerpolicy="no-referrer">
  <style>
    :root {
      --bg: #0a0a0a;
      --text: #ededed;
      --text-2: #a1a1a1;
      --border: #2e2e2e;
      --border-subtle: #1f1f1f;
      --sans: "Geist", ui-sans-serif, system-ui, sans-serif;
      --mono: "Geist Mono", ui-monospace, SFMono-Regular, monospace;
    }
    * { box-sizing: border-box; }
    html { color-scheme: dark; }
    body {
      margin: 0; background: var(--bg); color: var(--text);
      font: 400 16px/1.6 var(--sans);
      -webkit-font-smoothing: antialiased;
    }
    a { color: inherit; text-underline-offset: 3px; text-decoration-color: var(--border); }
    a:hover { text-decoration-color: var(--text); }
    a:focus-visible { outline: 2px solid var(--text); outline-offset: 2px; border-radius: 2px; }
    .mono { font-family: var(--mono); font-size: 0.875em; }

    .shell { max-width: 1080px; margin: 0 auto; padding: 0 24px; display: grid; min-height: 100vh; grid-template-rows: auto 1fr auto; }
    header, footer { display: flex; justify-content: space-between; align-items: baseline; gap: 16px; padding: 24px 0; font-size: 14px; color: var(--text-2); }
    header .id { color: var(--text); font-weight: 500; }

    main { display: grid; gap: 96px; padding: 64px 0 96px; align-content: start; }

    .opening { display: grid; grid-template-columns: repeat(12, minmax(0, 1fr)); column-gap: 24px; row-gap: 48px; align-items: end; }
    .claim { grid-column: span 7; min-width: 0; }
    .label { margin: 0 0 8px; font-size: 14px; color: var(--text-2); }
    h1 { margin: 0; font-size: clamp(96px, 18vw, 184px); line-height: 0.9; font-weight: 600; letter-spacing: -0.06em; font-variant-numeric: tabular-nums; }
    .lede { margin: 24px 0 0; font-size: 20px; line-height: 1.5; color: var(--text-2); max-width: 36ch; }
    .lede strong { color: var(--text); font-weight: 500; }

    dl { grid-column: span 5; margin: 0; min-width: 0; }
    dl div { display: grid; grid-template-columns: 112px minmax(0, 1fr); gap: 16px; padding: 12px 0; border-top: 1px solid var(--border-subtle); }
    dl div:last-child { border-bottom: 1px solid var(--border-subtle); }
    dt { font-size: 14px; color: var(--text-2); }
    dd { margin: 0; overflow-wrap: anywhere; }
    dd a + a { margin-left: 12px; }

    h2 { margin: 0 0 32px; font-size: 24px; line-height: 1.3; font-weight: 600; letter-spacing: -0.02em; }
    ol { list-style: none; margin: 0; padding: 0; display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 24px; }
    ol li { position: relative; padding-top: 28px; border-top: 1px solid var(--border); min-width: 0; }
    ol li::before { content: ""; position: absolute; top: -5px; left: 0; width: 9px; height: 9px; border-radius: 50%; background: var(--bg); border: 1px solid var(--text-2); }
    ol li[aria-current]::before { background: var(--text); border-color: var(--text); }
    ol li[aria-current] { border-top-color: var(--text); }
    .step { display: block; margin-bottom: 8px; font-family: var(--mono); font-size: 14px; color: var(--text); }
    ol p { margin: 0; font-size: 15px; color: var(--text-2); }

    @media (max-width: 800px) {
      main { gap: 64px; padding: 32px 0 64px; }
      .claim, dl { grid-column: 1 / -1; }
      ol { grid-template-columns: repeat(2, minmax(0, 1fr)); row-gap: 40px; }
    }
    @media (max-width: 480px) {
      .shell { padding: 0 16px; }
      ol { grid-template-columns: 1fr; }
      header, footer { flex-direction: column; gap: 4px; }
    }
  </style>
</head>
<body>
  <div class="shell">
    <header>
      <span class="id">tp-devops</span>
      <span>DevOps avancé, TP1 GitOps</span>
    </header>

    <main>
      <section class="opening" aria-labelledby="version">
        <div class="claim">
          <p class="label">Version déployée</p>
          <h1 id="version">$version</h1>
          <p class="lede">Servie par <strong class="mono">$pod</strong>. Rechargez pour voir une autre réplique répondre.</p>
        </div>
        <dl>
          <div><dt>Pod</dt><dd class="mono">$pod</dd></div>
          <div><dt>Image</dt><dd class="mono">tp-devops:$version</dd></div>
          <div><dt>Rendu</dt><dd class="mono">$rendered</dd></div>
          <div><dt>API</dt><dd><a class="mono" href="/version">/version</a><a class="mono" href="/healthz">/healthz</a></dd></div>
        </dl>
      </section>

      <section aria-labelledby="flow">
        <h2 id="flow">De Git jusqu'à ce pod</h2>
        <ol>
          <li><span class="step">git tag $version</span><p>GitHub Actions construit l'image et la publie sur GHCR.</p></li>
          <li><span class="step">newTag: $version</span><p>Le tag est modifié dans l'overlay Kustomize puis poussé sur main.</p></li>
          <li><span class="step">argocd sync</span><p>ArgoCD détecte l'écart entre Git et le cluster et applique le manifeste.</p></li>
          <li aria-current="step"><span class="step">rolling update</span><p>Kubernetes remplace les pods un par un. Cette page en est le résultat.</p></li>
        </ol>
      </section>
    </main>

    <footer>
      <span>Déployé par ArgoCD depuis <a href="$repo">github.com/KacemMathlouthi/tp-devops</a></span>
    </footer>
  </div>
</body>
</html>
""")


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
