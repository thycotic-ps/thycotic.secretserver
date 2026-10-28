using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Detail
    {
        public bool Active { get; set; }
        public int? DaysToShowAdExpiration { get; set; }
        public string Description { get; set; }
        public int? ExpirationChangeRequiredOnFieldId { get; set; }
        public int? ExpirationDays { get; set; }
        public string IconName { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string NamePattern { get; set; }
        public string NamePatternErrorMessage { get; set; }
        public int? OneTimePasswordDuration { get; set; }
        public bool OneTimePasswordEnabled { get; set; }
        public string OneTimePasswordHash { get; set; }
        public int? OneTimePasswordLength { get; set; }
        public string PermissionRequiredToEditPasswordChangeConfiguration { get; set; }
        public bool SaveAllNameHistory { get; set; }
        public int SecretCount { get; set; }
        public int? SecretNameHistoryLength { get; set; }
        public string SshKeyAlgorithm { get; set; }
        public string SshKeyFormat { get; set; }
        public string SshKeySize { get; set; }
        public string TicketSystemScriptArgs { get; set; }
        public bool ValidatePasswordRequirementsOnCreate { get; set; }
        public bool ValidatePasswordRequirementsOnEdit { get; set; }
    }
}
