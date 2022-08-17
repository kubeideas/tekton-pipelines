# Kaniko task

This document describes how to build and install Kaniko task.

## Encode docker hub username and password

```bash
echo -n "<USERNAME>:<PASSWORD>"| base64
```

## config.json file

Create file `"config.json"` with json example bellow and add encoded credential generated previously:

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "<ENCODED-CREDENTIAL>"
        }
    }
}
```

## docker hub credential Secret

Create a Kubernetes secret with docker hub credentials.

```bash
kubectl create secret generic dockerconfig \
--from-file=config.json
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
