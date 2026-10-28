using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EraseRequests
{
    public class Secret
    {
        public int Id { get; set; }
        public int RequestId { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public DateTime? TimeErased { get; set; }
    }
}
