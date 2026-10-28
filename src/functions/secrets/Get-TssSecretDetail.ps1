function Get-TssSecretDetail {
    <#
    .SYNOPSIS
    Get the general details of a secret

    .DESCRIPTION
    Returns the general details of a secret as the web UI shows them: name, folder, template, site, secret policy, heartbeat and password compliance status, launchers, SSH key and TOTP settings.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER IsEditMode
    Return the details as the edit view loads them

    .PARAMETER LoadReadOnlyFlags
    Include read only flags

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDetail -TssSession $session -Id 42

    Returns the general details of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretDetail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretDetail.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.DetailGeneral')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [switch]
        $IsEditMode,

        [switch]
        $LoadReadOnlyFlags
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
                $uri = $TssSession.ApiUrl, 'secrets', 'secret-detail', $currentId, 'general' -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'IsEditMode' {
                        $queryParams += "isEditMode=$([boolean]$IsEditMode)"
                    }
                    'LoadReadOnlyFlags' {
                        $queryParams += "loadReadOnlyFlags=$([boolean]$LoadReadOnlyFlags)"
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
                    Write-Warning 'Issue with Get-TssSecretDetail request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.DetailGeneral](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.DetailGeneral]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
