function Update-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Update a field on a Secret Template

    .DESCRIPTION
    Update a field on a Secret Template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $template = Get-TssSecret -TssSession $session -TemplateId 6025
    $pwdField = $template.GetField('password')
    $pwdField.IsRequired = $true
    Update-TssSecretTemplateField -TssSession $session -TemplateId 6026 -Field $pwdField

    Gets current Password field on Template 6025 and updates IsRequired to be true

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplateField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.SecretTemplates.Field')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Template ID
        [Parameter(Mandatory, Position = 1)]
        [int]
        $TemplateId,

        # Secret Template Field (see example)
        [Thycotic.PowerShell.SecretTemplates.Field]
        $Field
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-templates', $TemplateId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $invokeParams.Body = $Field | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("Secret Template ID: $TemplateId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating Secret Template [$TemplateId] field"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Field]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}