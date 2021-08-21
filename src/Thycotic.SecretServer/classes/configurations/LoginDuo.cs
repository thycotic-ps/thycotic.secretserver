using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LoginDuo
    {
        public string ApiHostname { get; set; }
        public bool Enable { get; set; }
        public string IntegrationKey { get; set; }
        public string SecretKey { get; set; }
        public bool UseRadiusUsername { get; set; }
    }
}