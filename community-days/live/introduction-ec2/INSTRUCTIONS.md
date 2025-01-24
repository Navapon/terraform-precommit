# Command

## Run Check All

```bash
pre-commit run --file main.tf 
```

## Trivy

```bash
pre-commit run terraform_trivy --file main.tf
```

## Checkov

```bash
pre-commit run terraform_checkov --file main.tf
```

## TFLint

```bash
pre-commit run terraform_tflint --file main.tf 
```
