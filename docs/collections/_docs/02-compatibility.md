---
title: "Compatibility"
permalink: /docs/compatibility/
excerpt: "Module Compatibility"
last_modified_at: 2021-02-10T00:00:00-00:00
toc: false
---

The module will attempt to support version 10.0 and higher of Secret Server. Endpoints added in specific releases of Secret Server in the module are listed below for reference.

Each function listed below will include a test for the Secret Server version to warn of any potential failure with an endpoint.
{: .notice--info}

## Function List

Check the below table to determine what functions are available for you to use:

The Secret Server version listed is the minimum required to use the function.
{: .notice--info}

**Function Name**                                            | **Secret Server Version**     | **Details**
-------------------------------------------------------------| ------------------------------| :----------------
[New-TssReportSchedule][New-TssReportSchedule]               | **10.9.32**                   | Endpoint `POST /reports/schedules` added

[New-TssReportSchedule]:/thycotic.secretserver/commands/New-TssReportSchedule
