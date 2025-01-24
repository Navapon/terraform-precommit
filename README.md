# Terraform Pre-commit Hooks

This repository contains pre-commit hook configurations for Terraform projects to ensure code quality and consistency.

## Description

This repository is used for the Community Day AWS 2025 event. It provides a set of pre-commit hooks to maintain Terraform code quality and consistency across various projects. The hooks include formatting, documentation generation, linting, and security checks.

## Prerequisites

Before you begin, ensure you have the following installed:

- Git
- pre-commit
- Terraform
- terraform-docs (for documentation generation)
- Other optional tools based on your needs:

```bash
brew install pre-commit terraform-docs tflint trivy checkov infracost tfupdate minamijoyo/hcledit/hcledit jq
```

## Quick Start

Initialize your Git repository:

```bash
git init
git branch -M main
```

Create the pre-commit configuration file:

```bash
cat <<EOF > .pre-commit-config.yaml
repos:

- repo: <https://github.com/antonbabenko/pre-commit-terraform>
  rev: v1.96.3
  hooks:
  - id: terraform_fmt
  - id: terraform_docs
      args:
    - --hook-config=--create-file-if-not-exist=true
EOF
```

Install the pre-commit hooks:

```bash
pre-commit install --install-hooks
```

Once installed, the hooks will run automatically on every commit. You can also run them manually:

Run all pre-commit hooks

```bash
pre-commit run --all-files
Or
pre-commit run --file filename.extension
```

Run specific hook

```bash
pre-commit run terraform_fmt --all-files
```

## More available hooks

- [pre-commit hooks](https://pre-commit.com/hooks.html)
- [awesome-git-hooks](https://github.com/aitemr/awesome-git-hooks)
- [pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks)
- [conventional-pre-commit](https://github.com/compilerla/conventional-pre-commit)
- [gitleaks](https://github.com/gitleaks/gitleaks)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
