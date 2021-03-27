function Get-UserStub {
    <#
    .SYNOPSIS
    Get user stub object

    .DESCRIPTION
    Get user stub object to create a new user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserStub -TssSession $session

    Returns an empty User object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newUser = Get-TssUserStub -TssSession $session
    $newUser.DisplayName = 'IT Operator - Bob'
    $newUser.Username = 'bob'
    New-TssUser -TssSession $session -UserStub $newUser -Password (ConvertTo-SecureString 'P@ssword$01' -AsPlainText -Force)

    Get empty User object, setting required minimum properties for Local User, and creating via New-TssUser

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUser')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            # these properties always return null for an empty user object
            $invokeParams.RemoveProperty = 'verifyEmailSentDate', 'passwordLastChanged', 'adAccountExpires', 'resetSessionStarted', 'lastSessionActivity', 'LastLogin'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue getting user stub"
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