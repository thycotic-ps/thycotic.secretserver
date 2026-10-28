using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.License
{
    public class ValidLicense
    {
        public bool IsLicensed { get; set; }
        public bool IsTrial { get; set; }
        public DateTime? LicenseEndDate { get; set; }
    }
}
