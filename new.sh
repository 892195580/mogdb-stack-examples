#! /bin/bash
# build a new single-mogdb-cluster with kind and kubectl

set -e
stack_examples_path=$(cd $(dirname $0); pwd)
$stack_examples_path/setup-kind-multicluster.sh -o
wait
kubectl create ns mogdb-ha
kubectl apply --server-side -k $stack_examples_path/kustomize/mogdb-ha/install
kubectl apply --server-side -k $stack_examples_path/kustomize/mogdb-operator/bases/crd
kubectl create ns mogdb-operator-system
kubectl apply --server-side -k $stack_examples_path/kustomize/mogdb-operator/install/default
kubectl apply --server-side -k $stack_examples_path/kustomize/mogdb-cluster/install/default
kubectl get pods -A
