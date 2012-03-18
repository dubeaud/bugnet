using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel.Syndication;
using System.Xml;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET
{
    /// <summary>
    /// Generates Syndication Feeds for BugNET
    /// </summary>
    public partial class Feed : System.Web.UI.Page
    {
        const int maxItemsInFeed = 10;
        int ProjectId = 0;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

           
            int ChannelId = 0;
            string ProjectName = string.Empty;
            // Determine the maximum number of items to show in the feed
           
            if (Request.QueryString["pid"] != null)
                ProjectId = Convert.ToInt32(Request.Params["pid"]);
            //get feed id
            if (Request.QueryString["channel"] != null)
                ChannelId = Convert.ToInt32(Request.Params["channel"]);

            //Security Checks
            if (!User.Identity.IsAuthenticated && ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private)
                Response.Redirect("~/Errors/AccessDenied.aspx", true);
            else if (User.Identity.IsAuthenticated && ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(User.Identity.Name, ProjectId))
                Response.Redirect("~/Errors/AccessDenied.aspx", true);

            ProjectName = ProjectManager.GetById(ProjectId).Name;

            // Determine whether we're outputting an Atom or RSS feed
            bool outputRss = (Request.QueryString["Type"] == "RSS");
            bool outputAtom = !outputRss;

            // Output the appropriate ContentType
            if (outputRss)
                Response.ContentType = "application/rss+xml";
            else if (outputAtom)
                Response.ContentType = "application/atom+xml";

            // Create the feed and specify the feed's attributes
            SyndicationFeed myFeed = new SyndicationFeed();
            myFeed.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(GetFullyQualifiedUrl("~/Default.aspx"))));
            myFeed.Links.Add(SyndicationLink.CreateSelfLink(new Uri(GetFullyQualifiedUrl(Request.RawUrl))));
            //myFeed.Copyright = TextSyndicationContent.CreatePlaintextContent("Copyright Nile.com Bookstore");
            myFeed.Language = "en-us";

            switch (ChannelId)
            {
                case 1:
                    MilestoneFeed(ref myFeed);
                    break;
                case 2:
                    CategoryFeed(ref myFeed);
                    break;
                case 3:
                    StatusFeed(ref myFeed);
                    break;
                case 4:
                    PriorityFeed(ref myFeed);
                    break;
                case 5:
                    TypeFeed(ref myFeed);
                    break;
                case 6:
                    AssigneeFeed(ref myFeed);
                    break;
                case 7:
                    FilteredIssuesFeed(ref myFeed);
                    break;
                case 8:
                    RelevantFeed(ref myFeed);
                    break;
                case 9:
                    AssignedFeed(ref myFeed);
                    break;
                case 10:
                    OwnedFeed(ref myFeed);
                    break;
                case 11:
                    CreatedFeed(ref myFeed);
                    break;
                case 12:
                    AllIssuesFeed(ref myFeed);
                    break;
                case 13:
                    QueryFeed(ref myFeed);
                    break;
                case 14: //Missing in build 0.9.152
                    OpenIssueFeed(ref myFeed); //add new method for open issues
                    break;
            }

            // Return the feed's XML content as the response
            XmlWriterSettings outputSettings = new XmlWriterSettings();
            outputSettings.Indent = true; //(Uncomment for readability during testing)
            XmlWriter feedWriter = XmlWriter.Create(Response.OutputStream, outputSettings);

            if (outputAtom)
            {
                // Use Atom 1.0        
                Atom10FeedFormatter atomFormatter = new Atom10FeedFormatter(myFeed);
                atomFormatter.WriteTo(feedWriter);
            }
            else if (outputRss)
            {
                // Emit RSS 2.0
                Rss20FeedFormatter rssFormatter = new Rss20FeedFormatter(myFeed);
                rssFormatter.WriteTo(feedWriter);
            }

            feedWriter.Close();
        }

        #region Helper Methods
       
        /// <summary>
        /// Creates the syndication items from issue list.
        /// </summary>
        /// <param name="issueList">The issue list.</param>
        /// <returns></returns>
        private List<SyndicationItem> CreateSyndicationItemsFromIssueList(List<Issue> issueList)
        {
            List<SyndicationItem> feedItems = new List<SyndicationItem>();

            foreach (Issue issue in issueList.Take(maxItemsInFeed))
            {
                // Atom items MUST have an author, so if there are no authors for this content item then go to next item in loop
                //if (outputAtom && t.TitleAuthors.Count == 0)
                //    continue;    
                SyndicationItem item = new SyndicationItem();
                item.Title = TextSyndicationContent.CreatePlaintextContent(string.Format("{0} - {1}", issue.FullId, issue.Title));
                item.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(GetFullyQualifiedUrl(string.Format("~/Issues/IssueDetail.aspx?id={0}",issue.Id.ToString())))));
                item.Summary = TextSyndicationContent.CreatePlaintextContent(issue.Description);
                item.Categories.Add(new SyndicationCategory(issue.CategoryName));
                item.PublishDate = issue.DateCreated;

                // Add a custom element.
                XmlDocument doc = new XmlDocument();
                XmlElement itemElement = doc.CreateElement("milestone");
                itemElement.InnerText = issue.MilestoneName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("project");
                itemElement.InnerText = issue.ProjectName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("issueType");
                itemElement.InnerText = issue.IssueTypeName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("priority");
                itemElement.InnerText = issue.PriorityName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("status");
                itemElement.InnerText = issue.StatusName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("resolution");
                itemElement.InnerText = issue.ResolutionName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("assignedTo");
                itemElement.InnerText = issue.AssignedDisplayName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("owner");
                itemElement.InnerText = issue.OwnerDisplayName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("dueDate");
                itemElement.InnerText = issue.DueDate.ToShortDateString();
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("progress");
                itemElement.InnerText = issue.Progress.ToString();
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("estimation");
                itemElement.InnerText = issue.Estimation.ToString();
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("lastUpdated");
                itemElement.InnerText = issue.LastUpdate.ToShortDateString();
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("lastUpdateBy");
                itemElement.InnerText = issue.LastUpdateDisplayName;
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("created");
                itemElement.InnerText = issue.DateCreated.ToShortDateString();
                item.ElementExtensions.Add(itemElement);

                itemElement = doc.CreateElement("createdBy");
                itemElement.InnerText = issue.CreatorDisplayName;
                item.ElementExtensions.Add(itemElement);

                //foreach (TitleAuthor ta in t.TitleAuthors)
                //{
                //    SyndicationPerson authInfo = new SyndicationPerson();
                //    authInfo.Email = ta.Author.au_lname + "@example.com";
                //    authInfo.Name = ta.Author.au_fullname;
                //    item.Authors.Add(authInfo);

                //    // RSS feeds can only have one author, so quit loop after first author has been added
                //    if (outputRss)
                //        break;
                //}
                WebProfile Profile = new WebProfile().GetProfile(issue.CreatorUserName);
                SyndicationPerson authInfo = new SyndicationPerson();
                //authInfo.Email = Membership.GetUser(IssueCreatorUserId).Email;
                authInfo.Name = Profile.DisplayName;
                item.Authors.Add(authInfo);

                // Add the item to the feed
                feedItems.Add(item);
            }
            
            return feedItems;
        }

        /// <summary>
        /// Creates the syndication items from issue count list.
        /// </summary>
        /// <param name="issueCountList">The issue count list.</param>
        /// <returns></returns>
        private List<SyndicationItem> CreateSyndicationItemsFromIssueCountList(List<IssueCount> issueCountList)
        {
            List<SyndicationItem> feedItems = new List<SyndicationItem>();

            foreach (IssueCount issueCount in issueCountList.Take(maxItemsInFeed))
            {
                // Atom items MUST have an author, so if there are no authors for this content item then go to next item in loop
                //if (outputAtom && t.TitleAuthors.Count == 0)
                //    continue;    
                SyndicationItem item = new SyndicationItem();

                item.Title = TextSyndicationContent.CreatePlaintextContent(issueCount.Name);
                item.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(GetFullyQualifiedUrl(string.Format("~/Issues/IssueList.aspx?pid={0}&s=0&m={1}", ProjectId, issueCount.Id)))));
                item.Summary = TextSyndicationContent.CreatePlaintextContent(string.Concat(issueCount.Count.ToString(), " Open Issues"));
                //item.Categories.Add(new SyndicationCategory(IssueManager.CategoryName));
                item.PublishDate = DateTime.Now;
                // Add the item to the feed
                feedItems.Add(item);
            }

            return feedItems;
        }

        /// <summary>
        /// Gets the fully qualified URL.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <returns></returns>
        private string GetFullyQualifiedUrl(string url)
        {
            return string.Concat(Request.Url.GetLeftPart(UriPartial.Authority), ResolveUrl(url));
        }
        #endregion

        #region Feed Methods
        /// <summary>
        /// Milestones the feed.
        /// </summary>
        private void MilestoneFeed(ref SyndicationFeed feed)
        {
            List<IssueCount> lsVersion = IssueManager.GetMilestoneCountByProjectId(ProjectId);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueCountList(lsVersion);
            Project p = ProjectManager.GetById(ProjectId);
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByMilestoneTitle").ToString(),p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByMilestoneDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Alls the issues feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AllIssuesFeed(ref SyndicationFeed feed)
        {
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(IssueManager.GetByProjectId(ProjectId));
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AllIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AllIssuesDescription").ToString(),p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By category
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void CategoryFeed(ref SyndicationFeed feed)
        {
            CategoryTree objComps = new CategoryTree();
            List<Category> al = objComps.GetCategoryTreeByProjectId(ProjectId);

            List<SyndicationItem> feedItems = new List<SyndicationItem>();
            Project p = ProjectManager.GetById(ProjectId);

            foreach (Category c in al)
            {
                SyndicationItem item = new SyndicationItem();

                item.Title = TextSyndicationContent.CreatePlaintextContent(c.Name);
                item.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(GetFullyQualifiedUrl(string.Format("~/Issues/IssueList.aspx?pid={0}&s=0&c={1}", ProjectId, c.Id)))));
                item.Summary = TextSyndicationContent.CreatePlaintextContent(string.Concat(IssueManager.GetCountByProjectAndCategoryId(ProjectId, c.Id).ToString(), GetLocalResourceObject("OpenIssues").ToString()));
                item.PublishDate = DateTime.Now;
                // Add the item to the feed
                feedItems.Add(item);
            }
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByCategoryTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByCategoryDescription").ToString(), p.Name));
            feed.Items = feedItems;     
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By Status
        /// </summary>
        private void StatusFeed(ref SyndicationFeed feed)
        {
            List<IssueCount> al = IssueManager.GetStatusCountByProjectId(ProjectId);
            List<SyndicationItem> feedItems = new List<SyndicationItem>();
            Project p = ProjectManager.GetById(ProjectId);

            feedItems = CreateSyndicationItemsFromIssueCountList(al);    
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByStatusTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByStatusDescription").ToString(), p.Name));
            feed.Items = feedItems;     
        }

        /// <summary>
        /// Priorities the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void PriorityFeed(ref SyndicationFeed feed)
        {
            List<IssueCount> al = IssueManager.GetPriorityCountByProjectId(ProjectId);
            List<SyndicationItem> feedItems = new List<SyndicationItem>();
            Project p = ProjectManager.GetById(ProjectId);

            feedItems = CreateSyndicationItemsFromIssueCountList(al);
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByPriorityTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByPriorityDescription").ToString(), p.Name));
            feed.Items = feedItems;    
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By Type
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void TypeFeed(ref SyndicationFeed feed)
        {
            List<IssueCount> al = IssueManager.GetTypeCountByProjectId(ProjectId);
            List<SyndicationItem> feedItems = new List<SyndicationItem>();
            Project p = ProjectManager.GetById(ProjectId);

            feedItems = CreateSyndicationItemsFromIssueCountList(al);
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByIssueTypeTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("IssuesByIssueTypeDescription").ToString(), p.Name));
            feed.Items = feedItems;   
        }

        /// <summary>
        /// Assigneds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AssignedFeed(ref SyndicationFeed feed)
        {
            List<Issue> issues = IssueManager.GetByAssignedUserName(ProjectId, User.Identity.Name);
            Project p = ProjectManager.GetById(ProjectId);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issues);
            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AssignedIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AssignedIssuesDescription").ToString(), Security.GetDisplayName()));
            feed.Items = feedItems;   
        }

        /// <summary>
        /// Filtereds the issues feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void FilteredIssuesFeed(ref SyndicationFeed feed)
        {
            QueryClause q;
            bool isStatus = false;
            string BooleanOperator = "AND";
            List<QueryClause> queryClauses = new List<QueryClause>();

            if (!string.IsNullOrEmpty(IssueCategoryId))
            {
                q = new QueryClause(BooleanOperator, "IssueCategoryId", "=", IssueCategoryId.ToString(), SqlDbType.Int, false);
                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(IssueTypeId))
            {
                q = new QueryClause(BooleanOperator, "IssueTypeId", "=", IssueTypeId.ToString(), SqlDbType.Int, false);
                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(IssueMilestoneId))
            {
                //if zero, do a null comparison.
                if (IssueMilestoneId == "0")
                    q = new QueryClause(BooleanOperator, "IssueMilestoneId", "IS", null, SqlDbType.Int, false);
                else
                    q = new QueryClause(BooleanOperator, "IssueMilestoneId", "=", IssueMilestoneId, SqlDbType.Int, false);

                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(IssueResolutionId))
            {
                q = new QueryClause(BooleanOperator, "IssueResolutionId", "=", IssueResolutionId.ToString(), SqlDbType.Int, false);
                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(IssuePriorityId))
            {
                q = new QueryClause(BooleanOperator, "IssuePriorityId", "=", IssuePriorityId.ToString(), SqlDbType.Int, false);
                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(IssueStatusId))
            {
                isStatus = true;
                q = new QueryClause(BooleanOperator, "IssueStatusId", "=", IssueStatusId.ToString(), SqlDbType.Int, false);
                queryClauses.Add(q);
            }
            if (!string.IsNullOrEmpty(AssignedUserName))
            {
                if (AssignedUserName == "0")
                    q = new QueryClause(BooleanOperator, "IssueAssignedUserId", "IS", null, SqlDbType.NVarChar, false);
                else
                    q = new QueryClause(BooleanOperator, "IssueAssignedUserId", "=", AssignedUserName, SqlDbType.NVarChar, false);
                queryClauses.Add(q);
            }

            //exclude all closed status's
            if (!isStatus)
            {
                List<Status> status = StatusManager.GetByProjectId(ProjectId).FindAll(delegate(Status s) { return s.IsClosedState == true; });
                foreach (Status st in status)
                {
                    q = new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false);
                    queryClauses.Add(q);
                }
            }
            //q = new QueryClause(BooleanOperator, "new", "=", "another one", SqlDbType.NVarChar, true);
            //queryClauses.Add(q);
            List<Issue> issueList = IssueManager.PerformQuery(queryClauses, ProjectId);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issueList);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("FilteredIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("FilteredIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;   

        }

        /// <summary>
        /// Relevants the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void RelevantFeed(ref SyndicationFeed feed)
        {
            List<Issue> issueList = IssueManager.GetByRelevancy(ProjectId, User.Identity.Name);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issueList);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("RelevantIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("RelevantIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;   
        }

        /// <summary>
        /// Owneds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void OwnedFeed(ref SyndicationFeed feed)
        {
            List<Issue> issueList = IssueManager.GetByOwnerUserName(ProjectId, User.Identity.Name);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issueList);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("OwnedIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("OwnedIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems; 
        }

        /// <summary>
        /// Queries the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void QueryFeed(ref SyndicationFeed feed)
        {
            List<Issue> issueList = IssueManager.PerformSavedQuery(ProjectId, Convert.ToInt32(QueryId));
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issueList);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("SavedQueryTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("SavedQueryDescription").ToString(), p.Name));
            feed.Items = feedItems; 
        }

        /// <summary>
        /// Createds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void CreatedFeed(ref SyndicationFeed feed)
        {
            List<Issue> issueList = IssueManager.GetByCreatorUserName(ProjectId, User.Identity.Name);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(issueList);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("CreatedIssuesTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("CreatedIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems; 
        }

        /// <summary>
        /// Assignees the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AssigneeFeed(ref SyndicationFeed feed)
        {
            List<IssueCount> al = IssueManager.GetUserCountByProjectId(ProjectId);
            List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueCountList(al);
            Project p = ProjectManager.GetById(ProjectId);

            feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AssigneeTitle").ToString(), p.Name));
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("AssigneeDescription").ToString(), p.Name));
            feed.Items = feedItems;      
        }

        /// <summary>
        /// Gets feed for open issues.
        /// </summary>
        /// <param name="feed">SyndicationFeed</param>
        /// <remarks>Missing in build 0.9.152</remarks>
        private void OpenIssueFeed(ref SyndicationFeed feed)
        {
             List<Issue> openissueList = IssueManager.GetOpenIssues(ProjectId);
             List<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(openissueList);
             Project p = ProjectManager.GetById(ProjectId);
             feed.Title = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("OpenIssuesTitle").ToString(), p.Name));
              
            feed.Description = TextSyndicationContent.CreatePlaintextContent(string.Format(GetLocalResourceObject("OpenIssuesDescription").ToString(), p.Name));
              
            feed.Items = feedItems;
        }
        #endregion

        #region QueryString Properties
        public string QueryId
        {
            get
            {
                if (Context.Request.QueryString["q"] == null)
                    return string.Empty;

                return Context.Request.QueryString["q"];
            }
        }
        ///<summary>
        ///Returns the component Id from the querystring
        ///</summary>
        public string IssueCategoryId
        {
            get
            {
                if (Context.Request.QueryString["c"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["c"];
            }
        }
        /// <summary>
        /// Returns the keywords from the querystring
        /// </summary>
        public string Key
        {
            get
            {
                if (Context.Request.QueryString["key"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["key"].Replace("+", " ");
            }
        }
        /// <summary>
        /// Returns the Milestone Id from the querystring
        /// </summary>
        public string IssueMilestoneId
        {
            get
            {
                if (Context.Request.QueryString["m"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["m"].ToString();
            }
        }


        /// <summary>
        /// Returns the priority Id from the querystring
        /// </summary>
        public string IssuePriorityId
        {
            get
            {
                if (Context.Request.QueryString["p"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["p"].ToString();
            }
        }
        /// <summary>
        /// Returns the Type Id from the querystring
        /// </summary>
        public string IssueTypeId
        {
            get
            {
                if (Context.Request.QueryString["t"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["t"].ToString();
            }
        }
        /// <summary>
        /// Returns the status Id from the querystring
        /// </summary>
        public string IssueStatusId
        {
            get
            {
                if (Context.Request.QueryString["s"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["s"].ToString();
            }
        }
        /// <summary>
        /// Returns the assigned to user Id from the querystring
        /// </summary>
        public string AssignedUserName
        {
            get
            {
                if (Request.Params["u"] == null)
                {
                    return string.Empty;
                }
                return Request.Params["u"].ToString();
            }
        }

        /// <summary>
        /// Gets the name of the reporter user.
        /// </summary>
        /// <value>The name of the reporter user.</value>
        public string ReporterUserName
        {
            get
            {
                if (Context.Request.QueryString["ru"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["ru"].ToString();
            }
        }
        /// <summary>
        /// Returns the hardware Id from the querystring
        /// </summary>
        public string IssueResolutionId
        {
            get
            {
                if (Context.Request.QueryString["r"] == null)
                {
                    return string.Empty;
                }
                return Context.Request.QueryString["r"].ToString();
            }
        }

        /// <summary>
        /// Gets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return Convert.ToInt32(Context.Request.QueryString["bid"]); }
        }
        #endregion
    }
}