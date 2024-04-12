import requests
import json
import boto3
import base64

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
pork_api_key = secret_dict['pork_api_key']  # Ensure this key name matches what's in Secrets Manager
pork_api_secret = secret_dict['pork_api_secret']  # Ensure this key name matches what's in Secrets Manager

# Initialize a Route 53 client
route53_client = boto3.client('route53')

# Retrieve the hosted zone ID for the domain
response = route53_client.list_hosted_zones_by_name(DNSName=domain_name)
for hosted_zone in response['HostedZones']:
    if hosted_zone['Name'] == f"{domain_name}.":
        hosted_zone_id = hosted_zone['Id'].split('/')[-1]  # Extracting the hosted zone ID
        break
else:
    raise ValueError("Hosted zone not found for domain.")

# Retrieve name servers from Route 53
response = route53_client.get_hosted_zone(Id=hosted_zone_id)
name_servers = response['DelegationSet']['NameServers']

# Check if name servers are already a list
if isinstance(name_servers, str):
    name_servers = name_servers.split(',')
elif not isinstance(name_servers, list):
    raise TypeError("Unexpected data type for name servers")

# Construct the request body according to the Porkbun API documentation
request_body = {
    "apikey": pork_api_key,
    "secretapikey": pork_api_secret,
    "ns": name_servers
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
