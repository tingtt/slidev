.PHONY: branch
branch:
	git checkout -b ${BRANCH}
	cat .github/workflows/release.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		tee ./github/workflows/release.yml
	cat .k8s/argocd/application.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		tee .k8s/argocd/application.yml
	cat .k8s/ingress/ingress.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		tee .k8s/ingress/ingress.yml
	git add .k8s/argocd/application.yml .k8s/ingress/ingress.yml ./github/workflows/release.yml
	git commit -m '[add] checkout ${BRANCH}'

BRANCH := $(shell git branch --show-current)
.PHONY: tag
tag:
	cat .k8s/deploy.yml.template | \
		sed "s/BRANCH/${BRANCH}/g" | \
		sed "s/TAG/${TAG}/g" | \
		tee .k8s/deploy.yml
	git add .k8s/deploy.yml
	git commit -m '[add] ${TAG}' || true
	git tag ${BRANCH}/${TAG}