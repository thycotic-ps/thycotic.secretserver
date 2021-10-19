using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.SecretExtensions
{
    public class Secret
    {
        public bool HasOwnerOrEditAccess { get; set; }
        public int Id { get; set; }
        public bool IsButtonBound { get; set; }
        public bool IsFavoriteSecret { get; set; }
        public bool IsSystemFolder { get; set; }
        public SecretMatchType MatchOrderType { get; set; }
        public string Name { get; set; }
        public string RedirectUrl { get; set; }
        public bool RequireComment { get; set; }
        public int ResultPriority { get; set; }
        public int SecretTypeId { get; set; }
        public string SecretUrl { get; set; }
        public bool ShouldRedirect { get; set; }
    }
}