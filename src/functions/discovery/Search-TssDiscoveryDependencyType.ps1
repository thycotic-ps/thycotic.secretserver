function Search-TssDiscoveryDependencyType {
    <#
    .SYNOPSIS
    Search Discovery dependency types

    .DESCRIPTION
    Returns the dependency types Discovery knows (for example Windows service, scheduled task or IIS application pool), whether the license allows each one, and whether it can be assigned to a dependency template or a custom dependency changer.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ValidForDependencyChanger
    Return only the dependency types that a custom dependency changer can use

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyType -TssSession $session

    List every dependency type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryDependencyType -TssSession $session -ValidForDependencyChanger

    List the dependency types a custom dependency changer can use

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyType[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ValidForDependencyChanger
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', 'dependency-types' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ValidForDependencyChanger' {
                    $queryParams += "filter.validForDependencyChanger=$([boolean]$ValidForDependencyChanger)"
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
                Write-Warning 'Issue with Search-TssDiscoveryDependencyType request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.DependencyType[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.DependencyType]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
