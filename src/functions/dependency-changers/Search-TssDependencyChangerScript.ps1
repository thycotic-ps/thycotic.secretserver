function Search-TssDependencyChangerScript {
    <#
    .SYNOPSIS
    List the scripts a dependency changer can use

    .DESCRIPTION
    Returns the scripts that can be bound to the script slots of a dependency changer (password change, verification, success and fail).
    The server requires a dependency changer ID and returns HTTP 500 without one.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DependencyChangerId
    Dependency changer ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyChangerScript -TssSession $session -DependencyChangerId 7

    List the scripts available to dependency changer 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DependencyChangers.Script[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretDependencyChangerId')]
        [int]
        $DependencyChangerId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changer-scripts' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'DependencyChangerId' {
                    $queryParams += "secretDependencyChangerId=$($DependencyChangerId)"
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
                Write-Warning 'Issue with Search-TssDependencyChangerScript request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DependencyChangers.Script[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DependencyChangers.Script]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
