function Search-TssCustomCommand {
    <#
    .SYNOPSIS
    List the custom commands of a password type

    .DESCRIPTION
    Returns the custom commands of one or more password types, in command order.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password type ID whose custom commands are listed

    .PARAMETER CommandTypeCode
    Only return commands with this command type code (1 password change, 2 verify password, 3 password change with other credentials, 4 after a successful change, 5 after a failed change)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssCustomCommand -TssSession $session -Id 18

    List the custom commands of password type 18

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRpcPasswordType -TssSession $session | Where-Object Name -like '*Custom (SSH)' | Search-TssCustomCommand -TssSession $session

    List the custom commands of every custom SSH password type

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Search-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Search-TssCustomCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.CustomCommand[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordTypeId')]
        [int[]]
        $Id,

        [int]
        $CommandTypeCode
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
                $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-commands', $currentId -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'CommandTypeCode' {
                        $queryParams += "filter.commandTypeCode=$($CommandTypeCode)"
                    }
                }
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
                    Write-Warning 'Issue with Search-TssCustomCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Rpc.CustomCommand[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Rpc.CustomCommand]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
