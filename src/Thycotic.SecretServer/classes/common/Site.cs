using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Common
{
    public class Site
    {
        public bool Active { get; set; }
        public int SiteId { get; set; }
        public string SiteName { get; set; }
    }
}