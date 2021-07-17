using System;
using System.Text;
using System.IO;
using System.Globalization;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using CsvHelper;
using CsvHelper.Configuration;

namespace Thycotic.SecretServer
{
    /// <summary>
    /// <para type="synopsis">Writes message to the log file.</para>
    /// <para type="description">Writes the message provided by appending.</para>
    /// <para type="description">This is used during your script process or workflow to add messages based on the MessageType desired (error, warning, info, etc.).</para>
    /// </summary>
    [Cmdlet(VerbsCommunications.Write, "Log", HelpUri = "http://thycotic-ps.github.io/thycotic.secretserver/commands/Write-TssLog")]
    public class WriteLogCmdlet : PSCmdlet
    {
        /// <summary>
        /// <para type="description">Full file path to the log file</para>
        /// </summary>
        [Parameter(Mandatory = true, Position = 0)]
        public string LogFilePath { get; set; }

        /// <summary>
        /// <para type="description">Format of log to generate, default to LOG; allowed: log, csv</para>
        /// </summary>
        [Parameter(Mandatory = true, Position = 1)]
        [ValidateSet("log", "csv")]
        public string LogFormat { get; set; } = "log";

        /// <summary>
        /// <para type="description">Message type to write to the log, default INFO (allowed INFO, WARNING, ERROR, FATAL)</para>
        /// </summary>
        [Parameter(Mandatory = true, Position = 2)]
        [ValidateSet("INFO", "WARNING", "ERROR", "FATAL")]
        public string MessageType { get; set; } = "INFO";

        /// <summary>
        /// <para type="description">Message to append to the log</para>
        /// </summary>
        [Parameter(ParameterSetName = "message", Position = 3)]
        public string Message { get; set; }

        /// <summary>
        /// <para type="description">Switch to indicate a divider is appended to the log file.</para>
        /// </summary>
        [Parameter(ParameterSetName = "divider", Position = 4)]
        public SwitchParameter Divider { get; set; }

        /// <summary>
        /// <para type="description">The character to use for the divider, autogenerates 120-character divider and append to the log file. Defaults to plus-sign (+)</para>
        /// </summary>
        [Parameter(ParameterSetName = "divider", Position = 5)]
        public string DividerCharacter { get; set; } = "+";


        protected override void EndProcessing()
        {
            // check if path is valid
            if (!File.Exists(LogFilePath))
            {
                // throw exception could not remove file
                throw new System.Exception("Could not find file: " + LogFilePath);
            }

            // get current timestamp
            var currentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

            if (LogFormat.Equals("log"))
            {
                if (this.MyInvocation.BoundParameters.ContainsKey("Divider"))
                {
                    var repeatingDivider = new StringBuilder(DividerCharacter, 120);

                    // write message to file
                    using (StreamWriter sw = File.AppendText(LogFilePath))
                    {
                        // write line with timestamp included
                        sw.WriteLine(currentTime + ";" + MessageType + ";" + repeatingDivider);
                    }
                }
                else
                {
                    using (StreamWriter sw = File.AppendText(LogFilePath))
                    {
                        // write line with timestamp included
                        sw.WriteLine(currentTime + ";" + MessageType + ";" + MessageType);
                    }
                }

            }

            if (LogFormat.Equals("csv"))
            {
                if (this.MyInvocation.BoundParameters.ContainsKey("Divider"))
                {
                    // throw exception could not remove file
                    throw new System.Exception("Log Type of CSV does not support using a Divider");
                }

                var data = new List<msgCsv>
                {
                    new msgCsv { MsgTime = currentTime, MsgType = MessageType, MsgText = Message }
                };

                var config = new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    Delimiter = ",",
                    HasHeaderRecord = false,
                };

                using (var stream = File.Open(LogFilePath, FileMode.Append))
                using (var writer = new StreamWriter(stream))
                using (var csvWriter = new CsvWriter(writer, CultureInfo.InvariantCulture))
                {
                    csvWriter.WriteRecords(data);
                }
            }
        }

        public class msgCsv
        {
            public string MsgTime { get; set; }
            public string MsgType { get; set; }
            public string MsgText { get; set; }
        }
    }
}
