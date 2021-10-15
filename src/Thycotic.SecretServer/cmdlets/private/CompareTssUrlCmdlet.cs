using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Comparing Secret Server URL to SSC domains</para>
    /// <para type="description">Use with commands that are only supported against SSC subscriptions. Will return true if it is, false if it can't match to any domain.</para>
    /// </summary>
    [Cmdlet(VerbsData.Compare, "TssUrl")]
    public class NameCmdlet : PSCmdlet
    {
        ///<summary>
        ///<para type="description">TssSession object created by New-TssSession for authentication</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
        public Thycotic.PowerShell.Authentication.Session TssSession {get; set;}

        protected override void ProcessRecord()
        {
            WriteVerbose("Verifying SecretServer URL is not a Secret Server Subscription");
            if (!TssSession.SecretServer.Contains("secretservercloud"))
            {
                WriteVerbose("SecretServer URL [" + TssSession.SecretServer + "] is not part of Secret Server Cloud domain");
                throw new System.Exception("This command is only supported with Secret Server Cloud");
            }
            else
            {
                WriteVerbose("Secret Server Cloud URL detected");
            }
        }
    }
}