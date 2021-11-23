# Sendmail task

This document describes how to build and install Sendmail task.

## Sendmail Secret

Create a Kubernetes secret with SMTP keys to send emails.

```bash
kubectl create secret generic sendmail \
--from-literal=SMTP_SERVER=<SERVER-NAME:PORT> \
--from-literal=SMTP_AUTH_USER=<SMTP-USERNAME> \
--from-literal=SMTP_AUTH_PASSOWRD=<SMTP-PASSWORD>
```

## Build and install Sendmail task

```bash
./build_install.sh <RESPOSITORY> <SENDMAIL-VERSION>
```
