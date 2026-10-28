using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.OauthExpiration
{
    public class Summary
    {
        public DateTime? ExpirationDate { get; set; }
        public string OAuthExpirationId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
