param(
    [string]$PropertyKey,
    [string]$PropertyValue,
    [string]$AppSiteUrl,
    [string]$Description,
    [string]$Comment
)
begin{
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
        Set-SPOStorageEntity -Site $AppSiteUrl -Key $PropertyKey -Value $PropertyValue -Comments $Comment -Description $Description
        Write-Host "The Tenant property: $PropertyKey succesfully created" -ForegroundColor Green
    }else{
        Write-Host "The tenant property is already created. You must remove it before." -ForegroundColor Yellow
    }
}
