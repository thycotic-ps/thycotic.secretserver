function Get-TssFeatureFlag {
    <#
    .SYNOPSIS
    Get whether a feature flag is enabled

    .DESCRIPTION
    Get whether a Secret Server feature flag is enabled. Returns the key and its state. Secret Server reports Enabled as False for an unknown key and when it cannot evaluate the flag.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Key
    Feature flag key, for example inventory or url-type-match

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFeatureFlag -TssSession $session -Key inventory, url-type-match

    Show whether the inventory and url-type-match feature flags are enabled

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/featureflag/Get-TssFeatureFlag

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/featureflag/Get-TssFeatureFlag.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.FeatureFlag.State')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $Key
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentKey in $Key) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'featureflag', $currentKey -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssFeatureFlag request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [Thycotic.PowerShell.FeatureFlag.State]@{
                        Key     = $currentKey
                        Enabled = [System.Convert]::ToBoolean($restResponse)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
