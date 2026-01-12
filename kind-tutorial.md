# manual
https://betterstack.com/community/guides/scaling-docker/kind/


kubectl config use-context kind-kind-cluster
kubectl config set-cluster kind-kind-cluster --server="https://127.0.0.1:36391"

kubectl cluster-info
kubectl get nodes
kubectl get all -n kube-system
kubectl get all -n ingress-nginx
kubectl get all -n kubernetes-dashboard

kind get clusters
kind delete cluster --name kind-cluster

# zatrzymanie clustra i ponowny start
docker stop $(docker ps -q --filter "name=kind-")
wsl --shutdown
docker start $(docker ps -aq --filter "name=kind-")


# Deploying the dashboard -v1
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

  # login to dashboard
  kubectl proxy
  http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/


# Deploying the dashboard -v2
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard --repo https://kubernetes.github.io/dashboard/

  # To access Dashboard run:
  kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
  https://localhost:8443
  
# user for Dashboard
kubectl apply -f dashboard-adminuser.yaml
kubectl -n kubernetes-dashboard create token admin-user > token.txt



docker ps --filter "name=kind-cluster-control-plane"
docker inspect -f '{{ (index (index .NetworkSettings.Ports "6443/tcp") 0).HostPort }}' kind-cluster-control-plane
kubectl config view --minify | grep server
