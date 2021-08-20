using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class Subscriber
    {
        public string DisplayName { get; set; }
        public int GroupId { get; set; }
    }
}