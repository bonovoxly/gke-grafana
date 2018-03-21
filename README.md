# gke-grafana

This deploys a Grafana Kubernetes deployment to Google Kubernetes Engine, in the namespace `monitoring`. This deployment is meant to integrate with an NGINX Ingress Controller, a Lets Encrypt Kubernetes Certificate Manager, oauth2_proxy, and Prometheus.

# Requirements

- A Google Cloud account with Google Kubernetes Engine configured.
- The `monitoring` namespace.
- [An NGINX Ingress Controller and a LetsEncrypt kube-cert-manager deployment](https://blog.billyc.io/2017/12/27/deploying-and-using-kube-cert-manager-with-an-nginx-ingress-controller-on-kubernetes/). Note you will want/need this to access it publically, but it is not necessary to simply run Prometheus and Grafana in Kubernetes. This particular deployment uses it.
- An oauth2_proxy service deployment.
- Prometheus.

It integrates with these components to provide an ingress, a TLS secret, an authentication mechanism, and the Prometheus back end..


# Deployment

- Create the Grafana secret:

```
kubectl -n monitoring create secret generic grafana-credentials --from-literal=GF_SECURITY_ADMIN_PASSWORD=yourpassword
```

Before deploying, edit the `cert.yml` and `grafana-ingress.yml` files. Change `EXAMPLE.ORG` to your domain. Note the requirements above, with the NGINX Ingress Controller, kube-cert-manager, and oauth. A fast way to modify this is with sed:

```
# OSX example
sed -i '' 's/GRAFANA.EXAMPLE.ORG/grafana.yourdomain.com' ./*
```

The deployment script can quickly deploy Grafana:

```
# if it doesn't exist, create the namespace - `kubectl create namespace monitoring`
./deploy.sh
```

This runs the following:

```
kubectl create -f cert.yml
kubectl create -f pvc.yml
kubectl create -f grafana-deployment.yml
kubectl create -f grafana-service.yml
kubectl create -f grafana-ingress.yml
```

# Uninstall

To remove:

```
./remove.sh
```

