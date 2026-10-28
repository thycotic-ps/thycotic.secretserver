using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class ExtendedSearchDetail
    {
        public bool HasLaunchers { get; set; }
        public bool IsFavorite { get; set; }
        public DateTime? LastAccessed { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public int TotalSecretViews { get; set; }
    }
}
