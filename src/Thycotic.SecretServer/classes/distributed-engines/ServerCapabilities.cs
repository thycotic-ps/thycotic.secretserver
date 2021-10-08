using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class ServerCapabilities
    {
        public int DotNetRelease { get; set; }
        public string DotNetVersion { get; set; }
        public string OperatingSystemVersion { get; set; }
        public string OperatingSystemPlatform { get; set; }
        public string OperatingSystemServicePack { get; set; }
        public string Architecture { get; set; }
        public string InstallationPath { get; set; }
        public string ComputerName { get; set; }
        public int ProcessorCount { get; set; }
        public string PowerShellVersion { get; set; }
        public string SystemDirectory { get; set; }
        public string ServiceAccountName { get; set; }
        public bool ServiceAccountCanRestartService { get; set; }
        public DateTime? LastModifiedDate { get; set; }
    }
}