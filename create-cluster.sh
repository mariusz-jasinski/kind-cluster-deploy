kind create cluster --name kind-cluster --config multi-node.yaml

echo
echo "ingress-nginx for kind"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo
echo "kubectl wait for ingress-nginx"
kubectl wait --namespace ingress-nginx \
 --for=condition=ready pod \
 --selector=app.kubernetes.io/component=controller \
 --timeout=30s
