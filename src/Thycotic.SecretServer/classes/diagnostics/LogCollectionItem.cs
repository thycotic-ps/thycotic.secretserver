using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class LogCollectionItem
    {
        public int LogCollectionId { get; set; }
        public string Name { get; set; }
        public int SourceId { get; set; }
        public string SourceType { get; set; }
        public string Status { get; set; }
    }
}