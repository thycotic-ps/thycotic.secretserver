function Get-TssDependencyChanger {
    <#
    .SYNOPSIS
    Get a dependency changer

    .DESCRIPTION
    Returns a dependency changer with its settings and its password change, verification, success and fail scripts.
    Script credentials (Username, Password, Key, Passphrase) are token placeholders when UseTokens is true; otherwise they are the values stored on the changer, returned as is.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dependency changer ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDependencyChanger -TssSession $session -Id 7

    Get dependency changer 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyChanger -TssSession $session -Status All | Get-TssDependencyChanger -TssSession $session

    Get every dependency changer, active or not, in full

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Get-TssDependencyChanger

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Get-TssDependencyChanger.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DependencyChangers.DependencyChanger')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretDependencyChangerId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changer', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDependencyChanger request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DependencyChangers.DependencyChanger](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DependencyChangers.DependencyChanger]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
