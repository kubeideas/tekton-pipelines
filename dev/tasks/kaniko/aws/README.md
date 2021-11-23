# Kaniko task

This document describes how to build and install Kaniko task.

## AWS credential Secret (Optional)

Create a Kubernetes secret with AWS credentials.

```bash
kubectl create secret generic aws-secret \
--from-literal=AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID> \
--from-literal=AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
```

## Service account tekton-triggers (Optional)

If OIDC was configured to EKS cluster it is possible to grant ECR permissions to IAM role and assign it to `"tekton-triggers"` Kuberntes service account as presented in the example bellow:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::<ACCOUNT_ID>:role/<IAM_ROLE_NAME>
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
