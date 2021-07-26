using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class CurrentUser
    {
        public MenuLink[] AdminLinks { get; set; }
        public int DateOptionId { get; set; }
        public string DisplayName { get; set; }
        public string EmailAddress { get; set; }
        public int Id { get; set; }
        public RolePermission[] Permissions { get; set; }
        public MenuLink[] ProfileLinks { get; set; }
        public int TimeOptionId { get; set; }
        public int UserLcid { get; set; }
        public string Username { get; set; }
        public string UserTheme { get; set; }
    }
}