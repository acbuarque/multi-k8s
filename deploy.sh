docker build -t animal505/multi-client:latest -t animal505/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t animal505/multi-server:latest -t animal505/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t animal505/multi-worker:latest -t animal505/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push animal505/multi-client:latest
docker push animal505/multi-client:$SHA
docker push animal505/multi-server:latest
docker push animal505/multi-server:$SHA
docker push animal505/multi-worker:latest
docker push animal505/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=animal505/multi-server:$SHA
kubectl set image deployments/client-deployment client=animal505/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=animal505/multi-worker:$SHA

