function Get-SecretDependency {
    <#
    .SYNOPSIS
    Get a Secret Dependency

    .DESCRIPTION
    Get a Secret Dependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependency -TssSession $session -Id 24

    Return the Secret Dependency 24

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretDependency

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-SecretDependency.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretDependency')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Dependency ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretDependencyId')]
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
            foreach ($dependency in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies', $dependency -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting Secret Dependency [$dependency]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssSecretDependency]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}