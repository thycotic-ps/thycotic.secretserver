using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class UserInterface
    {
        public bool AllowUserToSelectTheme { get; set; }
        public string CustomLogoCollapsed { get; set; }
        public string CustomLogoFullSize { get; set; }
        public string DefaultClassicTheme { get; set; }
        public bool NewUiDefault { get; set; }
    }
}