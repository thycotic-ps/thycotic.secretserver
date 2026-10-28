using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Preference
    {
        public string SettingCode { get; set; }
        public int? SettingId { get; set; }
        public string SettingKey { get; set; }
        public string SettingName { get; set; }
        public string SettingValue { get; set; }
        public int UserId { get; set; }
        public int UserSettingId { get; set; }
    }
}
