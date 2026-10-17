using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class BulkExport
    {
        public object[] Errors { get; set; }
        public string ExportedSecretsFileText { get; set; }
        public string ExportJobId { get; set; }
        public string FileType { get; set; }
        public int? SecretsCount { get; set; }
        public string Status { get; set; }
        public string Tracking { get; set; }
    }
}
