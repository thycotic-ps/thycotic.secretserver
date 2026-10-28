using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SdkClientAudits
{
    public class Summary
    {
        public string Action { get; set; }
        public string CorrelationId { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int Id { get; set; }
        public string IpAddress { get; set; }
        public string Notes { get; set; }
        public int? SdkClientAccountId { get; set; }
        public string SdkClientAccountName { get; set; }
        public string UserDisplayName { get; set; }
        public int? UserId { get; set; }
    }
}
