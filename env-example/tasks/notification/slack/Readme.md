# Slack task

This document describes how to build and install Slack task.

## API token Secret

Create a Kubernetes secret with `"HOOK_URL"` key to access Slack API.

```bash
kubectl create secret generic sendmail \
--from-literal=HOOK_URL=XXXXXXXXXXXXXXXXXXXXXX
```

## Install Slack task

```bash
kubectl apply -f slack.yaml
```
