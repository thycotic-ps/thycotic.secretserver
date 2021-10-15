function Export-TssAutoExportStorageItem {
    <#
    .SYNOPSIS
    Export the Automatic Export Storage Item

    .DESCRIPTION
    Export the Automatic Export Storage Item, output will show the latest as the first object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
    $item = Search-TssAutoExportStorage -TssSession $session
    Export-TssAutoExportStorageItem -TssSession $session -Id $item[0].Id -Filename $item[0].Filename -Output C:\temp\backup

    Exports the latest automatic secret export zip file to C:\temp\backup\<filename>.zip

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.au -Credential $ssCred
    Search-TssAutoExportStorage -TssSession $session | select -First 1 | Export-TssAutoExportStorageItem -TssSession $session -Output C:\temp\backup

    Exports the latest automatic secret export zip file to C:\temp\backup\<filename>.zip

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Export-TssAutoExportStorageItem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/sExport-TssAutoExportStorageItem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Automatic Export Item ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        # Automatic Export Item Filename
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [string]
        $Filename,

        # Output folder
        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        try { Compare-TssUrl $TssSession } catch { throw $_ }
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'auto-export-storage', 'item', $Id -join '/'
            $itemFilename = $Filename + '.zip'
            $outFile = [System.IO.Path]::Combine($Output, $itemFilename)

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            $InvokeParams.OutFile = $outFile

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                Invoke-TssApi @invokeParams
            } catch {
                Write-Warning 'Issue getting Export Storage Item [$itemId]'
                $err = $_
                . $ErrorHandling $err
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}