using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCiphers
{
    public class SshCipher
    {
        public string AlgorithmType { get; set; }
        public bool FipsCompliant { get; set; }
        public string Name { get; set; }
    }
}
