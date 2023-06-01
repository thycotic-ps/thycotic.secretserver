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
        public string CustomBannerStyle { get; set; }
        public string CustomBannerText{ get; set; }
        public string CustomBannerViewLink{ get; set; }
        public string CustomBannerViewLinkText{ get; set; }
        public string CustomLogoCollapsedDark{ get; set; }
        public string CustomLogoFullSizeDark{ get; set; }
        public string CustomLogoLogin{ get; set; }
        public string CustomLogoLoginDark{ get; set; }
        public bool disableLegacyUi{ get; set; }
        public bool isCustomBannerDismissable{ get; set; }
        public bool showCustomBanner{ get; set; }
    }
}