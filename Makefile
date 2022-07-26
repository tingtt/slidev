.PHONY: branch
branch:
	git checkout -b ${BRANCH}
	cat .k8s/argocd/application.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		tee .k8s/argocd/application.yml
	git add .k8s/argocd/application.yml
	git commit

BRANCH := $(shell git branch --show-current)
.PHONY: tag
tag:
	cat .k8s/deploy.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		sed "s/TAG/${TAG}/g" | \
		tee .k8s/deploy.yml
	git add .k8s/deploy.yml
	git commit || true
	git tag ${BRANCH}/${TAG}