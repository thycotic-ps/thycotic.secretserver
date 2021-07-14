using System;
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
    /// <para type="synopsis">Creates an initial log file with a header.</para>
    /// <para type="description">Creates a log file (will delete if the name already exists) and adds a formatted header.</para>
    /// </summary>
    [Cmdlet(VerbsLifecycle.Start, "Log", HelpUri = "https://thycotic-ps.github.io/thycotic.secretserver/commands/Start-TssLog")]
    public class StartLogCmdlet : PSCmdlet
    {
        /// <summary>
        /// <para type="description">Full file path to the log file to create</para>
        /// </summary>
        [Parameter(Position = 0)]
        public string LogFilePath { get; set; }

        /// <summary>
        /// <para type="description">Format of log to generate, default to LOG; allowed: log, csv</para>
        /// </summary>
        [Parameter(Position = 1)]
        [ValidateSet("log", "csv")]
        public string LogFormat { get; set; }

        /// <summary>
        /// <para type="description">Script Version to include as reference in the log file header</para>
        /// </summary>
        [Parameter(Position = 2)]
        public string ScriptVersion { get; set; }

        protected override void EndProcessing()
        {
            // check if path is valid
            if (!File.Exists(LogFilePath))
            {
                // remove file if exists
                if (File.Exists(LogFilePath))
                {
                    // try to remove file if exists
                    try
                    {
                        File.Delete(LogFilePath);
                    }
                    catch
                    {
                        // throw exception could not remove file
                        throw new System.Exception("Could not remove file: " + LogFilePath);
                    }
                }
            }

            // get current timestamp
            var currentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

            if (LogFormat.Equals("log"))
            {
                // write initial header to the file
                using (StreamWriter sw = File.AppendText(LogFilePath))
                {
                    // write line with timestamp included
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;..######..########..######..########..########.########.....######..########.########..##.....##.########.########.");
                    sw.WriteLine(currentTime + ";INFO;.##....##.##.......##....##.##.....##.##..........##.......##....##.##.......##.....##.##.....##.##.......##.....##");
                    sw.WriteLine(currentTime + ";INFO;.##.......##.......##.......##.....##.##..........##.......##.......##.......##.....##.##.....##.##.......##.....##");
                    sw.WriteLine(currentTime + ";INFO;..######..######...##.......########..######......##........######..######...########..##.....##.######...########.");
                    sw.WriteLine(currentTime + ";INFO;.......##.##.......##.......##...##...##..........##.............##.##.......##...##....##...##..##.......##...##..");
                    sw.WriteLine(currentTime + ";INFO;.##....##.##.......##....##.##....##..##..........##.......##....##.##.......##....##....##.##...##.......##....##.");
                    sw.WriteLine(currentTime + ";INFO;..######..########..######..##.....##.########....##........######..########.##.....##....###....########.##.....##");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;Started processing at" + "[" + currentTime + "]");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;");
                    sw.WriteLine(currentTime + ";INFO;Module Version:     [$((Get-Module Thycotic.SecretServer).Version.ToString())]");
                    sw.WriteLine(currentTime + ";INFO;PowerShell Version: [$($PSVersionTable.PSVersion.ToString())]");
                    sw.WriteLine(currentTime + ";INFO;OS Version:         [$($PSVersionTable.OS.ToString())]");
                    sw.WriteLine(currentTime + ";INFO;Script version:     [" + ScriptVersion + "].");
                    sw.WriteLine(currentTime + ";INFO;");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;************************************************************************************************************************");
                    sw.WriteLine(currentTime + ";INFO;");
                }
            }
            if (LogFormat.Equals("csv"))
            {
                var osVersion = Environment.OSVersion;
                var data = new List<msgCsv>
                {
                    new msgCsv { MsgTime = currentTime, MsgType = "INFO", MsgText = "Started processing at" + "[" + currentTime + "]" },
                    new msgCsv { MsgTime = currentTime, MsgType = "INFO", MsgText = "OS Version: " + "[" + osVersion + "]" },
                    new msgCsv { MsgTime = currentTime, MsgType = "INFO", MsgText = "Script version: " + "[" + ScriptVersion + "]." },
                };

                var config = new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    Delimiter = ",",
                    HasHeaderRecord = true,
                };

                using (var writer = new StreamWriter(LogFilePath))
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
