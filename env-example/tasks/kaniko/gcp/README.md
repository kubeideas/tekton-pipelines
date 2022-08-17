# Kaniko task

This document describes how to build and install Kaniko task.

## docker hub credential Secret (Optional)

Create a Kubernetes secret with docker hub credentials.

```bash
kubectl create secret generic gcp-service-account-secret \
--from-file=gcp-sa.json=./<GCP-SERVICE-ACCOUNT-FILE.JSON>
```

## Service account tekton-triggers (Optional)

If Workload Identity was enabled to GKE cluster it is possible to grant GCR permissions to a Google service account and assign it to `"tekton-triggers"` Kubernetes service account as presented in the example bellow:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    iam.gke.io/gcp-service-account=<GSA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com
  name: tekton-triggers
```

## M2 cache

If Java compilation is expected create a pvc for m2 cache and uncomment volume in `"kaniko.yaml"`.

`[IMPORTANT]`: Check Storage class and size for pvc before apply.

```bash
kubectl apply -f pvc-m2.yaml

```

## Install Kaniko task

`[IMPORTANT]`: Check Storage class and size for pvc before apply.

```bash
kubectl apply -f pvc-kaniko.yaml
kubectl apply -f kaniko.yaml
```
