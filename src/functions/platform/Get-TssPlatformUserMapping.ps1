function Get-TssPlatformUserMapping {
    <#
    .SYNOPSIS
    Get the Platform user mapped to a Secret Server user

    .DESCRIPTION
    Get the Delinea Platform user mapped to a Secret Server user. Every property is empty when the user has no mapping.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret Server user Id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformUserMapping -TssSession $session -Id 4

    Show the Platform user mapped to Secret Server user 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformUserMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformUserMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.UserMapping')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'platform', 'user', 'mapping' -join '/'
                $uri = $uri, "userId=$currentId" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Platform user mapping for user [$currentId]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Platform.UserMapping](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.UserMapping]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
