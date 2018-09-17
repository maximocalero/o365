param(
    [string]$PropertyKey,
    [string]$AppSiteUrl
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

    if($tenantProp.ServerObjectIsNull -eq $false){
        Remove-SPOStorageEntity -Site $AppSiteUrl -Key $PropertyKey
        Write-Host "The Tenant property: $PropertyKey succesfully removed" -ForegroundColor Green
    }else{
        Write-Host "The tenant property doesn't exist. May be the Key or the URL is not correct, please check it" -ForegroundColor Yellow
    }
}