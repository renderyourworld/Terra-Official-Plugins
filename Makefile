.PHONY: plugins

SHELL := /bin/bash

# env
cluster:
	@kind create cluster --name terra-plugins --config .kind.yaml || echo "Cluster already exists..."

dependencies: cluster
	@kubectl create namespace argocd || echo "Argo namespace already exists..."
	@kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@(kubectl get pods -n argocd | grep argocd-server) || (sleep 15 && kubectl wait --namespace argocd \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/name=argocd-server \
		--timeout=90s)
	@kubectl apply -n argocd -f k8s/

down:
	@kind delete cluster --name terra-plugins

test-%: cluster dependencies
	@echo " >> Running tests for $(subst test-,,$@) << "
	helm upgrade -i terra-plugin ./tests/Application \
		--set branch=$(shell git rev-parse --abbrev-ref HEAD),plugin=$(subst test-,,$@) \
		--wait \
		--timeout 5m

#app-%:
#	@template/templateapp/makeapp.sh "$(subst app-,,$@)"
