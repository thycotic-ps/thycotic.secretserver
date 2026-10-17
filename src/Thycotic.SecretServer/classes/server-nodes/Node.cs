using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ServerNodes
{
    public class Node
    {
        public string BackgroundWorkerError { get; set; }
        public string BinaryVersion { get; set; }
        public bool? ChangeRootLogLevel { get; set; }
        public string Database { get; set; }
        public bool? EnableBackgroundWorker { get; set; }
        public bool? EnableEngineWorker { get; set; }
        public bool? EnableSessionRecordingWorker { get; set; }
        public string EngineWorkerError { get; set; }
        public string ErrorMessage { get; set; }
        public bool InCluster { get; set; }
        public bool IsCurrentNode { get; set; }
        public string LastConnected { get; set; }
        public DateTime? LastConnectedDate { get; set; }
        public string LogLevel { get; set; }
        public string MachineName { get; set; }
        public int NodeId { get; set; }
        public bool ReadonlyModeEnabled { get; set; }
        public string ReadonlyModeStatus { get; set; }
        public string SessionRecordingWorkerError { get; set; }
    }
}
