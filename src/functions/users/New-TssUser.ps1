function New-TssUser {
    <#
    .SYNOPSIS
    Create a new Secret Server User

    .DESCRIPTION
    Create a new Secret Server User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
    New-TssUser -TssSession $session -Username 'testuser' -DisplayName 'My Test User' -Password (ConvertTo-SecureString 'pass!' -AsPlainText -Force) -Active

    Create testuser with a DisplayName of "My Test User", and enable on creation.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
    New-TssUser -TssSession $session -Username 'apiuser' -DisplayName 'Dev Test App User' -Password (ConvertTo-SecureString 'pass$' -AsPlainText -Force) -IsApplicationAccount -Active

    Create apiuser as an Application Account and enable on creation.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.User')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Username
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Username,

        # Display Name
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $DisplayName,

        # Password (for local only)
        [Parameter(Mandatory)]
        [securestring]
        $Password,

        # Enable the account on creation
        [switch]
        $Active,

        # Create as an application account
        [switch]
        $IsApplicationAccount,

        # Email address
        [string]
        $EmailAddress,

        # Active Directory Domain ID
        [ValidateRange(-1, [int]::MaxValue)]
        [int]
        $DomainId,

        # Active Directory GUID
        [ValidateLength(36, 50)]
        [string]
        $AdGuid,

        # 2FA type (DUO, FIDO, RADIUS, OATH)
        [Thycotic.PowerShell.Enums.TwoFactorTypes]
        $TwoFactorType,

        # Username for RADIUS
        [string]
        $RadiusUsername
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = [ordered]@{}
            switch ($tssNewParams.Keys) {
                'Username' { $newBody.Add('userName', $Username) }
                'DisplayName' { $newBody.Add('displayName', $DisplayName) }
                'Password' {
                    $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
                    $newBody.Add('password', $passwd)
                }
                'Active' { $newBody.Add('enabled', [boolean]$Active) }
                'IsApplicationAccount' { $newBody.Add('isApplicationAccount', [boolean]$IsApplicationAccount) }
                'EmailAddress' { $newBody.Add('emailAddress', $EmailAddress) }
                'DomainId' { $newBody.Add('domainId', $DomainId) }
                'AdGuid' { $newBody.Add('adGuid', $AdGuid) }
                'TwoFactorType' {
                    if ([string]$TwoFactorType -eq 'RADIUS' -and -not $tssNewParams.ContainsKey('RadiusUsername')) {
                        Write-Warning 'Radius Username is required to create a user with RADIUS 2FA'
                        return
                    }
                    $newBody.Add('radiusTwoFactor', $true)
                    $newBody.Add('radiusUserName', $RadiusUsername)
                }
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json -Depth 100)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("User: $Username", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue creating report [User]'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Users.User]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}