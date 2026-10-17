function New-TssPasswordType {
    <#
    .SYNOPSIS
    Create a custom password type

    .DESCRIPTION
    Creates a custom password type as a copy of an editable base password type (CanEdit True, for example Unix Account Custom (SSH); see Search-TssRpcPasswordType).
    Built-in password types that are not editable cannot be used as the base.
    When -BasePasswordTypeId is omitted, the server looks up the base from -TypeName and -PasswordTypeField.
    Returns the new password type, including its PasswordTypeId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Name of the new password type

    .PARAMETER BasePasswordTypeId
    ID of the editable password type to copy

    .PARAMETER TypeName
    Password changer type name used to look up the base when -BasePasswordTypeId is omitted, for example Thycotic.ihawu.Business.Federator.UnixSshCustomAccountFederator

    .PARAMETER PasswordTypeField
    Password type fields used to look up the base when -BasePasswordTypeId is omitted: objects or hashtables with name and scanItemFieldId

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssPasswordType -TssSession $session -BasePasswordTypeId 9 -Name 'Unix Account Custom (SSH) - Jump hosts'

    Create a password type that starts as a copy of password type 9

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcPasswordType -TssSession $session -Id 9 | New-TssPasswordType -TssSession $session -Name 'Unix Account Custom (SSH) - Jump hosts'

    Create the same copy from the output of Get-TssRpcPasswordType

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('PasswordTypeId')]
        [int]
        $BasePasswordTypeId,

        [string]
        $TypeName,

        [object[]]
        $PasswordTypeField
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-types' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ name = $Name }
            switch ($tssParams.Keys) {
                'BasePasswordTypeId' {
                    $body.Add('basePasswordTypeId', $BasePasswordTypeId)
                }
                'TypeName' {
                    $body.Add('typeName', $TypeName)
                }
                'PasswordTypeField' {
                    $body.Add('passwordTypeFields', @($PasswordTypeField | ForEach-Object { @{ name = $_.Name; scanItemFieldId = $_.ScanItemFieldId } }))
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password type: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPasswordType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    if ($restResponse.fields) {
                        $restResponse.fields = @(
                            $restResponse.fields | ForEach-Object {
                                [Thycotic.PowerShell.Rpc.PasswordTypeField](. $FilterTssResponse $_ ([Thycotic.PowerShell.Rpc.PasswordTypeField]))
                            }
                        )
                    }
                    [Thycotic.PowerShell.Rpc.PasswordType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.PasswordType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
