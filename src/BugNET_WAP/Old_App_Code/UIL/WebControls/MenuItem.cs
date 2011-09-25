using System.Web;

namespace BugNET.UserInterfaceLayer.WebControls
{

    /// <summary>
    /// http://www.aspcode.net/Suckerfish-menu-with-ASPNET-and-JQuery.aspx
    /// </summary>
    public class SuckerMenuItem 
    { 
        /// <summary>
        /// Initializes a new instance of the <see cref="SuckerMenuItem"/> class.
        /// </summary>
        /// <param name="sLink">The s link.</param>
        /// <param name="sText">The s text.</param>
        /// <param name="sClass">The s class.</param>
        /// <param name="oRoot">The o root.</param>
        public SuckerMenuItem(string sLink, string sText, MenuHelperRoot oRoot) :this (sLink,sText,oRoot,string.Empty)
        {}

        /// <summary>
        /// Initializes a new instance of the <see cref="SuckerMenuItem"/> class.
        /// </summary>
        /// <param name="sLink">The s link.</param>
        /// <param name="sText">The s text.</param>
        /// <param name="oRoot">The o root.</param>
        /// <param name="cssClass">The CSS class.</param>
        public SuckerMenuItem(string sLink, string sText, MenuHelperRoot oRoot, string cssClass)
        {
            Link = sLink.StartsWith("~") ? VirtualPathUtility.ToAbsolute(sLink) : sLink;
            Text = sText;
            m_Root = oRoot;
            CssClass = cssClass;
        } 
        private MenuHelperRoot m_Root; 
        public string Link = ""; 
        public string Text = "";
        public string CssClass = "";
        public System.Collections.Generic.List<SuckerMenuItem> Items = new System.Collections.Generic.List<SuckerMenuItem>();

        /// <summary>
        /// Gets a value indicating whether [recursive is current].
        /// </summary>
        /// <value><c>true</c> if [recursive is current]; otherwise, <c>false</c>.</value>
        public bool RecursiveIsCurrent 
        { 
            get 
            { 
                if (Link != "#" && m_Root.IsCurrent(this)) 
                    return true; 
                foreach (SuckerMenuItem oItem in Items) 
                    if (oItem.RecursiveIsCurrent) 
                        return true; 
                return false; 
            } 
        }

        /// <summary>
        /// Gets the HTML.
        /// </summary>
        /// <returns></returns>
        public string GetHtml() 
        {
            Text = Text.Replace("»", "<span class=\"sf-sub-indicator\"> »</span>");
            System.Text.StringBuilder oBuilder = new System.Text.StringBuilder(); 
//oBuilder.Append("<li " + (RecursiveIsCurrent ? " " + m_Root.LICurrentDecoration : "") + ">");

            oBuilder.Append("<li " + (CssClass != string.Empty ? "class=\"" + CssClass + "\"" : "") + ">");
            if (Items.Count > 0) 
            { 
                oBuilder.Append("<a href=\"" + Link + "\" class=\"sf-with-ul\">" + Text + "</a>"); 
                oBuilder.Append("<ul>"); 
                foreach (SuckerMenuItem oItem in Items) 
                    oBuilder.Append(oItem.GetHtml()); 
                oBuilder.Append("</ul>"); 
            } 
            else
                oBuilder.Append("<a href=\"" + Link + "\">" + Text + "</a>"); 
            oBuilder.Append("</li>"); 
            return oBuilder.ToString(); 
        } 
    } 
 
}