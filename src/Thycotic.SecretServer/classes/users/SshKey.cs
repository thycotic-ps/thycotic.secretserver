using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class SshKey
    {
        public bool Active { get; set; }
        public DateTime? DateCreated { get; set; }
        public string Description { get; set; }
        public bool Expired { get; set; }
        public string Format { get; set; }
        public int Id { get; set; }
        public string PublicSshKey { get; set; }
    }
}
