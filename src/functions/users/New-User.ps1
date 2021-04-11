function New-User {
    <#
    .SYNOPSIS
    Create a new Secret Server User

    .DESCRIPTION
    Create a new Secret Server User

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/New-User.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssUser')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Username
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $Username,

        # Display Name
        [Parameter(Mandatory,ValueFromPipeline)]
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
        [ValidateRange(-1,[int]::MaxValue)]
        [int]
        $DomainId,

        # Active Directory GUID
        [ValidateLength(36,50)]
        [string]
        $AdGuid,

        # 2FA type
        [ValidateSet('DUO', 'FIDO', 'RADIUS', 'OATH')]
        [string]
        $TwoFactorType,

        [string]
        $RadiusUsername
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = [ordered]@{}
            switch ($tssNewParams.Keys) {
                'Username' { $newBody.Add('userName',$Username) }
                'DisplayName' { $newBody.Add('displayName',$DisplayName) }
                'Password' {
                    $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
                    $newBody.Add('password',$passwd)
                }
                'Active' { $newBody.Add('enabled',[boolean]$Active) }
                'IsApplicationAccount' { $newBody.Add('isApplicationAccount',[boolean]$IsApplicationAccount) }
                'EmailAddress' { $newBody.Add('emailAddress',$EmailAddress) }
                'DomainId' { $newBody.Add('domainId',$DomainId) }
                'AdGuid' { $newBody.Add('adGuid',$AdGuid) }
                'TwoFactorType' {
                    if ($TwoFactorType -eq 'RADIUS' -and -not $tssNewParams.ContainsKey('RadiusUsername')) {
                        Write-Warning 'Radius Username is required to create a user with RADIUS 2FA'
                        return
                    }
                    $newBody.Add('radiusTwoFactor',$true)
                    $newBody.Add('radiusUserName',$RadiusUsername)
                }
            }

            $invokeParams.Body = ($newBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating report [User]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssUser]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}