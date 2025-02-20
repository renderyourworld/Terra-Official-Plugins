.PHONY: plugins

SHELL := /bin/bash

# env
cluster:
	@kind create cluster --name terra-plugins --config .kind.yaml || echo "Cluster already exists..."

dependencies: cluster
	@kubectl create namespace argocd || echo "Argo namespace already exists..."
	@echo " >> Installing ArgoCD << "
	@kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@echo "Waiting for ArgoCD to be ready..."
	@(kubectl get pods -n argocd | grep argocd-server) || (sleep 15 && kubectl wait --namespace argocd \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/name=argocd-server \
		--timeout=90s)
	@echo " >> ArgoCD Ready << "
	@echo " >> Setting Example Volumes << "
	@kubectl apply -n argocd -f k8s/
	@echo " >> Cluster Ready << "

down:
	@kind delete cluster --name terra-plugins

test-%: cluster dependencies
	@echo " >> Deploying $(subst test-,,$@) << "
	@helm upgrade -i terra-plugin ./tests/Application \
		--set branch=$(shell git rev-parse --abbrev-ref HEAD),plugin=$(subst test-,,$@) \
		--wait \
		--timeout 5m
	@echo
	@echo " >> ArgoCD UI Listening << "
	@echo "http://localhost:8080"
	@echo
	@echo " >> ArgoCD Admin Credentials << "
	@echo "admin"
	@kubectl -n argocd get secret argocd-initial-admin-secret \
               -o jsonpath="{.data.password}" | base64 -d; echo
	@kubectl -n argocd port-forward service/argocd-server 8080:80 > /dev/null 2>&1

package-%:
	@tar -czf scripts.tar ./plugins/$(subst package-,,$@)/scripts
	@base64 -w 0 scripts.tar > scripts.base64
	@rm -rf scripts.tar
	@cp plugins/packaged-scripts-template.yaml ./plugins/$(subst package-,,$@)/templates/packaged-scripts.yaml
	@sed -i '1s/^/  packaged_scripts.base64: "/' scripts.base64
	@sed -i '1s/$$/"/' scripts.base64
	@cat scripts.base64 >> ./plugins/$(subst package-,,$@)/templates/packaged-scripts.yaml
	@sed -i 's/PLUGIN/$(subst package-,,$@)/g' ./plugins/$(subst package-,,$@)/templates/packaged-scripts.yaml
	@rm -rf scripts.base64

#app-%:
#	@template/templateapp/makeapp.sh "$(subst app-,,$@)"
