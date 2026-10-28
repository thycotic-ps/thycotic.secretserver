using System.Collections.Generic;
using System.Management.Automation;

namespace Thycotic.SecretServer.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Confirm, "TssDangerousOperation")]
    [OutputType(typeof(bool))]
    public class ConfirmDangerousOperationCmdlet : PSCmdlet
    {
        private const string ProceedCaption = "OK to proceed?";

        private static readonly Dictionary<string, string> DangerMessages = new Dictionary<string, string>
        {
            ["SupportOnlySetting"] = "These settings are only to be updated by Delinea Support. Modifying them will have a major impact on Secret Server",
            ["NodeDatabaseConfiguration"] = "The database configuration is set per web node. This change applies only to the node that receives the request, so the session must point directly at that node, not at a load-balanced address.",
            ["PlatformAccess"] = "Changing the Platform configuration, unified mode or Platform user mappings can cause loss of access to the Delinea Platform.",
            ["EncryptionKeys"] = "This changes how Secret Server encrypts its data. A wrong or interrupted change can leave Secret Server or its secrets unreadable."
        };

        [Parameter(Mandatory = true, Position = 0)]
        public PSCmdlet Caller { get; set; }

        [Parameter(Mandatory = true, Position = 1)]
        [ValidateSet("SupportOnlySetting", "NodeDatabaseConfiguration", "PlatformAccess", "EncryptionKeys")]
        public string Danger { get; set; }

        [Parameter(Mandatory = true, Position = 2)]
        public string Target { get; set; }

        [Parameter(Mandatory = true, Position = 3)]
        public string Action { get; set; }

        [Parameter]
        public SwitchParameter Force { get; set; }

        protected override void ProcessRecord()
        {
            var message = DangerMessages[Danger];
            WriteWarning(message);
            WriteObject(IsApproved(message));
        }

        private bool IsApproved(string message)
        {
            if (IsWhatIfRequested())
            {
                return Caller.ShouldProcess(Target, Action);
            }
            if (!Force && !Caller.ShouldContinue(message, ProceedCaption))
            {
                return false;
            }
            if (Force && !IsCallerSwitchBoundOn("Confirm"))
            {
                return true;
            }
            return Caller.ShouldProcess(Target, Action);
        }

        private bool IsWhatIfRequested()
        {
            if (Caller.MyInvocation.BoundParameters.ContainsKey("WhatIf"))
            {
                return IsCallerSwitchBoundOn("WhatIf");
            }
            return LanguagePrimitives.IsTrue(GetVariableValue("WhatIfPreference"));
        }

        private bool IsCallerSwitchBoundOn(string name)
        {
            return Caller.MyInvocation.BoundParameters.TryGetValue(name, out var value) && LanguagePrimitives.IsTrue(value);
        }
    }
}
