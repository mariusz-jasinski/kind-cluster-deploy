[ ! -f ".env" ] && { echo "Create the .env file with vars: EMAIL, LETSENCRYPT_TOKEN"; exit 1; }
. .env

export EMAIL
export LETSENCRYPT_TOKEN

echo
echo "LETSENCRYPT_TOKEN: ${LETSENCRYPT_TOKEN}"
if [ -n  "${LETSENCRYPT_TOKEN}" ]; then
  cat letsencrypt-secret.yaml | envsubst | kubectl apply -f -
fi

echo
echo "letsencrypt-nginx"
cat letsencrypt.yaml | envsubst | kubectl apply -f -
