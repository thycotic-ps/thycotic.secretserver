function Import-TssSecretCsv {
    <#
    .SYNOPSIS
    Import secrets from CSV

    .DESCRIPTION
    Imports secrets of one secret template from CSV text. The import runs in the background; the TaskIdentifier of the import and any errors are returned.
    -Verify checks the CSV without importing and returns the parsed rows and errors.
    The CSV has no header row: each line is one secret, with the secret name first, then the template field values in template field order, then the folder when -ImportWithFolder is set, then the TOTP values when -ImportWithTotp is set. A header line is imported as a secret.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateId
    Secret template ID of the secrets to import

    .PARAMETER Csv
    CSV text without a header row, one secret per line: secret name, the template field values in template field order, then the folder and TOTP values when those switches are set

    .PARAMETER AllowDuplicateSecrets
    Import rows that duplicate existing secrets

    .PARAMETER ImportWithFolder
    Each line has a folder column, after the template field values, with the folder of the secret

    .PARAMETER ImportWithTotp
    Each line ends with the TOTP values

    .PARAMETER ChangeRemotePasswords
    Change the imported passwords on the remote systems

    .PARAMETER Verify
    Check the CSV without importing (POST api/v1/secrets/import-csv-verify); returns the parsed rows and errors

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssSecretCsv -TssSession $session -TemplateId 6003 -Csv (Get-Content -Path ./secrets.csv -Raw) -Verify

    Checks secrets.csv against template 6003 without importing

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssSecretCsv -TssSession $session -TemplateId 6003 -Csv (Get-Content -Path ./secrets.csv -Raw) -ImportWithFolder

    Imports secrets.csv into template 6003, placing each secret in the folder named in its Folder column

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretCsv

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretCsv.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.CsvImport')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $TemplateId,

        [Parameter(Mandatory)]
        [string]
        $Csv,

        [switch]
        $AllowDuplicateSecrets,

        [switch]
        $ImportWithFolder,

        [switch]
        $ImportWithTotp,

        [Parameter(ParameterSetName = 'Default')]
        [switch]
        $ChangeRemotePasswords,

        [Parameter(Mandatory, ParameterSetName = 'Verify')]
        [switch]
        $Verify
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Verify' {
                    $uri = $TssSession.ApiUrl, 'secrets', 'import-csv-verify' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'TemplateId' {
                            $body.data.Add('templateId', $TemplateId)
                        }
                        'Csv' {
                            $body.data.Add('csv', $Csv)
                        }
                        'AllowDuplicateSecrets' {
                            $body.data.Add('allowDuplicateSecrets', [boolean]$AllowDuplicateSecrets)
                        }
                        'ImportWithFolder' {
                            $body.data.Add('importWithFolder', [boolean]$ImportWithFolder)
                        }
                        'ImportWithTotp' {
                            $body.data.Add('importWithTotp', [boolean]$ImportWithTotp)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secrets', 'import-csv-process' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'TemplateId' {
                            $body.data.Add('templateId', $TemplateId)
                        }
                        'Csv' {
                            $body.data.Add('csv', $Csv)
                        }
                        'AllowDuplicateSecrets' {
                            $body.data.Add('allowDuplicateSecrets', [boolean]$AllowDuplicateSecrets)
                        }
                        'ImportWithFolder' {
                            $body.data.Add('importWithFolder', [boolean]$ImportWithFolder)
                        }
                        'ImportWithTotp' {
                            $body.data.Add('importWithTotp', [boolean]$ImportWithTotp)
                        }
                        'ChangeRemotePasswords' {
                            $body.data.Add('changeRemotePasswords', [boolean]$ChangeRemotePasswords)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Secret csv", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssSecretCsv request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.CsvImport](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.CsvImport]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
