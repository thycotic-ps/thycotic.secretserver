using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class Pinned
    {
        public bool? ActiveFilter { get; set; }
        public DateTime? CreateDate { get; set; }
        public string DisplayName { get; set; }
        public int FolderId { get; set; }
        public bool IncludeSubfolders { get; set; }
        public DateTime? LastViewed { get; set; }
        public string SearchText { get; set; }
        public int? SelectedFolderId { get; set; }
        public bool ShowCards { get; set; }
        public int? TemplateFilter { get; set; }
    }
}
