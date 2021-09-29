function Get-TssSecretDependencyRunStatus {
    <#
    .SYNOPSIS
    Get Run status of a Secret Dependency identifier

    .DESCRIPTION
    Get Run status of a Secret Dependency identifier

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ident = Start-TssSecretDependency -TssSession $session -Id 46
    Get-TssSecretDependencyRunStatus -TssSession $session -Identifier $run

    After starting a Secret's Dependency 46, get the status of that run

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyRunStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyRunStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretDependencies.TaskProgress')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Identifier, output from Start-TssSecretDependency
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]
        $Identifier
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($run in $Identifier) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies', 'run', $run -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting run status on [$run]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretDependencies.TaskProgress]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}