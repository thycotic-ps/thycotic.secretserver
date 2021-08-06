using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPolicies
{
    public class SshCommandMenuGroupMap
    {
        public int GroupId {get;set;}
        public int SshCommandMenuId {get;set;}
    }
}