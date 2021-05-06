function Get-SecretDependencyGroup {
    <#
    .SYNOPSIS
    Get Secret Dependency Group for a Secret

    .DESCRIPTION
    Get Secret Dependency Group for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyGroup -TssSession $session -Id 42

    Return Secret Dependency Group(s) for Secret ID 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretDependencyGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-SecretDependencyGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretDependencyGroup')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
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
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies', 'groups', $secret -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting Secret Dependency Group(s) on [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.model) {
                    [TssSecretDependencyGroup[]]$restResponse.model
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}