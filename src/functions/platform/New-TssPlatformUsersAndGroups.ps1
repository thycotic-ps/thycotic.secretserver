function New-TssPlatformUsersAndGroups {
    <#
    .SYNOPSIS
    Create Secret Server users and groups for Platform identities

    .DESCRIPTION
    Create local Secret Server users and groups linked to Delinea Platform users and groups. Pipe in the output of Search-TssPlatformUsersGroups, or pass one identity with the parameters; every identity from the pipeline is sent in one request, and an empty pipeline sends nothing.
    Returns the outcome per identity (Data: Type, PlatformUuid, UserId or GroupId, Error) and an Error for the whole request, for example when Platform integration is not enabled.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER PlatformUuid
    Platform user or group Id (GUID); binds PlatformEntityUuid from Search-TssPlatformUsersGroups

    .PARAMETER Name
    User name or group name for the new Secret Server user or group

    .PARAMETER DisplayName
    Display name for the new Secret Server user or group

    .PARAMETER EntityType
    User or Group; DirectoryGroup and XpmGroup, as Search-TssPlatformUsersGroups returns them, are created as groups

    .PARAMETER ServiceUser
    Create the user as a Platform service user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformUsersGroups -TssSession $session -SearchText 'Eng' -EntityType Groups -ExcludeLinkedLocalEntities | New-TssPlatformUsersAndGroups -TssSession $session

    Create Secret Server groups for the Platform groups starting with Eng that are not linked yet

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssPlatformUsersAndGroups -TssSession $session -PlatformUuid 0f8c2b9e-1d43-4b7a-9c55-6a0e2f1d7b31 -Name jdoe -DisplayName 'Jane Doe' -EntityType User

    Create a Secret Server user for one Platform user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformUsersAndGroups

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformUsersAndGroups.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Platform.UsersAndGroupsResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PlatformEntityUuid')]
        [string]
        $PlatformUuid,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EntityName')]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $DisplayName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateSet('User', 'Group', 'DirectoryGroup', 'XpmGroup')]
        [string]
        $EntityType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $ServiceUser
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $entities = [System.Collections.Generic.List[hashtable]]::new()
    }
    process {
        $entities.Add(@{
                type         = if ($EntityType -eq 'User') { 0 } else { 1 }
                platformUuid = $PlatformUuid
                entityName   = $Name
                displayName  = $DisplayName
                serviceUser  = [boolean]$ServiceUser
            })
    }
    end {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($entities.Count -eq 0) {
            Write-Verbose 'No Platform identities received, nothing to create'
        } elseif ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'create-users-and-groups' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = $entities.ToArray() }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("$($entities.Count) Platform identities", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPlatformUsersAndGroups request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Platform.UsersAndGroupsResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.UsersAndGroupsResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}