function Get-TssList {
    <#
    .SYNOPSIS
    Get a List

    .DESCRIPTION
    Get a List

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssList -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.List')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("CategorizedListId")]
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
                $uri = $TssSession.ApiUrl, 'lists', $list -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting List [$list]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Lists.List[]]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}