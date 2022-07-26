.PHONY: branch
branch:
	git checkout -b ${BRANCH}
	cat .k8s/argocd/application.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		tee .k8s/argocd/application.yml
	git add .k8s/argocd/application.yml
	git commit

BRANCH := $(shell git branch --format="%(refname:short)" | head -n1)
.PHONY: tag
tag:
	cat .k8s/deploy.yml.template | \
		sed "s/name: slidev/name: slidev-${BRANCH}/g" | \
		sed "s/image: tingtt\/slidev\/branch:tag/image: tingtt\/slidev\/${BRANCH}:${TAG}/g" | \
		tee .k8s/deploy.yml
	git add .k8s/deploy.yml
	git commit || true
	git tag ${BRANCH}/${TAG}