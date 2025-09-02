#!/bin/bash
set -e
set -x

kubectl create clusterrolebinding viewer-binding \
  --clusterrole=viewer \
  --user=viewer

kubectl create clusterrolebinding operator-binding \
  --clusterrole=operator \
  --user=operator

kubectl create clusterrolebinding admin-binding \
  --clusterrole=admin \
  --user=admin
