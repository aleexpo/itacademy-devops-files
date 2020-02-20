curl -X POST 'http://localhost:8080/credentials/store/system/domain/_/createCredentials' \
--user admin:admin \
--data-urlencode 'json={  
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "nexus-creds",
    "username": "apicredentials",
    "password": "P@$$W0rd",
    "description": "apicredentials",
    "stapler-class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'
