docker build -t gabrielgelgor/multi-client:latest -t gabrielgelgor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gabrielgelgor/multi-server:latest -t gabrielgelgor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gabrielgelgor/multi-worker:latest -t gabrielgelgor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gabrielgelgor/multi-client:latest
docker push gabrielgelgor/multi-server:latest
docker push gabrielgelgor/multi-worker:latest

docker push gabrielgelgor/multi-client:$SHA
docker push gabrielgelgor/multi-server:$SHA
docker push gabrielgelgor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gabrielgelgor/multi-server:$SHA
kubectl set image deployments/client-deployment client=gabrielgelgor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gabrielgelgor/multi-worker:$SHA