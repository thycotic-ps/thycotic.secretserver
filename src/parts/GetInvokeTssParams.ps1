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
        'WindowsAuth' {
            $invokeParams.UseDefaultCredentials = $true
        }
        default {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
        }
    }
    return $invokeParams
}