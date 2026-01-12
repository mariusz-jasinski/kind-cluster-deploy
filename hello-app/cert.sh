openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=hello.localtest.me"

kubectl create secret tls hello-tls -n default \
  --cert=tls.crt \
  --key=tls.key
