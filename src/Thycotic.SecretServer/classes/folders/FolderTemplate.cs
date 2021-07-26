using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class FolderTemplate
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int SecretCount { get; set; }
        public bool Active { get; set; }
    }
}