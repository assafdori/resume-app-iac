import requests
import json
import boto3
import time

## Created by assafdori.com
print("Firing up domain changes...")
time.sleep(3)

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
url = f"https://api.porkbun.com/api/json/v3/domain/updateNs/{domain_name}"
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

###################### !!!!!! BELOW IS DEPRECATED !!!!!! ##################

# Wait for a few seconds for DNS propagation
# print("Hold on, waiting for records to propagate before continuing...")
# time.sleep(30)

# # Get ACM certificate ARN
# acm_client = boto3.client('acm')
# response = acm_client.list_certificates()
# certificate_arn = None
# for certificate in response['CertificateSummaryList']:
#     if certificate['DomainName'] == domain_name:
#         certificate_arn = certificate['CertificateArn']
#         break

# if certificate_arn:
#     # Get DNS validation options
#     response = acm_client.describe_certificate(CertificateArn=certificate_arn)
#     validation_options = response['Certificate']['DomainValidationOptions']
#     for option in validation_options:
#         if option['ValidationMethod'] == 'DNS':
#             dns_record_name = option['ResourceRecord']['Name']
#             dns_record_value = option['ResourceRecord']['Value']

#             # Create CNAME record in Route 53
#             response = route53_client.change_resource_record_sets(
#                 HostedZoneId=hosted_zone_id,
#                 ChangeBatch={
#                     'Changes': [{
#                         'Action': 'UPSERT',
#                         'ResourceRecordSet': {
#                             'Name': dns_record_name,
#                             'Type': 'CNAME',
#                             'TTL': 300,
#                             'ResourceRecords': [{'Value': dns_record_value}]
#                         }
#                     }]
#                 }
#             )

#             print("CNAME record created successfully.")
#             print("DNS Record Name:", dns_record_name)
#             print("DNS Record Value:", dns_record_value)
#             break
# else:
#     print("ACM certificate not found for domain:", domain_name)
