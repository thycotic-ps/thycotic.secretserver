using System;
using System.Net;
using System.Security;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using RestSharp;
using RestSharp.Serializers.Json;

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
        public bool SkipCertificateCheck { get; set; } = false;
        public string AuthProvider { get; set; } = "SecretServer";
        public string PlatformUrl { get; set; }
        public string VaultId { get; set; }
        public string VaultType { get; set; }
        public bool IsPlatformToken { get; set; } = false;
        public bool AutoRefresh { get; private set; } = false;
        private string platformClientId;
        private SecureString platformClientSecret;

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
            if (this.IsPlatformToken)
            {
                return false;
            }
			if (!this.TokenType.Equals("WindowsAuth") || !this.TokenType.Equals("SdkClient"))
            {
                try
                {
                    var sessionClient = new RestClient(this.ApiUrl + "/oauth-expiration");
                    var sessionRequest = new RestRequest() { Method = Method.Post };
                    sessionRequest.AddHeader("Authorization", "Bearer " + this.AccessToken);
                    RestResponse sessionResponse = sessionClient.Execute(sessionRequest);
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
            if (this.IsPlatformToken)
            {
                return PlatformSessionRefresh();
            }
			try
            {
				var obj = Request.RefreshToken(this.SecretServer, this.RefreshToken, null);
				SystemTextJsonSerializer ds = new SystemTextJsonSerializer();
				var jsonObj = ds.Deserialize<ApiTokenResponse>(obj);
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

        public void EnablePlatformAutoRefresh(PSCredential Credential)
        {
            this.platformClientId = Credential.UserName;
            this.platformClientSecret = Credential.Password.Copy();
            this.platformClientSecret.MakeReadOnly();
            this.AutoRefresh = true;
        }

        private bool PlatformSessionRefresh()
        {
            if (!this.AutoRefresh)
            {
                return false;
            }
            try
            {
                var response = Request.PlatformToken(this.PlatformUrl, this.platformClientId, this.platformClientSecret, this.SkipCertificateCheck, 0);
                if (!response.IsSuccessful)
                {
                    return false;
                }
                SystemTextJsonSerializer ds = new SystemTextJsonSerializer();
                var jsonObj = ds.Deserialize<ApiTokenResponse>(response);
                if (string.IsNullOrEmpty(jsonObj.access_token))
                {
                    return false;
                }
                this.AccessToken = jsonObj.access_token;
                this.ExpiresIn = jsonObj.expires_in;
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
        public static RestResponse AccessToken(string SecretServerHost, string Username, string Password, string ProxyServer, int Timeout = 0)
        {
			var options = new RestClientOptions(SecretServerHost + "/oauth2/token");
			options.Timeout = Timeout > 0 ? TimeSpan.FromMilliseconds(Timeout) : TimeSpan.FromSeconds(100);

			if (string.IsNullOrEmpty(ProxyServer))
			{
				options.Proxy = new WebProxy(ProxyServer);
			}
			var client = new RestClient(options);
			var request = new RestRequest() { Method = Method.Post };
			request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
			request.AddParameter("username", Username);
			request.AddParameter("password", Password);
			request.AddParameter("grant_type", "password");
			RestResponse response = client.Execute(request);
			return response;
		}

        public static RestResponse RefreshToken(string SecretServerHost, string TokenValue, string ProxyServer, int Timeout = 0)
        {
			var options = new RestClientOptions(SecretServerHost + "/oauth2/token");
			options.Timeout = Timeout > 0 ? TimeSpan.FromMilliseconds(Timeout) : TimeSpan.FromSeconds(100);

			if (string.IsNullOrEmpty(ProxyServer))
			{
				options.Proxy = new WebProxy(ProxyServer);
			}
			var client = new RestClient(options);
			var request = new RestRequest() { Method = Method.Post };
			request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
			request.AddParameter("refresh_token", TokenValue);
			request.AddParameter("grant_type", "refresh_token");
			RestResponse response = client.Execute(request);
			return response;
		}

        public static RestResponse PlatformToken(string PlatformUrl, string ClientId, SecureString ClientSecret, bool SkipCertificateCheck, int Timeout = 0)
        {
            var options = new RestClientOptions(PlatformUrl + "/identity/api/oauth2/token/xpmplatform");
            options.Timeout = Timeout > 0 ? TimeSpan.FromMilliseconds(Timeout) : TimeSpan.FromSeconds(100);
            if (SkipCertificateCheck)
            {
                options.RemoteCertificateValidationCallback = (sender, certificate, chain, sslPolicyErrors) => true;
            }
            var client = new RestClient(options);
            var request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
            request.AddHeader("X-CENTRIFY-NATIVE-CLIENT", "true");
            request.AddParameter("grant_type", "client_credentials");
            request.AddParameter("client_id", ClientId);
            request.AddParameter("client_secret", new NetworkCredential(string.Empty, ClientSecret).Password);
            request.AddParameter("scope", "xpmheadless");
            RestResponse response = client.Execute(request);
            return response;
        }
    }

}