function New-SecretTemplate {
    <#
    .SYNOPSIS
    Create a new Secret Template

    .DESCRIPTION
    Create a new Secret Template

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/New-SecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecretTemplate')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Template Stub object
        [Parameter(Mandatory,ValueFromPipeline,Position = 1)]
        [Alias('TemplateStub')]
        [TssSecretTemplate]
        $Template
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $invokeParams.Body = ($Template | ConvertTo-Json -Depth 6)
            $templateName = $Template.Name
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $($invokeParams.Body)"
            if (-not $PSCmdlet.ShouldProcess("Secret Template: $templateName", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating template [$templateName]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssSecretTemplate]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}