function Set-TssDiscoveryDependencyTemplate {
    <#
    .SYNOPSIS
    Update a Discovery dependency template

    .DESCRIPTION
    Updates the given fields of a Discovery dependency template and returns the updated template. Fields not given are unchanged. Built-in templates cannot be changed (the server returns an error; CanEdit is false on them).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dependency template id

    .PARAMETER Active
    Activate the template; use -Active:$false to deactivate it

    .PARAMETER ScanItemTemplateId
    Scan template the dependency template uses

    .PARAMETER SecretDependencyChangerId
    Dependency changer the template uses

    .PARAMETER SecretDependencyTemplateDescription
    Template description

    .PARAMETER SecretDependencyTemplateName
    Template name

    .PARAMETER SecretDependencyTypeId
    Dependency type id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryDependencyTemplate -TssSession $session -Id 12 -SecretDependencyTemplateDescription 'App pools on the web farm'

    Change the description of dependency template 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryDependencyTemplate -TssSession $session -Id 12 -Active:$false

    Deactivate dependency template 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyTemplate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretDependencyTemplateId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $ScanItemTemplateId,

        [int]
        $SecretDependencyChangerId,

        [string]
        $SecretDependencyTemplateDescription,

        [string]
        $SecretDependencyTemplateName,

        [int]
        $SecretDependencyTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', 'dependency-template', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'ScanItemTemplateId' {
                    $body.data.Add('scanItemTemplateId', @{ dirty = $true; value = $ScanItemTemplateId })
                }
                'SecretDependencyChangerId' {
                    $body.data.Add('secretDependencyChangerId', @{ dirty = $true; value = $SecretDependencyChangerId })
                }
                'SecretDependencyTemplateDescription' {
                    $body.data.Add('secretDependencyTemplateDescription', @{ dirty = $true; value = $SecretDependencyTemplateDescription })
                }
                'SecretDependencyTemplateName' {
                    $body.data.Add('secretDependencyTemplateName', @{ dirty = $true; value = $SecretDependencyTemplateName })
                }
                'SecretDependencyTypeId' {
                    $body.data.Add('secretDependencyTypeId', @{ dirty = $true; value = $SecretDependencyTypeId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryDependencyTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.DependencyTemplate](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.DependencyTemplate]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
