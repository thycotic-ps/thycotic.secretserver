using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretHooks
{
    public class Parameter
    {
        public string ParameterName { get; set; }
        public string ParameterValue { get; set; }
        public string ParameterType { get; set; } = "Literal";
    }
}