using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Metadata
{
    public class Field
    {
        public DateTime? CreateDateTime { get; set; }
        public int CreateUserId { get; set; }
        public string CreateUserName { get; set; }
        public int ItemId { get; set; }
        public int MetadataFieldId { get; set; }
        public string MetadataFieldName { get; set; }
        public int MetadataFieldSectionId { get; set; }
        public string MetadataFieldSectionName { get; set; }
        public int MetadataFieldTypeId { get; set; }
        public string MetadataFieldTypeName { get; set; }
        public int MetadataItemDataId { get; set; }
        public string MetadataTypeName { get; set; }
        public int SortOrder { get; set; }
        public bool ValueBit { get; set; }
        public DateTime? ValueDateTime { get; set; }
        public int ValueInt { get; set; }
        public double ValueNumber { get; set; }
        public string ValueString { get; set; }
        public string ValueUserDisplayName { get; set; }
    }
}