#!/bin/bash
set -e
set -x

mkdir -p ./certs
cd ./certs

openssl genrsa -out viewer.key 2048
openssl req -new -key viewer.key -out viewer.csr -subj "//CN=viewer"
openssl x509 -req -in viewer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out viewer.crt -days 365

kubectl config set-credentials viewer \
  --client-certificate=viewer.crt \
  --client-key=viewer.key

kubectl config set-context viewer-context \
  --cluster=minikube \
  --namespace=default \
  --user=viewer

openssl genrsa -out operator.key 2048
openssl req -new -key operator.key -out operator.csr -subj "//CN=operator"
openssl x509 -req -in operator.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out operator.crt -days 365

kubectl config set-credentials operator \
  --client-certificate=operator.crt \
  --client-key=operator.key

kubectl config set-context operator-context \
  --cluster=minikube \
  --namespace=default \
  --user=operator

openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -out admin.csr -subj "//CN=admin"
openssl x509 -req -in admin.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out admin.crt -days 365

kubectl config set-credentials admin \
  --client-certificate=admin.crt \
  --client-key=admin.key

kubectl config set-context admin-context \
  --cluster=minikube \
  --namespace=default \
  --user=admin