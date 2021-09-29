function Add-TssDirectoryServiceGroup {
    <#
    .SYNOPSIS
    Add or link a Directory Service Group to synchronize

    .DESCRIPTION
    Add or link a Directory Service Group to synchronize

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssDirectoryServiceGroup -TssSession $session -DomainId 4  -DomainIdentifier 'd87ac1d5-8f28-4910-b08a-5128af003626' -Name 'Secret User Group 1'

    Add a domain group named "Secret User Group 1" to be synchronized with under Directory Services ID 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceGroup -TssSession $session -DomainId 4 -SearchText 'Secret*' | Add-TssDirectoryServiceGroup -TssSession $session -DomainId 4
    Search-TssGroup -TssSession $session -DomainId 4

    Add all Directory Groups found starign with "Secret" for Domain ID 4, then run a group search to show they are added

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Add-TssDirectoryServiceGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Add-TssDirectoryServiceGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Domain ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DomainId,

        # Group Name
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string]
        $GroupName,

        # Unique directory/domain identifier (e.g. AD GUID from Active Directory of that object)
        [Parameter(ValueFromPipelineByPropertyName)]
        [guid]
        $DomainIdentifier
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
            Get-TssInvocation $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
                Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
                $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $DomainId, 'group' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $addGroupBody = @{ data = @{} }
                switch ($tssParams.Keys) {
                    'GroupName' {$addGroupBody.data.Add('name',$GroupName)}
                    'DomainIdentifier' {$addGroupBody.data.Add('domainIdentifier',$DomainIdentifier)}
                }
                $invokeParams.Body = $addGroupBody | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue adding Group [$GroupName] to Domain [$DomainId]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        Write-Verbose "Group [$GroupName] successfully added to Domain [$DomainId]"
                    }
                }
            } else {
                Write-Warning 'No valid session found'
            }
        }
}