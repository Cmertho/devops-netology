import requests
import os 
a = requests.post("http://127.0.0.1:8201/v1/pki_int/issue/example-dot-com",
                    headers={"X-Vault-Token": "s.5Pi5yMABH0ZJMNokDMRZ9X9t"}, 
                    data={"common_name": "test.dozolin.devops.ru", "ttl": "720h"})
data = a.json()
with open("/etc/cert_script/ca_chain.pem", "w") as ca_chain:
    ca_chain.write(data["data"]["ca_chain"][0])

with open("/etc/cert_script/certificate.pem", "w") as certificate:
    certificate.write(data['data']["certificate"])

with open("/etc/cert_script/issuing_ca.pem", "w") as issuing_ca:
    issuing_ca.write(data['data']["issuing_ca"])

with open("/etc/cert_script/private_key.pem", "w") as private_key:
    private_key.write(data['data']["private_key"])

os.popen("systemctl reload nginx")