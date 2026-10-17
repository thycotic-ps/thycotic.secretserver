using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SecretSearchFilter
    {
        public bool AllowPartialMatch { get; set; }
        public bool ExpectSingle { get; set; }
        public int? FolderId { get; set; }
        public string FolderName { get; set; }
        public string FolderPath { get; set; }
        public bool IncludeSubfolders { get; set; }
        public bool IsActive { get; set; }
        public string SecretNameSearchPattern { get; set; }
        public int SecretSearchFilterId { get; set; }
        public int SecretTypeId { get; set; }
        public string SecretTypeName { get; set; }
    }
}
