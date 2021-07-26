using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Items
    {
        public string FieldDescription { get; set; }
        public int FieldId { get; set; }
        public string FieldName { get; set; }
        public int FileAttachmentId { get; set; }
        public string Filename { get; set; }
        public bool IsFile { get; set; }
        public bool IsNotes { get; set; }
        public bool IsPassword { get; set; }
        public bool IsList { get; set; }
        public string ListType { get; set; }
        public int ItemId { get; set; }
        public string ItemValue { get; set; }
        public string Slug { get; set; }
    }
}