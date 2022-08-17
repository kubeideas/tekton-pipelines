# Github Eventlistener

This document describes how preparare HMAC key for Eventlistener and Github webhook.

## HMAC token

Use openssl to generate HMAC token. This token will be used by Github webhook to sign payload and also by Tekton EventListener to check the payload received.

```bash
openssl rand -hex 20
```

## Kubernetes secret

Create a Kubernetes secret with token generated in previous step.

```bash
kubectl create secret generic github-token --from-literal=secretToken=<HMAC-TOKEN>
```
