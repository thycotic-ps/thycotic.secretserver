using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Dependency
    {
        public bool Active { get; set; }

        public bool ChildDependencyStatus { get; set; }
        public int ConditionDependencyId { get; set; }
        public string ConditionMode { get; set; }
        public DependencyTemplate DependencyTemplate { get; set; }
        public string Description { get; set; }
        public int GroupId { get; set; }
        public int Id { get; set; }
        public string LogMessage { get; set; }
        public int PrivilegedAccountSecretId { get; set; }
        public RunScript RunScript { get; set; }
        public bool SecretDependencyStatus { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public DependencySetting[] Settings { get; set; }
        public int SortOrder { get; set; }
        public int SshKeySecretId { get; set; }
        public string SshKeySecretName { get; set; }
        public int TypeId { get; set; }
        public string TypeName { get; set; }
    }
}