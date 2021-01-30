class TssGroupSummary {
    # Created date
    [datetime]$Created
    # Domain Directory Group GUID
    [string]$DomainGuid
    # Directory Domain ID
    [int]$DomainId
    # Directory Domain Name
    [string]$DomainName
    # Group is Active
    [boolean]$Enabled
    # Group ID
    [int]$Id
    # Number of members
    [int]$MemberCount
    # Group Name
    [string]$Name
    # Group is synchronized with Active Directory
    [boolean]$Synchronized
    # Active Directory Sync will pull members for domain groups
    [boolean]$SynchronizeNow
}