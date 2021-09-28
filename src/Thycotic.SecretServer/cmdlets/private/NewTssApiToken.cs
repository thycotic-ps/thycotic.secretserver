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

            WriteVerbose("Base URL set to: " + requestUri);
            WriteVerbose("Request timeout set to : " + Timeout);

            if (MyInvocation.BoundParameters.ContainsKey("Proxy"))
            {
                apiClient.Proxy = new WebProxy(Proxy);
                WriteVerbose("Configuring Proxy for request");
                if (ProxyUseDefaultCredentials.IsPresent)
                {
                    apiClient.Proxy.Credentials = System.Net.CredentialCache.DefaultCredentials;
                    WriteVerbose("Default Credentials being used for Proxy");
                }
                if (MyInvocation.BoundParameters.ContainsKey("ProxyCredential"))
                {
                    apiClient.Proxy.Credentials = new NetworkCredential(ProxyCredential.UserName, ProxyCredential.Password);
                    WriteVerbose("Proxy credential username being set to: " + ProxyCredential.UserName);
                }
            }

            var apiRequest = new RestRequest(Method.POST);
            apiRequest.AddHeader("Content-Type", "application/x-www-form-urlencoded");

            if (MyInvocation.BoundParameters.ContainsKey("OtpCode"))
            {
                apiRequest.AddParameter("otp", OtpCode.ToString(), ParameterType.HttpHeader);
                WriteVerbose("OTP Code added to request: " + OtpCode.ToString());
            }

            apiRequest.AddParameter("username", Username);
            WriteVerbose("Username: " + Username);
            apiRequest.AddParameter("password", Password);
            apiRequest.AddParameter("grant_type", "password");

            WriteVerbose("Performing the operation " + apiRequest.Method + " " + apiClient.BaseUrl);
            IRestResponse apiResponse = apiClient.Execute(apiRequest);
            WriteObject(apiResponse);
        }
    }
}