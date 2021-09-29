function Get-TssSecretDependencyStub {
    <#
    .SYNOPSIS
    Get default values for a new Secret Dependency

    .DESCRIPTION
    Get default values for a new Secret Dependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyStub -TssSession $session -SecretId 42 -TemplateId 6

    Return Secret Dependency Stub for Secret 42 and Template ID 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Dependency')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, Position = 1)]
        [int]
        $SecretId,

        # Dependency Template ID
        [Parameter(Mandatory, ParameterSetName = 'template')]
        [Alias('Id')]
        [int]
        $TemplateId,

        # ID of the Script this Dependency will run, must match the TypeID
        [Parameter(ParameterSetName = 'script')]
        [int]
        $ScriptId,

        # Dependency Type this Dependency will be modeled on. Allowed values: PowerShell (7), SSH (8), SQL (9)
        [Parameter(Mandatory, ParameterSetName = 'script')]
        [ValidateSet('PowerShell', 'SSH', 'SQL')]
        [string]
        $Type
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
            $invokeParams.Method = 'GET'

            $uri = $TssSession.ApiUrl, 'secret-dependencies', 'stub' -join '/'
            $uri = $uri, "secretId=$SecretId" -join '?'
            if ($tssParams.ContainsKey('TemplateId')) {
                $uri = $uri, "templateId=$TemplateId" -join '&'
            }
            if ($tssParams.ContainsKey('ScriptId')) {
                $uri = $uri, "scriptId=$ScriptId" -join '&'
            }
            if ($tssParams.ContainsKey('Type')) {
                switch ($Type) {
                    'PowerShell' { $uri = $uri, 'typeId=7' -join '&' }
                    'SSH' { $uri = $uri, 'typeId=8' -join '&' }
                    'SQL' { $uri = $uri, 'typeId=9' -join '&' }
                }
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting stub for secret [$secret]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.SecretDependencies.Dependency]$restResponse
            }

        } else {
            Write-Warning 'No valid session found'
        }
    }
}