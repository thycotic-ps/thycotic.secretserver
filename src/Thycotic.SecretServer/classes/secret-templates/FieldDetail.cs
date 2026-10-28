using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class FieldDetail
    {
        public bool Active { get; set; }
        public string DataType { get; set; }
        public string Description { get; set; }
        public object[] DropdownOptions { get; set; }
        public string EditRequiresPermission { get; set; }
        public bool ExposeForDisplay { get; set; }
        public int? HistoryLength { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public int? PasswordRequirement { get; set; }
        public bool Required { get; set; }
        public bool SaveAllHistory { get; set; }
        public bool Searchable { get; set; }
        public string SlugName { get; set; }
        public int SortOrder { get; set; }
        public bool ViewingRequiresEdit { get; set; }
    }
}
