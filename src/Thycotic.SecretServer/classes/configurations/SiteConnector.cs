using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SiteConnector
    {
        public bool Active { get; set; }
        public int SiteConnectorId { get; set; }
        public string SiteConnectorName {get;set;}
    }
}