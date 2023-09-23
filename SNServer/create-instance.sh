
#!/bin/bash

red='\e[31m'
yellow1='\e[0;93m'
yellow='\e[1;33m'
gray='\e[90m'
green='\e[92m'
blue='\e[94m'   
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
plain='\033[0m'

if [[ -n $1 ]] && [[ $2 == e2-* ]] && [[ -n $3 ]] && [[ -n $4 ]] && [[ -n $5 ]] && [[ -n $6 ]] && [[ -n $7 ]] && [[ $(($(date +%s) - $7)) -lt 120 ]] && [[ $(($(date +%s) - $7)) -ge 0 ]]; then

echo -e "${yellow}Creating instance ...${plain}"
instance=$(gcloud compute instances create $1 --project=$5 --zone=$4 --machine-type=$2 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=$6-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server --create-disk=auto-delete=yes,boot=yes,device-name=persistent-disk-0,image=projects/debian-cloud/global/images/debian-10-buster-v20230912,mode=rw,size=10,type=projects/$5/zones/$4/diskTypes/pd-standard --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any)
echo -e "${green}Instance created.${plain}"
echo -e "${yellow}Checking firewall rule ...${plain}"
if [[ $(gcloud compute firewall-rules list --format='value(allowed)') == *"'IPProtocol': 'all'"* ]]; then
echo -e "${green}Firewall rule already exist.${plain}"
else
echo -e "${yellow}Creating firewall rule ...${plain}"
gcloud compute firewall-rules create $3 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all --source-ranges=0.0.0.0/0 --no-user-output-enabled
echo -e "${green}Firewall rule created.${plain}"
fi

echo ""
echo -e "${yellow}------------------------------------${plain}"
printf "Success Created!!"
echo -e "${yellow}------------------------------------${plain}"

echo -e "${yellow1}●●●●●●●●●●●●●●●●●●●●●●●●●●●● ${plain}"

else
echo -e "${red}Something went wrong. Contact the developer https://t.me/mlulinX.${plain}"
fi
