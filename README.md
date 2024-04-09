# Infrastracture as Code 🏗️
 
#### 20/03/2024 

 - This repository will eventually contain both Terraform and Ansible configuration files. Currently working on getting the whole infra set up via Terraform, will move on to Ansible after.
 - Transfer all .tf files to use vars from a base variables.tf file.
 - Add prod.tfvars, dev.tfvars etc that will ovverride the main variables.tf file.
 - Add backend.tf file that will define where the state.tf file will be saved.