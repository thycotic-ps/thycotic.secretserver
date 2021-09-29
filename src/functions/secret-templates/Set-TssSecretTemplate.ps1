function Set-TssSecretTemplate {
    <#
    .SYNOPSIS
    Set Secret Template active or inactive

    .DESCRIPTION
    Set Secret Template active or inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplate -TssSession $session -Id 6093 -Active:$false

    Sets Secret Template 6093 Active to false or90

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Template ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("TemplateId")]
        [int[]]
        $Id,

        # Set template active
        [Parameter(Mandatory)]
        [switch]
        $Active
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($template in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $template -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $setBody = @{
                    data = @{
                        active = @{
                            dirty = $true
                            value = [boolean]$Active
                        }
                    }
                }
                $invokeParams.Body = $setBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("Secret Template ID: $template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting Secret Template [$template]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.success) {
                        Write-Verbose "Secret Template [$template] set to $Active"
                    } else {
                        Write-Warning "Secret Template [$template] not updated"
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}