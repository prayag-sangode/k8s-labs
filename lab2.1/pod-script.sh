eksctl get cluster

kubectl get all

kubectl run httpd-pod --image=httpd

kubectl expose pod httpd-pod --name=httpd-svc-cip --port=80

kubectl expose pod httpd-pod --name=httpd-svc-np  --port=80 --target-port=80 --type=NodePort

kubectl expose pod httpd-pod --name=httpd-svc-lb  --port=80 --target-port=80 --type=LoadBalancer

kubectl get all
