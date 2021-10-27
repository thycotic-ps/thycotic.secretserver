using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretPermissions
    {
        List = 1,
        View = 2,
        Edit = 3,
        Owner = 4
    }
}