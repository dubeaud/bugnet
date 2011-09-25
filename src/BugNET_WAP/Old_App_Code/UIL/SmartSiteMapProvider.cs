using System;
using System.Collections.Specialized;
using System.Web;

namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// A custom site map provider that allows query string usage.
    /// </summary>
    public class SmartSiteMapProvider : XmlSiteMapProvider
    {
        /// <summary>
        /// Initializes the <see cref="T:System.Web.XmlSiteMapProvider"></see> object. The <see cref="M:System.Web.XmlSiteMapProvider.Initialize(System.String,System.Collections.Specialized.NameValueCollection)"></see> method does not actually build a site map, it only prepares the state of the <see cref="T:System.Web.XmlSiteMapProvider"></see> to do so.
        /// </summary>
        /// <param name="name">The <see cref="T:System.Web.XmlSiteMapProvider"></see> to initialize.</param>
        /// <param name="attributes">A <see cref="T:System.Collections.Specialized.NameValueCollection"></see> that can contain additional attributes to help initialize name. These attributes are read from the <see cref="T:System.Web.XmlSiteMapProvider"></see> configuration in the Web.config file.</param>
        /// <exception cref="T:System.InvalidOperationException">The <see cref="T:System.Web.XmlSiteMapProvider"></see> is initialized more than once.</exception>
        /// <exception cref="T:System.Web.HttpException">A <see cref="T:System.Web.SiteMapNode"></see> used a physical path to reference a site map file.- or -An error occurred while attempting to parse the virtual path supplied for the siteMapFile attribute.</exception>
        public override void Initialize(string name, NameValueCollection attributes)
        {
            base.Initialize(name, attributes);
            this.SiteMapResolve += new SiteMapResolveEventHandler(SmartSiteMapProvider_SiteMapResolve);
        }

        /// <summary>
        /// Handles the SiteMapResolve event of the SmartSiteMapProvider control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.SiteMapResolveEventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        SiteMapNode SmartSiteMapProvider_SiteMapResolve(object sender, SiteMapResolveEventArgs e)
        {
            if (SiteMap.CurrentNode == null)
                return null;

            SiteMapNode temp;
            temp = SiteMap.CurrentNode.Clone(true);
            Uri u = new Uri(e.Context.Request.Url.ToString());

            SiteMapNode tempNode = temp;
            while (tempNode != null)
            {
                string qs = GetReliance(tempNode, e.Context);
                if (qs != null)
                    if (tempNode != null)
                        tempNode.Url += qs;

                temp = tempNode.ParentNode;
            }
          
            return temp;
        }

        /// <summary>
        /// Gets the reliance.
        /// </summary>
        /// <param name="node">The node.</param>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        private string GetReliance(SiteMapNode node, HttpContext context)
        {
            //Check to see if the node supports reliance
            if (node["reliantOn"] == null)
                return null;

            NameValueCollection values = new NameValueCollection();
            string[] vars = node["reliantOn"].Split(",".ToCharArray());

            foreach (string s in vars)
            {
                string var = s.Trim();
                //Make sure the var exists in the querystring
                if (context.Request.QueryString[var] == null)
                    continue;

                values.Add(var, context.Request.QueryString[var]);
            }

            if (values.Count == 0)
                return null;

            return NameValueCollectionToString(values);
        }

        /// <summary>
        /// Names the value collection to string.
        /// </summary>
        /// <param name="col">The col.</param>
        /// <returns></returns>
        private string NameValueCollectionToString(NameValueCollection col)
        {
            string[] parts = new string[col.Count];
            string[] keys = col.AllKeys;

            for (int i = 0; i < keys.Length; i++)
                parts[i] = keys[i] + "=" + col[keys[i]];

            string url = "?" + String.Join("&", parts);
            return url;
        }
    }
}
