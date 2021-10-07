using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class Diagnostic
    {
        public string ActiveDirectorySynchronizationThreadStatus { get; set; }
        public string BackboneClass { get; set; }
        public string BackboneType { get; set; }
        public string HsmCacheMapSize { get; set; }
        public string HsmTiming { get; set; }
        public string IsDomainController { get; set; }
        public string LastUpgrade { get; set; }
        public string LdapProvider { get; set; }
        public string MaxDegreeOfParallelism { get; set; }
        public string NetFxVersion { get; set; }
        public string OperatingSystem { get; set; }
        public string OperatingSystemArchitecture { get; set; }
        public string PhysicalMemory { get; set; }
        public string ProductVersion { get; set; }
        public string ProxyConfiguration { get; set; }
        public string ReadOnlyMode { get; set; }
        public string SearchIndexerThreadStatus { get; set; }
        public string SecretServerUrl { get; set; }
        public string ServerName { get; set; }
        public string ServerTime { get; set; }
        public string ServerTimeZone { get; set; }
        public string SqlDatabaseName { get; set; }
        public string SqlIsDatabaseReplicated { get; set; }
        public string SqlServerCollation { get; set; }
        public string SqlServerConnectionString { get; set; }
        public string SqlServerEdition { get; set; }
        public string SqlServerIsPublished { get; set; }
        public string SqlServerIsReplicationRunning { get; set; }
        public string SqlServerIsSubscribed { get; set; }
        public string SqlServerName { get; set; }
        public string SqlServerTime { get; set; }
        public string SqlServerVersion { get; set; }
        public string UpgradeAvailable { get; set; }
        public string UpgradeInProgress { get; set; }
        public string UpTime { get; set; }
    }
}