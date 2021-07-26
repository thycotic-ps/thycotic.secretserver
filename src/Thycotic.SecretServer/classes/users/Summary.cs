using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Summary
    {
        public DateTime? Created { get; set; }
        public string DisplayName { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string EmailAddress { get; set; }
        public bool Enabled { get; set; }
        public string ExternalUserSource { get; set; }
        public int Id { get; set; }
        public bool IsApplicationAccount { get; set; }
        public bool IsLockedOut { get; set; }
        public DateTime? LastLogin { get; set; }
        public int LoginFailures { get; set; }
        public string Username { get; set; }
        public string TwoFactorMethod { get; set; }
    }
}