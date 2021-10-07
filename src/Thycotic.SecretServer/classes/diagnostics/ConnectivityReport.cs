using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class ConnectivityReport
    {
        public string Address {get; set;}
        public bool IsSuccess {get;set;}
    }
}