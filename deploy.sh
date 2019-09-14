docker build -t harshvb7/multi-client:latest -t harshvb7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harshvb7/multi-server:latest -t harshvb7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harshvb7/multi-worker:latest -t harshvb7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harshvb7/multi-client:latest
docker push harshvb7/multi-server:latest
docker push harshvb7/multi-worker:latest

docker push harshvb7/multi-client:$SHA
docker push harshvb7/multi-server:$SHA
docker push harshvb7/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=harshvb7/multi-client:$SHA
kubectl set image deployments/server-deployment server=harshvb7/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=harshvb7/multi-worker:$SHA