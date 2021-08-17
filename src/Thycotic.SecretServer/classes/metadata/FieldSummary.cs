using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Metadata
{
    public class FieldSummary
    {
        public int DefaultSortOrder { get; set; }
        public MetadataFieldDataType FieldDataType {get;set;}
        public int MetadataFieldId { get; set; }
        public string MetadataFieldName { get; set; }
        public int MetadataFieldSectionId { get; set; }
        public string MetadataFieldSectionName { get; set; }
    }
}