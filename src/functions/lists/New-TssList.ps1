function New-TssList {
    <#
    .SYNOPSIS
    Create a new List

    .DESCRIPTION
    Create a new List

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssList -TssSession $session -Name 'My New List' -Active

    Creates a new List named "My New List" and Actives it upon creation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssList -TssSession $session -Name 'My New List' -Active:$false

    Creates a new List named "My New List" and disabling it upon creation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Lists.List')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # List Name
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $Name,

        # List Description
        [string]
        $Description,

        # Activate the List on creation
        [switch]
        $Active
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'lists' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{ data = @{} }
            switch ($tssNewParams.Keys) {
                'Name' {
                    $nameValue = @{
                        dirty = $true
                        value = $Name
                    }
                    $newBody.data.Add('name',$nameValue)
                }
                'Description' {
                    $descValue = @{
                        dirty = $true
                        value = $Description
                    }
                    $newBody.data.Add('description',$descValue)
                }
                'Active' {
                    $activeValue = @{
                        dirty = $true
                        value = [boolean]$Active
                    }
                    $newBody.data.Add('active',$activeValue)
                }
            }
            $invokeParams.Body = $newBody | ConvertTo-Json -Dept 25

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("List $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating List [$Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Lists.List]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}