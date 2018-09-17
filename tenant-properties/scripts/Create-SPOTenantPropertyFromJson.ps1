param(
    [string]$PropertyKey,
    [string]$AppSiteUrl,
    [string]$Description,
    [string]$Comment,
    [string]$PropertyPathValue
)
begin{
    $checkPath = Test-Path -Path $PropertyPathValue
    if ($checkPath -eq $false){
        Write-Host "The path provided in the $PropertyPathValue is incorrect. Please provide a correct path to the json file" -ForegroundColor Red
        return
    }

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

    $jsonString = $json | ConvertTo-Json -Compress

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

    if($tenantProp.ServerObjectIsNull){
        Set-SPOStorageEntity -Site $AppSiteUrl -Key $PropertyKey -Value $jsonString -Comments $Comment -Description $Description
        Write-Host "The Tenant property: $PropertyKey succesfully created" -ForegroundColor Green
    }else{
        Write-Host "The tenant property is already created. You must remove it before." -ForegroundColor Yellow
    }
}
