using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class AutomaticExport
    {
        public bool EnableAutoExport { get; set; }
        public bool ExportChildFolders { get; set; }
        public bool ExportFolderPaths { get; set; }
        public int ExportPasswordSecretId { get; set; }
        public string ExportPath { get; set; }
        public bool ExportTotpSettings { get; set; }
        public int FolderId { get; set; }
        public int FrequencyDays { get; set; }
        public DateTime? LastExported { get; set; }
        public int UserId { get; set; }
    }
}