{ blockTypes }:
with blockTypes; [
  (files "helm-chart")
  (files "helm-repo")
  (files "helm-template")
  (files "helm-values")

  (files "kustomize-manifest")
  (files "kustomize-template")
  (files "kubernetes-manifest")
  (files "kubeconfig")
  (kubectl "kubectl")

]
