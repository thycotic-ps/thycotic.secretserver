function Update-TssList {
    <#
    .SYNOPSIS
    Update a given list

    .DESCRIPTION
    Update a given list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $list = Get-TssList -TssSession -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
    $list.Active = $false
    Update-TssList -TssSession $session  -List $list

    Disable the provided List ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $list = Get-TssList -TssSession -Id 2d92c585-a3e1-4706-96b8-23ad2edda6b0
    $list.Active = $true
    Update-TssList -TssSession $session -List $list

    Enable the provided List ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $lists = Search-TssList -TssSession $session -SearchText URL | Get-TssList -TssSession
    $lists.Description = 'Testing URL List'
    Update-TssList -TssSession $session -List $list

    Update the Description on all Lists that have "URL" in their name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Lists.List')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List Object (output via Get-TssList)
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Thycotic.PowerShell.Lists.List[]]
        $List
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            foreach ($l in $List) {
                $listId = $l.CategorizedListId
                $uri = $TssSession.ApiUrl, 'lists', $listId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $updateBody = @{
                    data = @{
                        Active = @{
                            dirty = $true
                            value = $l.Active
                        }
                        Description = @{
                            dirty = $true
                            value = $l.Description
                        }
                        Name = @{
                            dirty = $true
                            value = $l.Name
                        }
                    }
                }
                $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 50
                if ($PSCmdlet.ShouldProcess("List: $Id", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue updating List [$Id]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Lists.List[]]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}