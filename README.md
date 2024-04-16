# Infrastracture as Code 🏗️

This repository holds all infrastracture related Terraform code that plans and builds the AWS infrastracture used for the <a href="https://github.com/assafdori/resume-app" target="_blank">resume web application.</a>

### Features 🌐
- Employs industry best practices in Terraform syntax.
- Backend configuration that saves the state file remotely within an S3 bucket.
- Variables configuration file to allow easy modification of infrastracture properties.
- Outputting of infrastracture properties for easy debugging and reusability in other Terraform modules.
- Modules have dependencies specified on each other, ensuring seamless infrastructure provisioning.
- Automatic creation, validaiton and renewal of SSL certification.
- Included is a custom Python script that utilizes boto3 to extract infrastracture information via AWS CLI and uses API's to update name-servers on Porkbun.

### Provisioned Infrastracture 🏰
- DNS records, including name-servers configuration against external domain provider.
- EC2 Instance (Might be migrated to ECS soon).
- Application Load Balancer, Listener & Target Group.
- Amazon generated SSL Cert (ACM).
- ECR Repository.
- Internet gateways.
- Routing Tables.
- Security groups to allow HTTP&S ingress.
- Subnets.
- VPC.

#### Progression and Future Ideas 💡

 - This repository will eventually contain both Terraform and Ansible configuration files. Currently working on getting the whole infra set up via Terraform, will move on to Ansible after.
 - Add prod.tfvars, dev.tfvars etc that will ovverride the main variables.tf file.
 - ~~Transfer all .tf files to use vars from a base variables.tf file.~~
 - ~~Add backend.tf file that will define where the state.tf file will be saved (s3)~~

### Commands 🕹️

```zsh
terraform init
terraform plan
terraform apply
```