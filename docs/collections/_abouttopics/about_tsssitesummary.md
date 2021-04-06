---
category: distributed-engines, sites
title: "TssSiteSummary"
last_modified_at: 2021-04-05T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSiteSummary class in the Thycotic.SecretServer module

# CLASS
    TssSiteSummary

# INHERITANCE
    None

# DESCRIPTION
    The TssSiteSummary class represents the SiteSummaryModel object returned by Secret Server endpoint GET /distributed-engines/sites

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Is Site Active

    IsLocal: boolean
        Indicates if this site is the local site that cannot have engines assigned

    LastActivity: string (date-time)
        Last Date of Activity of Site

    NumEnginesMissingNetFramework: integer (int32)
        The number of engines on the site missing the minimum DotNet Framework

    OfflineEngineCount: integer (int32)
        Offline Engine Count of Site

    OnlineEngineCount: integer (int32)
        Online Engine Count of Site

    SiteId: integer (int32)
        Id of Site

    SiteMetrics: [TssSiteMetric[]]
        List of Metrics for this site such as ConnectionStatusOffline, ConnectionStatusOnline, ActivationStatusPending, LostConnection, and more. Only returned on a search when IncludeSiteMetrics is true.

    SiteName: string
        Name of Site

# METHODS

# RELATED LINKS:
    Search-TssDistributedEngineSite