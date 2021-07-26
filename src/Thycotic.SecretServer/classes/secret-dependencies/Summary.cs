using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Summary
    {
        public bool Enabled { get; set; }
        public int GroupId { get; set; }
        public int Id { get; set; }
        public string MachineName { get; set; }
        public int Order { get; set; }
        public string RunResult { get; set; }
        public int SecretId { get; set; }
        public string ServiceName { get; set; }
        public int TypeId { get; set; }
        public string TypeName { get; set; }
    }
}