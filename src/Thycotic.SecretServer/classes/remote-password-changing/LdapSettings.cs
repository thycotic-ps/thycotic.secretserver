using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class LdapSettings
    {
        public string AuthType { get; set; }
        public bool ConvertUserToDistinguishedName { get; set; }
        public int LdapConnectionSettingsId { get; set; }
        public bool LookupDistinguishedNameForConnection { get; set; }
        public bool LookupDistinguishedNameForReset { get; set; }
        public string PasswordAttribute { get; set; }
        public string PasswordEncodingType { get; set; }
        public int ProtocolVersion { get; set; }
        public bool SecureSocketLayer { get; set; }
        public string UserDistinguishedNameFormat { get; set; }
        public string UserNameAuthenticationFormat { get; set; }
        public string UserSearchFormat { get; set; }
    }
}
