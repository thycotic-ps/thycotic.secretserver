using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DirectoryAccountService
    {
        public bool CanLaunch { get; set; }
        public int? ComputerAccountId { get; set; }
        public string ComputerAccountName { get; set; }
        public int ComputerDependencyId { get; set; }
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public string DependencyName { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
    }
}
