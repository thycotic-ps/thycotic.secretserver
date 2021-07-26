using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Lookup
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
    }
}