using System;
using System.Management.Automation;
using System.Net;
using RestSharp;
using RestSharp.Extensions;
using System.IO;

namespace Thycotic.SecretServer.Cmdlets
{
    /// <summary>
    /// <para type="synopsis">Invokes the Secret Server Rest API.</para>
    /// <para type="description">Invokes the Secret Server Rest API.</para>
    /// </summary>
    [Cmdlet(VerbsLifecycle.Invoke, "TssApi")]
    public class InvokeTssApiCmdlet : PSCmdlet
    {
        ///<summary>
        ///<para type="description">Full URL endpoint, e.g. https://alpha.local/SecretServer/api/v1/secrets.</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 0)]
        [Alias("Url")]
        public string Uri { get; set; }

        ///<summary>
        ///<para type="description">Valid Access Token issued by Secret Server.</para>
        ///</summary>
        [Parameter(Position = 1)]
        public string AccessToken { get; set; }

        ///<summary>
        ///<para type="description">Method used for the web request, supported by Secret Server.</para>
        ///</summary>
        [Parameter(Mandatory = true, Position = 2)]
        [ValidateSet("GET", "DELETE", "PATCH", "POST", "PUT")]
        public Method Method { get; set; }

        ///<summary>
        ///<para type="description">Specifies the body of the request.</para>
        ///</summary>
        [Parameter(Position = 3)]
        public object Body { get; set; }

        ///<summary>
        ///<para type="description">Specifies the file path to write the content.</para>
        ///</summary>
        [Parameter(Position = 4)]
        public string OutFile { get; set; }

        ///<summary>
        ///<para type="description">Specifies the content type of the web request.</para>
        ///<para type="description">If this parameter is omitted and the request method is POST, Invoke-RestMethod sets the content type to application/x-www-form-urlencoded. Otherwise, the content type is not specified in the call.</para>
        ///</summary>
        [Parameter(Position = 5)]
        public string ContentType { get; set; } = "application/json";

        ///<summary>
        ///<para type="description">Indicates using the credentials of the current user to send the web request (winauth).</para>
        ///</summary>
        [Parameter(Position = 6)]
        public SwitchParameter UseDefaultCredential { get; set; }

        ///<summary>
        ///<para type="description">Specifies that the cmdlet uses a proxy server for the request,</para>
        ///<para type="description">rather than connecting directly to the Internet resource. Enter the URI of a network proxy server.</para>
        ///</summary>
        [Parameter(Position = 7)]
        public string Proxy { get; set; }

        ///<summary>
        ///<para type="description">Specifies a user account that has permission to use the proxy server that is specified by the Proxy parameter. The default is the current user.</para>
        ///<para type="description">This parameter is valid only when the Proxy parameter is also used in the command. You cannot use the ProxyCredential and ProxyUseDefaultCredentials parameters in the same command.</para>
        ///</summary>
        [Parameter(Position = 8)]
        public PSCredential ProxyCredential { get; set; }

        ///<summary>
        ///<para type="description">Indicates that the cmdlet uses the credentials of the current user to access the proxy server that is specified by the Proxy parameter.</para>
        ///<para type="description">This parameter is valid only when the Proxy parameter is also used in the command. You cannot use the ProxyCredential and ProxyUseDefaultCredentials parameters in the same command.</para>
        ///</summary>
        [Parameter(Position = 9)]
        public SwitchParameter ProxyUseDefaultCredentials { get; set; }

        ///<summary>
        ///<para type="description">Timeout in seconds for the REST client connection.</para>
        ///<para type="description">Default value is 0 (zero), which defaults to the http client default time of 100 seconds.</para>
        ///</summary>
        [Parameter(Position = 10)]
        public int Timeout { get; set; } = 0;

        protected override void ProcessRecord()
        {
            Uri requestUri = new Uri(Uri);
            var apiClient = new RestClient();
            apiClient.BaseUrl = requestUri;
            apiClient.Timeout = Timeout;

            if (MyInvocation.BoundParameters.ContainsKey("Proxy"))
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

            var apiRequest = new RestRequest(Method);
            apiRequest.AddHeader("Content-Type", ContentType);
            if (MyInvocation.BoundParameters.ContainsKey("AccessToken"))
            {
                apiRequest.AddHeader("Authorization", "Bearer " + AccessToken);
            }
            if (MyInvocation.BoundParameters.ContainsKey("UseDefaultCredential"))
            {
                apiRequest.UseDefaultCredentials = true;
            }
            if (MyInvocation.BoundParameters.ContainsKey("Body"))
            {
                apiRequest.AddParameter(ContentType, Body, ParameterType.RequestBody);
            }

            if (!String.IsNullOrEmpty(OutFile))
            {
                // stream file content out
                IRestResponse apiResponse = apiClient.Execute(apiRequest);
                File.WriteAllBytes(OutFile, apiResponse.RawBytes);
            }
            else
            {
                IRestResponse apiResponse = apiClient.Execute(apiRequest);
                WriteObject(apiResponse);
            }
        }
    }
}