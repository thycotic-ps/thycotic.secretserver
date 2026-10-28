function Update-TssEventPipelinePolicyFolder {
    <#
    .SYNOPSIS
    Set the folders an event pipeline policy is assigned to

    .DESCRIPTION
    Replaces the folders an event pipeline policy is assigned to with the folder IDs given. An empty list removes the policy from every folder.
    Returns True when the assignment was saved.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .PARAMETER FolderId
    Folder IDs the policy is assigned to. Replaces the current list; an empty list removes every folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelinePolicyFolder -TssSession $session -Id 3 -FolderId 12, 15

    Assigns event pipeline policy 3 to folders 12 and 15 only

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelinePolicyFolder -TssSession $session -Id 3 -FolderId @()

    Removes event pipeline policy 3 from every folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Update-TssEventPipelinePolicyFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Update-TssEventPipelinePolicyFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [int[]]
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $Id, 'folders' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @($FolderId) }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline policy folder: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssEventPipelinePolicyFolder request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
