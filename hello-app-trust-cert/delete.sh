kubectl delete -f hello-app.yaml -n default
kubectl delete secret today-ingress  -n default

kubectl get Certificate,Issuer,secret -n default