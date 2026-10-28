function Get-TssKeyManagementAudit {
    <#
    .SYNOPSIS
    Get the Key Management audit trail

    .DESCRIPTION
    By default, gets the master encryption key rotation audit records, filtered by action, user or text.
    -Users gets the distinct users that appear in the master encryption key rotation audit. -Configuration gets the Key Management configuration change audit records.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Action
    Return only rotation audit records with this action

    .PARAMETER SearchTerm
    Return only rotation audit records that contain this text

    .PARAMETER UserId
    Return only rotation audit records of this user id

    .PARAMETER Users
    Get the distinct users in the master encryption key rotation audit

    .PARAMETER SearchText
    Return only configuration audit records that contain this text

    .PARAMETER Configuration
    Get the Key Management configuration change audit records

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssKeyManagementAudit -TssSession $session

    Get the master encryption key rotation audit records

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssKeyManagementAudit -TssSession $session -Users

    Get the users that appear in the master encryption key rotation audit

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssKeyManagementAudit -TssSession $session -Configuration

    Get the Key Management configuration change audit records

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.KeyManagement.RotationAudit[]', ParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.KeyManagement.AuditUser[]', ParameterSetName = 'Users')]
    [OutputType('Thycotic.PowerShell.KeyManagement.ConfigurationAudit[]', ParameterSetName = 'Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ParameterSetName = 'Default')]
        [string]
        $Action,

        [Parameter(ParameterSetName = 'Default')]
        [string]
        $SearchTerm,

        [Parameter(ParameterSetName = 'Default')]
        [int]
        $UserId,

        [Parameter(Mandatory, ParameterSetName = 'Users')]
        [switch]
        $Users,

        [Parameter(ParameterSetName = 'Configuration')]
        [string]
        $SearchText,

        [Parameter(Mandatory, ParameterSetName = 'Configuration')]
        [switch]
        $Configuration
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            switch ($PSCmdlet.ParameterSetName) {
                'Users' {
                    Compare-TssVersion $TssSession '11.1.000006' $PSCmdlet.MyInvocation
                    $uri = $TssSession.ApiUrl, 'key-management', 'audit', 'users' -join '/'
                }
                'Configuration' {
                    Compare-TssVersion $TssSession '11.7.000031' $PSCmdlet.MyInvocation
                    $uri = $TssSession.ApiUrl, 'key-management', 'config', 'audit' -join '/'
                    $queryParams = @()
                    $queryParams += "take=$($TssSession.Take)"
                    switch ($tssParams.Keys) {
                        'SearchText' {
                            $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                        }
                    }
                    if ($queryParams) {
                        $uri = $uri, ($queryParams -join '&') -join '?'
                    }
                }
                default {
                    Compare-TssVersion $TssSession '11.1.000006' $PSCmdlet.MyInvocation
                    $uri = $TssSession.ApiUrl, 'key-management', 'audit' -join '/'
                    $queryParams = @()
                    $queryParams += "take=$($TssSession.Take)"
                    switch ($tssParams.Keys) {
                        'Action' {
                            $queryParams += "filter.action=$([uri]::EscapeDataString($Action))"
                        }
                        'SearchTerm' {
                            $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
                        }
                        'UserId' {
                            $queryParams += "filter.userId=$($UserId)"
                        }
                    }
                    if ($queryParams) {
                        $uri = $uri, ($queryParams -join '&') -join '?'
                    }
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssKeyManagementAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            switch ($PSCmdlet.ParameterSetName) {
                'Users' {
                    if ($restResponse) {
                        [Thycotic.PowerShell.KeyManagement.AuditUser[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.AuditUser]))
                    }
                }
                'Configuration' {
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.KeyManagement.ConfigurationAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.KeyManagement.ConfigurationAudit]))
                    }
                }
                default {
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.KeyManagement.RotationAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.KeyManagement.RotationAudit]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
