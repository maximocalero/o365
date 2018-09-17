**PowerShell Scripts to create and remove Tenant Properties**
===============================

I created three PowerShell Scripts that they could help you to create and remove Tenant Properties. A brief description of these scripts:

* **Create-SPOTenantPropertyFromValue.ps1**. To create a new tenant property for a string value. This script checks that the tenant property doesn't exist and a SharePoint online connection is available.
* **Remove-SPOTEnantProperty.ps1**. To remove a tenant property. This script checks that the tenant property exists  and a SharePoint online connection is available.
* **Create-SPOTenantPropertyFromJson.ps1**. This script is a little more complex, since there are several validations related with the json file to be sure we will create succesfully our new tenant property and a SharePoint online connection is available.

I'm going to explain in detail the last one, **Create-SPOTenantPropertyFromJson.ps1**.

As I commented before, this script has some validations to check that the json file is correct. The first validation is check the path of the json file:

```
    $checkPath = Test-Path -Path $PropertyPathValue
    if ($checkPath -eq $false){
        Write-Host "The path provided in the $PropertyPathValue is incorrect. Please provide a correct path to the json file" -ForegroundColor Red
        return
    }
```

After this validation, the script also checks that the json is correct. For that the script is using a Try/Cath block:

```
    try {
        $json = Get-Content $PropertyPathValue | Out-String | ConvertFrom-Json        
    }
    catch {
        Write-Host "-------------------------" -ForegroundColor Red
        Write-Host "An Exception has ocurred" -ForegroundColor Red
        Write-Host "-------------------------" -ForegroundColor Red
        Write-Host "Getting $PropertyPathValue failed. Please, check the json file to fix any issue could have" -ForegroundColor Red
        return        
    }
    if ($null -eq $json){
        Write-Host "The json file provided in the $PropertyPathValue is incorrect. Please provide a correct json file" -ForegroundColor Red
        return
    }
```

The last validation is related with the SharePoint Online connection. This is also important because we need a SharePoint online connection to execute our command:

```
    $SpoConnectionAvailable = $false

    try {
        $tenantProp = Get-SPOStorageEntity -Site $AppSiteUrl -Key $PropertyKey
        $SpoConnectionAvailable = $true
    }
    catch [System.InvalidOperationException]{
        $ExceptionMessageConn = $_.Exception.Message
        If ($ExceptionMessageConn -match "No connection available*"){
            Write-Host "There is no SharePoint online connection available. You must use Connect-SPOService before running this command" -ForegroundColor Red
        }else{
            Write-Host "Another Invalid Operation Exception has ocurred. Message: $ExceptionMessageConn" -ForegroundColor Red
        }
    } 
    catch{
        $ExceptionMessageConn = $_.Exception.Message
        Write-Host "A general exception has ocurred. Message: $ExceptionMessageConn" -ForegroundColor Red
    }

    if ($SpoConnectionAvailable -eq $false){
        return
    }
```
>   **Note:** It's important to mention that to connect successfully with the Connect-SPOService, we are going to need an SharePoint Online global administrator user, otherwise we will not be able to do a connection correctly.
>   Also we must remember that the url for this command must be the following pattern:
>   https://[yourtenant]-admin.sharepoint.com
>   Where [yourtenant] would be the tenant name you have in Office 365

To run this script, we need a json file, you have in this repository a json example in [Global Navigation Example Json File](./jsonFiles/globalNavigationExample.json).

An example to launch this command would be the following:
```
.\Create-SPOTenantPropertyFromJson.ps1 -PropertyKey 'global-navigation-example' -AppSiteUrl https://[yourtenant].sharepoint.com/sites/apps-catalog -Description 'test' -Comment 'test' -PropertyPathValue ..\jsonFiles\globalNavigationExample.json
```
