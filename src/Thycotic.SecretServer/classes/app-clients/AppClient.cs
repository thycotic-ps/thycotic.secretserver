using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AppClients
{
    public class AppClient
    {
        public string ClientId { get; set; }
        public int Id { get; set; }
        public string RedirectUri { get; set; }
    }
}
