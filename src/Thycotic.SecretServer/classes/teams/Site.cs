using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Teams
{
    public class Site
    {
        public int SiteId { get; set; }
        public string SiteName { get; set; }
        public int TeamId { get; set; }
        public int TeamSiteMapId { get; set; }
    }
}
