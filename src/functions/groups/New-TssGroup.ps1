function New-TssGroup {
    <#
    .SYNOPSIS
    Create a new Group

    .DESCRIPTION
    Create a new Group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssGroup -TssSession $session -GroupName 'Local Admin Group' -Enabled

    Creates a local Secret Server group named, Local Admin Group, enabling it upon creation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/New-TssGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Groups.Group')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Name of the Group
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $GroupName,

        #  Create the group as Active
        [Parameter(Mandatory,ValueFromPipeline)]
        [switch]
        $Enabled,

        # Directory Services Domain ID
        [int]
        $DomainId,

        # Active Directory Object GUID
        [string]
        $AdGuid,

        # Synchronize Group with Directory Services
        [switch]
        $Synchronized,

        # Directory Services Sync will only pull members for Domain Groups that have this set to true
        [switch]
        $SynchronizeNow
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'groups' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newGroupBody = [ordered]@{}
            switch ($tssNewParams.Keys) {
                'GroupName' { $newGroupBody.Add('name',$GroupName) }
                'Enabled' { $newGroupBody.Add('enabled',[boolean]$Enabled) }
                'DomainId' { $newGroupBody.Add('domainId',$DomainId) }
                'AdGuid' { $newGroupBody.Add('adGuid',$AdGuid) }
                'Synchronized' { $newGroupBody.Add('synchronized',[boolean]$Synchronized) }
                'SynchronizeNow' { $newGroupBody.Add('synchronizeNow', [boolean]$SynchronizeNow) }
            }
            $invokeParams.Body = ($newGroupBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newGroupBody"
            if (-not $PSCmdlet.ShouldProcess("", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating group [$Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                Get-TssGroup -TssSession $TssSession -Id $restResponse.Id
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}