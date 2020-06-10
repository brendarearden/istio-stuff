#!/bin/bash
ca=$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w 0)
token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
namespace=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
server=https://10.43.0.1
echo "
apiVersion: v1
kind: Config
clusters:
- name: ${releaseName}-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: ${releaseName}-context
  context:
    cluster: ${releaseName}-cluster
    namespace: istio-system
    user: ${releaseName}-user
current-context: default-context
users:
- name: ${releaseName}-user
  user:
    token: ${token}
" > sa.kubeconfig
kubectl config --kubeconfig=sa.kubeconfig use-context ${releaseName}-context 