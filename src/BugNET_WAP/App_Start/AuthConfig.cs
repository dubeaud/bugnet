

namespace BugNET
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Microsoft.AspNet.Membership.OpenAuth;
    using System.Configuration;
    using BugNET.BLL;

    internal static class AuthConfig
    {
        public static void RegisterOpenAuth()
        {
            // See http://go.microsoft.com/fwlink/?LinkId=252803 for details on setting up this ASP.NET
            // application to support logging in via external services.

            if (HostSettingManager.Get(Common.HostSettingNames.TwitterAuthentication, false)
               && HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerKey, string.Empty) != string.Empty
               && HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerSecret, string.Empty) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddTwitter(
                    consumerKey: HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerKey, string.Empty),
                    consumerSecret: HostSettingManager.Get(Common.HostSettingNames.TwitterConsumerSecret, string.Empty));
            }

            if (HostSettingManager.Get(Common.HostSettingNames.FacebookAuthentication, false) 
                && HostSettingManager.Get(Common.HostSettingNames.FacebookAppId, string.Empty) != string.Empty
                && HostSettingManager.Get(Common.HostSettingNames.FacebookAppSecret, string.Empty) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddFacebook(
                    appId: HostSettingManager.Get(Common.HostSettingNames.FacebookAppId, string.Empty),
                    appSecret: HostSettingManager.Get(Common.HostSettingNames.FacebookAppSecret, string.Empty));

            }

            if (HostSettingManager.Get(Common.HostSettingNames.MicrosoftAuthentication, false)
               && HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientId, string.Empty) != string.Empty
               && HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientSecret, string.Empty) != string.Empty)
            {
                OpenAuth.AuthenticationClients.AddMicrosoft(
                    clientId: HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientId, string.Empty),
                    clientSecret: HostSettingManager.Get(Common.HostSettingNames.MicrosoftClientSecret, string.Empty));
            }

            if(HostSettingManager.Get(Common.HostSettingNames.GoogleAuthentication, false))
            {
                OpenAuth.AuthenticationClients.AddGoogle();
            }

            OpenAuth.ConnectionString = ConfigurationManager.ConnectionStrings["BugNET"].ConnectionString;
        }
    }
}