using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class PasswordTypeAuth
    {
        public int Id { get; set; }
        public int PasswordTypeId { get; set; }
        public int CommandTypeCode { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Key { get; set; }
        public string Passphrase { get; set; }
    }
}
