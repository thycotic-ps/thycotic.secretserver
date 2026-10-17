using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class UsersAndGroupsResult
    {
        public object[] Data { get; set; }
        public string Error { get; set; }
    }
}
