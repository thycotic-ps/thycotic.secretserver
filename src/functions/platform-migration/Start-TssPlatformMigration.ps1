function Start-TssPlatformMigration {
    <#
    .SYNOPSIS
    Start a migration of users and groups to the Delinea Platform

    .DESCRIPTION
    Starts a Delinea Platform data migration run for the given Secret Server users and groups. The run continues in the background.
    Follow it with Get-TssPlatformMigrationProgress and review it with Search-TssPlatformMigration and Search-TssPlatformMigrationLog.
    Migration creates or updates identities on the Platform tenant and changes how the migrated users sign in. It cannot be undone from Secret Server.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Name of the migration run

    .PARAMETER UserId
    Secret Server user IDs to migrate

    .PARAMETER GroupId
    Secret Server group IDs to migrate

    .PARAMETER MigrateUserTotpSettings
    Also migrate the TOTP (authenticator) settings of each user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssPlatformMigration -TssSession $session -Name 'Pilot users' -UserId 15, 16 -MigrateUserTotpSettings

    Starts a migration of users 15 and 16 with their TOTP settings, after confirmation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $groups = Search-TssPlatformMigrationGroup -TssSession $session -MigrationState NotMigrated
    Start-TssPlatformMigration -TssSession $session -Name 'Remaining groups' -GroupId $groups.GroupId -WhatIf

    Shows the request that would start a migration of every group not yet migrated

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Start-TssPlatformMigration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Start-TssPlatformMigration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False (the success flag of the response).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('MigrationName')]
        [string]
        $Name,

        [int[]]
        $UserId,

        [int[]]
        $GroupId,

        [switch]
        $MigrateUserTotpSettings
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'migrate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    migrationName = $Name
                    userIds       = @()
                    groupIds      = @()
                }
            }
            switch ($tssParams.Keys) {
                'UserId' {
                    $body.data.userIds = $UserId
                }
                'GroupId' {
                    $body.data.groupIds = $GroupId
                }
                'MigrateUserTotpSettings' {
                    $body.data.Add('migrateUserTOTPSettings', [boolean]$MigrateUserTotpSettings)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Platform migration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssPlatformMigration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
