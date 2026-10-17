function Get-TssDcm {
    <#
    .SYNOPSIS
    Get the Delinea Credential Manager configuration

    .DESCRIPTION
    Returns Delinea Credential Manager (browser extension) settings.
    With -Type, returns the configuration for business users or unrestricted users. Secret Server serves the business user configuration only to a session authenticated through Delinea Platform; with any other session -Type BusinessUser returns the unrestricted user configuration (Type shows UnrestrictedUser). With -CurrentUser, returns the settings in effect for the current user. With -Mobile, returns the mobile offline access limits for the current user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Type
    Configuration to return: BusinessUser or UnrestrictedUser. BusinessUser needs a session authenticated through Delinea Platform; with any other session Secret Server returns the unrestricted user configuration

    .PARAMETER CurrentUser
    Return the configuration in effect for the current user

    .PARAMETER Mobile
    Return the mobile offline access limits for the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDcm -TssSession $session -Type UnrestrictedUser

    Get the Delinea Credential Manager configuration for unrestricted users

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDcm -TssSession $session -CurrentUser

    Get the Delinea Credential Manager settings in effect for the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDcm -TssSession $session -Mobile

    Get the mobile offline access limits for the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDcm

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDcm.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'type')]
    [OutputType('Thycotic.PowerShell.Configuration.Dcm', 'Thycotic.PowerShell.Configuration.DcmCurrentUser', 'Thycotic.PowerShell.Configuration.DcmMobile')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'type')]
        [ValidateSet('BusinessUser', 'UnrestrictedUser')]
        [string]
        $Type,

        [Parameter(Mandatory, ParameterSetName = 'currentUser')]
        [switch]
        $CurrentUser,

        [Parameter(Mandatory, ParameterSetName = 'mobile')]
        [switch]
        $Mobile
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'currentUser' {
                    $uri = $TssSession.ApiUrl, 'configuration', 'dcm', 'current-user' -join '/'
                    $outputType = [Thycotic.PowerShell.Configuration.DcmCurrentUser]
                }
                'mobile' {
                    $uri = $TssSession.ApiUrl, 'configuration', 'dcmmobile', 'current-user' -join '/'
                    $outputType = [Thycotic.PowerShell.Configuration.DcmMobile]
                }
                default {
                    $typeId = @{ BusinessUser = 1; UnrestrictedUser = 2 }[$Type]
                    $uri = $TssSession.ApiUrl, 'configuration', 'dcm', $typeId -join '/'
                    $outputType = [Thycotic.PowerShell.Configuration.Dcm]
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDcm request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [System.Management.Automation.LanguagePrimitives]::ConvertTo((. $FilterTssResponse $restResponse $outputType), $outputType)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
