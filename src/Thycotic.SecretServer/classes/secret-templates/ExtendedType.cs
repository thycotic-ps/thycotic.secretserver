using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class ExtendedType
    {
        public string ExtendedTypeDescription { get; set; }
        public int ExtendedTypeId { get; set; }
        public string ExtendedTypeName { get; set; }
    }
}
