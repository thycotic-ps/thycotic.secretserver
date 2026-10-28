using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class EmailHeader
    {
        public bool Active { get; set; }
        public string HeaderName { get; set; }
        public string HeaderValue { get; set; }
        public string Id { get; set; }
    }
}
