ba_api_get_call () {
	endpoint=$1
	curl -s --request GET --header "content-type: application/json" --header "authorization: Bearer $BA_BEARER_TOKEN" --url "$BA_API_URI$endpoint"
}

ba_get_default_proj_id () {
	echo $(ba_api_get_call "/user-info" | jq -r ".data.organizationId" | cut -d"_" -f2)
}

export_BA_env_vars () {
	cred_name="${1:-ton}" ## Replace "ton" with your credential name, if you're using something different
	if ! biganimal cluster show -c $cred_name > /dev/null
	then
		echo "!!! Running the credential reset command now !!!"
		biganimal credential reset $cred_name
	fi
	biganimal cluster show -c $cred_name >&/dev/null
	export BA_BEARER_TOKEN=$(biganimal credential show -o json| jq -r --arg CREDNAME "$cred_name" '.[]|select(.name==$CREDNAME).accessToken')
	export BA_API_URI="https://"$(biganimal credential show -o json | jq -r --arg CREDNAME "$cred_name" '.[]|select(.name==$CREDNAME).address')/api/v3
	export BA_CRED_NAME="$cred_name"
	echo "$cred_name BA_BEARER_TOKEN and BA_API_URI are exported."
	export TF_VAR_project_id="prj_$(ba_get_default_proj_id)"
	echo "TF_VAR_project_id terraform variable is also exported. Value is $TF_VAR_project_id"
}
