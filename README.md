# Custom Python Container - Connecting MySQL with MSI and Azure KeyVault

>**The purpose of this repository is intended just for training material and it is not recommended to take this as a reference for production scenarios.**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazureossd%2Fappsreadynext-python-msi%2Fmaster%2Ftemplate.json)

- This template will create the following resources:
    - Azure Database for MySQL with Enforce SSL option disabled.
    - Azure Web Apps for Containers Python pulling from **azureossd/appsreadynext-msi:01**

## Requirements
1. Create an **Azure KeyVault** resource.
2. Create a **secret** for your KeyVault with your MySQL password.
3. Go to Azure Web App under **Identity** and then enable **System Assigned** and copy the Object ID value for next step.
4. Create/Update the following App Settings for your web app.

 -  **KEY_VAULT_URL**=your_keyvault_url
 -  **SECRET_NAME** = your_secret_name
 -  **HOST** = database_server
 -  **USER** = database_user
 -  **DATABASE** = database_name
5. Go to your KeyVault under **Access policies** and add an **Access Policy**.
6. Select from template **Secret Management** and select just Secret Permissions **Get** and then Select principal and search by object id and add it.(Do not add Authorized Application, leave it as none selected) 
7. Enable Application Logs and request the site.
8. You will get the following exception: *EnvironmentCredential.get_token failed: EnvironmentCredential authentication unavailable. Environment variables are not fully configured*.

## Not able to find Environment Credentials
1. In order to fix this issue, you need to replace DefaultAzureCredential with ManagedIdentityCredential, this change is already made in **azureossd/appsreadynext-msi:02**, so go to Container Settings and pull from this image **azureossd/appsreadynext-msi:02**