echo "namespace cert-manager"
kubectl create namespace cert-manager || exit 1

echo
echo "cert-manager"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.19.1/cert-manager.yaml

echo
echo "internal-ca"
sleep 2
kubectl apply -f internal-ca.yaml