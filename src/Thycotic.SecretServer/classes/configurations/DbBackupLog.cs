using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class DbBackupLog
    {
        public DateTime? BackupTime {get;set;}
        public string DisplayName {get;set;}
        public string Notes {get;set;}
        public bool Success {get;set;}
    }
}