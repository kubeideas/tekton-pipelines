# Snyk task

This document describes how to build and install Snyk task.

## API token Secret

Create a Kubernetes secret with `"SNYK_TOKEN"` key to access Snyk API.

```bash
kubectl create secret generic snyk \
--from-literal=SNYK_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## Build and install Snyk task

```bash
./build_install.sh <RESPOSITORY> <SNYK-VERSION>
```
