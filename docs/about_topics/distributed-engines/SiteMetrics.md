---
title: "SiteMetrics"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.DistributedEngines.SiteMetrics class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.DistributedEngines.SiteMetrics

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.DistributedEngines.SiteMetrics class represents the SiteMetic object returned by Secret Server endpoint GET /distributed-engines/sites
    List of Metrics for this site such as ConnectionStatusOffline, ConnectionStatusOnline, ActivationStatusPending, LostConnection, and more. Only returned on a search when IncludeSiteMetrics is true.

# CONSTRUCTORS
    new()

# PROPERTIES
    MetricDisplayName: string
        Metric Display Name

    MetricName: string
        Metric Name

    MetricValue: integer (int32)
        Metric Value

# METHODS

# RELATED LINKS:
    Search-TssDistributedEngineSite