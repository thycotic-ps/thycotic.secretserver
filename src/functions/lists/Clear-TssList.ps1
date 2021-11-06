function Clear-TssList {
    <#
    .SYNOPSIS
    Clear all List categories and options from the list.

    .DESCRIPTION
    Clear all List categories and options from the list.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssList -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0

    Clear all the options from the provided List Id, will prompt to confirm the action since it is not reversible

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssList -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0 -Confirm:$false

    Clear all the options from the provided List Id, will **not** prompt to confirm the action since it is not reversible

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Clear-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Clear-TssList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            foreach ($list in $Id) {
                $uri = $TssSession.ApiUrl, 'lists', $list, 'options' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("List: $list", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "$($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue clearing List [$list]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}