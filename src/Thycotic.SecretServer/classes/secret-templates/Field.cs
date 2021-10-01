using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Field
    {
        public string Description { get; set; }
        public string DisplayName { get; set; }
        public int EditablePermission { get; set; }
        public TemplateEditRequiresOptions EditRequires { get; set; }
        public string FieldSlugName { get; set; }
        public string GeneratePasswordCharacterSet { get; set; }
        public int GeneratePasswordLength { get; set; }
        public bool HideOnView { get; set; }
        public int HistoryLength { get; set; }
        public bool IsExpirationField { get; set; }
        public bool IsFile { get; set; }
        public bool IsIndexable { get; set; }
        public bool IsNotes { get; set; }
        public bool IsPassword { get; set; }
        public bool IsRequired { get; set; }
        public bool IsUrl { get; set; }
        public bool IsList { get; set; }
        public TemplateFieldListType ListType { get; set; }
        public bool MustEncrypt { get; set; }
        public string Name { get; set; }
        public int PasswordRequirementId { get; set; }
        public int PasswordTypeFieldId { get; set; }
        public int SecretTemplateFieldId { get; set; }
        public int SortOrder { get; set; }
    }
}
