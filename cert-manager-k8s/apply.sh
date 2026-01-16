[ ! -f ".env" ] && { echo "Create the .env file with vars: EMAIL, LETSENCRYPT_TOKEN"; exit 1; }
. .env

export EMAIL
export LETSENCRYPT_TOKEN

echo "namespace cert-manager"
kubectl create namespace cert-manager || exit 1

echo
echo "cert-manager"
sleep 2
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.19.1/cert-manager.yaml

echo
echo "LETSENCRYPT_TOKEN: ${LETSENCRYPT_TOKEN}"
if [ -n  "${LETSENCRYPT_TOKEN}" ]; then
  cat letsencrypt-secret.yaml | envsubst | kubectl apply -f -
fi

echo
echo "letsencrypt-nginx"
cat clusterissuer.yaml | envsubst | kubectl apply -f -
