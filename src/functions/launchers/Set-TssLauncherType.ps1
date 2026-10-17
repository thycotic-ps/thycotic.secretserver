function Set-TssLauncherType {
    <#
    .SYNOPSIS
    Update a launcher type

    .DESCRIPTION
    Update the properties of a launcher type. Only the parameters you pass are changed. Custom launcher types accept every field; built-in launcher types reject some.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher type Id

    .PARAMETER Active
    Set the launcher type active (-Active) or inactive (-Active:$false)

    .PARAMETER AdditionalProcessesToRecord
    The additional process to record if record multiple windows is set to true

    .PARAMETER AdditionalPromptField
    Determines whether to include additional prompts for the launcher

    .PARAMETER AdditionalPromptFieldName
    The updated name of the additional prompt

    .PARAMETER BatchFileId
    The updated batch file id

    .PARAMETER CanUseSSHKey
    Determines whether you can use ssh key

    .PARAMETER CharactersToEscape
    Denotes a group of characters to escape

    .PARAMETER ChildLauncherId
    The updated ID of the child launcher associated to this launcher

    .PARAMETER CustomLauncherId
    The custom launcher id

    .PARAMETER EscapeCharacter
    Denotes an escape character

    .PARAMETER LaunchAsSecretCredentials
    Determines whether to launch as secret credentials

    .PARAMETER Name
    New name of the launcher type

    .PARAMETER LoadUserProfile
    Determines whether to load user profile if launch as secret credentials is set to true

    .PARAMETER MacProcessArguments
    The updated mac process arguments

    .PARAMETER MacProcessName
    The updated mac process name

    .PARAMETER MstscLauncherOption
    The updated Mstsc launcher option

    .PARAMETER OverrideDisallowAdditionalParametersInQuotes
    Determines whether to wrap parameters in quotes

    .PARAMETER PreserveSSHClientProcess
    Determines whether to preserve ssh client

    .PARAMETER ProcessArguments
    Command-line arguments template for the process

    .PARAMETER ProcessName
    Process to launch (custom launchers)

    .PARAMETER RdsCredentialsSecretId
    The updated rds credentials secret ID

    .PARAMETER RdsServerHostname
    The updated rds server hostname

    .PARAMETER RdsServerPort
    The updated rds server port

    .PARAMETER RecordKeystrokes
    Determines whether to record keystrokes

    .PARAMETER RecordMultipleWindows
    Determines whether to record multiple windows

    .PARAMETER RecordOnlyKeystrokes
    Determines whether to record only keystrokes and no video. This option will override RecordKeystrokes if set to true

    .PARAMETER RecordSSHTunnel
    Determines whether to record ssh tunnel

    .PARAMETER ScriptId
    The updated tbScript.ScriptId of the customer-authored PowerShell script for the PowerShell Launcher type. The PowerShell engine choice is owned by the referenced script

    .PARAMETER ShellScriptId
    The updated shell script id

    .PARAMETER UseSFTPTunnel
    Determines whether to use sftp tunnel to allow multiple data connections

    .PARAMETER UseShellExecute
    Determines whether to use shell execute

    .PARAMETER UseSSHTunnel
    Determines whether to use ssh tunnel

    .PARAMETER UseTemporaryFile
    The updated PowerShell Launcher invocation mode: false = inline -EncodedCommand; true = -File

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssLauncherType -TssSession $session -Id 9 -Active:$false

    Deactivate launcher type 9

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssLauncherType -TssSession $session -Id 9 -Name 'Admin CMD v2' -ProcessArguments '/k whoami'

    Rename launcher type 9 and change its arguments

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Launchers.LauncherType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LauncherTypeId')]
        [int]
        $Id,

        [switch]
        $Active,

        [string]
        $AdditionalProcessesToRecord,

        [switch]
        $AdditionalPromptField,

        [string]
        $AdditionalPromptFieldName,

        [int]
        $BatchFileId,

        [switch]
        $CanUseSSHKey,

        [string]
        $CharactersToEscape,

        [int]
        $ChildLauncherId,

        [int]
        $CustomLauncherId,

        [string]
        $EscapeCharacter,

        [switch]
        $LaunchAsSecretCredentials,

        [Alias('LauncherTypeName')]
        [string]
        $Name,

        [switch]
        $LoadUserProfile,

        [string]
        $MacProcessArguments,

        [string]
        $MacProcessName,

        [switch]
        $MstscLauncherOption,

        [switch]
        $OverrideDisallowAdditionalParametersInQuotes,

        [switch]
        $PreserveSSHClientProcess,

        [string]
        $ProcessArguments,

        [string]
        $ProcessName,

        [int]
        $RdsCredentialsSecretId,

        [string]
        $RdsServerHostname,

        [int]
        $RdsServerPort,

        [switch]
        $RecordKeystrokes,

        [switch]
        $RecordMultipleWindows,

        [switch]
        $RecordOnlyKeystrokes,

        [switch]
        $RecordSSHTunnel,

        [int]
        $ScriptId,

        [int]
        $ShellScriptId,

        [switch]
        $UseSFTPTunnel,

        [switch]
        $UseShellExecute,

        [switch]
        $UseSSHTunnel,

        [switch]
        $UseTemporaryFile
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'launchers', 'types', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'AdditionalProcessesToRecord' {
                    $body.data.Add('additionalProcessesToRecord', @{ dirty = $true; value = $AdditionalProcessesToRecord })
                }
                'AdditionalPromptField' {
                    $body.data.Add('additionalPromptField', @{ dirty = $true; value = [boolean]$AdditionalPromptField })
                }
                'AdditionalPromptFieldName' {
                    $body.data.Add('additionalPromptFieldName', @{ dirty = $true; value = $AdditionalPromptFieldName })
                }
                'BatchFileId' {
                    $body.data.Add('batchFileId', @{ dirty = $true; value = $BatchFileId })
                }
                'CanUseSSHKey' {
                    $body.data.Add('canUseSSHKey', @{ dirty = $true; value = [boolean]$CanUseSSHKey })
                }
                'CharactersToEscape' {
                    $body.data.Add('charactersToEscape', @{ dirty = $true; value = $CharactersToEscape })
                }
                'ChildLauncherId' {
                    $body.data.Add('childLauncherId', @{ dirty = $true; value = $ChildLauncherId })
                }
                'CustomLauncherId' {
                    $body.data.Add('customLauncherId', @{ dirty = $true; value = $CustomLauncherId })
                }
                'EscapeCharacter' {
                    $body.data.Add('escapeCharacter', @{ dirty = $true; value = $EscapeCharacter })
                }
                'LaunchAsSecretCredentials' {
                    $body.data.Add('launchAsSecretCredentials', @{ dirty = $true; value = [boolean]$LaunchAsSecretCredentials })
                }
                'Name' {
                    $body.data.Add('launcherTypeName', @{ dirty = $true; value = $Name })
                }
                'LoadUserProfile' {
                    $body.data.Add('loadUserProfile', @{ dirty = $true; value = [boolean]$LoadUserProfile })
                }
                'MacProcessArguments' {
                    $body.data.Add('macProcessArguments', @{ dirty = $true; value = $MacProcessArguments })
                }
                'MacProcessName' {
                    $body.data.Add('macProcessName', @{ dirty = $true; value = $MacProcessName })
                }
                'MstscLauncherOption' {
                    $body.data.Add('mstscLauncherOption', @{ dirty = $true; value = [boolean]$MstscLauncherOption })
                }
                'OverrideDisallowAdditionalParametersInQuotes' {
                    $body.data.Add('overrideDisallowAdditionalParametersInQuotes', @{ dirty = $true; value = [boolean]$OverrideDisallowAdditionalParametersInQuotes })
                }
                'PreserveSSHClientProcess' {
                    $body.data.Add('preserveSSHClientProcess', @{ dirty = $true; value = [boolean]$PreserveSSHClientProcess })
                }
                'ProcessArguments' {
                    $body.data.Add('processArguments', @{ dirty = $true; value = $ProcessArguments })
                }
                'ProcessName' {
                    $body.data.Add('processName', @{ dirty = $true; value = $ProcessName })
                }
                'RdsCredentialsSecretId' {
                    $body.data.Add('rdsCredentialsSecretId', @{ dirty = $true; value = $RdsCredentialsSecretId })
                }
                'RdsServerHostname' {
                    $body.data.Add('rdsServerHostname', @{ dirty = $true; value = $RdsServerHostname })
                }
                'RdsServerPort' {
                    $body.data.Add('rdsServerPort', @{ dirty = $true; value = $RdsServerPort })
                }
                'RecordKeystrokes' {
                    $body.data.Add('recordKeystrokes', @{ dirty = $true; value = [boolean]$RecordKeystrokes })
                }
                'RecordMultipleWindows' {
                    $body.data.Add('recordMultipleWindows', @{ dirty = $true; value = [boolean]$RecordMultipleWindows })
                }
                'RecordOnlyKeystrokes' {
                    $body.data.Add('recordOnlyKeystrokes', @{ dirty = $true; value = [boolean]$RecordOnlyKeystrokes })
                }
                'RecordSSHTunnel' {
                    $body.data.Add('recordSSHTunnel', @{ dirty = $true; value = [boolean]$RecordSSHTunnel })
                }
                'ScriptId' {
                    $body.data.Add('scriptId', @{ dirty = $true; value = $ScriptId })
                }
                'ShellScriptId' {
                    $body.data.Add('shellScriptId', @{ dirty = $true; value = $ShellScriptId })
                }
                'UseSFTPTunnel' {
                    $body.data.Add('useSFTPTunnel', @{ dirty = $true; value = [boolean]$UseSFTPTunnel })
                }
                'UseShellExecute' {
                    $body.data.Add('useShellExecute', @{ dirty = $true; value = [boolean]$UseShellExecute })
                }
                'UseSSHTunnel' {
                    $body.data.Add('useSSHTunnel', @{ dirty = $true; value = [boolean]$UseSSHTunnel })
                }
                'UseTemporaryFile' {
                    $body.data.Add('useTemporaryFile', @{ dirty = $true; value = [boolean]$UseTemporaryFile })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher type: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssLauncherType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Launchers.LauncherType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Launchers.LauncherType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
