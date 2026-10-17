function New-TssDiscoveryDependencyTemplate {
    <#
    .SYNOPSIS
    Create a Discovery dependency template

    .DESCRIPTION
    Creates a Discovery dependency template that maps a dependency type to a scan template, and returns the created template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the template active. Without it the template is created inactive

    .PARAMETER ScanItemTemplateId
    Scan template the dependency template uses

    .PARAMETER SecretDependencyChangerId
    Dependency changer the template uses

    .PARAMETER SecretDependencyTemplateDescription
    Template description

    .PARAMETER SecretDependencyTemplateName
    Template name

    .PARAMETER SecretDependencyTypeId
    Dependency type id (see Search-TssDiscoveryDependencyType)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryDependencyTemplate -TssSession $session -SecretDependencyTemplateName 'Custom app pools' -SecretDependencyTypeId 7 -ScanItemTemplateId 9 -Active

    Create an active dependency template for dependency type 7 on scan template 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyTemplate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [int]
        $ScanItemTemplateId,

        [int]
        $SecretDependencyChangerId,

        [string]
        $SecretDependencyTemplateDescription,

        [Parameter(Mandatory)]
        [string]
        $SecretDependencyTemplateName,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', 'dependency-template' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'ScanItemTemplateId' {
                    $body.data.Add('scanItemTemplateId', $ScanItemTemplateId)
                }
                'SecretDependencyChangerId' {
                    $body.data.Add('secretDependencyChangerId', $SecretDependencyChangerId)
                }
                'SecretDependencyTemplateDescription' {
                    $body.data.Add('secretDependencyTemplateDescription', $SecretDependencyTemplateDescription)
                }
                'SecretDependencyTemplateName' {
                    $body.data.Add('secretDependencyTemplateName', $SecretDependencyTemplateName)
                }
                'SecretDependencyTypeId' {
                    $body.data.Add('secretDependencyTypeId', $SecretDependencyTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryDependencyTemplate request'
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
