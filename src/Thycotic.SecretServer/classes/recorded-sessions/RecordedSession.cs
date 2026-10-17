using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class RecordedSession
    {
        public string AccessedByName { get; set; }
        public bool Active { get; set; }
        public string Application { get; set; }
        public int? AuditSecretId { get; set; }
        public int Duration { get; set; }
        public DateTime? EndDate { get; set; }
        public string EndDateDisplay { get; set; }
        public string ErrorMessage { get; set; }
        public string FileExtension { get; set; }
        public bool HasCapturedFrames { get; set; }
        public bool HasKeyStrokes { get; set; }
        public bool HasProcesses { get; set; }
        public bool HasProcessingError { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsKeystrokeOnlyRecording { get; set; }
        public bool IsLauncher { get; set; }
        public bool? LaunchedSuccessfully { get; set; }
        public string LauncherName { get; set; }
        public string LauncherSessionGuid { get; set; }
        public int LauncherSessionStatus { get; set; }
        public int? LauncherTypeId { get; set; }
        public string MachineName { get; set; }
        public string MatchingSearchTypes { get; set; }
        public long? PbaId { get; set; }
        public bool PlaybackCompatible { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
        public int? SecretSessionId { get; set; }
        public string SecretSessionUserName { get; set; }
        public bool SessionMovieProcessComplete { get; set; }
        public DateTime? StartDate { get; set; }
        public string StartDateDisplay { get; set; }
        public int UserAccessLevelOnSecret { get; set; }
        public string UserDomainName { get; set; }
        public int? UserId { get; set; }
        public string UserName { get; set; }
        public string UserNameForDisplay { get; set; }
        public int WebMProcessingStatus { get; set; }
    }
}
