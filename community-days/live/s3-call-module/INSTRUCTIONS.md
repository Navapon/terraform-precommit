# Command

```bash
pre-commit run terraform_trivy --file main.tf
pre-commit run terraform_checkov --file main.tf
```

Run from json plan outputs

```bash
terraform init
terraform plan -out tf.plan
terraform show -json tf.plan  > tf.json
checkov -f tf.json
```
