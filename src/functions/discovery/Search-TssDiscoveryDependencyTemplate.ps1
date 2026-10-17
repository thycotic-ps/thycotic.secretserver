function Search-TssDiscoveryDependencyTemplate {
    <#
    .SYNOPSIS
    Search Discovery dependency templates

    .DESCRIPTION
    Returns the Discovery dependency templates, which map a dependency type (for example a Windows service or IIS application pool) to a scan template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretDependencyTypeId
    Return only templates of this dependency type

    .PARAMETER Status
    Active, Inactive or All. The server returns active templates when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyTemplate -TssSession $session

    List the active dependency templates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyTemplate -TssSession $session -Status All -SecretDependencyTypeId 1

    List active and inactive dependency templates of dependency type 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyTemplateSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $SecretDependencyTypeId,

        [ValidateSet('Active', 'Inactive', 'All')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', 'dependency-templates' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SecretDependencyTypeId' {
                    $queryParams += "filter.secretDependencyTypeId=$($SecretDependencyTypeId)"
                }
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
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
                Write-Warning 'Issue with Search-TssDiscoveryDependencyTemplate request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.DependencyTemplateSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.DependencyTemplateSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
