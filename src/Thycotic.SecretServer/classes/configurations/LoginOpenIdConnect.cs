using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LoginOpenIdConnect
    {
        public bool AddNewUsersToThycoticOne { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public bool Enable { get; set; }
        public string LogoutUrl { get; set; }
        public string ServerUrl { get; set; }
        public bool UseThycoticOneAuthAsDefault { get; set; }
    }
}