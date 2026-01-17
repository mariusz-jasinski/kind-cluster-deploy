# kind tutorial

<!-- TOC -->
* [kind manuals](#kind-manuals)
* [helper commands](#helper-commands)
  * [kubectl commands](#kubectl-commands-)
  * [kind commands](#kind-commands-)
  * [cluster commands](#cluster-commands)
* [deploying the cluster](#deploying-the-cluster-)
  * [creating cluster](#creating-cluster)
  * [deploying the cert-manager](#deploying-the-cert-manager)
  * [deploying the dashboard (v1)](#deploying-the-dashboard-v1)
  * [deploying the dashboard (v2)](#deploying-the-dashboard-v2)
  * [deploying hello app with fake cert (nginx ingress)](#deploying-hello-app-with-fake-cert-nginx-ingress)
  * [deploying hello app with internal-ca (cert-manager)](#deploying-hello-app-with-internal-ca-cert-manager)
<!-- TOC -->

## kind manuals
- [Getting Started with Kind](https://betterstack.com/community/guides/scaling-docker/kind/)
- [Deploying Cert Manager on Kubernetes](https://github.com/aman7mishra/cert-manager-k8s)
- [Simple CA Setup with Kubernetes Cert Manager](https://medium.com/geekculture/a-simple-ca-setup-with-kubernetes-cert-manager-bc8ccbd9c2)
- [Deploying Kubernetes Dashboard](https://medium.com/@aman07mishra/deploying-kubernetes-dashboard-with-helm-and-secure-access-via-ingress-08a916fef64d)

# helper commands

## kubectl commands  

```
kubectl config use-context kind-kind-cluster
kubectl config set-cluster kind-kind-cluster --server="https://127.0.0.1:36391"

kubectl cluster-info
kubectl get nodes
kubectl get all -n kube-system
kubectl get all -n ingress-nginx
kubectl get all -n kubernetes-dashboard

kubectl config view --minify | grep server
docker ps --filter "name=kind-cluster"

kubectl get Certificate,Issuer,secret -n default
```

## kind commands  
```
kind get clusters
kind delete cluster --name kind-cluster
```

## cluster commands
cluster stop:
```shell
docker stop $(docker ps -q --filter "name=kind-")
```

```cmd
wsl --shutdown
```

cluster start:
```shell
docker start $(docker ps -aq --filter "name=kind-")
```

# deploying the cluster 

## creating cluster

Config: [multi-node.yaml](multi-node.yaml)

deploy cluster and ingress-nginx:
```
./create-cluster.sh
```

## deploying the cert-manager
```shell
cd cert-manager-k8s
./apply.sh
```

## deploying the dashboard (v1)
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f dashboard-adminuser.yaml
```

### login to dashboard
- kubectl proxy
- go: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

user for Dashboard:
```
kubectl -n kubernetes-dashboard create token admin-user > token.txt
```

## deploying the dashboard (v2)

Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart:

```
helm upgrade --install kubernetes-dashboard kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard --repo https://kubernetes.github.io/dashboard/
kubectl apply -f dashboard-adminuser.yaml
kubectl apply -f dashboard-ingress.yaml
```

user for Dashboard:
`kubectl -n kubernetes-dashboard create token admin-user > token.txt`

go: https://dashboard.localtest.me


## deploying hello app with fake cert (nginx ingress)
[hello-app](hello-app)

deploy app:
```shell
./cert.sh
./apply.sh
```

## deploying hello app with internal-ca (cert-manager)
[hello-app-trust-cert](hello-app-trust-cert)

deploy app:
```shell
./apply.sh
```
