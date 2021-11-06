function Clear-TssListOption {
    <#
    .SYNOPSIS
    Clear a List option from a list

    .DESCRIPTION
    Clear a List option from a list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $options = Get-TssListOption -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
    $options | Where-Object Option -eq 'Option 2' | Clear-TssListOption -TssSession $session

    Clear the "Option 1" from the List, will prompt to confirm the action since it is not reversible

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $options = Get-TssListOption -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
    $options | Where-Object Option -eq 'Option 2' | Clear-TssListOption -TssSession $session -Confirm:$false

    Clear the "Option 1" from the List, will **not** prompt to confirm the action since it is not reversible

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $options = Get-TssListOption -TssSession $session -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
    $options | Where-Object Option -match '^TBSERV' | Clear-TssListOption -TssSession $session -Confirm:$false

    Clear all options that start with "TBSERV" from the List, will **not** prompt to confirm the action since it is not reversible

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Clear-TssListOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Clear-TssListOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string]
        $Id,

        # The List's Option Id to clear
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListItemId')]
        [string[]]
        $OptionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            foreach ($option in $OptionId) {
                $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', $option -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("List: $Id", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "$($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue clearing List [$list] option [$option]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.isDeleted) {
                        Write-Verbose "Option [$option] successfully cleared from List [$Id]"
                    } else {
                        Write-Warning "Option [$option] was not cleared from List [$Id]"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}