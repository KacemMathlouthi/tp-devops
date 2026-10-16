# tp-devops — GitOps with ArgoCD

Advanced DevOps, TP1: continuous deployment of a FastAPI app on Kubernetes, driven by ArgoCD from this repository.

| Folder | Contents |
|---|---|
| `app/` | FastAPI app + Dockerfile |
| `.github/workflows/` | builds and pushes the image on `v*` tags → `ghcr.io/kacemmathlouthi/tp-devops` |
| `k8s/` | Kustomize: `base/` + `dev/` overlay (namespace, replicas, image tag) |
| `argocd/` | ArgoCD Application (auto-sync, prune, self-heal) |
| `compte-rendu/` | report ([PDF](compte-rendu/main.pdf), in French) |

## Run

```bash
minikube start --driver=docker --cpus=2 --memory=4g
kubectl create namespace argocd
kubectl apply -n argocd --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f argocd/application.yaml
kubectl -n argocd port-forward svc/argocd-server 8080:443   # UI
kubectl -n tp-gitops port-forward svc/web 8081:80           # app
```

## Deploy a new version

```bash
git tag v3 && git push origin v3          # CI builds the image
# k8s/overlays/dev/kustomization.yaml: newTag: v3
git commit -am "feat(k8s): deploy v3" && git push   # ArgoCD deploys it
```

Report: `cd compte-rendu && typst compile --font-path fonts main.typ`
