kubectl create deployment httpd-deploy --image=httpd --replicas=2

kubectl expose deployment httpd-deploy --name=httpd-deploy-cip --port=80

kubectl expose deployment httpd-deploy --name=httpd-deploy-np --port=80 --type=NodePort

kubectl expose deployment httpd-deploy --name=httpd-deploy-lb --port=80 --type=LoadBalancer
