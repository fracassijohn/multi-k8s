docker build -t fracassijohn/multi-client:latest -t fracassijohn/multi-client:$SHA ./client
docker build -t fracassijohn/multi-server:latest -t fracassijohn/multi-server:$SHA ./server
docker build -t fracassijohn/multi-worker:latest -t fracassijohn/multi-worker:$SHA ./worker

docker push fracassijohn/multi-client:latest
docker push fracassijohn/multi-server:latest
docker push fracassijohn/multi-worker:latest

docker push fracassijohn/multi-client:$SHA
docker push fracassijohn/multi-server:$SHA
docker push fracassijohn/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=fracassijohn/multi-client:$SHA
kubectl set image deployments/server-deployment server=fracassijohn/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=fracassijohn/multi-worker:$SHA
