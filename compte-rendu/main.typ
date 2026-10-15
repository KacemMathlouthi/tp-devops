// ── Colour palette ──────────────────────────
#let vercel-black  = rgb("#171717")
#let white         = rgb("#ffffff")
#let gray-900      = rgb("#171717")
#let gray-600      = rgb("#4d4d4d")
#let gray-500      = rgb("#666666")
#let gray-400      = rgb("#808080")
#let gray-200      = rgb("#c9c9c9")
#let gray-100      = rgb("#ebebeb")
#let gray-50       = rgb("#fafafa")
#let link-blue     = rgb("#0072f5")
#let focus-blue    = rgb("#0070f3")
#let badge-blue-bg = rgb("#ebf5ff")
#let badge-blue-fg = rgb("#0068d6")
#let success-green = rgb("#17a34a")
#let success-bg    = rgb("#f0fdf4")
#let warn-amber    = rgb("#ca8a04")
#let warn-bg       = rgb("#fffbeb")
#let code-bg       = rgb("#fafafa")
#let shadow-color  = rgb("#00000014")

// ── Font family ─────────────────────────────
#let geist = "Geist"
#let geist-mono = "Geist Mono"

// ── Raw block styling ───────────────────────
#show raw.where(block: true): it => block(
  width: 100%, radius: 8pt, fill: gray-900, inset: 16pt,
  stroke: none,
)[
  #set text(fill: rgb("#e2e8f0"), font: geist-mono, size: 7.5pt)
  #it.text
]

// ── Inline code styling ─────────────────────
#show raw.where(block: false): it => box(
  fill: code-bg, radius: 4pt,
  stroke: 0.5pt + gray-100,
  inset: (x: 4pt, y: 2pt),
)[#text(font: geist-mono, size: 8.5pt, fill: vercel-black)[#it.text]]

// ── Heading styling ─────────────────────────
#show heading.where(level: 1): it => {
  v(24pt)
  block(width: 100%)[
    #set text(font: geist, size: 22pt, weight: 600, fill: vercel-black, tracking: -1.2pt)
    #it.body
  ]
  v(4pt)
  line(length: 100%, stroke: 0.5pt + gray-100)
  v(10pt)
}

#show heading.where(level: 2): it => {
  v(16pt)
  block(width: 100%)[
    #set text(font: geist, size: 14pt, weight: 600, fill: vercel-black, tracking: -0.5pt)
    #it.body
  ]
  v(4pt)
}

#show heading.where(level: 3): it => {
  v(10pt)
  block(width: 100%)[
    #set text(font: geist, size: 11.5pt, weight: 600, fill: gray-600, tracking: -0.3pt)
    #it.body
  ]
  v(3pt)
}

// ── Figure caption styling ──────────────────
#show figure.caption: it => {
  set text(size: 8.5pt, fill: gray-500, font: geist)
  it
}

// ── List styling ────────────────────────────
#set list(marker: text(fill: gray-400, size: 7pt)[#sym.circle.filled])
#set enum(numbering: n => text(fill: gray-500, font: geist-mono, size: 9pt, weight: 500)[#str(n).])

// ── Helpers ─────────────────────────────────
#let info-box(title, body) = block(
  width: 100%, radius: 8pt,
  fill: badge-blue-bg,
  stroke: 0.5pt + rgb("#bfdbfe"),
  inset: (left: 14pt, right: 14pt, top: 12pt, bottom: 12pt),
)[
  #text(weight: 600, fill: badge-blue-fg, font: geist, size: 9.5pt)[#title]
  #v(5pt)
  #set text(fill: gray-600, size: 9.5pt)
  #body
]

#let success-box(body) = block(
  width: 100%, radius: 8pt,
  fill: success-bg,
  stroke: 0.5pt + rgb("#bbf7d0"),
  inset: (left: 14pt, right: 14pt, top: 12pt, bottom: 12pt),
)[
  #text(weight: 600, fill: success-green, font: geist, size: 9.5pt)[Résultat]
  #v(5pt)
  #set text(fill: gray-600, size: 9.5pt)
  #body
]

#let warn-box(body) = block(
  width: 100%, radius: 8pt,
  fill: warn-bg,
  stroke: 0.5pt + rgb("#fde68a"),
  inset: (left: 14pt, right: 14pt, top: 12pt, bottom: 12pt),
)[
  #text(weight: 600, fill: warn-amber, font: geist, size: 9.5pt)[Note]
  #v(5pt)
  #set text(fill: gray-600, size: 9.5pt)
  #body
]

#let cmd(body) = box(
  fill: code-bg, radius: 4pt,
  stroke: 0.5pt + gray-100,
  inset: (x: 4pt, y: 2pt),
)[#text(font: geist-mono, size: 8.5pt, fill: vercel-black)[#body]]

#let pill(body) = box(
  fill: badge-blue-bg, radius: 100pt,
  inset: (x: 10pt, y: 4pt),
)[#text(font: geist, size: 8pt, weight: 500, fill: badge-blue-fg)[#body]]

// ── Screenshot helper ───────────────────────
#let shot(name, caption) = figure(
  image("screenshots/" + name, width: 100%),
  caption: caption,
)

// ── Page setup ──────────────────────────────
#set page(
  paper: "a4",
  fill: white,
  margin: (top: 24mm, bottom: 22mm, left: 22mm, right: 22mm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 7.5pt, fill: gray-400, font: geist, weight: 500)
      #grid(
        columns: (1fr, 1fr),
        [TP1 — GitOps & Continuous Deployment avec ArgoCD],
        align(right)[DevOps Avancé · 2026–2027]
      )
      #v(3pt)
      #line(length: 100%, stroke: 0.5pt + gray-100)
    ]
  },
  footer: context [
    #set text(size: 7.5pt, fill: gray-400, font: geist, weight: 500)
    #line(length: 100%, stroke: 0.5pt + gray-100)
    #v(3pt)
    #grid(
      columns: (1fr, 1fr),
      [Mathlouthi · Kraiem · Haouas],
      align(right)[Page #counter(page).display("1 / 1", both: true)]
    )
  ]
)

#set text(font: geist, size: 10pt, fill: vercel-black, lang: "fr")
#set par(justify: true, leading: 0.72em)
#set heading(numbering: "1.1.")

// ── Placeholder for screenshots not taken yet ──
#let todo-shot(caption) = figure(
  block(
    width: 100%, height: 120pt, radius: 8pt,
    fill: warn-bg, stroke: (paint: rgb("#fde68a"), thickness: 0.8pt, dash: "dashed"),
  )[#align(center + horizon)[#text(fill: warn-amber, font: geist-mono, size: 8.5pt)[CAPTURE À AJOUTER]]],
  caption: caption,
)

#let panel(body) = block(
  width: 100%, radius: 8pt, fill: gray-50,
  stroke: 0.5pt + gray-100, inset: 14pt,
)[#set text(size: 9pt); #body]

// ═══════════════════════════════════════════
//  COVER PAGE
// ═══════════════════════════════════════════
#page(margin: (top: 35mm, bottom: 25mm, left: 28mm, right: 28mm), header: none, footer: none)[

  #align(center)[
    #image("screenshots/uni.png", width: 90pt)
  ]

  #v(10pt)
  #align(center)[
    #text(size: 9pt, fill: gray-400, font: geist, weight: 500)[Année universitaire 2026–2027 · DevOps Avancé]
  ]

  #v(60pt)

  #align(center)[
    #text(font: geist, size: 11pt, weight: 500, fill: gray-500)[Travaux Pratiques]
    #v(16pt)
    #text(font: geist, size: 42pt, weight: 600, fill: vercel-black, tracking: -2.4pt)[TP 1]
    #v(8pt)
    #text(font: geist, size: 18pt, weight: 400, fill: gray-600, tracking: -0.5pt)[Continuous Deployment avec GitOps et ArgoCD]
    #v(20pt)
    #line(length: 40%, stroke: 0.5pt + gray-100)
    #v(14pt)
    #text(font: geist-mono, size: 10pt, fill: gray-500, weight: 500)[Git comme unique source de vérité]
  ]

  #v(40pt)

  #align(center)[
    #pill("GITOPS")
    #h(6pt)
    #pill("ARGOCD")
    #h(6pt)
    #pill("KUSTOMIZE")
    #h(6pt)
    #pill("KUBERNETES")
  ]

  #v(1fr)

  #let student-card(name) = block(
    fill: gray-50, radius: 8pt,
    stroke: 0.5pt + gray-100, inset: 12pt, width: 100%,
  )[
    #align(center)[
      #text(size: 7.5pt, fill: gray-400, font: geist, weight: 500)[Étudiant]
      #v(4pt)
      #text(weight: 600, size: 9.5pt, fill: vercel-black, font: geist)[#name]
    ]
  ]

  #block(width: 100%, radius: 12pt, stroke: 0.5pt + gray-100, inset: 18pt)[
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 10pt,
      student-card("Kacem Mathlouthi"),
      student-card("Oussema Kraiem"),
    )
    #v(10pt)
    #grid(
      columns: (1fr, 2fr, 1fr),
      column-gutter: 10pt,
      [], student-card("Med Amin Haouas"), [],
    )
  ]
]

// ═══════════════════════════════════════════
//  TABLE OF CONTENTS
// ═══════════════════════════════════════════
#outline(
  title: text(font: geist, size: 16pt, weight: 600, fill: vercel-black, tracking: -0.8pt)[Table des matières],
  indent: 1.5em,
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

#panel[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 14pt,
    row-gutter: 8pt,
    [#text(weight: 600)[Single Source of Truth]], [tout l'état désiré vit dans Git (manifests Kustomize + définition de l'Application ArgoCD)],
    [#text(weight: 600)[Pull-based CD]],          [ArgoCD surveille le dépôt et applique automatiquement chaque commit],
    [#text(weight: 600)[Drift & Self-Healing]],   [toute modification manuelle du cluster est détectée puis annulée],
    [#text(weight: 600)[Sync vs Health]],         [un manifeste conforme à Git (#emph[Synced]) peut produire des pods en échec (#emph[Degraded])],
    [#text(weight: 600)[Rollback & Historique]],  [retour instantané à une révision stable depuis l'onglet #emph[History and Rollback]],
  )
]

== Application support

Le sujet laissant le choix de l'application, nous avons retenu un serveur #cmd[nginx] (image officielle #cmd[nginx:alpine]) qui sert une page HTML affichant un numéro de version. La page est injectée via un #cmd[ConfigMap] généré par Kustomize : modifier le fichier #cmd[index.html] dans Git suffit à déclencher un nouveau déploiement, ce qui rend chaque démonstration visible directement dans le navigateur.

== Stack technique

#panel[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 14pt,
    row-gutter: 8pt,
    [#text(weight: 600)[Cluster]],          [minikube (driver Docker) sous WSL 2],
    [#text(weight: 600)[GitOps]],           [ArgoCD (manifests officiels, namespace #cmd[argocd])],
    [#text(weight: 600)[Manifests]],        [Kustomize : une #cmd[base] et un overlay #cmd[dev]],
    [#text(weight: 600)[Dépôt]],            [GitHub public #cmd[KacemMathlouthi/tp-devops], branche #cmd[main]],
    [#text(weight: 600)[Application]],      [nginx + page HTML versionnée (ConfigMap)],
  )
]

== Architecture

```
 Développeur                GitHub (SSOT)                     Cluster minikube
 ───────────                ─────────────                     ────────────────
 git commit  ──push──▶  KacemMathlouthi/tp-devops   ◀──pull──  argocd (namespace)
                         └── k8s/overlays/dev                  ├── repo-server   : rend Kustomize
                                                               ├── app-controller: compare & sync
                                                               └── server (UI)   : https://localhost:8080
                                                                        │ apply
                                                                        ▼
                                                               tp-gitops (namespace)
                                                               ├── Deployment web (nginx)
                                                               ├── Service web
                                                               └── ConfigMap web-content-<hash>
```

#pagebreak()

// ═══════════════════════════════════════════
//  2. ÉTAPE 1 — DÉPÔT
// ═══════════════════════════════════════════
= Étape 1 — Structure du dépôt Git

== Organisation

Un seul dépôt contient l'ensemble du TP. ArgoCD ne lit que le chemin #cmd[k8s/overlays/dev] ; le reste du dépôt (rapport, définition de l'Application) ne perturbe donc pas la synchronisation.

```
tp-devops/
├── k8s/
│   ├── base/                     # ressources communes
│   │   ├── kustomization.yaml
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── index.html            # contenu servi par nginx
│   └── overlays/
│       └── dev/
│           └── kustomization.yaml  # namespace, replicas, tag d'image
├── argocd/
│   └── application.yaml          # l'Application ArgoCD (déclarative elle aussi)
└── compte-rendu/                 # ce rapport
```

== Base Kustomize

La base déclare le #cmd[Deployment], le #cmd[Service] et génère le #cmd[ConfigMap] à partir de #cmd[index.html]. Le suffixe de hash ajouté par le #cmd[configMapGenerator] change à chaque modification du fichier, ce qui force un rolling update des pods.

```yaml
# k8s/base/kustomization.yaml
resources:
  - deployment.yaml
  - service.yaml
configMapGenerator:
  - name: web-content
    files:
      - index.html
```

Dans le #cmd[Deployment], #cmd[progressDeadlineSeconds] est réduit à 60 s : en cas d'image introuvable, Kubernetes marque le rollout en échec au bout d'une minute (au lieu de 10 par défaut) et ArgoCD affiche alors #emph[Degraded].

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
  - name: nginx
    newTag: 1.27-alpine
```

Le rendu final peut être vérifié localement sans cluster :

```bash
kubectl kustomize k8s/overlays/dev
```

#todo-shot([Dépôt GitHub #cmd[tp-devops] : arborescence #cmd[k8s/] et #cmd[argocd/]])

#pagebreak()

// ═══════════════════════════════════════════
//  3. ÉTAPE 2 — ARGOCD
// ═══════════════════════════════════════════
= Étape 2 — Installation et configuration d'ArgoCD

== Cluster Kubernetes

```bash
minikube start --driver=docker --cpus=4 --memory=6g
kubectl config use-context minikube
kubectl get nodes
```

== Installation d'ArgoCD

ArgoCD est installé à partir des manifests officiels dans son propre namespace. L'option #cmd[--server-side] est nécessaire car certaines CRD dépassent la taille maximale de l'annotation #cmd[last-applied-configuration].

```bash
kubectl create namespace argocd
kubectl apply -n argocd --server-side \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd rollout status deploy/argocd-server
```

#todo-shot([Pods ArgoCD en état #cmd[Running] dans le namespace #cmd[argocd]])

== Accès à l'interface

```bash
# mot de passe initial de l'utilisateur admin
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
# exposition locale de l'UI
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

L'interface est alors accessible sur #cmd[https://localhost:8080] (certificat auto-signé).

#todo-shot([Page de connexion / tableau de bord ArgoCD])

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
```

#info-box([Options de synchronisation], [
  - #text(weight: 600)[automated] : ArgoCD synchronise dès qu'un nouveau commit est détecté, sans clic sur #emph[Sync].
  - #text(weight: 600)[selfHeal] : si l'état du cluster s'écarte de Git (drift), ArgoCD réapplique les manifests.
  - #text(weight: 600)[prune] : une ressource retirée de Git est supprimée du cluster.
  - ArgoCD interroge Git toutes les 3 minutes par défaut ; le bouton #emph[Refresh] force une vérification immédiate.
])

#todo-shot([Application #cmd[tp-gitops] : arbre des ressources, statut #emph[Synced] et #emph[Healthy]])

#todo-shot([Page nginx servie par le cluster (version v1)])

#pagebreak()

// ═══════════════════════════════════════════
//  4. DÉMO 1
// ═══════════════════════════════════════════
= Démonstration 1 — Déploiement continu automatisé

Objectif : montrer qu'un simple commit suffit à modifier le cluster, sans aucune commande #cmd[kubectl].

#todo-shot([Commit modifiant le nombre de réplicas et la version])

#todo-shot([ArgoCD détecte le nouveau commit et synchronise automatiquement])

#todo-shot([Terminal : nouveaux pods créés par ArgoCD])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  5. DÉMO 2
// ═══════════════════════════════════════════
= Démonstration 2 — Détection du drift et Self-Healing

Objectif : altérer manuellement le cluster et montrer qu'ArgoCD rétablit l'état décrit dans Git.

#todo-shot([Suppression manuelle du Deployment avec #cmd[kubectl delete]])

#todo-shot([ArgoCD : drift détecté (#emph[OutOfSync]) puis réconciliation])

#todo-shot([Le Deployment est recréé automatiquement])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  6. DÉMO 3
// ═══════════════════════════════════════════
= Démonstration 3 — Sync Status vs Health Status

Objectif : montrer qu'une application peut être parfaitement synchronisée avec Git tout en étant défaillante.

#todo-shot([Commit introduisant un tag d'image inexistant])

#todo-shot([ArgoCD : application #emph[Synced] mais #emph[Degraded]])

#todo-shot([Pod en #cmd[ErrImagePull] / #cmd[ImagePullBackOff]])

#success-box([À compléter après la démonstration.])

#pagebreak()

// ═══════════════════════════════════════════
//  7. DÉMO 4
// ═══════════════════════════════════════════
= Démonstration 4 — Historique et Rollback

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
