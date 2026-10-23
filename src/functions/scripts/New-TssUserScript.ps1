function New-TssUserScript {
    <#
    .SYNOPSIS
    Create a user script

    .DESCRIPTION
    Creates a PowerShell, SQL or SSH user script through the v2 userscripts endpoint and returns it with its type settings.
    Unlike New-TssScript, it can link a SQL script to a password changer, choose PowerShell Core for a PowerShell script, and returns the v2 script model.
    Name, description and script must not be empty. ScriptCategoryId must be an existing category (see Search-TssUserScriptCategory); category 9 (Dependency Validation) needs a PowerShell script.
    The script is created inactive unless -Active is passed.
    Requires the Administer Scripts permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Script name

    .PARAMETER Description
    Script description

    .PARAMETER ScriptType
    Script type: PowerShell, SQL or SSH

    .PARAMETER Script
    Script body

    .PARAMETER ScriptCategoryId
    Script category ID, see Search-TssUserScriptCategory. Defaults to 1 (Untyped)

    .PARAMETER Active
    Create the script active. Omit it to create the script inactive

    .PARAMETER PasswordChangerId
    SQL scripts: ID of the password changer the script uses to connect. Omit it to keep the server default

    .PARAMETER UsePowerShellCore
    PowerShell scripts: run the script under PowerShell Core instead of Windows PowerShell

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssUserScript -TssSession $session -Name 'Restart IIS' -Description 'Restart IIS after a password change' -ScriptType PowerShell -ScriptCategoryId 8 -Script 'iisreset /restart' -Active

    Create an active PowerShell dependency script

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssUserScript -TssSession $session -Name 'Check DB' -Description 'Connectivity check' -ScriptType SQL -Script 'SELECT 1' -PasswordChangerId 9

    Create an inactive SQL script linked to password changer 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssUserScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssUserScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Scripts.ScriptItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [string]
        $Description,

        [Parameter(Mandatory)]
        [ValidateSet('PowerShell', 'SQL', 'SSH')]
        [string]
        $ScriptType,

        [Parameter(Mandatory)]
        [string]
        $Script,

        [int]
        $ScriptCategoryId = 1,

        [switch]
        $Active,

        [int]
        $PasswordChangerId,

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
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'userscripts' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    name             = $Name
                    description      = $Description
                    scriptType       = $ScriptType
                    script           = $Script
                    scriptCategoryId = $ScriptCategoryId
                    isActive         = [boolean]$Active
                }
            }
            switch ($tssParams.Keys) {
                'PasswordChangerId' {
                    $body.data.Add('passwordChangerId', $PasswordChangerId)
                }
                'UsePowerShellCore' {
                    $body.data.Add('powerShellSettings', @{ usePowerShellCore = [boolean]$UsePowerShellCore })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User script: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssUserScript request'
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
