# Slack task

This document describes how to build and install Slack task.

## API token Secret

Create a Kubernetes secret with `"TOKEN"` key to access Slack API.

```bash
kubectl create secret generic sendmail \
--from-literal=TOKEN=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Build and install Slack task

```bash
./build_install.sh <RESPOSITORY> <SLACK-VERSION>
```
