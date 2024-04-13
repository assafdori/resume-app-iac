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

# Retrieve name servers from Route 53
route53_client = boto3.client('route53')
response = route53_client.list_hosted_zones_by_name(DNSName=domain_name)
hosted_zone_id = response['HostedZones'][0]['Id'].split('/')[-1]
response = route53_client.get_hosted_zone(Id=hosted_zone_id)
name_servers = response['DelegationSet']['NameServers']

# Construct the request body to update name servers according to the Porkbun API documentation
request_body = {
    "apikey": pork_api_key,
    "secretapikey": pork_api_secret,
    "ns": name_servers
}

# Update name servers on Porkbun
url = f"https://porkbun.com/api/json/v3/domain/updateNs/{domain_name}"
headers = {"Content-Type": "application/json"}
response = requests.post(url, headers=headers, json=request_body)

# Check the response for name server update
if response.status_code == 200:
    print("Name servers updated successfully.")
    print(response.json())
else:
    print("Failed to update name servers.")
    print("Status Code:", response.status_code)
    print("Response:", response.json())

# Retrieve ACM certificate ARN and DNS validation records
acm_client = boto3.client('acm')
response = acm_client.list_certificates()
acm_certificate_arn = response['CertificateSummaryList'][0]['CertificateArn']
response = acm_client.describe_certificate(CertificateArn=acm_certificate_arn)
dns_validation_options = response['Certificate']['DomainValidationOptions']

# Construct DNS records for Porkbun API request
dns_records = []
for option in dns_validation_options:
    dns_records.append({
        'name': option['ResourceRecord']['Name'],
        'type': option['ResourceRecord']['Type'],
        'content': option['ResourceRecord']['Value'],
        'ttl': '600'
    })

# Create DNS records on Porkbun
url = f"https://porkbun.com/api/json/v3/dns/create/{domain_name}"
headers = {"Content-Type": "application/json"}

# Remove domain name from the record name
subdomain_name = dns_records[0]['name'].replace(f'.{domain_name}', '') # + '.' # ADD IF DOMAIN ISN'T AUTHENTICATED
request_body = {
    "apikey": pork_api_key,
    "secretapikey": pork_api_secret,
    "name": subdomain_name,  # Use only the subdomain without the domain name, according to Porkbun.
    "type": dns_records[0]['type'],
    "content": dns_records[0]['content'],
    "ttl": dns_records[0]['ttl']
}

response = requests.post(url, headers=headers, json=request_body)

# Check the response for DNS record creation
if response.status_code == 200:
    print("DNS records created successfully.")
    print(response.json())
else:
    print("Failed to create DNS records.")
    print("Status Code:", response.status_code)
    print("Response:", response.json())
