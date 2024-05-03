kubectl delete --all pods
kubectl delete --all service
kubectl delete --all deployment



kubectl apply -f deployment-backend-feed.yaml -n kube-system metrics-server -p='{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server","args":["--cert-dir=/tmp", "- --secure-port=4443", "--kubelet-insecure-tls", "--kubelet-preferred-address-types=InternalIP"]}]}}}}'
kubectl apply -f service-backend-feed.yaml -n kube-system metrics-server -p='{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server","args":["--cert-dir=/tmp", "- --secure-port=4443", "--kubelet-insecure-tls", "--kubelet-preferred-address-types=InternalIP"]}]}}}}'

kubectl apply -f deployment-backend-user.yaml -n kube-system metrics-server -p='{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server","args":["--cert-dir=/tmp", "- --secure-port=4443", "--kubelet-insecure-tls", "--kubelet-preferred-address-types=InternalIP"]}]}}}}'
kubectl apply -f service-backend-user.yaml  -n kube-system metrics-server -p='{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server","args":["--cert-dir=/tmp", "- --secure-port=4443", "--kubelet-insecure-tls", "--kubelet-preferred-address-types=InternalIP"]}]}}}}'

kubectl apply -f deployment-frontend.yaml
kubectl apply -f service-frontend.yaml

kubectl apply -f deployment-reverseproxy.yaml
kubectl apply -f service-reverseproxy.yaml


# env variables and secrets
kubectl apply -f aws-secret.yaml
kubectl apply -f env-secret.yaml
kubectl apply -f env-configmap.yaml

kubectl expose deployment frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy

kubectl delete hpa backend-user
kubectl delete hpa backend-feed

kubectl autoscale deployment backend-user --cpu-percent=70 --min=3 --max=5
kubectl autoscale deployment backend-feed --cpu-percent=70 --min=3 --max=5

# expose services
kubectl expose service udagram-reverseproxy --type=LoadBalancer  --name=public-reverseproxy --port=80 --target-port=8080
kubectl expose service udagram-frontend --type=LoadBalancer --name=public-frontend --port=80 --target-port=80

kubectl expose service udagram-reverseproxy --type=LoadBalancer  --name=publicreverseproxy --port=80 --target-port=8080
kubectl expose service udagram-frontend --type=LoadBalancer --name=publicfrontend --port=80 --target-port=80