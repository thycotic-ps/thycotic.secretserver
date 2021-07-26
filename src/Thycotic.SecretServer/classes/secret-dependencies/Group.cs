using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Group
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int SiteId { get; set; }
        public string SiteName { get; set; }
        public int StatusFailedCount { get; set; }
        public int StatusNotRunCount { get; set; }
        public int StatusSuccessCount { get; set; }
        public int TotalDependencies { get; set; }
    }
}