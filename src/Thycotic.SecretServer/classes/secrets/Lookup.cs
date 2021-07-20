using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Lookup
    {
        public int Id { get; set; }
        public int FolderId { get; set; }
        public int SecretTemplateId { get; set; }
        public string SecretName { get; set; }
    }
}