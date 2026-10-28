using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Preview
    {
        public string ErrorMessage { get; set; }
        public bool Favorite { get; set; }
        public bool HasLauncher { get; set; }
        public int Id { get; set; }
        public bool IsTotpEnabled { get; set; }
        public object[] Items { get; set; }
        public object[] Launchers { get; set; }
        public string SecretName { get; set; }
        public bool ShowViewButton { get; set; }
        public bool UserCanEdit { get; set; }
        public bool UserCanShare { get; set; }
        public bool UserCanViewAudit { get; set; }
        public bool UsesClickOnce { get; set; }
    }
}
