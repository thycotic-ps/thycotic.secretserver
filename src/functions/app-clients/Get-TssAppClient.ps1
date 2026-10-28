function Get-TssAppClient {
    <#
    .SYNOPSIS
    Get an OAuth app client by ID

    .DESCRIPTION
    Get one or more OAuth app clients by ID, including the client ID and the redirect URI.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    App client ID

    .PARAMETER IncludeInactive
    Include inactive app clients

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssAppClient -TssSession $session -Id 2

    Returns app client 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.AppClients.AppClient')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        [switch]
        $IncludeInactive
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
                $uri = $TssSession.ApiUrl, 'app-clients', $currentId -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'IncludeInactive' {
                        $queryParams += "includeInactive=$([boolean]$IncludeInactive)"
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
                    Write-Warning 'Issue with Get-TssAppClient request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AppClients.AppClient](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AppClients.AppClient]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
