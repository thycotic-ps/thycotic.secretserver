using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SdkClientAccounts
{
    public class Summary
    {
        public string ClientId { get; set; }
        public string Details { get; set; }
        public int Id { get; set; }
        public string IpAddress { get; set; }
        public string Name { get; set; }
        public string UserDisplayName { get; set; }
        public int? UserId { get; set; }
    }
}
