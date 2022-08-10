# GitHub ssh keys

## Genereate new ssh private and public keys and create Kubernetes secret

Secret created by this script will be used in eventlistener to validate GitHub webhooks.

``` bash
./github-ssh-secret.sh
```

## Tekton Hub task

Installing git-clone task from Tekton Hub

``` bash
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.7/git-clone.yaml

```

## Import Public to GitHub service user

Create a GitHub account with permissions to clone project repository code and import public key generated previously.

## Safe place for ssh keys

Code repository is not safe to store ssh keys, please upload them to a vault password manager of your preference and do not forget to remove them from this directory.
