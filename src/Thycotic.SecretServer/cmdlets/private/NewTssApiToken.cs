using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Security;
using System.Runtime.InteropServices;
using System.Net;
using RestSharp;

namespace Thycotic.SecretServer
{
    /// <summary>
    /// <para type="synopsis">Invokes the Secret Server OAuth2 endpoint</para>
    /// <para type="description">Invokes the Secret Server OAuth2 endpoint</para>
    /// </summary>
    [Cmdlet(VerbsCommon.New, "TssApiToken")]
    public class NameCmdlet : PSCmdlet
    {
        [Parameter(Mandatory = true, Position = 0)]
        public string Uri { get; set; }

        [Parameter(Mandatory = true, Position = 1)]
        public string Username { get; set; }

        [Parameter(Mandatory = true, Position = 2)]
        public string Password { get; set; }

        [Parameter(Position = 3)]
        public int OtpCode { get; set; }

        [Parameter(Position = 4)]
        public SwitchParameter UseDefaultCredential { get; set; }

        [Parameter(Position = 5)]
        public string Proxy { get; set; }

        [Parameter(Position = 6)]
        public PSCredential ProxyCredential { get; set; }

        [Parameter(Position = 7)]
        public SwitchParameter ProxyUseDefaultCredentials { get; set; }

        [Parameter(Position = 8)]
        public int Timeout { get; set; } = 0;

        protected override void ProcessRecord()
        {
            Uri requestUri = new Uri(Uri);
            var apiClient = new RestClient();
            apiClient.BaseUrl = requestUri;
            apiClient.Timeout = Timeout;

            if (string.IsNullOrEmpty(Proxy))
            {
                apiClient.Proxy = new WebProxy(Proxy);
                if (ProxyUseDefaultCredentials.IsPresent)
                {
                    apiClient.Proxy.Credentials = System.Net.CredentialCache.DefaultCredentials;
                }
                if (MyInvocation.BoundParameters.ContainsKey("ProxyCredential"))
                {
                    apiClient.Proxy.Credentials = new NetworkCredential(ProxyCredential.UserName, ProxyCredential.Password);
                }
            }

            var apiRequest = new RestRequest(Method.POST);
            apiRequest.AddHeader("Content-Type", "application/x-www-form-urlencoded");

            if (MyInvocation.BoundParameters.ContainsKey("OtpCode"))
            {
                apiRequest.AddParameter("otp", OtpCode.ToString(), ParameterType.HttpHeader);
            }

            apiRequest.AddParameter("username", Username);
            apiRequest.AddParameter("password", Password);
            apiRequest.AddParameter("grant_type", "password");

            IRestResponse apiResponse = apiClient.Execute(apiRequest);
            WriteObject(apiResponse);
        }
    }
}