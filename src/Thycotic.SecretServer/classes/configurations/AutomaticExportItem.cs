using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class AutomaticExportItem
    {
        public int AutoExportConfigurationId {get;set;}
        public bool CanDownload {get;set;}
        public string Filename {get;set;}
        public int Id {get;set;}
        public DateTime? StorageDate {get;set;}
    }
}