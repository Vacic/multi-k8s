docker build -t vacic/multi-client:latest -t vacic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vacic/multi-server:latest -t vacic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vacic/multi-worker:latest -t vacic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vacic/multi-client:latest
docker push vacic/multi-client:$SHA

docker push vacic/multi-server:latest
docker push vacic/multi-server:$SHA

docker push vacic/multi-worker:latest
docker push vacic/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vacic/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vacic/multi-worker:$SHA
kubectl set image deployments/client-deployment client=vacic/multi-client:$SHA
