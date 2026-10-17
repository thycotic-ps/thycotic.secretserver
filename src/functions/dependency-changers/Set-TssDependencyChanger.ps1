function Set-TssDependencyChanger {
    <#
    .SYNOPSIS
    Update a dependency changer

    .DESCRIPTION
    Changes the given fields of a dependency changer; fields you do not pass stay as they are.
    Built-in changers, and changers used by a system dependency template, cannot be edited: the server returns HTTP 400.
    The request body is not written to Verbose or ShouldProcess output because script slots can carry credentials.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dependency changer ID

    .PARAMETER Name
    New name

    .PARAMETER Description
    New description

    .PARAMETER DependencyTypeId
    New dependency type ID

    .PARAMETER ScanItemTemplateId
    New discovery scan template ID

    .PARAMETER Active
    Make the changer active (-Active) or inactive (-Active:$false)

    .PARAMETER Setting
    Replacement settings: objects or hashtables with settingName and value

    .PARAMETER PasswordChangeScript
    Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = <value> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }. This slot cannot be removed: a script changer must keep a password change script, so a scriptId of $null returns HTTP 400 (passwordChangeScript is required) and the slot stays. The server applies the slot only when scriptId or arguments is dirty, then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

    .PARAMETER VerificationScript
    Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = <value> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }. The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

    .PARAMETER ChangeSuccessScript
    Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = <value> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }. The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

    .PARAMETER ChangeFailScript
    Hashtable in the server update shape for this script slot: each key (scriptId, useTokens, username, password, key, passphrase, arguments, parameters, odbcParameters) holds @{ dirty = $true; value = <value> }; the parameters value is an array of @{ name; type; value }, the odbcParameters value an array of @{ name; value }. The server applies the slot only when scriptId or arguments is dirty (a scriptId of $null removes the slot), then rebuilds its script arguments: a PowerShell script takes arguments (space separated; none = script defaults), an SSH or SQL script ignores arguments and takes parameters matched by name and type, and every parameter not sent goes back to its script default

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDependencyChanger -TssSession $session -Id 42 -Description 'Changer for the web farm'

    Change the description of dependency changer 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDependencyChanger -TssSession $session -Id 42 -Active:$false

    Retire dependency changer 42 (there is no delete endpoint)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Set-TssDependencyChanger

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Set-TssDependencyChanger.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DependencyChangers.DependencyChanger')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretDependencyChangerId')]
        [int]
        $Id,

        [Alias('SecretDependencyChangerName')]
        [string]
        $Name,

        [Alias('SecretDependencyChangerDescription')]
        [string]
        $Description,

        [Alias('SecretDependencyTypeId')]
        [int]
        $DependencyTypeId,

        [int]
        $ScanItemTemplateId,

        [switch]
        $Active,

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
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changer', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('secretDependencyChangerName', @{ dirty = $true; value = $Name })
                }
                'Description' {
                    $body.data.Add('secretDependencyChangerDescription', @{ dirty = $true; value = $Description })
                }
                'DependencyTypeId' {
                    $body.data.Add('secretDependencyTypeId', @{ dirty = $true; value = $DependencyTypeId })
                }
                'ScanItemTemplateId' {
                    $body.data.Add('scanItemTemplateId', @{ dirty = $true; value = $ScanItemTemplateId })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'Setting' {
                    $body.data.Add('settings', @{ dirty = $true; value = $Setting })
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
            if ($PSCmdlet.ShouldProcess("Dependency changer: $Id", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDependencyChanger request'
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
