using System;
using System.Text.RegularExpressions;
using System.Web.Security;

namespace BugNET.Account
{
    public partial class Verify : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Make sure that a valid querystring value was passed through
            if (string.IsNullOrEmpty(Request.QueryString["ID"]) || !Regex.IsMatch(Request.QueryString["ID"].ToLower(), "[0-9a-f]{8}\\-([0-9a-f]{4}\\-){3}[0-9a-f]{12}"))
            {
                InformationLabel.Text = GetLocalResourceObject("InvalidUserAccountID").ToString();
                return;
            }
            else
            {
                try
                {
                    //ID exists and is kosher, see if this user is already approved
                    //Get the ID sent in the querystring
                    Guid userId = new Guid(Request.QueryString["ID"]);

                    //Get information about the user
                    MembershipUser userInfo = Membership.GetUser(userId);
                    if (userInfo == null)
                    {
                        //Could not find user!
                        InformationLabel.Text = GetLocalResourceObject("UserAccountCouldNotBeFound").ToString();
                    }
                    else
                    {
                        if (userInfo.CreationDate.AddDays(7) >= DateTime.Now)
                        {
                            //User is valid, approve them
                            userInfo.IsApproved = true;
                            Membership.UpdateUser(userInfo);
                      
                            //Display a message
                            InformationLabel.Text =  GetLocalResourceObject("AccountVerified").ToString();
                        }
                        else
                        {
                            //Display a message
                            InformationLabel.Text = GetLocalResourceObject("AccountDeactivated").ToString();
                            return;
                        }
                    }
                }
                catch
                {
                    // Error. Redirect some where
                    Response.Redirect("~/Errors/Error.aspx");
                }
            }

            // We should never reach here. Just in case redirect some where
            Response.Redirect("~/Default.aspx", true);
            
        }
    }
}