function Get-TssSshCommandBlocklistPolicy {
    <#
    .SYNOPSIS
    Get the secret policies that apply an SSH command blocklist

    .DESCRIPTION
    Returns the secret policies that apply the SSH command blocklist with the given ID.
    Requires the View SSH Menus or Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SshCommandBlocklistId
    ID (a GUID) of the blocklist whose secret policies are returned

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandBlocklistPolicy -TssSession $session -SshCommandBlocklistId 'a3f1c9e2-5b7d-4e8a-9c0f-1d2e3b4a5c6d'

    Returns the secret policies that apply that blocklist

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' | Get-TssSshCommandBlocklistPolicy -TssSession $session

    Returns the secret policies that apply a blocklist with "Production" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandBlocklist.Policy[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $SshCommandBlocklistId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-blocklist', 'policies' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += "filter.sshCommandBlocklistId=$([uri]::EscapeDataString($SshCommandBlocklistId))"
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSshCommandBlocklistPolicy request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommandBlocklist.Policy[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommandBlocklist.Policy]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
