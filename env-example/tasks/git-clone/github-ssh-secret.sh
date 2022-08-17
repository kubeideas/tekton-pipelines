
## new private and public key
ssh-keygen -t ed25519 -C "tekton@tekton.test.io" -f ${PWD}/id_ed25519


## Kubernetes secret
kubectl delete secret github-ssh --ignore-not-found

kubectl create secret generic github-ssh --from-file=id_ed25519 --from-file=id_ed25519.pub
