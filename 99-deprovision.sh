#!/bin/bash

echo "Be sure to be logged in to Big Animal and that you are in the correct project."
read -p "Are you? Y/N " LOGGEDIN

if [ $LOGGEDIN == "Y" ]; then
    export cred_name=ton
    export BA_BEARER_TOKEN=$(biganimal credential show -o json| jq -r --arg CREDNAME "$cred_name" '.[]|select(.name==$CREDNAME).accessToken')
    echo $BA_BEARER_TOKEN
    export TF_VAR_cluster_name=tons_tf_cluster
    echo $TF_VAR_cluster_name
    export BA_API_URI="https://"$(biganimal credential show -o json | jq -r --arg CREDNAME "$cred_name" '.[]|select(.name==$CREDNAME).address')/api/v3
    echo $BA_API_URI
    export TF_VAR_project_id=$(cat $HOME/.baproject)
    biganimal config set confirm_mode off
    biganimal cluster delete --name tons-cli-cluster --provider bah:aws --region eu-west1
    terraform destroy
    rm -rf .terraform
    rm .terraform.lock.hcl
    rm terraform.*
    biganimal cluster show
    read -p "All cluster gone? Y/N " ALLGONE
    if [ $ALLGONE == "Y" ]; then
        biganimal credential delete $cred_name
    fi
fi