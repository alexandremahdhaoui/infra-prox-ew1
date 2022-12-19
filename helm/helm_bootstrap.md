# Helm Bootstrap

Helm boostrap aims to create a privileged pod able to access the kubernetes API.
From the `helm-bootstrap` pod, we'll be running commands to bootstrap our cluster. 

We'll bootstrap our Idp, gitlab-runners, proxmox operator... with this `helm-bootstrap`.
Once it's done, we can get rid of `helm-bootstrap`

```shell
kubectl apply -f helm-bootstrap.yaml
```