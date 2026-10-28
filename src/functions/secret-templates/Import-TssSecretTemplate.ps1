function Import-TssSecretTemplate {
    <#
    .SYNOPSIS
    Import a secret template from XML

    .DESCRIPTION
    Creates a secret template from template XML, such as the ExportFileText of an XML export from Export-TssSecretTemplate.
    Returns the new template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateXml
    Secret template XML. Accepts the ExportFileText property of Export-TssSecretTemplate output from the pipeline

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $xml = Get-Content -Path ./template-6001.xml -Raw
    Import-TssSecretTemplate -TssSession $session -TemplateXml $xml

    Create a secret template from an exported XML file

    .EXAMPLE
    $source = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $target = New-TssSession -SecretServer https://beta -Credential $ssCred
    Export-TssSecretTemplate -TssSession $source -Id 6001 | Import-TssSecretTemplate -TssSession $target

    Copy template 6001 from one Secret Server to another

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Import-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Import-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExportFileText')]
        [string]
        $TemplateXml
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', 'import' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'TemplateXml' {
                    $body.data.Add('templateXml', $TemplateXml)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssSecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Template](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Template]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
