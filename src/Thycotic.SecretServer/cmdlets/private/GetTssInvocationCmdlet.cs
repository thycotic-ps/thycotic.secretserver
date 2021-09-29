using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Internal cmdlet to output the inputs for a given command</para>
    /// <para type="description">Internal cmdlet to output the inputs for a given command</para>
    /// </summary>
    [Cmdlet(VerbsCommon.Get, "TssInvocation")]
    public class GetInvocationCmdlet : PSCmdlet
    {
        ///<summary>
        ///<para type="description">MyInvocation object from the calling command</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
        public InvocationInfo Invocation {get; set;}

        protected override void ProcessRecord()
        {
            var cmdText = Invocation.InvocationName;
            var paramKeys = Invocation.BoundParameters.Keys;
            string paramValue = null;
            foreach (var p in paramKeys)
            {
                switch (Invocation.BoundParameters[p].GetType().ToString())
                {
                    case "Thycotic.PowerShell.Authentication.Session":
                        paramValue = "TssSessionObject";
                        break;
                    case "System.Management.Automation.PSObject":
                        paramValue = "Object";
                        break;
                    case "System.Int32[]":
                        paramValue = Invocation.BoundParameters[p].ToString();
                        break;
                    case "System.String":
                        paramValue = Invocation.BoundParameters[p].ToString();
                        break;
                    case "System.Management.Automation.SwitchParameter":
                        paramValue = Invocation.BoundParameters[p].ToString();
                        break;
                }
                cmdText = cmdText + " -" + p + ":" + paramValue;
            }
            WriteVerbose("Command invocation: " + cmdText);
        }
    }
}