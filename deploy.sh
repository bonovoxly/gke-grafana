#!/bin/bash
kubectl create -f cert.yml
kubectl create -f pvc.yml
kubectl create -f grafana-deployment.yml
kubectl create -f grafana-service.yml
kubectl create -f grafana-ingress.yml
