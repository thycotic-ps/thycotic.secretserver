<#
.Synopsis
    Gets Invoke-TssRestApi parameters
.Description
    Gets the parameters for Invoke-TssRestApi, presetting some based on TssSession contents
#>
param(
    # A collection of parameters.  Parameters not used in Invoke-TssRestApi will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory)]
    [TssSession]
    $TssSession
)

process {
    $invokeParams = @{}
    switch ($TssSession.TokenType) {
        'bearer' {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
        }
        'ExternalToken' {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
        }
        'SdkClient' {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
        }
        'WindowsAuth' {
            $invokeParams.UseDefaultCredentials = $true
        }
    }
    return $invokeParams
}