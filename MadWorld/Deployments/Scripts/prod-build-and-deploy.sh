#!/bin/bash
build_and_load_image () {
  docker build -f $1/Dockerfile -t madworld/vps/$2 .
  docker save madworld/houseapp/$2 > Deployment/Kubernetes/images/madworld-vps-$2.tar
  sudo microk8s images import < Deployment/Kubernetes/images/madworld-vps-$2.tar
  echo "$2 image loaded"
}

#This removes the error of nginx image not found while building the image
sudo docker pull nginx

mkdir -p Deployment/Kubernetes/images
sudo microk8s kubectl delete deployment,pods --all -n madworld
sudo microk8s kubectl delete deployment,pods --all -n default

build_and_load_image "HouseApp.Backend.API" "api"

sudo docker image prune -f

sudo microk8s kubectl apply -f Deployments/Kubernetes/Environment/Config.yaml
sudo microk8s kubectl apply -f Deployments/Kubernetes/Environment/Ingress-Deployment-Prod.yaml
sudo microk8s kubectl apply -f Deployments/Kubernetes/Internal
#sudo microk8s kubectl apply -f Deployments/Kubernetes/External

sudo rm -r Deployment/Kubernetes/images