using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.CharacterSets
{
    public class CharacterSet
    {
        public string Abbreviation { get; set; }
        public bool Active { get; set; }
        public int CharacterSetId { get; set; }
        public string Description { get; set; }
        public bool IsStandard { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
    }
}
