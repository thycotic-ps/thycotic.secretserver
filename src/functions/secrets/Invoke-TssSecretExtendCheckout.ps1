function Invoke-TssSecretExtendCheckout {
    <#
    .SYNOPSIS
    Extend a secret check out

    .DESCRIPTION
    Adds minutes to the active check out of a secret by the current user and returns the new check out end time.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER MinutesToAdd
    Minutes to add to the check out

    .PARAMETER Notes
    Reason for the extension

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssSecretExtendCheckout -TssSession $session -Id 42 -MinutesToAdd 30 -Notes 'Maintenance window'

    Extends the check out of secret 42 by 30 minutes

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretExtendCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretExtendCheckout.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.ExtendCheckout')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $MinutesToAdd,

        [string]
        $Notes
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
                $uri = $TssSession.ApiUrl, 'secrets', $currentId, 'extend-check-out' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $body = @{ data = @{ } }
                switch ($tssParams.Keys) {
                    'MinutesToAdd' {
                        $body.data.Add('minutesToAdd', $MinutesToAdd)
                    }
                    'Notes' {
                        $body.data.Add('notes', $Notes)
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssSecretExtendCheckout request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.ExtendCheckout](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ExtendCheckout]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
