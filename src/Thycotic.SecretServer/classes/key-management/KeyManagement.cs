using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.KeyManagement
{
    public class KeyManagement
    {
        public string AwsKmsAccessKeyId { get; set; }
        public string AwsKmsKeyArn { get; set; }
        public string AwsKmsKeyId { get; set; }
        public string AwsKmsSecretAccessKey { get; set; }
        public string AzureManagedHsmKeyUrl { get; set; }
        public string AzureManagedHsmPrincipalId { get; set; }
        public string AzureManagedHsmPrincipalSecret { get; set; }
        public string AzureManagedHsmTenantId { get; set; }
        public int KeyManagementConfigId { get; set; }
        public int KeyManagementTypeId { get; set; }
        public string KeyManagementTypeName { get; set; }
    }
}
