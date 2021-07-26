function Get-TssScript {
    <#
    .SYNOPSIS
    Get a single Secret Server Script by Id

    .DESCRIPTION
    Get a single Secret Server Script by Id (Admin > Scripts)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssScript -TssSession $session -Id 10

    Return Script ID 10

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.Script')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Script ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("ScriptId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($script in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'userscripts', $script -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting script [$script]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $TssScriptObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}