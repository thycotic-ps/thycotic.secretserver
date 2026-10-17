using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Stub
    {
        public DateTime? AdAccountExpires { get; set; }
        public string AdGuid { get; set; }
        public DateTime? Created { get; set; }
        public int DateOptionId { get; set; }
        public string DisplayName { get; set; }
        public int DomainId { get; set; }
        public bool DuoTwoFactor { get; set; }
        public string EmailAddress { get; set; }
        public bool Enabled { get; set; }
        public string ExternalUserSource { get; set; }
        public bool Fido2TwoFactor { get; set; }
        public int Id { get; set; }
        public object[] IpAddressRestrictions { get; set; }
        public bool IsApplicationAccount { get; set; }
        public bool IsEmailCopiedFromAD { get; set; }
        public bool IsEmailVerified { get; set; }
        public bool IsLockedOut { get; set; }
        public DateTime? LastLockout { get; set; }
        public DateTime? LastLogin { get; set; }
        public DateTime? LastSessionActivity { get; set; }
        public string LockOutReason { get; set; }
        public string LockOutReasonDescription { get; set; }
        public int LoginFailures { get; set; }
        public bool MustVerifyEmail { get; set; }
        public bool OathTwoFactor { get; set; }
        public bool OathVerified { get; set; }
        public DateTime? PasswordLastChanged { get; set; }
        public int PersonalGroupId { get; set; }
        public string PlatformIntegrationType { get; set; }
        public string PlatformMembershipType { get; set; }
        public bool PlatformServiceUser { get; set; }
        public bool RadiusTwoFactor { get; set; }
        public string RadiusUserName { get; set; }
        public DateTime? ResetSessionStarted { get; set; }
        public string SlackId { get; set; }
        public int TimeOptionId { get; set; }
        public bool TwoFactor { get; set; }
        public string UnixAuthenticationMethod { get; set; }
        public int UserLcid { get; set; }
        public string UserName { get; set; }
        public string UserPrincipalName { get; set; }
        public DateTime? VerifyEmailSentDate { get; set; }
    }
}
