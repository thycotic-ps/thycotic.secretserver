using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Outputs verbose statement for commands using internal endpoints</para>
    /// <para type="description">Outputs verbose statement for commands using internal endpoints</para>
    /// </summary>
    [Cmdlet(VerbsCommunications.Write, "TssInternalNote")]
    public class WriteInternalNote : PSCmdlet
    {
        ///<summary>
        ///<para type="description">MyInvocation object from the calling command</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
        public InvocationInfo Invocation {get; set;}

        protected override void ProcessRecord()
        {
            var cmdName = Invocation.MyCommand;
            WriteVerbose("[" + cmdName + "] calling an internal endpoint.");
        }
    }
}