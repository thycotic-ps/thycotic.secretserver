function Get-TssInboxTemplateLocale {
    <#
    .SYNOPSIS
    Get the subject and body of an inbox template locale

    .DESCRIPTION
    Gets the subject and body an inbox notification template uses for one locale.
    The locale is chosen by locale culture ID (the Locale property of Get-TssInboxTemplate output is the default one). When the template has no locale for that culture, the server returns the template's default locale instead: check LocaleCultureId on the result.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateId
    Inbox template ID

    .PARAMETER LocaleCultureId
    Locale culture ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxTemplateLocale -TssSession $session -TemplateId 4 -LocaleCultureId 9

    Get locale culture 9 of inbox template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxTemplate -TssSession $session -Id 4 | Get-TssInboxTemplateLocale -TssSession $session

    Get the default locale of inbox template 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateLocale

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateLocale.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.TemplateLocale')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $TemplateId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Locale', 'LocaleId')]
        [int]
        $LocaleCultureId
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
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', $TemplateId, 'locales', $LocaleCultureId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssInboxTemplateLocale request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Inbox.TemplateLocale](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.TemplateLocale]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
