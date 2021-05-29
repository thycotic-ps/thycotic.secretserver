function Get-UserOwner {
    <#
    .SYNOPSIS
    Get the owners for a User ID

    .DESCRIPTION
    Get the owners of a User ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserOwner -TssSession $session -Id 42

    Get Owners of the User ID 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/Get-UserOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUserOwnerSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # User ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserId")]
        [int[]]
        $Id,

        # Sort by specific property, default Id (user owner ID)
        [string]
        $SortBy = 'Id'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'owners' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting owners on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [TssUserOwnerSummary[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}