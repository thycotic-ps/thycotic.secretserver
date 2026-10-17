using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PbaConfiguration
{
    public class Challenge
    {
        public int? ChallengeClearedByUserId { get; set; }
        public string ChallengeClearedByUserName { get; set; }
        public DateTime? ChallengeClearedDate { get; set; }
        public string ChallengeClearedDateDisplay { get; set; }
        public int? ChallengeDurationMinutes { get; set; }
        public DateTime? ChallengeStartedDate { get; set; }
        public string ChallengeStartedDateDisplay { get; set; }
        public long ChallengeType { get; set; }
        public string ChallengeTypeName { get; set; }
        public int? FailureCount { get; set; }
        public int? FailureLimit { get; set; }
        public DateTime? LastResponseDate { get; set; }
        public int SecurityAnalyticsChallengeId { get; set; }
        public long SecurityAnalyticsEventId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
