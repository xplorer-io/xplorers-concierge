SHELL = /bin/bash
SHELLFLAGS = -ex

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
VERSION ?= $(shell git rev-parse --short HEAD)
# GITHUB_TOKEN := $(shell aws ssm get-parameter --name '/github/token' --with-decryption --query Parameter.Value --output text)

export PYTHONPATH := src:$(PYTHONPATH)

deploy-cognito:
	$(info [+] Deploying Cognito Pool...")
	@aws cloudformation deploy \
		--template-file resources/cloudformation/SumerianConciergeExperience-CloudFormationTemplate.yml \
		--stack-name sumerian-cognito-$(BRANCH) \
		--capabilities CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset 
.PHONY: deploy-cognito