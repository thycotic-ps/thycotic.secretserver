function New-TssSecretDependencyGroup {
    <#
    .SYNOPSIS
    Create a new Dependency Group on a Secret

    .DESCRIPTION
    Create a new Dependency Group on a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential (Get-Secret apiacct)
    New-TssSecretDependencyGroup -TssSession $session -Id 330, 342 -GroupName 'QA Env'

    Create the Dependency Group "QA Env" on Secrets 330 and 342

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential (Get-Secret apiacct)
    Search-TssSecret -TssSession $session -FolderId 50 | New-TssSecretDependencyGroup -TssSession $session -GroupName 'Test Env'

    Create the Dependency Group "Test Env" on all Secrets found under Folder ID 50, that the apiacct has access

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/New-TssSecretDependencyGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/New-TssSecretDependencyGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Group')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        #  Name of Group
        [Parameter(Mandatory)]
        [string]
        $GroupName,

        # Site ID, not provided will configure "Site from Secret"
        [int]
        $SiteId
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies', 'groups', $secret -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $newBody = [ordered]@{}
                switch ($tssNewParams.Keys) {
                    'GroupName' { $newBody.Add('secretDependencyGroupName', $GroupName) }
                    'SiteId' { $newBody.Add('siteId', $SiteId) }
                }
                $invokeParams.Body = ($newBody | ConvertTo-Json)

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
                if (-not $PSCmdlet.ShouldProcess('', "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue creating Dependency Group [$Name] on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretDependencies.Group]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}