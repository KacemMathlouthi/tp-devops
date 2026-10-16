# tp-devops — GitOps avec ArgoCD

TP1 DevOps avancé : déploiement continu d'une API FastAPI sur Kubernetes, piloté par ArgoCD depuis ce dépôt.

| Dossier | Contenu |
|---|---|
| `app/` | API FastAPI + Dockerfile |
| `.github/workflows/` | build et push de l'image sur tag `v*` → `ghcr.io/kacemmathlouthi/tp-devops` |
| `k8s/` | Kustomize : `base/` + overlay `dev/` (namespace, réplicas, tag) |
| `argocd/` | Application ArgoCD (auto-sync, prune, self-heal) |
| `compte-rendu/` | rapport ([PDF](compte-rendu/main.pdf)) |

## Lancer

```bash
minikube start --driver=docker --cpus=2 --memory=4g
kubectl create namespace argocd
kubectl apply -n argocd --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f argocd/application.yaml
kubectl -n argocd port-forward svc/argocd-server 8080:443   # UI
kubectl -n tp-gitops port-forward svc/web 8081:80           # app
```

## Déployer une version

```bash
git tag v3 && git push origin v3          # CI construit l'image
# k8s/overlays/dev/kustomization.yaml : newTag: v3
git commit -am "feat(k8s): deploy v3" && git push   # ArgoCD déploie
```

Rapport : `cd compte-rendu && typst compile --font-path fonts main.typ`
