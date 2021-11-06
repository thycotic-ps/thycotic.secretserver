using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Common
{
    public class Delete
    {
        public string Id { get; set; }
        public string ObjectType { get; set; }
        public string[] ResponseCodes { get; set; }
    }
}