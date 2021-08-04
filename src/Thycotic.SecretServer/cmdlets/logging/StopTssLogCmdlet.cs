using System;
using System.IO;
using System.Globalization;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using CsvHelper;
using CsvHelper.Configuration;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Adds footer to the end of the log file.</para>
    /// <para type="description">Appends a footer to the log file to "close" the logging process. This should be called at the end of your script or workflow.</para>
    /// </summary>
    [Cmdlet(VerbsLifecycle.Stop, "TssLog", HelpUri = "https://thycotic-ps.github.io/thycotic.secretserver/commands/Stop-TssLog")]
    public class StopLogCmdlet : PSCmdlet
    {
        /// <summary>
        /// <para type="description">Full file path to the log file</para>
        /// </summary>
        [Parameter(Position = 0)]
        public string LogFilePath { get; set; }

        /// <summary>
        /// <para type="description">Format of log to generate, default to LOG; allowed: log, csv</para>
        /// </summary>
        [Parameter(Position = 1)]
        [ValidateSet("log", "csv")]
        public string LogFormat { get; set; } = "log";

        protected override void EndProcessing()
        {
            // check if path is valid
            if (!File.Exists(LogFilePath))
            {
                // throw exception could find file
                throw new System.Exception("Could not find file: " + LogFilePath);
            }

            // get current timestamp
            var currentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

            if (LogFormat.Equals("log"))
            {
                // write footer to the file
                using (StreamWriter sw = File.AppendText(LogFilePath))
                {
                    // write line with timestamp included
                    sw.WriteLine(currentTime + ";INFO;");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;Finished processing at " + "[" + currentTime + "]");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                }
            }

            if (LogFormat.Equals("csv"))
            {
                var data = new List<msgCsv>
                {
                    new msgCsv { MsgTime = currentTime, MsgType = "INFO", MsgText = "Finished processing at " + "[" + currentTime + "]" }
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
