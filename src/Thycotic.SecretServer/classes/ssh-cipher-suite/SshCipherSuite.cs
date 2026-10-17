using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCipherSuite
{
    public class SshCipherSuite
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string EncryptionAlgorithms { get; set; }
        public object[] EncryptionAlgorithmsFipsCompliance { get; set; }
        public string KeyExchangeAlgorithms { get; set; }
        public object[] KeyExchangeAlgorithmsFipsCompliance { get; set; }
        public string MacAlgorithms { get; set; }
        public object[] MacAlgorithmsFipsCompliance { get; set; }
        public string Name { get; set; }
        public string PublicKeyAlgorithms { get; set; }
        public object[] PublicKeyAlgorithmsFipsCompliance { get; set; }
        public string SshCipherSuiteConfigurationId { get; set; }
    }
}
