using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Common
{
    public class RequestStatus
    {
        public bool IsSuccessful { get; set; }
        public int StatusCode { get; set; }
        public string StatusDescription { get; set; }
        public string ResponseStatus { get; set; }
        public string ResponseUri { get; set; }
    }
}