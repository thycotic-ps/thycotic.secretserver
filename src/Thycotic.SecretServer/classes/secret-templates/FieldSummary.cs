using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class FieldSummary
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string EditRequiresPermission { get; set; }
        public bool ExposeForDisplay { get; set; }
        public int HistoryLength { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public bool Required { get; set; }
        public bool Searchable { get; set; }
        public string SlugName { get; set; }
        public int SortOrder { get; set; }
        public string Type { get; set; }
        public bool ViewingRequiresEdit { get; set; }
    }
}
