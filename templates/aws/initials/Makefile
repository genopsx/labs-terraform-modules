PRE_COMMIT_TERRAFORM_VERSION=latest

all: lint

lint:
	@docker run -v ${PWD}:/lint -w /lint ghcr.io/antonbabenko/pre-commit-terraform:${PRE_COMMIT_TERRAFORM_VERSION} run -a

install: install_precommit

install_precommit:
	@echo "[install_precommit]: Installing pre-commit-terraform..."
	@pip install pre-commit
	@docker pull ghcr.io/antonbabenko/pre-commit-terraform:${PRE_COMMIT_TERRAFORM_VERSION}
