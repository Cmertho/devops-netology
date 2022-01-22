#!/bin/bash
vault login $login_vault # export login_vault=123123123

vault write pki_int/issue/example-dot-com common_name="test.dozolin.devops.ru" ttl="720h" -format=json > /etc/cert_script/data.json

if [[ -s /etc/cert_script/data.json ]]
then 
    cat /etc/cert_script/data.json | jq -r '.data.ca_chain[0]' > /etc/cert_script/ca_chain.pem
    cat /etc/cert_script/data.json | jq -r '.data.certificate' > /etc/cert_script/certificate.pem
    cat /etc/cert_script/data.json | jq -r '.data.issuing_ca' > /etc/cert_script/issuing_ca.pem
    cat /etc/cert_script/data.json | jq -r '.data.private_key' > /etc/cert_script/private_key.pem

    rm /etc/cert_script/data.json

    systemctl reload nginx
else
    rm /etc/cert_script/data.json
    echo "Generation problem"
fi