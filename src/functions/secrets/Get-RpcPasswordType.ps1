function Get-RpcPasswordType {
    <#
    .SYNOPSIS
    Get Password Type

    .DESCRIPTION
    Get Password Type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcPasswordType -TssSession $session -Id 52

    Get Password Type 52

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssRpcPasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-RpcPasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssPasswordType')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("PasswordTypeId")]
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
            foreach ($passwordType in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-types', $passwordType -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting Password Type [$passwordType]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssPasswordType]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}