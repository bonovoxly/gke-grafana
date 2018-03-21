#!/bin/bash
kubectl delete -f cert.yml
#kubectl delete -f pvc.yml
kubectl delete -f grafana-deployment.yml
kubectl delete -f grafana-service.yml
kubectl delete -f grafana-ingress.yml
kubectl -n monitoring delete secret grafana-credentials
