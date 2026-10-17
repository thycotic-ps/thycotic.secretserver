function Get-TssDirectoryDomainStub {
    <#
    .SYNOPSIS
    Get a template for a new Directory Services domain

    .DESCRIPTION
    Get the default values Secret Server uses for a new directory domain of the given type, such as the site, whether the domain starts active and the multifactor provider. Nothing is created.
    -V2 calls the v2 endpoint; both return the same shape.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DomainType
    Directory type: ActiveDirectory, OpenLdap or AzureActiveDirectory

    .PARAMETER V2
    Call the v2 endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDirectoryDomainStub -TssSession $session -DomainType ActiveDirectory

    Show the defaults for a new Active Directory domain

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDirectoryDomainStub -TssSession $session -DomainType OpenLdap -V2

    Show the defaults for a new OpenLDAP domain from the v2 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryDomainStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryDomainStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.DirectoryServices.DirectoryDomain')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [ValidateSet('ActiveDirectory', 'OpenLdap', 'AzureActiveDirectory')]
        [string]
        $DomainType,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'V2' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'directory-services', 'domains', 'stub' -join '/'
                    $queryParams = @()
                    switch ($tssParams.Keys) {
                        'DomainType' {
                            $queryParams += "domainType=$([uri]::EscapeDataString($DomainType))"
                        }
                    }
                    if ($queryParams) {
                        $uri = $uri, ($queryParams -join '&') -join '?'
                    }
                }
                default {
                    $uri = $TssSession.ApiUrl, 'directory-services', 'domains', 'stub' -join '/'
                    $queryParams = @()
                    switch ($tssParams.Keys) {
                        'DomainType' {
                            $queryParams += "domainType=$([uri]::EscapeDataString($DomainType))"
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
                Write-Warning 'Issue with Get-TssDirectoryDomainStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DirectoryServices.DirectoryDomain](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DirectoryServices.DirectoryDomain]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
