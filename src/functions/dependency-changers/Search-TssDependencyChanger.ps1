function Search-TssDependencyChanger {
    <#
    .SYNOPSIS
    List dependency changers

    .DESCRIPTION
    Returns dependency changers, active only unless -Status says otherwise.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DependencyTypeId
    Only return changers of this dependency type

    .PARAMETER Status
    Active (server default), Inactive or All

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyChanger -TssSession $session

    List the active dependency changers

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyChanger -TssSession $session -DependencyTypeId 8 -Status All

    List every dependency changer of dependency type 8 (SSH Script)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChanger

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChanger.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DependencyChangers.DependencyChangerSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Alias('SecretDependencyTypeId')]
        [int]
        $DependencyTypeId,

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
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changers' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DependencyTypeId' {
                    $queryParams += "filter.secretDependencyTypeId=$($DependencyTypeId)"
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
                Write-Warning 'Issue with Search-TssDependencyChanger request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DependencyChangers.DependencyChangerSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DependencyChangers.DependencyChangerSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
