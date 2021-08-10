using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Diagnostics
{
    public class SystemLog
    {
        public string CorrelationId { get; set; }
        public DateTime? DateRecorded { get; set; }
        public LogLevel LogLevel { get; set; }
        public string LogMessage { get; set; }
        public string MachineName { get; set; }
    }
}