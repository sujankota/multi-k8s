docker build -t sujankota/multi-client:latest -t sujankota/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sujankota/multi-server:latest -t sujankota/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sujankota/multi-worker:latest -t sujankota/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sujankota/multi-client:latest
docker push sujankota/multi-server:latest
docker push sujankota/multi-worker:latest

docker push sujankota/multi-client:$SHA 
docker push sujankota/multi-server:$SHA
docker push sujankota/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=sujankota/multi-server:$SHA
kubectl set image deployment/client-deployment client=sujankota/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=sujankota/multi-worker:$SHA