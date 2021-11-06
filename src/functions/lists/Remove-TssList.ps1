function Remove-TssList {
    <#
    .SYNOPSIS
    Remove a List by ID

    .DESCRIPTION
    Remove a List by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssList -TssSession $session -Id -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0

    Remove the provided List ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Remove-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Remove-TssList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("CategorizedListId")]
        [string]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($list in $Id) {
                $uri = $TssSession.ApiUrl, 'lists', $list -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("List $list","$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $body"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing List [$list]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]$restResponse
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}