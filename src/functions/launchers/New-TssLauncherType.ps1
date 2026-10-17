function New-TssLauncherType {
    <#
    .SYNOPSIS
    Create a custom launcher type

    .DESCRIPTION
    Create a custom (process) launcher type. Only the parameters you pass are sent; omitted switches are created as false, so omit -Active to create the launcher type inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the launcher type active

    .PARAMETER AdditionalProcessesToRecord
    The additional process to record if record multiple windows is set to true

    .PARAMETER AdditionalPromptField
    Prompt the user for additional input at launch

    .PARAMETER AdditionalPromptFieldName
    Label of the additional prompt

    .PARAMETER Application
    Application identifier of the launcher type

    .PARAMETER BatchFileId
    The batch file id

    .PARAMETER CharactersToEscape
    Denotes a group of characters to escape

    .PARAMETER ChildLauncherId
    The ID of the child launcher associated to this launcher

    .PARAMETER EscapeCharacter
    Denotes an escape character

    .PARAMETER LaunchAsSecretCredentials
    Determines whether to launch as secret credentials

    .PARAMETER Name
    Name of the launcher type

    .PARAMETER LoadUserProfile
    Determines whether to load user profile if launch as secret credentials is set to true

    .PARAMETER MacProcessArguments
    The updated mac process arguments

    .PARAMETER MacProcessName
    The updated mac process name

    .PARAMETER MstscLauncherOption
    The mstsc launcher option

    .PARAMETER OverrideDisallowAdditionalParametersInQuotes
    Determines whether to wrap parameters in quotes

    .PARAMETER PreserveSSHClientProcess
    Determines whether to preserve ssh client

    .PARAMETER ProcessArguments
    Command-line arguments template for the process

    .PARAMETER ProcessName
    Process to launch, for example cmd.exe or putty.exe

    .PARAMETER RdsCredentialsSecretId
    The rds credentials secret ID

    .PARAMETER RdsServerHostname
    The rds server hostname

    .PARAMETER RdsServerPort
    The rds server port

    .PARAMETER RecordKeystrokes
    Determines whether to record keystrokes

    .PARAMETER RecordMultipleWindows
    Determines whether to record multiple windows

    .PARAMETER RecordOnlyKeystrokes
    Determines whether to record only keystrokes and no video. This option will override RecordKeystrokes if set to true

    .PARAMETER RecordSSHTunnel
    Determines whether to record ssh tunnel

    .PARAMETER RunType
    Run type id of the launcher (1 = process). 5 = PowerShell launcher, which needs -ScriptId

    .PARAMETER ScriptId
    The tbScript.ScriptId of the customer-authored PowerShell script for the PowerShell Launcher type. Required when RunType is PowerShellLauncherType (5). The PowerShell engine choice is owned by the referenced script

    .PARAMETER ShellScriptId
    The updated shell script id

    .PARAMETER UseSFTPTunnel
    Determines whether to use sftp tunnel to allow multiple data connections

    .PARAMETER UseShellExecute
    Determines whether to use shell execute

    .PARAMETER UseSSHTunnel
    Determines whether to use ssh tunnel

    .PARAMETER UseTemporaryFile
    PowerShell Launcher invocation mode: false = inline -EncodedCommand (default); true = -File (opt-in)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssLauncherType -TssSession $session -Name 'Admin CMD' -ProcessName cmd.exe -ProcessArguments '/k echo $MACHINE' -Application 1 -RunType 1 -Active

    Create an active custom launcher type that opens cmd.exe

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/New-TssLauncherType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/New-TssLauncherType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Launchers.LauncherType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [string]
        $AdditionalProcessesToRecord,

        [switch]
        $AdditionalPromptField,

        [string]
        $AdditionalPromptFieldName,

        [string]
        $Application,

        [int]
        $BatchFileId,

        [string]
        $CharactersToEscape,

        [int]
        $ChildLauncherId,

        [string]
        $EscapeCharacter,

        [switch]
        $LaunchAsSecretCredentials,

        [Parameter(Mandatory)]
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
        $RunType,

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
            $uri = $TssSession.ApiUrl, 'launchers', 'types' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'AdditionalProcessesToRecord' {
                    $body.data.Add('additionalProcessesToRecord', $AdditionalProcessesToRecord)
                }
                'AdditionalPromptField' {
                    $body.data.Add('additionalPromptField', [boolean]$AdditionalPromptField)
                }
                'AdditionalPromptFieldName' {
                    $body.data.Add('additionalPromptFieldName', $AdditionalPromptFieldName)
                }
                'Application' {
                    $body.data.Add('application', $Application)
                }
                'BatchFileId' {
                    $body.data.Add('batchFileId', $BatchFileId)
                }
                'CharactersToEscape' {
                    $body.data.Add('charactersToEscape', $CharactersToEscape)
                }
                'ChildLauncherId' {
                    $body.data.Add('childLauncherId', $ChildLauncherId)
                }
                'EscapeCharacter' {
                    $body.data.Add('escapeCharacter', $EscapeCharacter)
                }
                'LaunchAsSecretCredentials' {
                    $body.data.Add('launchAsSecretCredentials', [boolean]$LaunchAsSecretCredentials)
                }
                'Name' {
                    $body.data.Add('launcherTypeName', $Name)
                }
                'LoadUserProfile' {
                    $body.data.Add('loadUserProfile', [boolean]$LoadUserProfile)
                }
                'MacProcessArguments' {
                    $body.data.Add('macProcessArguments', $MacProcessArguments)
                }
                'MacProcessName' {
                    $body.data.Add('macProcessName', $MacProcessName)
                }
                'MstscLauncherOption' {
                    $body.data.Add('mstscLauncherOption', [boolean]$MstscLauncherOption)
                }
                'OverrideDisallowAdditionalParametersInQuotes' {
                    $body.data.Add('overrideDisallowAdditionalParametersInQuotes', [boolean]$OverrideDisallowAdditionalParametersInQuotes)
                }
                'PreserveSSHClientProcess' {
                    $body.data.Add('preserveSSHClientProcess', [boolean]$PreserveSSHClientProcess)
                }
                'ProcessArguments' {
                    $body.data.Add('processArguments', $ProcessArguments)
                }
                'ProcessName' {
                    $body.data.Add('processName', $ProcessName)
                }
                'RdsCredentialsSecretId' {
                    $body.data.Add('rdsCredentialsSecretId', $RdsCredentialsSecretId)
                }
                'RdsServerHostname' {
                    $body.data.Add('rdsServerHostname', $RdsServerHostname)
                }
                'RdsServerPort' {
                    $body.data.Add('rdsServerPort', $RdsServerPort)
                }
                'RecordKeystrokes' {
                    $body.data.Add('recordKeystrokes', [boolean]$RecordKeystrokes)
                }
                'RecordMultipleWindows' {
                    $body.data.Add('recordMultipleWindows', [boolean]$RecordMultipleWindows)
                }
                'RecordOnlyKeystrokes' {
                    $body.data.Add('recordOnlyKeystrokes', [boolean]$RecordOnlyKeystrokes)
                }
                'RecordSSHTunnel' {
                    $body.data.Add('recordSSHTunnel', [boolean]$RecordSSHTunnel)
                }
                'RunType' {
                    $body.data.Add('runType', $RunType)
                }
                'ScriptId' {
                    $body.data.Add('scriptId', $ScriptId)
                }
                'ShellScriptId' {
                    $body.data.Add('shellScriptId', $ShellScriptId)
                }
                'UseSFTPTunnel' {
                    $body.data.Add('useSFTPTunnel', [boolean]$UseSFTPTunnel)
                }
                'UseShellExecute' {
                    $body.data.Add('useShellExecute', [boolean]$UseShellExecute)
                }
                'UseSSHTunnel' {
                    $body.data.Add('useSSHTunnel', [boolean]$UseSSHTunnel)
                }
                'UseTemporaryFile' {
                    $body.data.Add('useTemporaryFile', [boolean]$UseTemporaryFile)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher type", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssLauncherType request'
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
