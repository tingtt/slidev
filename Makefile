BRANCH := $(shell git branch --format="%(refname:short)" | head -n1)
tag:
	git tag ${TAG}
	cat .k8s/deploy.yml.template | \
		sed "s/name: slidev/name: slidev-${BRANCH}/g" | \
		sed "s/image: tingtt\/slidev\/branch:tag/image: tingtt\/slidev\/${BRANCH}:${TAG}/g" | \
		tee .k8s/deploy.yml