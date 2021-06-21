function Get-SecretAccessRequestSecret {
    <#
    .SYNOPSIS
    Get Secret Access Request by Secret ID for Current User

    .DESCRIPTION
    Get Secret Access Request by Secret ID for Current User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAccessRequestSecret -TssSession $session -SecretId 42

    Get any Secret Access Request on Secret 42 for current user (based on access token for session)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretAccessRequestSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Folder name/Get-SecretAccessRequestSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretAccessRequest')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [int[]]
        $SecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $SecretId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-access-requests', 'secrets', $secret -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting access request on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [TssSecretAccessRequest[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}