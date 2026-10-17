function Remove-TssPasswordDictionary {
    <#
    .SYNOPSIS
    Remove a custom password dictionary

    .DESCRIPTION
    Deletes a custom password dictionary and its items.
    A dictionary that a password requirement uses is not deleted: IsDeleted is false and InUsePasswordRequirements names the requirements that use it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password dictionary ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssPasswordDictionary -TssSession $session -Id 3

    Deletes password dictionary 3, unless a password requirement uses it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssPasswordDictionary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssPasswordDictionary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordDictionaryDelete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DictionaryId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'secret-templates', 'password-requirements', 'password-dictionaries', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Password dictionary: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssPasswordDictionary request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.SecretTemplates.PasswordDictionaryDelete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.PasswordDictionaryDelete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
