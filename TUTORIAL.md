# kind manuals
- [Getting Started with Kind](https://betterstack.com/community/guides/scaling-docker/kind/)
- [Deploying Cert Manager on Kubernetes](https://github.com/aman7mishra/cert-manager-k8s)
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
```

## kind commands  
```
kind get clusters
kind delete cluster --name kind-cluster
```

## cluster commands
cluster stop:
```
docker stop $(docker ps -q --filter "name=kind-")
wsl --shutdown
```

cluster start:
```
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


## deploying hello app with ingress fake cert
[hello-app](hello-app)

deploy app:
```shell
./cert.sh
./apply.sh
```

## deploying hello app with cert-manager
[hello-app-trust-cert](hello-app-trust-cert)

deploy app:
```shell
./apply.sh
```
