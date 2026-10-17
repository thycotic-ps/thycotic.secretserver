using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class AccountRuleMatch
    {
        public string AccountName { get; set; }
        public bool CanScanLocally { get; set; }
        public int ComputerAccountId { get; set; }
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public bool? HasLocalAdminRights { get; set; }
        public bool IsLocalAdministrator { get; set; }
        public DateTime? LastPolled { get; set; }
        public string OperatingSystem { get; set; }
        public string OrganizationUnitDisplayPath { get; set; }
        public string OrganizationUnitName { get; set; }
        public DateTime? PasswordLastSet { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
    }
}
