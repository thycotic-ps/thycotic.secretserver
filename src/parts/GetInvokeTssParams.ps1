<#
.Synopsis
    Gets Invoke-TssRestApi parameters
.Description
    Gets the parameters for Invoke-TssRestApi, presetting some based on TssSession contents
#>
param(
    [Parameter(ValueFromPipeline,Position = 0,Mandatory)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession
)

process {
    $getInvokeParams = @{}
    switch ($TssSession.TokenType) {
        'WindowsAuth' {
            $getInvokeParams.UseDefaultCredentials = $true
        }
        default {
            $getInvokeParams.PersonalAccessToken = $TssSession.AccessToken
        }
    }
    return $getInvokeParams
}