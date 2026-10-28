function Get-TssEventPipelinePolicyFolderChild {
    <#
    .SYNOPSIS
    Get child folder data for a folder of an event pipeline policy

    .DESCRIPTION
    Returns, for each child folder of a folder, its child folder count and whether it has an event pipeline policy, as the folder picker of an event pipeline policy shows it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .PARAMETER FolderId
    Parent folder ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelinePolicyFolderChild -TssSession $session -Id 3 -FolderId 12

    Returns the child folders of folder 12 for event pipeline policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Get-TssEventPipelinePolicyFolderChild

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyFolderChild.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.FolderChild[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $FolderId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $Id, 'folders', $FolderId, 'childdata' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssEventPipelinePolicyFolderChild request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.EventPipelinePolicy.FolderChild[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipelinePolicy.FolderChild]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
