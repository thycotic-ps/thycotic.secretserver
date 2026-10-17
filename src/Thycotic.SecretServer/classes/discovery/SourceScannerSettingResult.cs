using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceScannerSettingResult
    {
        public bool Success { get; set; }
        public string WarningMessage { get; set; }
    }
}
