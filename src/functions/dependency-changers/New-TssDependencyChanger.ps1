function New-TssDependencyChanger {
    <#
    .SYNOPSIS
    Create a dependency changer

    .DESCRIPTION
    Creates a dependency changer. The server rejects an empty setting list; list the settings with Search-TssDependencyChangerSetting.
    There is no delete endpoint for dependency changers: set -Active to false with Set-TssDependencyChanger to retire one.
    The request body is not written to Verbose or ShouldProcess output because script slots can carry credentials.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Dependency changer name

    .PARAMETER Description
    Dependency changer description

    .PARAMETER DependencyTypeId
    Dependency type ID (see SecretDependencyTypeId on Search-TssDependencyChanger output)

    .PARAMETER ScanItemTemplateId
    Discovery scan template ID the changer applies to

    .PARAMETER Active
    Make the changer active

    .PARAMETER CreateDependencyTemplate
    Also create a matching dependency template

    .PARAMETER Setting
    Changer settings: objects or hashtables with settingName and value, for example @{ settingName = 'WaitBeforeSeconds'; value = '0' }. The Settings of Get-TssDependencyChanger output can be passed as they are

    .PARAMETER PasswordChangeScript
    Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

    .PARAMETER VerificationScript
    Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

    .PARAMETER ChangeSuccessScript
    Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

    .PARAMETER ChangeFailScript
    Hashtable with the script slot settings: scriptId (from Search-TssDependencyChangerScript), useTokens, username, password, key, passphrase, arguments, parameters (array of name, type, value) and odbcParameters (array of name, value)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDependencyChanger -TssSession $session -Name 'App Pool Changer' -DependencyTypeId 1 -ScanItemTemplateId 11 -Setting @{ settingName = 'WaitBeforeSeconds'; value = '5' } -Active

    Create an active Application Pool dependency changer that waits five seconds before it runs

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/New-TssDependencyChanger

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/New-TssDependencyChanger.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DependencyChangers.DependencyChanger')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretDependencyChangerName')]
        [string]
        $Name,

        [Alias('SecretDependencyChangerDescription')]
        [string]
        $Description,

        [Parameter(Mandatory)]
        [Alias('SecretDependencyTypeId')]
        [int]
        $DependencyTypeId,

        [Parameter(Mandatory)]
        [int]
        $ScanItemTemplateId,

        [switch]
        $Active,

        [switch]
        $CreateDependencyTemplate,

        [Parameter(Mandatory)]
        [object[]]
        $Setting,

        [object]
        $PasswordChangeScript,

        [object]
        $VerificationScript,

        [object]
        $ChangeSuccessScript,

        [object]
        $ChangeFailScript
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changer' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('secretDependencyChangerName', $Name)
                }
                'Description' {
                    $body.data.Add('secretDependencyChangerDescription', $Description)
                }
                'DependencyTypeId' {
                    $body.data.Add('secretDependencyTypeId', $DependencyTypeId)
                }
                'ScanItemTemplateId' {
                    $body.data.Add('scanItemTemplateId', $ScanItemTemplateId)
                }
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'CreateDependencyTemplate' {
                    $body.data.Add('createDependencyTemplate', [boolean]$CreateDependencyTemplate)
                }
                'Setting' {
                    $body.data.Add('settings', $Setting)
                }
                'PasswordChangeScript' {
                    $body.data.Add('passwordChangeScript', $PasswordChangeScript)
                }
                'VerificationScript' {
                    $body.data.Add('verificationScript', $VerificationScript)
                }
                'ChangeSuccessScript' {
                    $body.data.Add('changeSuccessScript', $ChangeSuccessScript)
                }
                'ChangeFailScript' {
                    $body.data.Add('changeFailScript', $ChangeFailScript)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dependency changer", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDependencyChanger request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DependencyChangers.DependencyChanger](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DependencyChangers.DependencyChanger]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
