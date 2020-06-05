#!/bin/bash
ca=$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w 0)
token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
namespace=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
server=https://10.43.0.1
echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: istio-system
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > sa.kubeconfig
kubectl config --kubeconfig=sa.kubeconfig use-context default-context 