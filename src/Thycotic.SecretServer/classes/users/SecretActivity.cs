using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class SecretActivity
    {
        public bool Active { get; set; }
        public int? FolderId { get; set; }
        public string FolderPath { get; set; }
        public string IpAddress { get; set; }
        public DateTime? LastDate { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public string SecretType { get; set; }
    }
}
