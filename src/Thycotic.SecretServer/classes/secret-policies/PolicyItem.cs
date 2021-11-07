using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.SecretPolicies
{
    public class PolicyItem
    {
        public string Description { get; set; }
        public SecretPolicyItem Name { get; set; }
        public int ParentSecretPolicyItemId { get; set; }
        public SecretPolicyApplyType PolicyApplyType { get; set; }
        public int SecretPolicyItemId { get; set; }
        public int SecretPolicyItemMapId { get; set; }
        public string SectionName { get; set; }
        public SshCommandMenuGroupMap[] SshCommandMenuGroupMaps { get; set; }
        public UserGroupMap[] UserGroupMaps { get; set; }
        public bool ValueBool { get; set; }
        public int ValueInt { get; set; }
        public int ValueSecretId { get; set; }
        public string ValueString { get; set; }
        public SecretPolicyValueType ValueType { get; set; }
    }
}