// ── Tokens (Geist light) ────────────────────
#let ink           = rgb("#171717")
#let ink-2         = rgb("#4d4d4d")
#let ink-3         = rgb("#8f8f8f")
#let white         = rgb("#ffffff")
#let surface-2     = rgb("#fafafa")
#let border        = rgb("#ebebeb")
#let border-strong = rgb("#d4d4d4")
#let success       = rgb("#16a34a")
#let warning       = rgb("#ca8a04")

// ── Font family ─────────────────────────────
#let geist = "Geist"
#let geist-mono = "Geist Mono"
#let display = "Playfair Display"

// ── Code ────────────────────────────────────
#show raw.where(block: true): it => block(
  width: 100%, radius: 6pt, fill: surface-2, inset: 14pt, breakable: false,
  stroke: 0.5pt + border,
)[
  #set text(fill: ink, font: geist-mono, size: 7.5pt)
  #set par(justify: false)
  #it.text
]

#show raw.where(block: false): it => box(
  fill: surface-2, radius: 3pt,
  stroke: 0.5pt + border,
  inset: (x: 2pt, y: 0pt), outset: (y: 2.5pt),
)[#text(font: geist-mono, size: 8.5pt, fill: ink)[#it.text]]

// ── Headings ────────────────────────────────
#show heading.where(level: 1): it => {
  v(8pt)
  block(width: 100%, below: 18pt)[
    #set text(font: display, size: 26pt, weight: 600, fill: ink)
    #set par(justify: false)
    #it.body
  ]
}

#show heading.where(level: 2): it => {
  v(14pt)
  block(width: 100%, below: 8pt)[
    #set text(font: display, size: 15pt, weight: 600, fill: ink)
    #it.body
  ]
}

#show heading.where(level: 3): it => {
  v(8pt)
  block(width: 100%, below: 6pt)[
    #set text(font: geist, size: 10.5pt, weight: 600, fill: ink)
    #it.body
  ]
}

// ── Figures ─────────────────────────────────
#show figure: set block(above: 14pt, below: 18pt)
#show figure.caption: it => {
  set text(size: 8.5pt, fill: ink-2, font: geist)
  set par(justify: false)
  it
}
#set figure.caption(separator: [. ])
#show figure.caption: set align(left)

// ── Demo divider: a page with only the demo name ──
#let demo-page(n) = page(header: none, footer: none)[
  #align(center + horizon)[
    #text(font: display, size: 64pt, weight: 500, fill: ink)[Démo #n]
  ]
]

// ── Lists ───────────────────────────────────
#set list(marker: text(fill: ink-3)[–], indent: 2pt, body-indent: 8pt, spacing: 0.75em)
#set enum(numbering: n => text(fill: ink-3, font: geist-mono, size: 8.5pt)[#str(n)], indent: 2pt, body-indent: 8pt)

// ── Links ───────────────────────────────────
#show link: it => underline(stroke: 0.5pt + border-strong, offset: 2.5pt, it)

// ── Notes: one neutral surface, colour only for state ──
#let note-block(label, body, dot: none) = block(
  width: 100%, radius: 6pt, breakable: false,
  fill: surface-2,
  stroke: 0.5pt + border,
  inset: (x: 14pt, y: 12pt),
)[
  #text(weight: 600, fill: ink, size: 9.5pt)[
    #if dot != none [#box(circle(radius: 2.5pt, fill: dot), baseline: -1pt) #h(4pt)]
    #label
  ]
  #v(4pt)
  #set text(fill: ink-2, size: 9.5pt)
  #body
]

#let info-box(title, body) = note-block(title, body)
#let success-box(body) = note-block([Résultat], body, dot: success)
#let warn-box(body) = note-block([Attention], body, dot: warning)

#let cmd(body) = box(
  fill: surface-2, radius: 3pt,
  stroke: 0.5pt + border,
  inset: (x: 2pt, y: 0pt), outset: (y: 2.5pt),
)[#text(font: geist-mono, size: 8.5pt, fill: ink)[#body]]

// ── Label / value rows separated by hairlines ──
#let deflist(..rows) = { set par(justify: false); table(
  columns: (auto, 1fr),
  stroke: (x, y) => (top: 0.5pt + border, bottom: 0.5pt + border),
  inset: (left: 0pt, right: 18pt, y: 7pt),
  align: left + top,
  ..rows.pos().chunks(2).map(((k, v)) => (
    text(weight: 500, fill: ink)[#k], text(fill: ink-2)[#v],
  )).flatten(),
) }

// ── Screenshots ─────────────────────────────
#let shot(name, caption) = figure(
  box(stroke: 0.5pt + border, radius: 4pt, clip: true,
    image("screenshots/" + name, width: 100%)),
  caption: caption,
)

#let shot-w(name, w, caption) = figure(
  box(stroke: 0.5pt + border, radius: 4pt, clip: true,
    image("screenshots/" + name, width: w)),
  caption: caption,
)

#let todo-shot(caption) = figure(
  block(
    width: 100%, height: 110pt, radius: 6pt,
    stroke: (paint: border-strong, thickness: 0.6pt, dash: "dashed"),
  )[#align(center + horizon)[#text(fill: ink-3, size: 9pt)[Capture à ajouter]]],
  caption: caption,
)

// ── Page setup ──────────────────────────────
#set page(
  paper: "a4",
  fill: white,
  margin: (top: 26mm, bottom: 24mm, left: 24mm, right: 24mm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: ink-3, font: geist)
      #grid(
        columns: (1fr, 1fr),
        [#text(fill: ink, weight: 500)[TP1] #h(4pt) GitOps et ArgoCD],
        align(right)[DevOps avancé, 2026–2027]
      )
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: ink-3, font: geist)
      #grid(
        columns: (1fr, 1fr),
        [Mathlouthi, Kraiem, Haouas],
        align(right)[#counter(page).display("1 / 1", both: true)]
      )
    ]
  },
)

#set text(font: geist, size: 10pt, fill: ink, lang: "fr", number-type: "lining")
#set par(justify: true, leading: 0.75em, spacing: 1.1em)
#set heading(numbering: none)

// ═══════════════════════════════════════════
//  COVER PAGE
// ═══════════════════════════════════════════
#page(margin: (top: 26mm, bottom: 26mm, left: 24mm, right: 24mm), header: none, footer: none)[
  #set par(justify: false)

  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    image("screenshots/uni.png", width: 54pt),
    text(size: 9pt, fill: ink-3)[DevOps avancé #linebreak() Année universitaire 2026–2027],
  )

  #v(1fr)

  #text(size: 10pt, fill: ink-2)[Travaux pratiques, TP1]
  #v(10pt)
  #block(width: 90%)[
    #text(font: display, size: 40pt, weight: 600, fill: ink)[Continuous Deployment avec GitOps et ArgoCD]
  ]
  #v(14pt)
  #block(width: 72%)[
    #text(size: 13pt, fill: ink-2)[Un dépôt Git décrit l'état désiré du cluster. ArgoCD le surveille, l'applique, corrige toute dérive et permet de revenir à une version stable.]
  ]

  #v(1.4fr)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 24pt,
    [
      #text(size: 9pt, fill: ink-3)[Réalisé par]
      #v(6pt)
      #text(size: 10.5pt, weight: 500)[Kacem Mathlouthi #linebreak() Oussema Kraiem #linebreak() Med Amin Haouas]
    ],
    [
      #text(size: 9pt, fill: ink-3)[Dépôt]
      #v(6pt)
      #text(font: geist-mono, size: 9pt)[github.com/KacemMathlouthi/tp-devops]
      #v(10pt)
      #text(size: 9pt, fill: ink-3)[Image]
      #v(6pt)
      #text(font: geist-mono, size: 9pt)[ghcr.io/kacemmathlouthi/tp-devops]
    ],
  )
]

// ═══════════════════════════════════════════
//  TABLE OF CONTENTS
// ═══════════════════════════════════════════
#show outline.entry.where(level: 1): it => {
  v(6pt)
  text(weight: 500, it)
}
#outline(
  title: text(font: display, size: 26pt, weight: 600, fill: ink)[Table des matières],
  indent: 1.2em,
  depth: 2,
)
#pagebreak()


// ═══════════════════════════════════════════
//  PRÉSENTATION
// ═══════════════════════════════════════════
= Présentation générale

== Objectif

- Décrire l'application et son infrastructure Kubernetes de façon déclarative dans Git.
- Laisser ArgoCD, installé dans le cluster, appliquer cet état : le cluster #emph[tire] sa configuration, aucun #cmd[kubectl apply] externe.
- Démontrer cinq concepts :

#deflist(
  [Single Source of Truth], [tout l'état désiré vit dans Git],
  [Pull-based CD],          [chaque commit est appliqué automatiquement par ArgoCD],
  [Drift et self-healing],  [toute modification manuelle du cluster est annulée],
  [Sync et Health],         [conforme à Git (#emph[Synced]) ne veut pas dire fonctionnel (#emph[Healthy])],
  [Rollback et historique], [retour instantané à une révision stable],
)

== Application

- API #cmd[FastAPI] (Python 3.12, #cmd[uv]), libre choix laissé par le sujet.
- #cmd[GET /] : page affichant la version déployée et le pod qui répond.
- #cmd[GET /version] : même information en JSON.
- #cmd[GET /healthz] : sonde readiness / liveness.
- Version injectée au build (#cmd[ARG APP_VERSION]) : chaque déploiement est visible dans le navigateur.

== Construction de l'image

- GitHub Action (#cmd[.github/workflows/build.yml]) déclenchée par un tag Git #cmd[v\*].
- Build puis push vers #cmd[ghcr.io/kacemmathlouthi/tp-devops:<tag>].
- La CI n'a aucun accès au cluster : elle produit l'image, ArgoCD la déploie.

```bash
git tag v2 && git push origin v2   # → ghcr.io/kacemmathlouthi/tp-devops:v2
```

#shot-w("11-ci-build-v1.png", 75%,
  [Le push du tag #cmd[v1] déclenche le workflow #cmd[build] (34 s)],
)

== Stack technique

#deflist(
  [Cluster],     [minikube (driver Docker) sous WSL 2],
  [GitOps],      [ArgoCD v3.5.5, namespace #cmd[argocd]],
  [Manifests],   [Kustomize : #cmd[base] + overlay #cmd[dev]],
  [Dépôt],       [GitHub public #cmd[KacemMathlouthi/tp-devops], branche #cmd[main]],
  [Application], [FastAPI, image Docker non-root],
  [CI],          [GitHub Actions → GHCR],
)

== Architecture

```
 Développeur          GitHub (SSOT)                    Cluster minikube
 ───────────          ─────────────                    ────────────────
 git push ────────▶  tp-devops (main)       ◀──pull──  argocd
 git tag vX           ├── app/                          ├── repo-server    : rend Kustomize
                      └── k8s/overlays/dev              ├── app-controller : compare & sync
                             │                          └── server (UI)    : localhost:8080
                             ▼ tag vX                            │ apply
                      GitHub Actions                             ▼
                             │ docker push              tp-gitops
                             ▼                          ├── Deployment web
                      ghcr.io/.../tp-devops:vX ◀─pull── ├── Pods (FastAPI)
                                                        └── Service web
```

// ═══════════════════════════════════════════
//  ÉTAPE 1, DÉPÔT
// ═══════════════════════════════════════════
= Étape 1 : structure du dépôt Git

== Organisation

- Un seul dépôt : code, CI, manifests, Application ArgoCD et rapport.
- ArgoCD ne lit que #cmd[k8s/overlays/dev] ; le reste n'affecte pas la synchronisation.

```
tp-devops/
├── app/                          # code applicatif + Dockerfile
├── .github/workflows/build.yml   # build + push de l'image sur tag vX
├── k8s/
│   ├── base/                     # Deployment, Service, kustomization
│   └── overlays/dev/             # namespace, réplicas, tag d'image
├── argocd/application.yaml       # l'Application ArgoCD
└── compte-rendu/                 # ce rapport
```

== Base Kustomize

- Décrit l'application indépendamment de l'environnement : #cmd[Deployment] + #cmd[Service] + labels communs.
- #cmd[readinessProbe] / #cmd[livenessProbe] sur #cmd[/healthz] : base du Health Status d'ArgoCD.
- #cmd[POD_NAME] injecté via l'API downward.
- Requests / limits CPU et mémoire.
- #cmd[progressDeadlineSeconds: 60] : un rollout bloqué passe en échec en 1 min au lieu de 10.
- Service #cmd[ClusterIP] 80 → 8000 sur le label #cmd[app: web].

```yaml
# k8s/base/kustomization.yaml
labels:
  - pairs:
      app.kubernetes.io/name: web
      app.kubernetes.io/part-of: tp-gitops
resources:
  - deployment.yaml
  - service.yaml
```

== Overlay #cmd[dev]

- Seul fichier modifié pendant les démonstrations.
- Fixe le namespace, le nombre de réplicas et le tag de l'image.
- Rendu vérifiable sans cluster : #cmd[kubectl kustomize k8s/overlays/dev].

```yaml
# k8s/overlays/dev/kustomization.yaml
namespace: tp-gitops
resources:
  - ../../base
replicas:
  - name: web
    count: 2
images:
  - name: ghcr.io/kacemmathlouthi/tp-devops
    newTag: v1
```

#shot(
  "10-github-repo.png",
  [Dépôt public #cmd[KacemMathlouthi/tp-devops], avec le package GHCR lié],
)

// ═══════════════════════════════════════════
//  ÉTAPE 2, ARGOCD
// ═══════════════════════════════════════════
= Étape 2 : installation et configuration d'ArgoCD

== Cluster Kubernetes

- minikube mono-nœud, driver Docker, sous WSL 2.
- 2 vCPU et ~4 Go de RAM suffisent pour Kubernetes, ArgoCD et l'application.

```bash
minikube start --driver=docker --cpus=2 --memory=4g
kubectl config use-context minikube
```

#shot(
  "01-minikube-start.png",
  [Démarrage du cluster (Kubernetes v1.34.0)],
)

== Installation d'ArgoCD

- Manifests officiels dans le namespace #cmd[argocd].
- #cmd[--server-side] requis : certaines CRD dépassent la taille de l'annotation #cmd[last-applied-configuration].

```bash
kubectl create namespace argocd
kubectl apply -n argocd --server-side \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd rollout status deploy/argocd-server
```

#shot(
  "02-argocd-pods.png",
  [Les 7 pods ArgoCD en état #cmd[Running]],
)

== Accès à l'interface

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

#shot(
  "03-argocd-admin-password.png",
  [Mot de passe initial de #cmd[admin] (masqué)],
)

#shot(
  "04-argocd-port-forward.png",
  [UI exposée sur #cmd[https://localhost:8080]],
)

#shot(
  "05-argocd-ui-empty.png",
  [Première connexion : aucune application],
)

== Création de l'Application

- Décrite dans Git (#cmd[argocd/application.yaml]), comme le reste.
- Seule commande #cmd[kubectl apply] du TP : ArgoCD crée ensuite lui-même le namespace et les ressources.

```yaml
spec:
  source:
    repoURL: https://github.com/KacemMathlouthi/tp-devops.git
    targetRevision: main
    path: k8s/overlays/dev
  destination:
    server: https://kubernetes.default.svc
    namespace: tp-gitops
  syncPolicy:
    automated:
      prune: true      # supprime ce qui a disparu de Git
      selfHeal: true   # annule les modifications manuelles
    syncOptions:
      - CreateNamespace=true
```

#deflist(
  [automated], [synchronise dès qu'un nouveau commit est détecté],
  [selfHeal],  [réapplique Git si le cluster dérive],
  [prune],     [supprime du cluster ce qui est retiré de Git],
  [Polling],   [Git interrogé toutes les 3 min ; #emph[Refresh] force une vérification],
)

```bash
kubectl apply -f argocd/application.yaml
```

#shot(
  "06-app-apply-pods.png",
  [Création de l'Application : les deux pods passent #cmd[Running 1/1] en moins de 30 s],
)

#shot(
  "08-argocd-app-tree.png",
  [Arbre des ressources : Service, Deployment, ReplicaSet, 2 pods],
)

- #emph[App Health] et #emph[Sync Status] sont affichés séparément : deux indicateurs indépendants (démo 3).

```bash
kubectl -n tp-gitops port-forward svc/web 8081:80
```

#grid(
  columns: (1fr, 1fr),
  column-gutter: 16pt,
  align: horizon,
  figure(
    image("screenshots/07-argocd-app-tile.png", width: 100%),
    caption: [#cmd[tp-gitops] : #emph[Healthy] et #emph[Synced]],
  ),
  figure(
    image("screenshots/09-app-v1.png", width: 100%),
    caption: [Application servie : version #cmd[v1]],
  ),
)


// ═══════════════════════════════════════════
//  DÉMO 1
// ═══════════════════════════════════════════
#demo-page(1)

= Démo 1 : déploiement continu automatisé

*Objectif* : un commit suffit à modifier le cluster, sans commande #cmd[kubectl].

== Préparation : image v2

- Nouvelle version de la page, publiée par un tag Git.
- La CI produit l'image mais ne déploie rien : tant que Git ne la référence pas, le cluster ne change pas.

#shot(
  "12-ci-build-v2.png",
  [Le tag #cmd[v2] construit et publie #cmd[tp-devops:v2] (32 s)],
)

== Changement dans Git

```diff
# k8s/overlays/dev/kustomization.yaml
-    newTag: v1
+    newTag: v2
```

```bash
git commit -am "feat(k8s): deploy v2" && git push
```

== Synchronisation par ArgoCD

- Nouveau commit détecté (polling ou #emph[Refresh]), appliqué par la politique #cmd[automated].
- Kubernetes effectue un rolling update (#cmd[maxSurge] / #cmd[maxUnavailable] à 25 %) :
  - un pod v2 démarre ;
  - un pod v1 n'est supprimé qu'une fois le pod v2 prêt ;
  - jamais moins de deux pods disponibles.

#shot(
  "13-demo1-argocd-progressing.png",
  [#emph[Synced] mais #emph[Progressing] : le ReplicaSet v2 démarre son premier pod, les pods v1 servent encore],
)

#shot(
  "14-demo1-argocd-healthy.png",
  [#emph[Healthy] et #emph[Synced] : 2 pods v2, l'ancien ReplicaSet conservé à 0],
)

#figure(
  box(stroke: 0.5pt + border, radius: 4pt, clip: true, image("screenshots/15-demo1-app-v2.png", width: 70%)),
  caption: [La page affiche la version #cmd[v2]],
)

#success-box([
  - Un commit d'une ligne a déployé la v2.
  - Aucune intervention sur le cluster, aucune interruption de service.
])

// ═══════════════════════════════════════════
//  DÉMO 2
// ═══════════════════════════════════════════
#demo-page(2)

= Démo 2 : drift et self-healing

*Objectif* : modifier le cluster à la main et voir ArgoCD rétablir l'état de Git.

== Suppression du Deployment

```bash
kubectl -n tp-gitops delete deployment web
```

#shot(
  "16-demo2-delete.png",
  [Suppression manuelle du Deployment, sans passer par Git],
)

- L'application-controller surveille les ressources gérées via l'API Kubernetes (#emph[watches]).
- L'écart est détecté immédiatement, sans attendre le polling de Git.
- #cmd[selfHeal: true] relance aussitôt une synchronisation.

#shot(
  "17-demo2-argocd-recreating.png",
  [Quelques secondes après : Deployment déjà recréé, pods en démarrage (#emph[Progressing])],
)

#shot(
  "18-demo2-argocd-healed.png",
  [~15 s après : #emph[Healthy] et #emph[Synced]],
)

- Preuves de la recréation :
  - le Service garde son âge (40 min), le Deployment et les pods sont neufs ;
  - le Deployment repart en #cmd[rev:1] : son historique a disparu avec lui ;
  - nouveaux noms de pods, même hash de template (même manifeste Git).

== Drift sur un champ : réplicas

```bash
kubectl -n tp-gitops scale deploy web --replicas=5
```

#shot(
  "19-demo2-scale.png",
  [Passage manuel à 5 réplicas],
)

#shot(
  "20-demo2-argocd-scale-reverted.png",
  [ArgoCD rétablit #cmd[replicas: 2] : les pods en trop sont déjà en #cmd[terminating]],
)

#shot-w("21-demo2-pods-watch.png", 40%,
  [Les 3 pods supplémentaires passent en #cmd[Terminating] dès leur création],
)

- Correction si rapide que l'état #emph[OutOfSync] n'est même pas visible.

#success-box([
  - Toute modification faite hors de Git est annulée en quelques secondes.
  - Pour changer durablement le cluster, il faut passer par un commit.
])

// ═══════════════════════════════════════════
//  DÉMO 3
// ═══════════════════════════════════════════
#demo-page(3)

= Démo 3 : Sync Status et Health Status

*Objectif* : une application peut être synchronisée avec Git tout en étant défaillante.

== Deux indicateurs indépendants

#deflist(
  [Sync Status],   [manifests du cluster = manifests de Git ? #emph[Synced] / #emph[OutOfSync]],
  [Health Status], [les ressources fonctionnent-elles ? #emph[Healthy] / #emph[Progressing] / #emph[Degraded]],
)

== Erreur introduite dans Git

```diff
# k8s/overlays/dev/kustomization.yaml
-    newTag: v2
+    newTag: doesnotexist
```

```bash
git commit -am "feat(k8s): deploy nonexistent image" && git push
```

== Synced, puis Degraded

#shot(
  "22-demo3-argocd-progressing.png",
  [#emph[Synced] mais #emph[Progressing] : le nouveau pod échoue en #cmd[errimagepull]],
)

#shot(
  "23-demo3-argocd-degraded.png",
  [Après 60 s : toujours #emph[Synced], mais #emph[Degraded]],
)

- Le passage à #emph[Degraded] vient de Kubernetes : #cmd[ProgressDeadlineExceeded] après #cmd[progressDeadlineSeconds] (60 s).

#shot(
  "24-demo3-pod-events.png",
  [Événements du pod : #cmd[manifest unknown], puis #cmd[ErrImagePull] / #cmd[ImagePullBackOff]],
)

#shot-w("25-demo3-pods-watch.png", 70%,
  [Nouvelles tentatives à intervalles croissants ; les deux pods v2 restent #cmd[Running]],
)

- #cmd[ErrImagePull] : la tentative de pull vient d'échouer.
- #cmd[ImagePullBackOff] : attente avant la tentative suivante (délai croissant).
- Pas d'interruption : le pod cassé n'est jamais prêt, donc les pods v2 ne sont pas supprimés.

#success-box([
  - #emph[Synced] : ArgoCD a appliqué exactement ce que dit Git.
  - #emph[Degraded] : ce que dit Git ne fonctionne pas.
  - La synchronisation garantit la conformité à Git, pas le bon fonctionnement.
])

// ═══════════════════════════════════════════
//  DÉMO 4
// ═══════════════════════════════════════════
#demo-page(4)

= Démo 4 : historique et rollback

*Objectif* : revenir à une version stable depuis #emph[History and Rollback].

*Point de départ* : #emph[Synced] mais #emph[Degraded] sur #cmd[8a2a887] (image #cmd[doesnotexist]).

== Désactivation de l'auto-sync

- ArgoCD refuse le rollback tant que l'auto-sync est actif.
- Sinon, il réappliquerait aussitôt la révision de Git, donc la version cassée.

#figure(
  image("screenshots/26-demo4-disable-autosync.png", width: 85%),
  caption: [Désactivation de la synchronisation automatique],
)

#figure(
  image("screenshots/27-demo4-autosync-disabled.png", width: 45%),
  caption: [Sync Policy à #emph[None]],
)

== Historique

- Chaque synchronisation est enregistrée : révision, auteur, message, date, origine.
- 10 entrées conservées (#cmd[revisionHistoryLimit]).
- La v2 apparaît sous un message #cmd[docs(cr)] : ArgoCD enregistre la tête de branche au moment de la synchronisation.

#figure(
  image("screenshots/28-demo4-history.png", width: 60%),
  caption: [#cmd[8a2a887] (cassée), #cmd[51974a2] (v2), #cmd[6ce6324] (v1)],
)

== Rollback

#figure(
  image("screenshots/29-demo4-rollback-dialog.png", width: 85%),
  caption: [Rollback vers #cmd[51974a2]],
)

#shot(
  "30-demo4-healthy-outofsync.png",
  [#emph[Healthy], mais #emph[OutOfSync] : Git référence toujours l'image cassée],
)

- Quasi instantané, aucun nouveau pod : Kubernetes réutilise l'ancien ReplicaSet v2 (#cmd[rev:3]).
- #emph[OutOfSync] est attendu : le cluster ne correspond plus à Git.
- Le rollback UI est une mesure d'urgence qui court-circuite la source de vérité.

== Retour à Git

```bash
git revert 8a2a887   # newTag: doesnotexist → v2
git push
```

#shot(
  "31-demo4-synced-after-revert.png",
  [#emph[Synced] et #emph[Healthy] sans aucune synchronisation : Git décrit de nouveau ce qui tourne],
)

#figure(
  image("screenshots/32-demo4-history-after-rollback.png", width: 60%),
  caption: [Le rollback apparaît dans l'historique, initié par #cmd[admin]],
)

#grid(
  columns: (1fr, 1.4fr),
  column-gutter: 16pt,
  align: horizon,
  figure(
    image("screenshots/33-demo4-autosync-reenabled.png", width: 100%),
    caption: [Auto-sync réactivé],
  ),
  figure(
    image("screenshots/34-demo4-final-synced.png", width: 100%),
    caption: [État final : #emph[Synced], #emph[Auto sync is enabled]],
  ),
)

#block(breakable: false, table(
  columns: (auto, 1fr, 1fr),
  stroke: (x, y) => (top: 0.5pt + border, bottom: 0.5pt + border),
  inset: (x: 8pt, y: 7pt),
  align: left + top,
  table.header([], text(weight: 500)[Rollback ArgoCD (UI)], text(weight: 500)[#cmd[git revert] + push]),
  [Délai], [immédiat], [polling ou Refresh],
  [Traçabilité], [historique ArgoCD], [historique Git, relisible],
  [Auto-sync], [doit être désactivé], [reste actif],
  [Usage], [urgence], [correction pérenne],
))

#success-box([
  - Retour à la dernière version saine en un clic, #emph[Healthy] en quelques secondes.
  - #cmd[git revert] puis réactivation de l'auto-sync : Git redevient la seule source de vérité.
])

// ═══════════════════════════════════════════
//  CONCLUSION
// ═══════════════════════════════════════════
= Conclusion

== Concepts démontrés

#deflist(
  [Single Source of Truth], [tout l'état désiré est dans Git ; une seule commande #cmd[kubectl apply] (l'Application)],
  [Pull-based CD],          [démo 1 : un commit d'une ligne déploie la v2, sans interruption],
  [Drift et self-healing],  [démo 2 : Deployment supprimé recréé, scale manuel annulé, en quelques secondes],
  [Sync et Health],         [démo 3 : image inexistante → #emph[Synced] mais #emph[Degraded]],
  [Rollback et historique], [démo 4 : rollback en un clic, puis #cmd[git revert]],
)

== Limites et pistes

- Polling de Git (3 min) : un webhook GitHub rendrait la détection immédiate.
- Le rollback UI impose de suspendre l'auto-sync et doit être suivi d'une correction dans Git.
- ArgoCD applique fidèlement une erreur : revue de code, vérification de l'image en CI ou déploiement progressif (Argo Rollouts) en amont.
- Base / overlay : ajouter un environnement #cmd[prod] = un overlay + une Application.

#info-box([Dépôt], [
  - GitHub : #link("https://github.com/KacemMathlouthi/tp-devops")[github.com/KacemMathlouthi/tp-devops]
])
