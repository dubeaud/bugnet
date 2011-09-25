namespace BugNET.UserInterfaceLayer.WebControls
{
    public class MenuHelperRoot
    {
        public string ULDecoration = "class=\"sf-menu sf-js-enabled sf-shadow\"";
        public string LICurrentDecoration = "class=\"current\"";
        public string LIAdminDecoration = "class=\"admin\"";
        public System.Collections.Generic.List<SuckerMenuItem> Items = new System.Collections.Generic.List<SuckerMenuItem>();

        /// <summary>
        /// Determines whether the specified o item is current.
        /// </summary>
        /// <param name="oItem">The o item.</param>
        /// <returns>
        /// 	<c>true</c> if the specified o item is current; otherwise, <c>false</c>.
        /// </returns>
        public virtual bool IsCurrent(SuckerMenuItem oItem)
        {
            if (System.Web.HttpContext.Current.Request.Url.ToString().ToLower().IndexOf(oItem.Link.ToLower()) >= 0)
                return true;
            return false;
        }
   
        /// <summary>
        /// Gets the HTML.
        /// </summary>
        /// <returns></returns>
        public string GetHtml()
        {
            System.Text.StringBuilder oBuilder = new System.Text.StringBuilder();
            oBuilder.Append("<ul ");
            oBuilder.Append(ULDecoration);
            oBuilder.Append(">");
            foreach (SuckerMenuItem oItem in Items)
                oBuilder.Append(oItem.GetHtml());
            oBuilder.Append("</ul");
            return oBuilder.ToString();
        }

    } 
}