function Export-TssSecretBulk {
    <#
    .SYNOPSIS
    Export secrets in bulk

    .DESCRIPTION
    Exports the secrets of a folder to CSV or XML.
    By default the export runs synchronously and the file text is returned in ExportedSecretsFileText. -Job starts an export job instead and returns its ExportJobId; read its status and file with Get-TssSecretBulkExport.
    Secret Server asks for the login password of the current user again before an export: pass it as -Password. Secrets protected by DoubleLock also need -DoubleLockPassword.
    The user needs View on every secret in scope.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FolderId
    Folder ID to export. Use -1 for the root folder

    .PARAMETER ExportChildFolders
    Include the secrets of child folders

    .PARAMETER ExportFolderPath
    Add the folder path of each secret to the export

    .PARAMETER ExportTemplateName
    Add the secret template name of each secret to the export

    .PARAMETER ExportTotp
    Include TOTP settings

    .PARAMETER FileType
    File format of the export, Csv or Xml

    .PARAMETER Notes
    Note recorded with the export

    .PARAMETER Password
    Login password of the current user; Secret Server asks for it again before an export

    .PARAMETER DoubleLockPassword
    DoubleLock password, needed when secrets in scope are protected by DoubleLock

    .PARAMETER Job
    Start an export job (POST api/v2/secrets/export/job) instead of the synchronous export; returns the ExportJobId

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $password = Read-Host -AsSecureString
    (Export-TssSecretBulk -TssSession $session -FolderId 7 -ExportChildFolders -ExportFolderPath -Password $password).ExportedSecretsFileText | Set-Content -Path ./secrets.csv

    Exports folder 7 and its child folders to secrets.csv

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $password = Read-Host -AsSecureString
    $job = Export-TssSecretBulk -TssSession $session -FolderId -1 -ExportChildFolders -FileType Xml -Password $password -Job
    $job | Get-TssSecretBulkExport -TssSession $session -Status

    Starts an XML export job of every folder and checks its status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Export-TssSecretBulk

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Export-TssSecretBulk.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Secrets.BulkExport')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $FolderId,

        [switch]
        $ExportChildFolders,

        [switch]
        $ExportFolderPath,

        [switch]
        $ExportTemplateName,

        [switch]
        $ExportTotp,

        [ValidateSet('Csv', 'Xml')]
        [string]
        $FileType,

        [string]
        $Notes,

        [Parameter(Mandatory)]
        [securestring]
        $Password,

        [securestring]
        $DoubleLockPassword,

        [Parameter(Mandatory, ParameterSetName = 'Job')]
        [switch]
        $Job
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
                'Job' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secrets', 'export', 'job' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'FolderId' {
                            $body.data.Add('folderId', $FolderId)
                        }
                        'ExportChildFolders' {
                            $body.data.Add('exportChildFolders', [boolean]$ExportChildFolders)
                        }
                        'ExportFolderPath' {
                            $body.data.Add('exportFolderPath', [boolean]$ExportFolderPath)
                        }
                        'ExportTemplateName' {
                            $body.data.Add('exportTemplateName', [boolean]$ExportTemplateName)
                        }
                        'ExportTotp' {
                            $body.data.Add('exportTotp', [boolean]$ExportTotp)
                        }
                        'FileType' {
                            $body.data.Add('exportFileType', $FileType)
                        }
                        'Notes' {
                            $body.data.Add('notes', $Notes)
                        }
                        'Password' {
                            $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                        }
                        'DoubleLockPassword' {
                            $body.data.Add('doubleLockPassword', [System.Net.NetworkCredential]::new('', $DoubleLockPassword).Password)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secrets', 'export' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'FolderId' {
                            $body.data.Add('folderId', $FolderId)
                        }
                        'ExportChildFolders' {
                            $body.data.Add('exportChildFolders', [boolean]$ExportChildFolders)
                        }
                        'ExportFolderPath' {
                            $body.data.Add('exportFolderPath', [boolean]$ExportFolderPath)
                        }
                        'ExportTemplateName' {
                            $body.data.Add('exportTemplateName', [boolean]$ExportTemplateName)
                        }
                        'ExportTotp' {
                            $body.data.Add('exportTotp', [boolean]$ExportTotp)
                        }
                        'FileType' {
                            $body.data.Add('exportFileType', $FileType)
                        }
                        'Notes' {
                            $body.data.Add('notes', $Notes)
                        }
                        'Password' {
                            $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                        }
                        'DoubleLockPassword' {
                            $body.data.Add('doubleLockPassword', [System.Net.NetworkCredential]::new('', $DoubleLockPassword).Password)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                if ($apiResponse.IsSuccessful -and $apiResponse.StatusCode -eq [System.Net.HttpStatusCode]::Accepted) {
                    $restResponse = $apiResponse.Content | ConvertFrom-Json
                } else {
                    $restResponse = . $ProcessResponse $apiResponse
                }
            } catch {
                Write-Warning 'Issue with Export-TssSecretBulk request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.BulkExport](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.BulkExport]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
