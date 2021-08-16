using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Metadata
{
    public class FieldSectionSummary
    {
        public MetadataFieldSectionAction[] Actions { get; set; }
        public string MetadataFieldSectionDescription { get; set; }
        public int MetadataFieldSectionId { get; set; }
        public string MetadataFieldSectionName { get; set; }
        public bool RequiresAdministerMetadata { get; set; }
        public bool RequiresEntityEdit { get; set; }
    }
}