function Add-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Add a new field to a Secret Template

    .DESCRIPTION
    Add a new field to a Secret Template

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
    $newField = New-TssSecretTemplateField -FieldName 'Additional Field' -Searchable
    Add-TssSecretTemplateField -TssSession $session -Id 6042 -Field $newField
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields

    Output the current fields for Secret Template 6042, create a new field named "Additional Field" that is searchable and add to the Secret Template 6042

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Add-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Add-TssSecretTemplateField

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Template Stub object
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('TemplateId')]
        [int[]]
        $Id,

        # Fields, use New-TssSecretTemplateField to build this object
        [Parameter(Mandatory, Position = 2)]
        [Thycotic.PowerShell.SecretTemplates.Field]
        $Field
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($template in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $template -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $invokeParams.Body = ($Field | ConvertTo-Json)

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $($invokeParams.Body)"
                if (-not $PSCmdlet.ShouldProcess("Secret Template ID: $template", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue adding field to template [$template]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse -and ($restResponse.name -eq $field.Name)) {
                    Write-Verbose "Successfully added field to Secret Template [$template]"
                } else {
                    Write-Warning "Unable to add field to Secret Template [$template]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}