using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DependencyChangers
{
    public class Script
    {
        public string DatabasePlaceholder { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string[] OdbcConnectionStringArgs { get; set; }
        public object[] Parameters { get; set; }
        public string PortPlaceholder { get; set; }
        public int ScriptType { get; set; }
    }
}
