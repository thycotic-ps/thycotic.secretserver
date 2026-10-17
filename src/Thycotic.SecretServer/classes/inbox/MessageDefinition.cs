using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class MessageDefinition
    {
        public string MessageName { get; set; }
        public string MessageNameLocalized { get; set; }
        public object[] Properties { get; set; }
    }
}
