function Move-TssDistributedEngineSiteSecret {
    <#
    .SYNOPSIS
    Move every secret on a Distributed Engine site to another site

    .DESCRIPTION
    Reassigns every secret that uses a site to another site.
    With -DisableSite also deactivates the source site and every engine on it.
    Returns the source site.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the site the secrets move off

    .PARAMETER DisableSite
    Also deactivate the source site and its engines

    .PARAMETER NewSiteId
    ID of the site the secrets move to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssDistributedEngineSiteSecret -TssSession $session -Id 3 -NewSiteId 4

    Moves every secret on site 3 to site 4 after confirmation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssDistributedEngineSiteSecret -TssSession $session -Id 3 -NewSiteId 4 -DisableSite -Confirm:$false

    Moves every secret on site 3 to site 4 and deactivates site 3 and its engines without prompting

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngineSiteSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngineSiteSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Moves every secret on the site in one call; moving them back also moves the secrets that were already on the other site, so it asks for confirmation by default.
    A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint under a misspelled path (winauthwebsesrvices), so the request fails.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.DistributedEngines.Site')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SiteId')]
        [int]
        $Id,

        [switch]
        $DisableSite,

        [Parameter(Mandatory)]
        [int]
        $NewSiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', $Id, 'reassign' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DisableSite' {
                    $body.data.Add('disableSite', [boolean]$DisableSite)
                }
                'NewSiteId' {
                    $body.data.Add('newSiteId', $NewSiteId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secrets on site: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Move-TssDistributedEngineSiteSecret request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.Site](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.Site]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
