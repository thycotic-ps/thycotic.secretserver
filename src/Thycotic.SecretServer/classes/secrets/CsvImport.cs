using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class CsvImport
    {
        public string[] ImportErrors { get; set; }
        public object[] Results { get; set; }
        public string TaskIdentifier { get; set; }
    }
}
