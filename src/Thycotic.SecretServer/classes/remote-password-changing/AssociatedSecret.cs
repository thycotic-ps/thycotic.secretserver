using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class AssociatedSecret
    {
        public int ParentSecretId { get; set; }
        public int Order { get; set; }
        public int AssociatedSecretId { get; set; }
        public string SecretName { get; set; }
        public string SecretTemplateName { get; set; }
        public string FolderName { get; set; }
    }
}