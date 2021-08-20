using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Users
{
    public class User
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
        public UserSourceType ExternalUserSource { get; set; }
        public bool Fido2TwoFactor { get; set; }
        public int Id { get; set; }
        public bool IsApplicationAccount { get; set; }
        public bool IsEmailCopiedFromAD { get; set; }
        public bool IsEmailVerified { get; set; }
        public bool IsLockedOut { get; set; }
        public DateTime? LastLogin { get; set; }
        public DateTime? LastSessionActivity { get; set; }
        public string LockOutReason { get; set; }
        public string LockOutReasonDescription { get; set; }
        public int LoginFailures { get; set; }
        public bool MustVerifyEmail { get; set; }
        public bool OathTwoFactor { get; set; }
        public bool OathVerified { get; set; }
        public DateTime? PasswordLastChanged { get; set; }
        public bool RadiusTwoFactor { get; set; }
        public string RadiusUserName { get; set; }
        public DateTime? ResetSessionStarted { get; set; }
        public int SlackId { get; set; }
        public int TimeOptionId { get; set; }
        public bool TwoFactor { get; set; }
        public UnixAuthenticationType UnixAuthenticationMethod { get; set; }
        public int UserLcid { get; set; }
        public string Username { get; set; }
        public DateTime? VerifyEmailSentDate { get; set; }
    }
}