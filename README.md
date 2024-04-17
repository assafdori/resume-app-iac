# Infrastracture as Code 🏗️

This repository holds all infrastracture related Terraform code that plans and builds the AWS infrastracture used for the <a href="https://github.com/assafdori/resume-app" target="_blank">resume web application.</a>

### Features 🌐
- Employs industry best practices in Terraform syntax.
- Backend configuration that saves the state file remotely within an S3 bucket.
- Variables configuration file to allow easy modification of infrastracture properties.
- Outputting of infrastracture properties for easy debugging and reusability in other Terraform modules.
- Modules have dependencies specified on each other, ensuring seamless infrastructure provisioning.
- Automatic creation, validaiton and renewal of SSL certification.
- Application Load Balancer & Listener that handle SSL termination and redirection.
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

### Infracost Report 💰
<h4>💰 Infracost report</h4>
<h4>Monthly cost will be $28 📈</h4>
<table>
  <thead>
    <td>Project name</td>
    <td><span title="Baseline costs are consistent charges for provisioned resources, like the hourly cost for a virtual machine, which stays constant no matter how much it is used. Infracost estimates these resources assuming they are used for the whole month (730 hours).">Baseline cost</span></td>
    <td><span title="Usage costs are charges based on actual usage, like the storage cost for an object storage bucket. Infracost estimates these resources using the monthly usage values in the usage-file.">Usage cost</span>*</td>
    <td>Total change</td>
    <td>New monthly cost</td>
  </thead>
  <tbody>
    <tr>
      <td>resume-app-iac</td>
      <td align="right">+$21</td>
      <td align="right">+$7</td>
      <td align="right">+$28</td>
      <td align="right">$28</td>
    </tr>
  </tbody>
</table>


*Usage costs were estimated using [Infracost Cloud settings](https://dashboard.infracost.io/org/), see [docs](https://www.infracost.io/docs/features/usage_based_resources/#infracost-usageyml) for other options.
<details>

<summary>Cost details (includes details of skipped projects due to errors)</summary>

```
Key: * usage cost, ~ changed, + added, - removed

──────────────────────────────────
Project: main

+ aws_lb.resume-app-application-load-balancer
  +$18

    + Application load balancer
      +$16

    + Load balancer capacity units
      +$2, +0.3424 LCU*

+ aws_ecr_repository.resume-app-ecr-repo
  +$5

    + Storage
      +$5, +50 GB*

+ aws_instance.resume-app-ec2-instance
  +$4

    + Instance usage (Linux/UNIX, on-demand, t4g.nano)
      +$3

    + root_block_device
    
        + Storage (general purpose SSD, gp2)
          +$0.80

+ aws_route53_zone.main
  +$0.50

    + Hosted zone
      +$0.50

Monthly cost change for aws
Amount:  +$28 ($0.00 → $28)

──────────────────────────────────
Key: * usage cost, ~ changed, + added, - removed
1 project has no cost estimate change.
Run the following command to see its breakdown: infracost breakdown --path=/path/to/code

──────────────────────────────────
*Usage costs were estimated using Infracost Cloud settings, see docs for other options.

18 cloud resources were detected:
∙ 4 were estimated
∙ 14 were free

Infracost estimate: Monthly cost will increase by $28 ↑
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃ Project name                                       ┃ Baseline cost ┃ Usage cost ┃ Total change ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━┫
┃ resume-app-iac                                     ┃          +$21 ┃        +$7 ┃         +$28 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━┻━━━━━━━━━━━━━━┛
```
</details>

<h4>Governance checks</h4>

<details>
<summary><strong>🔴 1 failure</strong></summary>
<br />
<table>
<tr><td><strong>FinOps tags</strong>: This example Tagging policy shows how you can enforce required FinOps tag keys/values in pull requests. This example checks for the tags 'Service' (can have any value) and 'Environment' (must be Dev/Stage/Prod) on all taggable resources being changed in the pull request. You can adjust it from https://dashboard.infracost.io > Governance > Tagging policies. You have a 14 day trial of this feature as it's part of Infracost Cloud.</td></tr>
<tr><td>

aws_acm_certificate.resume-app-cert at `infracost_test.tf:5`
* Missing mandatory tags: `Service`, `Environment`

in project `AWS`

</td></tr>


</table>
</details>

<details>
<summary><strong>🟢 53 passed</strong></summary>
<br />
<table>
<tr><td>52 FinOps policies, 0 Tagging policies, and 1 Guardrail passed.</td></tr>
</table>
</details>

#### Progression and Future Ideas 💡

 - This repository will eventually contain both Terraform and Ansible configuration files. Currently working on getting the whole infra set up via Terraform, will move on to Ansible after.
 - Add prod.tfvars, dev.tfvars etc that will ovverride the main variables.tf file.
 - ~~Transfer all .tf files to use vars from a base variables.tf file.~~
 - ~~Add backend.tf file that will define where the state.tf file will be saved (s3)~~