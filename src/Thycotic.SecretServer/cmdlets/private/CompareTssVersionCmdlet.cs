using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Comparing Secret Server version to supported version for a given command</para>
    /// <para type="description">Comparing Secret Server version to supported version for a given command</para>
    /// </summary>
    [Cmdlet(VerbsData.Compare, "TssVersion")]
    public class CompareVersionCmdlet : PSCmdlet
    {
        ///<summary>
        ///<para type="description">TssSession object created by New-TssSession for authentication</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 0)]
        public Thycotic.PowerShell.Authentication.Session TssSession {get; set;}

        ///<summary>
        ///<para type="description">Minimum supported version for the command</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 1)]
        public string MinimumSupported { get; set; }

        ///<summary>
        ///<para type="description">Invocation from calling command</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 2)]
        public InvocationInfo Invocation { get; set; }

        protected override void ProcessRecord()
        {
            var ignoreVersion = SessionState.PSVariable.GetValue("ignoreVersion");
            var tssIgnoreVersionCheck = SessionState.PSVariable.GetValue("tss_ignoreversioncheck");
            if ((!Convert.ToBoolean(ignoreVersion) || !Convert.ToBoolean(tssIgnoreVersionCheck)) && !String.IsNullOrEmpty(TssSession.SecretServerVersion))
            {
                var minSupproted = new Version(MinimumSupported);
                string sourceCommand = Invocation.MyCommand.ToString();
                var currentVersion = new Version(TssSession.SecretServerVersion.ToString());
                var result = currentVersion.CompareTo(minSupproted);

                if (result < 0)
                {
                    WriteVerbose("[" + sourceCommand + "]: Detected version, [" + currentVersion + "], lower than command's supported version of [" + minSupproted + "].");
                    return;
                }
            }
        }
    }
}