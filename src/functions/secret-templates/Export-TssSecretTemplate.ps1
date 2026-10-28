function Export-TssSecretTemplate {
    <#
    .SYNOPSIS
    Export a secret template

    .DESCRIPTION
    Exports a secret template definition.
    The ExportFileText property holds the template as XML (the default) or JSON, and FileName holds a suggested file name.
    Pass an XML export to Import-TssSecretTemplate to create the template on another Secret Server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID to export

    .PARAMETER Format
    Export format: xml (default) or json

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $export = Export-TssSecretTemplate -TssSession $session -Id 6001
    Set-Content -Path ./template-6001.xml -Value $export.ExportFileText

    Export template 6001 as XML and save it to a file

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssSecretTemplate -TssSession $session -Id 6001 -Format json

    Export template 6001 as JSON

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Export-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Export-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Export')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        [ValidateSet('xml', 'json')]
        [string]
        $Format
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
                $uri = $TssSession.ApiUrl, 'secret-templates', $currentId, 'export' -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'Format' {
                        $queryParams += "format=$([uri]::EscapeDataString($Format))"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Export-TssSecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Export](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Export]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
