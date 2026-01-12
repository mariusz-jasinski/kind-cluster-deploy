openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout wildcard.key \
  -out wildcard.crt \
  -config wildcard.cnf -extensions req_ext


kubectl create secret tls wildcard-localtest-me \
  --cert=wildcard.crt \
  --key=wildcard.key
