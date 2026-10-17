function Set-TssUserScript {
    <#
    .SYNOPSIS
    Update a user script

    .DESCRIPTION
    Updates the fields you pass on a user script and returns the updated script; fields you omit are unchanged.
    Name, description and script must not be empty when passed. ScriptCategoryId must be an existing category; category 9 (Dependency Validation) needs a PowerShell script.
    The script type cannot be changed. To change the parameters or SQL and SSH settings use Update-TssUserScriptParameter.
    Requires the Administer Scripts permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User script ID

    .PARAMETER Name
    New script name

    .PARAMETER Description
    New script description

    .PARAMETER Script
    New script body

    .PARAMETER ScriptCategoryId
    New script category ID, see Search-TssUserScriptCategory

    .PARAMETER Active
    Activate the script, or deactivate it with -Active:$false

    .PARAMETER UsePowerShellCore
    PowerShell scripts: run the script under PowerShell Core, or under Windows PowerShell with -UsePowerShellCore:$false

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserScript -TssSession $session -Id 12 -Description 'Restart IIS and the app pool'

    Change the description of user script 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserScript -TssSession $session -Id 12 -Active:$false

    Deactivate user script 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Set-TssUserScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Set-TssUserScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Scripts.ScriptItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScriptId')]
        [int]
        $Id,

        [string]
        $Name,

        [string]
        $Description,

        [string]
        $Script,

        [int]
        $ScriptCategoryId,

        [switch]
        $Active,

        [switch]
        $UsePowerShellCore
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'Active' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$Active })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'UsePowerShellCore' {
                    $body.data.Add('powerShellSettings', @{ usePowerShellCore = [boolean]$UsePowerShellCore })
                }
                'Script' {
                    $body.data.Add('script', @{ dirty = $true; value = $Script })
                }
                'ScriptCategoryId' {
                    $body.data.Add('scriptCategoryId', @{ dirty = $true; value = $ScriptCategoryId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User script: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssUserScript request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Scripts.ScriptItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Scripts.ScriptItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
