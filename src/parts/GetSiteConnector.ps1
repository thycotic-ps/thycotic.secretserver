param(
    [Parameter(Position = 0)]
    [PSCustomObject]$Object
)

[Thycotic.PowerShell.DistributedEngines.SiteConnector]@{
    Active                   = $Object.active.value
    Hostname                 = $Object.hostName.value
    Port                     = $Object.port.value
    QueueType                = $Object.queueType.value
    SharedAccessKeyName      = $Object.sharedAccessKeyName.value
    SharedAccessKeyValue     = $Object.sharedAccessKeyValue.value
    SiteConnectorId          = $Object.siteConnectorId
    SiteConnectorName        = $Object.siteConnectorName.value
    SslCertificateThumbprint = $Object.sslCertificateThumbprint.value
    UseSsl                   = $Object.useSsl.value
    Validated                = $Object.validated.value
}