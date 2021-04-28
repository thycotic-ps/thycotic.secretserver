function New-SecretTemplate {
    <#
    .SYNOPSIS
    Create a new Secret Template

    .DESCRIPTION
    Create a new Secret Template

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    $copyTemplate = Get-TssSecretTemplate -TssSession $session -Id 6042
    $copyTemplate.Name = 'Test Template - copy of 6042'
    New-TssSecretTemplate -TssSession $session -Template $copyTemplate

    Gets the Secret Template 6042, changing the name of the Template and then creating it

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    $fields = @()
    $fields += New-TssSecretTemplateField -FieldName 'Field 1 Username' -Searchable
    $fields += New-TssSecretTemplateField -FieldName 'Field 2 Password' -Type Password
    $fields += New-TssSecretTemplateField -FieldName 'Field 3 URL' -Type Url -Searchable
    New-TssSecretTemplate -TssSession $session -TemplateName 'Test Template 42' -TemplateField $fields

    Creates a new template named "Test Template 42" with 3 fields

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-SecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecretTemplate')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Template Stub object
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'newcopy')]
        [Alias('TemplateStub')]
        [TssSecretTemplate]
        $Template,

        # Template Name
        [Parameter(Mandatory, ParameterSetName = 'new')]
        [string]
        $TemplateName,

        # Fields, use New-TssSecretTemplateField to build this object
        [Parameter(Mandatory, ParameterSetName = 'new')]
        [Alias('Fields')]
        [TssSecretTemplateField[]]
        $TemplateField
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession

        $newcopyParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'newcopy'
        $templateParams = @()
        foreach ($t in $newcopyParamSet) {
            if ($tssNewParams.ContainsKey($t)) {
                $templateParams += $t
            }
        }

        $newParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'new'
        $fieldParams = @()
        foreach ($f in $newParamSet) {
            if ($tssNewParams.ContainsKey($f)) {
                $fieldParams += $f
            }
        }
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            if ($templateParams.Count -gt 0) {
                $TemplateName = $Template.Name
                $invokeParams.Body = ($Template | ConvertTo-Json -Depth 6)
            }
            if ($fieldParams.Count -gt 0) {
                $Template = [TssSecretTemplate]@{
                    Id = 0
                    Name = $TemplateName
                    PasswordTypeId = 0
                    Fields = $TemplateField
                }
                $invokeParams.Body = ($Template | ConvertTo-Json -Depth 6)
            }
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $($invokeParams.Body)"
            if (-not $PSCmdlet.ShouldProcess("Secret Template: $TemplateName", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating template [$TemplateName]"
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