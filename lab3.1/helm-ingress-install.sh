helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --version 4.10.1 --namespace ingress-nginx --create-namespace
helm repo ls
helm ls
helm ls -n ingress-nginx
kubectl -n ingress-nginx get all
