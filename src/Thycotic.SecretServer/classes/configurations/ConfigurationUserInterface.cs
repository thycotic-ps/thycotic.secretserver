using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ConfigurationUserInterface
    {
        public DateTime? CustomBannerEndDate { get; set; }
        public DateTime? CustomBannerStartDate { get; set; }
        public string CustomBannerStyle { get; set; }
        public string CustomBannerText { get; set; }
        public string CustomBannerViewLink { get; set; }
        public string CustomBannerViewLinkText { get; set; }
        public string CustomLogoCollapsed { get; set; }
        public string CustomLogoCollapsedDark { get; set; }
        public string CustomLogoFullSize { get; set; }
        public string CustomLogoFullSizeDark { get; set; }
        public string CustomLogoLogin { get; set; }
        public string CustomLogoLoginDark { get; set; }
        public bool IsCustomBannerDismissable { get; set; }
        public bool ShowCustomBanner { get; set; }
    }
}
