using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using RestSharp;
using Newtonsoft.Json;

namespace Thycotic.PowerShell.Authentication
{
    public class Session
    {
        public string SecretServer { get; set; }
        public string SecretServerVersion { get; set; }
        public string ApiVersion { get; set; } = "api/v1";
        public string WindowsAuth { get; } = "winauthwebservices";
        public string ApiUrl { get; set; }
        public string AccessToken { get; set; }
        public string RefreshToken { get; set; }
        public string TokenType { get; set; }
        public int ExpiresIn { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime TimeOfDeath { get; set; }
        public int Take { get; set; } = int.MaxValue;

        public bool IsValidSession()
        {
            // check if string is null or empty
            if (string.IsNullOrEmpty(this.AccessToken) & this.StartTime == default(DateTime))
            {
                return false;
            }
            // check if tokentype equals SdkClient or WindowsAuth
            else if (this.TokenType.Equals("WindowsAuth") || this.TokenType.Equals("SdkClient"))
            {
                return true;
            }
            // otherwise assume it is good
            else
            {
                return true;
            }
        }

        public bool IsValidToken()
        {
            // check if AccessToken is empty or null
            if (string.IsNullOrEmpty(this.AccessToken))
            {
                return false;
            }
            else if (DateTime.Now < this.TimeOfDeath && (!this.TokenType.Equals("ExternalToken") || !this.TokenType.Equals("SdkClient")))
            {
                return true;
            }
            else if (DateTime.Now > this.TimeOfDeath && (!this.TokenType.Equals("ExternalToken") || !this.TokenType.Equals("SdkClient")))
            {
                return false;
            }
            else if (this.TokenType.Equals("ExternalToken") || this.TokenType.Equals("WindowsAuth") || this.TokenType.Equals("SdkClient"))
            {
                // no way to validate these token types, assume to be good
                return true;
            }
            else
            {
                return true;
            }
        }

        public bool CheckTokenTtl(int Value)
        {
            if (this.TimeOfDeath <= DateTime.Now.AddMinutes(Value))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool SessionExpire()
        {
            if (!this.TokenType.Equals("WindowsAuth") || !this.TokenType.Equals("SdkClient"))
            {
                try
                {
                    var sessionClient = new RestClient(this.ApiUrl + "/oauth-expiration");
                    var sessionRequest = new RestRequest(Method.POST);
                    sessionRequest.AddHeader("Authorization", "Bearer " + this.AccessToken);
                    IRestResponse sessionResponse = sessionClient.Execute(sessionRequest);
                    return true;
                }
                catch
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public bool SessionRefresh()
        {
            try
            {
                var obj = Request.RefreshToken(this.SecretServer, this.RefreshToken, null);
                var jsonObj = JsonConvert.DeserializeObject<ApiTokenResponse>(obj.Content);
                this.AccessToken = jsonObj.access_token;
                this.RefreshToken = jsonObj.refresh_token;
                this.ExpiresIn = jsonObj.expires_in;
                this.TokenType = jsonObj.token_type;
                this.StartTime = DateTime.Now;
                this.TimeOfDeath = DateTime.Now.Add(TimeSpan.FromSeconds(jsonObj.expires_in));
                return true;
            }
            catch
            {
                return false;
            }
        }

        private class ApiTokenResponse
        {
            public string access_token { get; set; }
            public string refresh_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
        }
    }
    public class Request
    {
        public static IRestResponse AccessToken(string SecretServerHost, string Username, string Password, string ProxyServer, int Timeout = 0)
        {
            var client = new RestClient(SecretServerHost + "/oauth2/token");
            client.Timeout = Timeout;
            if (string.IsNullOrEmpty(ProxyServer))
            {
                client.Proxy = new WebProxy(ProxyServer);
            }
            var request = new RestRequest(Method.POST);
            request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
            request.AddParameter("username", Username);
            request.AddParameter("password", Password);
            request.AddParameter("grant_type", "password");
            IRestResponse response = client.Execute(request);
            return response;
        }

        public static IRestResponse RefreshToken(string SecretServerHost, string TokenValue, string ProxyServer, int Timeout = 0)
        {
            var client = new RestClient(SecretServerHost + "/oauth2/token");
            client.Timeout = Timeout;
            if (string.IsNullOrEmpty(ProxyServer))
            {
                client.Proxy = new WebProxy(ProxyServer);
            }
            var request = new RestRequest(Method.POST);
            request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
            request.AddParameter("refresh_token", TokenValue);
            request.AddParameter("grant_type", "refresh_token");
            IRestResponse response = client.Execute(request);
            return response;
        }
    }

}