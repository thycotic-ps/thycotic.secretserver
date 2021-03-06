function Start-SecretDependency {
    <#
    .SYNOPSIS
    Start Secret Dependency

    .DESCRIPTION
    Start Secret Dependency, output must be captured to check run status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ident = Start-TssSecretDependency -TssSession $session -Id 46
    Get-TssSecretDependencyRunStatus -TssSession $session -Identifier $run

    After starting a Secret's Dependency 46, get the status of that run

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Start-TssSecretDependency

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Start-SecretDependency.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Dependency ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DependencyId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-dependencies', 'run' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $invokeParams.Body = ConvertTo-Json @($Id)
            if (-not $PSCmdlet.ShouldProcess("Dependency ID: $dependency", "$($invokeParamsOther.Method) $uri with:`n$($invokeParams.Body)`n")) { return }
            Write-Verbose "$($invokeParamsOther.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [string]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}