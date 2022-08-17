# Sendmail task

This document describes how to build and install Sendmail task.

## Sendmail Secret

Create a Kubernetes secret with SMTP keys to send emails.

```bash
kubectl create secret generic sendmail \
--from-literal=SMTP_SERVER=<SERVER-NAME:PORT> \
--from-literal=SMTP_PORT=<PORT> \
--from-literal=SMTP_USERNAME=<SMTP-USERNAME> \
--from-literal=SMTP_PASSWORD=<SMTP-PASSWORD>
```

## Install Sendmail task

```bash
kubectl apply -f sendmail.yaml
```
