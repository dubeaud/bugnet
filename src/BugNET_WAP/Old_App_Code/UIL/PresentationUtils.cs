using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Common;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;

namespace BugNET.UserInterfaceLayer
{
    public static class PresentationUtils
    {
        /// <summary>
        /// Sets the pager button states.
        /// </summary>
        /// <param name="gridView">The grid view.</param>
        /// <param name="gvPagerRow">The gv pager row.</param>
        /// <param name="page">The page.</param>
        public static void SetPagerButtonStates(GridView gridView, GridViewRow gvPagerRow, Page page)
        {

            int pageIndex = gridView.PageIndex;
            int pageCount = gridView.PageCount;

            ImageButton btnFirst = (ImageButton)gvPagerRow.FindControl("btnFirst");
            ImageButton btnPrevious = (ImageButton)gvPagerRow.FindControl("btnPrevious");
            ImageButton btnNext = (ImageButton)gvPagerRow.FindControl("btnNext");
            ImageButton btnLast = (ImageButton)gvPagerRow.FindControl("btnLast");

            btnFirst.Enabled = btnPrevious.Enabled = (pageIndex != 0);
            btnNext.Enabled = btnLast.Enabled = (pageIndex < (pageCount - 1));

            DropDownList ddlPageSelector = (DropDownList)gvPagerRow.FindControl("ddlPages");
            ddlPageSelector.Items.Clear();
            for (int i = 1; i <= gridView.PageCount; i++)
            {
                ddlPageSelector.Items.Add(i.ToString());
            }

            ddlPageSelector.SelectedIndex = pageIndex;

            Label lblPageCount = (Label)gvPagerRow.FindControl("lblPageCount");
            lblPageCount.Text = pageCount.ToString();

            //ddlPageSelector.SelectedIndexChanged += delegate
            //{
            //    gridView.PageIndex = ddlPageSelector.SelectedIndex;
            //    gridView.DataBind();
            //};

        }

        /// <summary>
        /// Sets the sort image states.
        /// </summary>
        /// <param name="gridView">The grid view.</param>
        /// <param name="row">The row.</param>
        /// <param name="columnStartIndex"> </param>
        /// <param name="sortField">The sort field.</param>
        /// <param name="sortAscending">if set to <c>true</c> [sort ascending].</param>
        public static void SetSortImageStates(GridView gridView, GridViewRow row,int columnStartIndex, string sortField, bool sortAscending)
        {
            for (var i = columnStartIndex; i < row.Cells.Count; i++)
            {
                var tc = row.Cells[i];
                if (!tc.HasControls()) continue;

                // search for the header link  
                var lnk = tc.Controls[0] as LinkButton;
                if (lnk == null) continue;

                // initialize a new image
                var img = new Image
                {
                    ImageUrl = string.Format("~/images/{0}.png", (sortAscending ? "bullet_arrow_up" : "bullet_arrow_down")),
                    CssClass = "icon"
                };

                // setting the dynamically URL of the image
                // checking if the header link is the user's choice
                if (sortField == lnk.CommandArgument)
                {
                    // adding a space and the image to the header link
                    //tc.Controls.Add(new LiteralControl(" "));
                    tc.Controls.Add(img);
                }
            }
        }

        /// <summary>
        /// Gets the selected items integer list.
        /// </summary>
        /// <param name="listBox">The list box.</param>
        /// <param name="returnAll">Returns all the items regardless if selected or not</param>
        /// <returns></returns>
        public static List<int> GetSelectedItemsIntegerList(ListControl listBox, bool returnAll = false)
        {
            var items = new List<int>();

            foreach (ListItem item in listBox.Items)
            {
                if (!item.Value.Is<int>()) continue;

                if (returnAll || item.Selected)
                    items.Add(int.Parse(item.Value));
            }
            return items;
        }

        /// <summary>
        /// Gets the gravatar image URL.
        /// </summary>
        /// <param name="email">The email id.</param>
        /// <param name="imgSize">Size of the img.</param>
        /// <returns></returns>
        public static string GetGravatarImageUrl(string email, int imgSize)
        {
            // Convert emailID to lower-case
            email = email.Trim().ToLower();

            var emailBytes = Encoding.ASCII.GetBytes(email);
            var hashBytes = new MD5CryptoServiceProvider().ComputeHash(emailBytes);

            Debug.Assert(hashBytes.Length == 16);

            var hash = new StringBuilder();
            foreach (var b in hashBytes)
            {
                hash.Append(b.ToString("x2"));
            }

            // build Gravatar Image URL
            var imageUrl = string.Format("https://www.gravatar.com/avatar/{0}?s={1}&d=identicon&r=g", hash, imgSize);

            return imageUrl;
        }
    }
}
