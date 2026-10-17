function Set-TssPlatformUsersToMigrate {
    <#
    .SYNOPSIS
    Mark Secret Server users to migrate to the Platform

    .DESCRIPTION
    Mark Secret Server users to migrate, or not to migrate, to the Delinea Platform in the next Platform migration. Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER UserId
    Secret Server user Ids to mark

    .PARAMETER Migrate
    True to migrate the users, False to leave them out of the migration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformUsersToMigrate -TssSession $session -UserId 4, 7 -Migrate $true

    Mark users 4 and 7 to migrate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformUsersToMigrate -TssSession $session -UserId 7 -Migrate $false

    Exclude user 7 from the migration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformUsersToMigrate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformUsersToMigrate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PlatformMigration.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $UserId,

        [Parameter(Mandatory)]
        [bool]
        $Migrate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'set-users-to-migrate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    userIds          = @($UserId)
                    setUserAsMigrate = $Migrate
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Users $($UserId -join ', ')", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformUsersToMigrate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PlatformMigration.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
