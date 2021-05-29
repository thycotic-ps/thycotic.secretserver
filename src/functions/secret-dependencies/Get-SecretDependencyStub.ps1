function Get-SecretDependencyStub {
    <#
    .SYNOPSIS
    Get default values for a new Secret Dependency

    .DESCRIPTION
    Get default values for a new Secret Dependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyStub -TssSession $session -SecretId 42

    Return Secret Dependency template for Secret 42,

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretDependencyStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/Get-SecretDependencyStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretDependencyStub')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
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
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

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

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue getting stub for secret [$secret]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssSecretDependency]$restResponse
            }

        } else {
            Write-Warning 'No valid session found'
        }
    }
}