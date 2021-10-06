using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Summary
    {
        public bool Active { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public int PasswordTypeId { get; set; }
        public int SecretCount { get; set; }
    }
}