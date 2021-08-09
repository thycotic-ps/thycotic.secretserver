using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Setting
    {
        public bool Active { get; set; }
        public bool CanEdit { get; set; }
        public bool CanEditValue { get; set; }
        public Setting[] ChildSettings { get; set; }
        public string DefaultValue { get; set; }
        public string DisplayName { get; set; }
        public int Id { get; set; }
        public bool isVisibile { get; set; }
        public int ParentSettingId { get; set; }
        public string RegexValidation { get; set; }
        public string SettingName { get; set; }
        public int SettingSectionId { get; set; }
        public int SettingType { get; set; }
        public int SubSettingSectionId { get; set; }
    }
}