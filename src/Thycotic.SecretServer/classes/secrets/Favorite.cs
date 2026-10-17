using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Favorite
    {
        public int FolderId { get; set; }
        public string FolderPath { get; set; }
        public int Id { get; set; }
        public string SecretName { get; set; }
    }
}
