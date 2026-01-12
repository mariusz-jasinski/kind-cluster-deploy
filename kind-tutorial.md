# kind manuals
- https://betterstack.com/community/guides/scaling-docker/kind/
- https://medium.com/@aman07mishra/deploying-kubernetes-dashboard-with-helm-and-secure-access-via-ingress-08a916fef64d


# kubectl commands  

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

# kind commands  
```
kind get clusters
kind delete cluster --name kind-cluster
```

# cluster commands
cluster stop:
```
docker stop $(docker ps -q --filter "name=kind-")
wsl --shutdown
```

cluster start:
```
docker start $(docker ps -aq --filter "name=kind-")
```

# create cluster

[create-cluster.sh](create-cluster.sh)

# Deploying the dashboard (v1)
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml`

login to dashboard
kubectl proxy

go: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

 user for Dashboard

`
kubectl apply -f dashboard-adminuser.yaml
kubectl -n kubernetes-dashboard create token admin-user > token.txt
`

# Deploying the dashboard (v2)

Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart

`helm upgrade --install kubernetes-dashboard kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard --repo https://kubernetes.github.io/dashboard/
kubectl apply -f dashboard-adminuser.yaml
kubectl apply -f dashboard-ingress.yaml
`

To access Dashboard run:
`kubectl -n kubernetes-dashboard create token admin-user > token.txt`

go: https://dashboard.localtest.me
  

