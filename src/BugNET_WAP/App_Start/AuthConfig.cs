

namespace BugNET
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Microsoft.AspNet.Membership.OpenAuth;
    using System.Configuration;
    using BugNET.BLL;
    using DotNetOpenAuth.GoogleOAuth2;

    internal static class AuthConfig
    {
        public static void RegisterOpenAuth()
        {
            // See http://go.microsoft.com/fwlink/?LinkId=252803 for details on setting up this ASP.NET
            // application to support logging in via external services.

            if (HostSettingManager.Get(Common.HostSettingNames.TwitterAuthentication, false)
               && HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerKey) != string.Empty
               && HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerSecret) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddTwitter(
                    consumerKey: HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerKey),
                    consumerSecret: HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerSecret));
            }

            if (HostSettingManager.Get(Common.HostSettingNames.FacebookAuthentication, false) 
                && HostSettingManager.Get(Common.HostSettingNames.FacebookAppId) != string.Empty
                && HostSettingManager.Get(Common.HostSettingNames.FacebookAppSecret) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddFacebook(
                    appId: HostSettingManager.Get(Common.HostSettingNames.FacebookAppId),
                    appSecret: HostSettingManager.Get(Common.HostSettingNames.FacebookAppSecret));

            }

            if (HostSettingManager.Get(Common.HostSettingNames.MicrosoftAuthentication, false)
               && HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientId, string.Empty) != string.Empty
               && HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientSecret, string.Empty) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddMicrosoft(
                    clientId: HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientId),
                    clientSecret: HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientSecret));
            }

            if(HostSettingManager.Get(Common.HostSettingNames.GoogleAuthentication, false)
                && HostSettingManager.Get(Common.HostSettingNames.GoogleClientId, string.Empty) != string.Empty
               && HostSettingManager.Get(Common.HostSettingNames.GoogleClientSecret, string.Empty) != string.Empty)
            {
                OpenAuth.AuthenticationClients.Add("Google", () => new GoogleOAuth2Client(
                    HostSettingManager.Get(Common.HostSettingNames.GoogleClientId),
                    HostSettingManager.Get(Common.HostSettingNames.GoogleClientSecret)));
            }

            OpenAuth.ConnectionString = ConfigurationManager.ConnectionStrings["BugNET"].ConnectionString;
        }
    }
}