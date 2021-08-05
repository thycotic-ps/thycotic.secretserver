param(
    [Parameter(ValueFromPipeline,Position = 0,Mandatory)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession
)

process {
    $getInvokeParams = @{}
    switch ($TssSession.TokenType) {
        'WindowsAuth' {
            $getInvokeParams.UseDefaultCredential = $true
        }
        default {
            $getInvokeParams.AccessToken = $TssSession.AccessToken
        }
    }
    return $getInvokeParams
}