using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class Parameter
    {
        public string Name { get; set; }
        public object[] Value { get; set; }
        public string ValueDisplayName { get; set; }
        public string VariableName { get; set; }
    }
}