using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DependencyChangers
{
    public class DependencyChanger
    {
        public bool Active { get; set; }
        public bool CanEdit { get; set; }
        public PSObject ChangeFailScript { get; set; }
        public PSObject ChangeSuccessScript { get; set; }
        public bool HasDependencies { get; set; }
        public bool HasImportRules { get; set; }
        public PSObject PasswordChangeScript { get; set; }
        public int? ScanItemTemplateId { get; set; }
        public string SecretDependencyChangerDescription { get; set; }
        public int SecretDependencyChangerId { get; set; }
        public string SecretDependencyChangerName { get; set; }
        public int SecretDependencyTypeId { get; set; }
        public object[] Settings { get; set; }
        public PSObject VerificationScript { get; set; }
    }
}
