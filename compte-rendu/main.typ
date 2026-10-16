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

// ── Code ────────────────────────────────────
#show raw.where(block: true): it => block(
  width: 100%, radius: 6pt, fill: surface-2, inset: 14pt,
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
    #set text(font: geist, size: 22pt, weight: 600, fill: ink, tracking: -0.9pt)
    #set par(justify: false)
    #it.body
  ]
}

#show heading.where(level: 2): it => {
  v(14pt)
  block(width: 100%, below: 8pt)[
    #set text(font: geist, size: 13pt, weight: 600, fill: ink, tracking: -0.35pt)
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

// ── Lists ───────────────────────────────────
#set list(marker: text(fill: ink-3)[–], indent: 2pt, body-indent: 8pt)
#set enum(numbering: n => text(fill: ink-3, font: geist-mono, size: 8.5pt)[#str(n)], indent: 2pt, body-indent: 8pt)

// ── Links ───────────────────────────────────
#show link: it => underline(stroke: 0.5pt + border-strong, offset: 2.5pt, it)

// ── Notes: one neutral surface, colour only for state ──
#let note-block(label, body, dot: none) = block(
  width: 100%, radius: 6pt,
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
  #block(width: 88%)[
    #text(size: 38pt, weight: 600, fill: ink, tracking: -1.8pt)[Continuous Deployment avec GitOps et ArgoCD]
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
  title: text(font: geist, size: 22pt, weight: 600, fill: ink, tracking: -0.9pt)[Table des matières],
  indent: 1.2em,
  depth: 2,
)
#pagebreak()


// ═══════════════════════════════════════════
//  1. PRÉSENTATION
// ═══════════════════════════════════════════
= Présentation générale

== Objectif

Ce TP met en place un pipeline GitOps de bout en bout : l'état désiré de l'application et de ses ressources Kubernetes est décrit de façon déclarative dans un dépôt Git, et ArgoCD, installé dans le cluster, se charge de le faire converger vers cet état. Aucun #cmd[kubectl apply] n'est lancé depuis l'extérieur pour déployer : le cluster #emph[tire] (pull) sa configuration depuis Git.

Le TP doit démontrer cinq concepts :

#deflist(
  [Single Source of Truth], [Tout l'état désiré vit dans Git : manifests Kustomize et définition de l'Application ArgoCD.],
  [Pull-based CD],          [ArgoCD surveille le dépôt et applique automatiquement chaque commit.],
  [Drift et self-healing],  [Toute modification manuelle du cluster est détectée puis annulée.],
  [Sync et Health],         [Un manifeste conforme à Git (#emph[Synced]) peut produire des pods en échec (#emph[Degraded]).],
  [Rollback et historique], [Retour instantané à une révision stable depuis l'onglet #emph[History and Rollback].],
)

== Application support

Le sujet laissant le choix de l'application, nous avons retenu une petite API #cmd[FastAPI] (Python 3.12, dépendances gérées par #cmd[uv]) qui expose trois routes :

- #cmd[GET /] : page HTML affichant la version déployée et le nom du pod qui a servi la requête ;
- #cmd[GET /version] : la même information au format JSON ;
- #cmd[GET /healthz] : sonde utilisée par Kubernetes (readiness et liveness).

La version affichée est injectée au build de l'image (#cmd[ARG APP_VERSION]) : chaque démonstration est ainsi visible directement dans le navigateur, et le nom du pod permet de constater la répartition de charge entre réplicas.

== Construction de l'image

Le dépôt contient le code applicatif (#cmd[app/]) et une GitHub Action (#cmd[.github/workflows/build.yml]) qui, à chaque tag Git #cmd[v\*], construit l'image et la publie sur GitHub Container Registry :

```bash
git tag v2 && git push origin v2
# → ghcr.io/kacemmathlouthi/tp-devops:v2
```

#info-box([Séparation CI / CD], [
  La CI (GitHub Actions) se contente de #emph[produire] une image versionnée ; elle n'a aucun accès au cluster. Le déploiement (CD) est entièrement piloté par ArgoCD, qui #emph[tire] l'état désiré depuis Git : changer la version déployée revient à modifier le tag dans l'overlay Kustomize et à pousser le commit.
])

#shot(
  "11-ci-build-v1.png",
  [GitHub Actions : le push du tag #cmd[v1] déclenche le workflow #cmd[build] (34 s) qui construit et publie l'image],
)

== Stack technique

#deflist(
  [Cluster],     [minikube (driver Docker) sous WSL 2],
  [GitOps],      [ArgoCD (manifests officiels, namespace #cmd[argocd])],
  [Manifests],   [Kustomize : une #cmd[base] et un overlay #cmd[dev]],
  [Dépôt],       [GitHub public #cmd[KacemMathlouthi/tp-devops], branche #cmd[main]],
  [Application], [FastAPI (Python 3.12, uv), image Docker non-root],
  [CI],          [GitHub Actions vers #cmd[ghcr.io/kacemmathlouthi/tp-devops:<tag>]],
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

#pagebreak()

// ═══════════════════════════════════════════
//  ÉTAPE 1, DÉPÔT
// ═══════════════════════════════════════════
= Étape 1 : structure du dépôt Git

== Organisation

Un seul dépôt contient l'ensemble du TP : code applicatif, pipeline de build et manifests. ArgoCD ne lit que le chemin #cmd[k8s/overlays/dev] ; le reste du dépôt (code, rapport, définition de l'Application) ne perturbe donc pas la synchronisation.

```
tp-devops/
├── app/                          # code applicatif
│   ├── main.py                   # API FastAPI
│   ├── pyproject.toml, uv.lock   # dépendances (uv)
│   └── Dockerfile
├── .github/workflows/build.yml   # build + push de l'image sur tag vX
├── k8s/
│   ├── base/                     # ressources communes
│   │   ├── kustomization.yaml
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── overlays/
│       └── dev/
│           └── kustomization.yaml  # namespace, replicas, tag d'image
├── argocd/
│   └── application.yaml          # l'Application ArgoCD (déclarative elle aussi)
└── compte-rendu/                 # ce rapport
```

== Base Kustomize

La base décrit l'application indépendamment de tout environnement : un #cmd[Deployment] et un #cmd[Service], auxquels Kustomize ajoute des labels communs.

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

Points notables du #cmd[Deployment] :

- sondes #cmd[readinessProbe] et #cmd[livenessProbe] sur #cmd[/healthz] : c'est sur elles que repose le #emph[Health Status] calculé par ArgoCD ;
- variable #cmd[POD_NAME] injectée via l'API downward, affichée par l'application ;
- requests/limits CPU et mémoire ;
- #cmd[progressDeadlineSeconds: 60] : en cas d'image introuvable, Kubernetes marque le rollout en échec au bout d'une minute (au lieu de 10 par défaut) et ArgoCD affiche alors #emph[Degraded].

Le #cmd[Service] (#cmd[ClusterIP], port 80 → 8000) répartit le trafic entre les pods portant le label #cmd[app: web].

== Overlay #cmd[dev]

L'overlay est le seul fichier modifié pendant les démonstrations : il fixe le namespace, le nombre de réplicas et le tag de l'image.

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

Le rendu final peut être vérifié localement sans cluster :

```bash
kubectl kustomize k8s/overlays/dev
```

#shot(
  "10-github-repo.png",
  [Dépôt public #cmd[KacemMathlouthi/tp-devops] : code applicatif, workflow CI, manifests Kustomize, Application ArgoCD et rapport ; le package GHCR #cmd[tp-devops] est lié au dépôt],
)

#pagebreak()

// ═══════════════════════════════════════════
//  ÉTAPE 2, ARGOCD
// ═══════════════════════════════════════════
= Étape 2 : installation et configuration d'ArgoCD

== Cluster Kubernetes

Le cluster est un minikube mono-nœud utilisant le driver Docker, sous WSL 2. Deux vCPU et environ 4 Go de RAM suffisent pour Kubernetes, ArgoCD (7 pods) et l'application.

```bash
minikube start --driver=docker --cpus=2 --memory=4g
kubectl config use-context minikube
kubectl get nodes
```

#shot(
  "01-minikube-start.png",
  [Démarrage du cluster minikube (Kubernetes v1.34.0, driver Docker) ; #cmd[kubectl] est configuré sur le contexte #cmd[minikube]],
)

== Installation d'ArgoCD

ArgoCD est installé à partir des manifests officiels dans son propre namespace. L'option `--server-side` est nécessaire car certaines CRD dépassent la taille maximale de l'annotation #cmd[last-applied-configuration].

```bash
kubectl create namespace argocd
kubectl apply -n argocd --server-side \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd rollout status deploy/argocd-server
```

#shot(
  "02-argocd-pods.png",
  [Fin du rollout de #cmd[argocd-server] puis les 7 pods ArgoCD en état #cmd[Running] : application-controller, applicationset-controller, dex, notifications, redis, repo-server et server],
)

== Accès à l'interface

```bash
# mot de passe initial de l'utilisateur admin
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
# exposition locale de l'UI
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

#shot(
  "03-argocd-admin-password.png",
  [Récupération du mot de passe initial de l'utilisateur #cmd[admin] (valeur masquée)],
)

#shot(
  "04-argocd-port-forward.png",
  [Port-forward du service #cmd[argocd-server] vers #cmd[localhost:8080]],
)

L'interface est alors accessible sur #cmd[https://localhost:8080] (certificat auto-signé). Après connexion, ArgoCD (v3.5.5) ne gère encore aucune application.

#shot(
  "05-argocd-ui-empty.png",
  [Tableau de bord ArgoCD après la première connexion : aucune application],
)

== Création de l'Application

L'Application est elle-même décrite dans Git (#cmd[argocd/application.yaml]) : la configuration de l'outil GitOps suit le même principe déclaratif que l'application.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: tp-gitops
  namespace: argocd
spec:
  project: default
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

```bash
kubectl apply -f argocd/application.yaml
kubectl -n tp-gitops get pods -w
```

C'est la seule commande #cmd[kubectl apply] du TP : à partir de là, ArgoCD crée lui-même le namespace #cmd[tp-gitops] et les ressources décrites dans Git. Les deux pods passent de #cmd[ContainerCreating] à #cmd[Running] puis #cmd[1/1] (readiness probe validée) en moins de 30 secondes.

#shot(
  "06-app-apply-pods.png",
  [Création de l'Application puis démarrage des deux pods #cmd[web] déployés par ArgoCD],
)

#info-box([Options de synchronisation], [
  - #text(weight: 600)[automated] : ArgoCD synchronise dès qu'un nouveau commit est détecté, sans clic sur #emph[Sync].
  - #text(weight: 600)[selfHeal] : si l'état du cluster s'écarte de Git (drift), ArgoCD réapplique les manifests.
  - #text(weight: 600)[prune] : une ressource retirée de Git est supprimée du cluster.
  - ArgoCD interroge Git toutes les 3 minutes par défaut ; le bouton #emph[Refresh] force une vérification immédiate.
])

#figure(
  image("screenshots/07-argocd-app-tile.png", width: 55%),
  caption: [Tuile de l'application #cmd[tp-gitops] : dépôt, révision #cmd[main], chemin #cmd[k8s/overlays/dev], statut #emph[Healthy] et #emph[Synced]],
)

#shot(
  "08-argocd-app-tree.png",
  [Arbre des ressources : Service et Deployment #cmd[web], ReplicaSet et deux pods. Synchronisé automatiquement sur le commit #cmd[6ce6324] (#emph[Auto sync is enabled])],
)

L'en-tête de la vue détaillée illustre déjà la distinction au cœur du TP : #emph[App Health] (état réel des ressources, ici #emph[Healthy]) et #emph[Sync Status] (conformité avec Git, ici #emph[Synced] sur #cmd[main]) sont deux indicateurs indépendants.

```bash
kubectl -n tp-gitops port-forward svc/web 8081:80   # http://localhost:8081
```

#figure(
  image("screenshots/09-app-v1.png", width: 60%),
  caption: [Application servie par le cluster : version #cmd[v1], réponse du pod #cmd[web-db7b48c65-hf4qp]],
)

#pagebreak()

// ═══════════════════════════════════════════
//  4. DÉMO 1
// ═══════════════════════════════════════════
= Démonstration 1 : déploiement continu automatisé

Objectif : montrer qu'un simple commit suffit à modifier le cluster, sans aucune commande #cmd[kubectl].

== Préparation : construction de la version v2

La nouvelle version de l'application (refonte de la page) est publiée en poussant un tag Git. La CI produit l'image #cmd[ghcr.io/kacemmathlouthi/tp-devops:v2] mais ne touche pas au cluster : tant que Git n'y fait pas référence, rien n'est déployé.

```bash
git tag v2 && git push origin v2
```

#shot(
  "12-ci-build-v2.png",
  [GitHub Actions : le tag #cmd[v2] déclenche le build et la publication de l'image #cmd[tp-devops:v2] (32 s)],
)

== Modification de l'état désiré dans Git

#todo-shot([Commit modifiant le nombre de réplicas et la version])

#todo-shot([ArgoCD détecte le nouveau commit et synchronise automatiquement])

#todo-shot([Terminal : nouveaux pods créés par ArgoCD])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  5. DÉMO 2
// ═══════════════════════════════════════════
= Démonstration 2 : détection du drift et self-healing

Objectif : altérer manuellement le cluster et montrer qu'ArgoCD rétablit l'état décrit dans Git.

#todo-shot([Suppression manuelle du Deployment avec #cmd[kubectl delete]])

#todo-shot([ArgoCD : drift détecté (#emph[OutOfSync]) puis réconciliation])

#todo-shot([Le Deployment est recréé automatiquement])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  6. DÉMO 3
// ═══════════════════════════════════════════
= Démonstration 3 : Sync Status et Health Status

Objectif : montrer qu'une application peut être parfaitement synchronisée avec Git tout en étant défaillante.

#todo-shot([Commit introduisant un tag d'image inexistant])

#todo-shot([ArgoCD : application #emph[Synced] mais #emph[Degraded]])

#todo-shot([Pod en #cmd[ErrImagePull] / #cmd[ImagePullBackOff]])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  7. DÉMO 4
// ═══════════════════════════════════════════
= Démonstration 4 : historique et rollback

Objectif : revenir instantanément à une version stable depuis l'onglet #emph[History and Rollback].

#todo-shot([Onglet #emph[History and Rollback] listant les révisions déployées])

#todo-shot([Rollback vers la dernière révision stable])

#todo-shot([Application de nouveau #emph[Healthy] après rollback])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  CONCLUSION
// ═══════════════════════════════════════════
= Conclusion

À compléter.

#info-box([Dépôt], [
  - GitHub : #link("https://github.com/KacemMathlouthi/tp-devops")[github.com/KacemMathlouthi/tp-devops]
])
