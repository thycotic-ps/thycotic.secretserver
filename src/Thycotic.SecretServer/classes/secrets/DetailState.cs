using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Secrets
{
    public class DetailState
    {
        public string[] Actions { get; set; }
        public string CheckedOutUserDisplayname { get; set; }
        public int CheckedOutUserId { get; set; }
        public int CheckOutIntervalMinutes { get; set; }
        public int CheckOutMinutesRemaining { get; set; }
        public int FolderId { get; set; }
        public string FolderName { get; set; }
        public int Id { get; set; }
        public bool IsActive { get; set; }
        public bool IsCheckedOut { get; set; }
        public bool IsCheckedOutByCurrentUser { get; set; }
        public bool PasswordChangePending { get; set; }
        public string Role { get; set; }
        public string SecretName { get; set; }
        public SecretStates SecretState { get; set; }

        public bool TestAction(string ActionName)
        {
            bool foundIt = false;
            foreach (string a in Actions)
            {
                if (a.Equals(ActionName, StringComparison.OrdinalIgnoreCase))
                {
                    foundIt = true;
                }
            }
            if (foundIt)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool TestState(string State)
        {
            var actualState = this.SecretState.ToString();
            if (actualState.Equals(State, StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}