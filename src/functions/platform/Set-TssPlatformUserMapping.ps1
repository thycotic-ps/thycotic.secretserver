function Set-TssPlatformUserMapping {
    <#
    .SYNOPSIS
    Map a Delinea Platform user to a Secret Server user

    .DESCRIPTION
    Map a Delinea Platform user to an existing Secret Server user.
    DirectoryServiceName Delinea with ExternalUserSource ThycoticOne maps through Thycotic One, EntraId maps through the Entra ID tenant of the Platform; anything else maps through the Platform login URL.
    Returns Success and a Message.
    Changing the Platform configuration, unified mode or Platform user mappings can cause loss of access to the Delinea Platform.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER PlatformUserId
    Platform user Id (GUID)

    .PARAMETER DirectoryServiceName
    Directory service name of the Platform user, for example Delinea or EntraId

    .PARAMETER ExternalUserSource
    Source of the external user: None, ThycoticOne, Azure or Platform

    .PARAMETER UserId
    Secret Server user Id to map the Platform user to

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $platformUser = Search-TssPlatformUser -TssSession $session -SearchText 'jdoe'
    Set-TssPlatformUserMapping -TssSession $session -PlatformUserId $platformUser.Uuid -UserId 4 -ExternalUserSource Platform

    Map the Platform user jdoe to Secret Server user 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Set-TssPlatformUserMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Set-TssPlatformUserMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Platform.UserMappingResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $PlatformUserId,

        [string]
        $DirectoryServiceName,

        [ValidateSet('None', 'ThycoticOne', 'Azure', 'Platform')]
        [string]
        $ExternalUserSource,

        [Parameter(Mandatory)]
        [int]
        $UserId,

        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'user', $PlatformUserId, 'map' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'DirectoryServiceName' {
                    $body.Add('directoryServiceName', $DirectoryServiceName)
                }
                'ExternalUserSource' {
                    $body.Add('externalUserSource', $ExternalUserSource)
                }
                'UserId' {
                    $body.Add('userId', $UserId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if (Confirm-TssDangerousOperation $PSCmdlet PlatformAccess "Platform user mapping: $PlatformUserId" "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformUserMapping request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Platform.UserMappingResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.UserMappingResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
