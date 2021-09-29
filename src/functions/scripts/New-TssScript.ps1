function New-TssScript {
    <#
    .SYNOPSIS
    Create a new Script

    .DESCRIPTION
    Create a new Script

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssScript.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssScript -TssSession $session -Name 'PS Script One' -Description 'Testing new script function' -Type PowerShell -Script 'throw whoami'

    Create a PowerShell script

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Scripts.Script')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Script name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # Description
        [Parameter(Mandatory)]
        [string]
        $Description,

        # Script type (PowerShell, SQL, SSH)
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.ScriptType]
        $Type,

        # Script Category (Untyped, TicketValidation, TicketComment, SecretDiscovery,
        #    Heartbeat, PasswordChanging, DiscoveryTakeover, Dependency)
        [Thycotic.PowerShell.Enums.ScriptCategory]
        $Category = 1,

        # Script content
        [Parameter(Mandatory)]
        [string]
        $Script
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{
                Active = $true
            }
            switch ($tssNewParams.Keys) {
                'Name' { $newBody.Add('name',$Name) }
                'Description' { $newBody.Add('description',$Description) }
                'Type' { $newBody.Add('scriptType', [string]$Type) }
                'Category' { $newBody.Add('scriptCategoryId',$Category) }
                'Script' { $newBody.Add('script',$Script) }
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json -Depth 20)

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Script: $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating report [Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                . $TssScriptObject $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}