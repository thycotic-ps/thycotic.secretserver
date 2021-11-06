function Show-TssListCurrentUser {
    <#
    .SYNOPSIS
    Return a list of the Lists for the current user

    .DESCRIPTION
    Return a list of the Lists for the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Show-TssListCurrentUser -TssSession $session

    Returns the list of Lists the current connected user can access

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Show-TssListCurrentUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Show-TssListCurrentUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.SummaryList')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
            Get-TssInvocation $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
                Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
                $uri = $TssSession.ApiUrl, 'lists', 'summary' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting current user's List"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Lists.SummaryList[]]$restResponse.records
                }
            } else {
                Write-Warning "No valid session found"
            }
        }
}