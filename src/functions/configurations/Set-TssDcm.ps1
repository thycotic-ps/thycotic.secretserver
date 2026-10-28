function Set-TssDcm {
    <#
    .SYNOPSIS
    Set the Delinea Credential Manager configuration

    .DESCRIPTION
    Updates the Delinea Credential Manager (browser extension) configuration for business users or unrestricted users and returns the updated configuration.
    Secret Server applies -Type BusinessUser to the business user configuration only for a session authenticated through Delinea Platform; with any other session it updates the unrestricted user configuration instead.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Autofill:$false turns autofill off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Autofill
    Fill matching login forms automatically

    .PARAMETER AutoSubmit
    Submit the login form after filling it

    .PARAMETER CustomTemplateIds
    Secret template ids the extension offers when -TemplateConfiguration is Custom

    .PARAMETER InlinePopup
    Use the inline popup

    .PARAMETER PromptToSave
    Offer to save a new secret after a login

    .PARAMETER PromptToUpdate
    Offer to update the secret after a change

    .PARAMETER TemplateConfiguration
    Secret templates the extension offers: Default, All, or Custom (the -CustomTemplateIds list)

    .PARAMETER Type
    Configuration to update: BusinessUser or UnrestrictedUser. BusinessUser needs a session authenticated through Delinea Platform; with any other session Secret Server updates the unrestricted user configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDcm -TssSession $session -Type UnrestrictedUser -Autofill -AutoSubmit:$false

    Unrestricted users get autofill without automatic form submit

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDcm -TssSession $session -Type UnrestrictedUser -TemplateConfiguration Custom -CustomTemplateIds 6001, 6003

    Unrestricted users are offered only secret templates 6001 and 6003

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssDcm

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssDcm.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.Dcm')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Autofill,

        [switch]
        $AutoSubmit,

        [int[]]
        $CustomTemplateIds,

        [switch]
        $InlinePopup,

        [switch]
        $PromptToSave,

        [switch]
        $PromptToUpdate,

        [ValidateSet('Default', 'All', 'Custom')]
        [string]
        $TemplateConfiguration,

        [Parameter(Mandatory)]
        [ValidateSet('BusinessUser', 'UnrestrictedUser')]
        [string]
        $Type
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'dcm' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Autofill' {
                    $body.data.Add('autofill', @{ dirty = $true; value = [boolean]$Autofill })
                }
                'AutoSubmit' {
                    $body.data.Add('autoSubmit', @{ dirty = $true; value = [boolean]$AutoSubmit })
                }
                'CustomTemplateIds' {
                    $body.data.Add('customTemplateIds', @{ dirty = $true; value = $CustomTemplateIds })
                }
                'InlinePopup' {
                    $body.data.Add('inlinePopup', @{ dirty = $true; value = [boolean]$InlinePopup })
                }
                'PromptToSave' {
                    $body.data.Add('promptToSave', @{ dirty = $true; value = [boolean]$PromptToSave })
                }
                'PromptToUpdate' {
                    $body.data.Add('promptToUpdate', @{ dirty = $true; value = [boolean]$PromptToUpdate })
                }
                'TemplateConfiguration' {
                    $body.data.Add('templateConfiguration', @{ dirty = $true; value = $TemplateConfiguration })
                }
                'Type' {
                    $body.data.Add('type', @{ BusinessUser = 1; UnrestrictedUser = 2 }[$Type])
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dcm", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDcm request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.Dcm](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.Dcm]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
