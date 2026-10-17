function Export-TssBundle {
    <#
    .SYNOPSIS
    Export a discovery bundle

    .DESCRIPTION
    Exports the configuration bundle of a discovery source: the discovery source, its scanners, scan templates and discovery command sets, plus the password changers, scripts and secret templates of the given password types.
    The bundle is returned as JSON text in ExportedSecretSettingsFileText, with its FileName and FileType. Pipe that text to ConvertFrom-Json to read the bundle as an object.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID to export

    .PARAMETER PasswordTypeId
    Password type (password changer) IDs to include

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssBundle -TssSession $session -DiscoverySourceId 3 -PasswordTypeId 1, 2

    Exports the bundle of discovery source 3 with password types 1 and 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Export-TssBundle -TssSession $session -DiscoverySourceId 3).ExportedSecretSettingsFileText | Set-Content -Path ./bundle.json

    Exports the bundle of discovery source 3 and saves it as bundle.json

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bundle/Export-TssBundle

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bundle/Export-TssBundle.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Bundle.Settings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoverySourceId,

        [Alias('PasswordTypeIds')]
        [int[]]
        $PasswordTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'bundle', 'export' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', $DiscoverySourceId)
                }
                'PasswordTypeId' {
                    $body.data.Add('passwordTypeIds', $PasswordTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Export-TssBundle request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Bundle.Settings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Bundle.Settings]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
