import requests
import json
import boto3

# AWS Secret Manager details
secret_name = "aws-pork-dns-ns"
region_name = "us-east-1"

# Porkbun Domain Name
domain_name = "assafdori.com"

# Initialize a Secrets Manager client
client = boto3.client('secretsmanager', region_name=region_name)

# Retrieve Porkbun API credentials from AWS Secret Manager
response = client.get_secret_value(SecretId=secret_name)
secret_dict = json.loads(response['SecretString'])
pork_api_key = secret_dict['pork_api_key']
pork_api_secret = secret_dict['pork_api_secret']

# Initialize ACM client
acm_client = boto3.client('acm')

# Retrieve the ACM certificate ARN
response = acm_client.list_certificates()
acm_certificate_arn = response['CertificateSummaryList'][0]['CertificateArn']

# Retrieve DNS validation records for the ACM certificate
response = acm_client.describe_certificate(CertificateArn=acm_certificate_arn)
dns_validation_options = response['Certificate']['DomainValidationOptions']

# Construct DNS records for Porkbun API request
dns_records = []
for option in dns_validation_options:
    dns_records.append({
        'name': option['ResourceRecord']['Name'],
        'type': option['ResourceRecord']['Type'],
        'value': option['ResourceRecord']['Value']
    })

# Retrieve name servers from Route 53
route53_client = boto3.client('route53')
response = route53_client.list_hosted_zones_by_name(DNSName=domain_name)
hosted_zone_id = response['HostedZones'][0]['Id'].split('/')[-1]
response = route53_client.get_hosted_zone(Id=hosted_zone_id)
name_servers = response['DelegationSet']['NameServers']

# Construct the request body according to the Porkbun API documentation
request_body = {
    "apikey": pork_api_key,
    "secretapikey": pork_api_secret,
    "ns": name_servers,
    "dns_records": dns_records  # Include DNS validation records
}

# Update DNS records on Porkbun
url = f"https://porkbun.com/api/json/v3/domain/updateNs/{domain_name}"
headers = {"Content-Type": "application/json"}
response = requests.post(url, headers=headers, json=request_body)

# Check the response
if response.status_code == 200:
    print("DNS records updated successfully.")
    print(response.json())
else:
    print("Failed to update DNS records.")
    print("Status Code:", response.status_code)
    print("Response:", response.json())
