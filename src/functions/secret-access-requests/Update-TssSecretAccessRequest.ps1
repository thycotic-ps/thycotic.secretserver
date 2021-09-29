function Update-TssSecretAccessRequest {
    <#
    .SYNOPSIS
    Update a Access Request for the current user

    .DESCRIPTION
    Update a Access Request for the current user

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Update-TssSecretAccessRequest -TssSession $session -RequestId

    Update ...

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Update-TssSecretAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Update-TssSecretAccessRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Access Request Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretAccessRequestId')]
        [int]
        $RequestId,

        # Set the status desired (Pending, Approved, Denied, Canceled)
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.SecretAccessStatus]
        $Status,

        # Start date, defaults to now (current datetime)
        [string]
        $StartDate = [datetime]::Now,

        # Expiration date
        [string]
        $ExpirationDate,

        # Response or comment
        [string]
        $Response
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-access-requests' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            if ($Status -eq 'Denied' -and (-not $updateParams.ContainsKey('Response'))) {
                Write-Warning 'A response is required when request has been denied'
                return
            }
            if ($Status -eq 'Approved' -and (-not $updateParams.ContainsKey('ExpirationDate'))) {
                Write-Warning 'A start and expiration date must be provided when Approving the request.'
                return
            }
            $updateBody = @{}
            $updateBody.Add('startDate',[datetime]$StartDate)
            switch ($updateParams.Keys){
                'RequestId' { $updateBody.Add('secretAccessRequestId',$RequestId) }
                'Status' { $updateBody.Add('status',[string]$Status) }
                'ExpirationDate' { $updateBody.Add('expirationDate',[datetime]$ExpirationDate) }
                'Response' { $updateBody.Add('responseComment',$Response) }
            }
            $invokeParams.Body = $updateBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("Secret Access Request: $RequestId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating Secret Access Request [$RequestId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    Write-Verbose "Secret Access Request [$RequestId] updated successfully"
                } else {
                    Write-Warning "Secret Access Request [$RequestId] was not updated, see previous output for errors"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}