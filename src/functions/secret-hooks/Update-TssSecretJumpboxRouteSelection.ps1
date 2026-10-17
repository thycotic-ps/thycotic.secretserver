function Update-TssSecretJumpboxRouteSelection {
    <#
    .SYNOPSIS
    Set or clear the jumpbox route of a secret

    .DESCRIPTION
    Assigns a jumpbox route to a secret, or clears the assignment with -Clear.
    Returns the assigned route; nothing when cleared.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER JumpboxRouteId
    ID (GUID) of the jumpbox route to assign

    .PARAMETER Clear
    Clear the jumpbox route assignment of the secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretJumpboxRouteSelection -TssSession $session -Id 42 -JumpboxRouteId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Assigns the jumpbox route to secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretJumpboxRouteSelection -TssSession $session -Id 42 -Clear

    Clears the jumpbox route of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Update-TssSecretJumpboxRouteSelection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Update-TssSecretJumpboxRouteSelection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'route')]
    [OutputType('Thycotic.PowerShell.SecretHooks.JumpboxRouteSelection')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'route')]
        [string]
        $JumpboxRouteId,

        [Parameter(Mandatory, ParameterSetName = 'clear')]
        [switch]
        $Clear
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-detail', $Id, 'jumpbox-route-selection' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ jumpboxRouteId = $null }
            if ($PSCmdlet.ParameterSetName -eq 'route') {
                $body.jumpboxRouteId = $JumpboxRouteId
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret jumpbox route selection: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretJumpboxRouteSelection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.jumpboxRouteId) {
                    [Thycotic.PowerShell.SecretHooks.JumpboxRouteSelection](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretHooks.JumpboxRouteSelection]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
