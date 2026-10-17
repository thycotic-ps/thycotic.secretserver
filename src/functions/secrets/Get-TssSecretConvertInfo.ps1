function Get-TssSecretConvertInfo {
    <#
    .SYNOPSIS
    Get template conversion details for secrets

    .DESCRIPTION
    Returns the source template fields of the given secrets and the fields of the destination template, to plan the field mapping before converting the secrets to another secret template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret IDs to convert

    .PARAMETER DestinationTemplateId
    Secret template ID to convert to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretConvertInfo -TssSession $session -SecretId 42, 43 -DestinationTemplateId 6003

    Returns the source and destination fields for converting secrets 42 and 43 to template 6003

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretConvertInfo

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretConvertInfo.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.ConvertInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretIds')]
        [int[]]
        $SecretId,

        [Parameter(Mandatory)]
        [int]
        $DestinationTemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', 'get-convert-info' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'SecretId' {
                    $body.data.Add('secretIds', $SecretId)
                }
                'DestinationTemplateId' {
                    $body.data.Add('destinationTemplateId', $DestinationTemplateId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretConvertInfo request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.ConvertInfo](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ConvertInfo]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
