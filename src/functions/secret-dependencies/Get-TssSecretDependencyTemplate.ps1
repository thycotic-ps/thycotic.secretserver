function Get-TssSecretDependencyTemplate {
    <#
    .SYNOPSIS
    Get list of Dependency Templates

    .DESCRIPTION
    Get list of Dependency Templates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyTemplate -TssSession $session

    Return list of the Dependency Templates found on Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyTemplate -TssSession $session -Id 6

    Return Dependency Template ID 6

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyTemplate -TssSession $session -Name 'Windows Service'

    Return Dependency Template named Window Service

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Template')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Dependency Template Id
        [int[]]
        $Id,

        # Dependency Template Name
        [string]
        $Template
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-dependencies', 'templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue getting Dependency Templates'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.model) {
                $depTemplates = [Thycotic.PowerShell.SecretDependencies.Template[]]$restResponse.model
                if ($tssParams.ContainsKey('Template')) {
                    $depTemplates.Where( { $_.Name -eq $Template })
                } elseif ($tssParams.ContainsKey('Id')) {
                    $depTemplates.Where( { $_.Id -in $Id })
                } else {
                    $depTemplates
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}