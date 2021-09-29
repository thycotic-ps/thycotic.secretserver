function New-TssSecretDependency {
    <#
    .SYNOPSIS
    Create a new Secret Dependency

    .DESCRIPTION
    Create a new Secret Dependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $dependentStub = Get-TssSecretDependencyStub -TssSession $session -SecretId 42 -TemplateId 4
    New-TssSecretDependency -TssSession $session -DependencyStub $dependentStub

    Create new dependency on Secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/New-TssSecretDependency

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/New-TssSecretDependency.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Dependency')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Dependency Stub object
        [Parameter(Mandatory,ValueFromPipeline)]
        [Thycotic.PowerShell.SecretDependencies.Dependency]
        $DependencyStub
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-dependencies' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $invokeParams.Body = ($SecretDependencyStub | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating dependency on Secret [$($DependencyStub.SecretId)]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.SecretDependencies.Dependency]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}