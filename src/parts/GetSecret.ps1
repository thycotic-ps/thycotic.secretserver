[cmdletbinding(DefaultParameterSetName = 'secret')]
param(
    [Parameter(Mandatory,Position = 0)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    [Alias("SecretId")]
    [int]
    $Id,

    [Parameter(Mandatory,Position = 2)]
    $RestrictedParams
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}

process {
    $restResponse = $null
    $uri = $TssSession.ApiUrl, 'secrets', $Id -join '/'

    $getSecretBody = @{}
    if ($restrictedParams.Count -gt 0) {
        switch ($tssParams.Keys) {
            'Comment' { $getSecretBody.Add('comment', $Comment) }
            'ForceCheckIn' { $getSecretBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
            'TicketNumber' { $getSecretBody.Add('ticketNumber', $TicketNumber) }
            'TicketSystemId' { $getSecretBody.Add('ticketSystemId', $TicketSystemId) }
            'DoublelockPassword' {
                $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                $getSecretBody.Add('doubleLockPassword',$passwd)
            }
        }

        $uri = $uri, 'restricted' -join '/'
        $invokeParams.Uri = $uri
        $invokeParams.Method = 'POST'
        $invokeParams.Body = $getSecretBody | ConvertTo-Json
    } else {
        $uri = $uri
        $invokeParams.Uri = $uri
        $invokeParams.Method = 'GET'
    }

    Write-Verbose "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
    try {
        $restResponse = . $InvokeApi @invokeParams
    } catch {
        Write-Warning "Issue getting secret [$secret]"
        $err = $_
        . $ErrorHandling $err
    }

    if ($restResponse) {
        $restResponse
    }
}