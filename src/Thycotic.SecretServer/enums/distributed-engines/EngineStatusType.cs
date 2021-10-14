using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum EngineStatusType
    {
        Activate,
        Deactivate,
        RemoveFromSite,
        Delete
    }
}