function Search-TssSubscription {
    <#
    .SYNOPSIS
    Search the subscriptions of a Secret Server Cloud tenant

    .DESCRIPTION
    Lists the subscription line items of a Secret Server Cloud tenant: display name, units, start and end date, recurrence and note.
    Use -IncludeUsage to get one object with the current and licensed numbers of users, secrets, sites, engines and session monitoring storage, with the line items in its Subscriptions property.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeUsage
    Return one object with the usage counts and licensed limits, with the line items in its Subscriptions property

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSubscription -TssSession $session

    List the subscription line items

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSubscription -TssSession $session -IncludeUsage | Select-Object NumberOfUsers, MaxNumberOfUsers, NumberOfSecrets, MaxNumberOfSecrets

    Compare user and secret counts with the licensed limits

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/subscriptions/Search-TssSubscription

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/subscriptions/Search-TssSubscription.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: on-premises Secret Server answers with an error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Subscriptions.Subscription')]
    [OutputType('Thycotic.PowerShell.Subscriptions.Usage')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeUsage
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'subscriptions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSubscription request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($IncludeUsage -and $restResponse) {
                [Thycotic.PowerShell.Subscriptions.Usage](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Subscriptions.Usage]))
            } elseif ($restResponse.subscriptions) {
                [Thycotic.PowerShell.Subscriptions.Subscription[]](. $FilterTssResponse $restResponse.subscriptions ([Thycotic.PowerShell.Subscriptions.Subscription]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
