using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum ScriptType
    {
        PowerShell = 1,
        SQL = 2,
        SSH = 3
    }
}