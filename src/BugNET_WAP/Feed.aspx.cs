using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel.Syndication;
using System.Web.UI;
using System.Xml;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using System.Web;

namespace BugNET
{
    /// <summary>
    /// Generates Syndication Feeds for BugNET
    /// </summary>
    public partial class Feed : Page
    {
        private const int maxItemsInFeed = 10;
        private int _projectId;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            var channelId = 0;
            // Determine the maximum number of items to show in the feed

            if (Request.QueryString["pid"] != null)
                _projectId = Convert.ToInt32(Request.Params["pid"]);

            //get feed id
            if (Request.QueryString["channel"] != null)
                channelId = Convert.ToInt32(Request.Params["channel"]);

            if (!User.Identity.IsAuthenticated && _projectId == 0)
            {
                throw new HttpException(403, "Access Denied");

            }

            if (_projectId != 0)
            {
                //Security Checks
                if (!User.Identity.IsAuthenticated &&
                    ProjectManager.GetById(_projectId).AccessType == ProjectAccessType.Private)
                {
                    throw new HttpException(403, "Access Denied");
                }

                if (User.Identity.IsAuthenticated &&
                    ProjectManager.GetById(_projectId).AccessType == ProjectAccessType.Private &&
                    !ProjectManager.IsUserProjectMember(User.Identity.Name, _projectId))
                {
                    throw new HttpException(403, "Access Denied");
                }
            }


            // Determine whether we're outputting an Atom or RSS feed
            var outputRss = (Request.QueryString["Type"] == "RSS");
            var outputAtom = !outputRss;

            // Output the appropriate ContentType
            Response.ContentType = outputRss ? "application/rss+xml" : "application/atom+xml";

            // Create the feed and specify the feed's attributes
            var myFeed = new SyndicationFeed();
            myFeed.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(GetFullyQualifiedUrl("~/Default.aspx"))));
            myFeed.Links.Add(SyndicationLink.CreateSelfLink(new Uri(GetFullyQualifiedUrl(Request.RawUrl))));
            //myFeed.Copyright = TextSyndicationContent.CreatePlaintextContent("Copyright Nile.com Bookstore");
            myFeed.Language = "en-us";

            switch (channelId)
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
                case 14: 
                    OpenIssueFeed(ref myFeed); 
                    break;
                case 15: 
                    MonitoredFeed(ref myFeed); 
                    break;
                //case 16:
                //    MyIssuesAssignedFeed(ref myFeed);
                //    break;
              
         
            }

            // Return the feed's XML content as the response
            var outputSettings = new XmlWriterSettings {Indent = true};
            //(Uncomment for readability during testing)
            var feedWriter = XmlWriter.Create(Response.OutputStream, outputSettings);

            if (outputAtom)
            {
                // Use Atom 1.0        
                var atomFormatter = new Atom10FeedFormatter(myFeed);
                atomFormatter.WriteTo(feedWriter);
            }
            else
            {
                // Emit RSS 2.0
                var rssFormatter = new Rss20FeedFormatter(myFeed);
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
        private IEnumerable<SyndicationItem> CreateSyndicationItemsFromIssueList(IEnumerable<Issue> issueList)
        {
            var feedItems = new List<SyndicationItem>();

            foreach (Issue issue in issueList.Take(maxItemsInFeed))
            {
                // Atom items MUST have an author, so if there are no authors for this content item then go to next item in loop
                //if (outputAtom && t.TitleAuthors.Count == 0)
                //    continue;    
                var item = new SyndicationItem
                {
                    Title = SyndicationContent.CreatePlaintextContent(string.Format("{0} - {1}", issue.FullId, issue.Title))
                };

                item.Links.Add(
                    SyndicationLink.CreateAlternateLink(
                        new Uri(
                            GetFullyQualifiedUrl(string.Format("~/Issues/IssueDetail.aspx?id={0}", issue.Id)))));
                item.Summary = SyndicationContent.CreatePlaintextContent(issue.Description);
                item.Categories.Add(new SyndicationCategory(issue.CategoryName));
                item.PublishDate = issue.DateCreated;

                // Add a custom element.
                var doc = new XmlDocument();
                var itemElement = doc.CreateElement("milestone");
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
                var profile = new WebProfile().GetProfile(issue.CreatorUserName);
                var authInfo = new SyndicationPerson {Name = profile.DisplayName};
                //authInfo.Email = Membership.GetUser(IssueCreatorUserId).Email;
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
        private IEnumerable<SyndicationItem> CreateSyndicationItemsFromIssueCountList(IEnumerable<IssueCount> issueCountList)
        {
            var feedItems = new List<SyndicationItem>();

            foreach (var issueCount in issueCountList.Take(maxItemsInFeed))
            {
                // Atom items MUST have an author, so if there are no authors for this content item then go to next item in loop
                //if (outputAtom && t.TitleAuthors.Count == 0)
                //    continue;    
                var item = new SyndicationItem {Title = SyndicationContent.CreatePlaintextContent(issueCount.Name)};

                item.Links.Add(
                    SyndicationLink.CreateAlternateLink(
                        new Uri(
                            GetFullyQualifiedUrl(string.Format("~/Issues/IssueList.aspx?pid={0}&s=0&m={1}", _projectId,
                                                               issueCount.Id)))));
                item.Summary =
                    SyndicationContent.CreatePlaintextContent(string.Concat(issueCount.Count.ToString(), " Open Issues"));
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
            var lsVersion = IssueManager.GetMilestoneCountByProjectId(_projectId);
            var feedItems = CreateSyndicationItemsFromIssueCountList(lsVersion);
            var p = ProjectManager.GetById(_projectId);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByMilestoneTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByMilestoneDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Alls the issues feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AllIssuesFeed(ref SyndicationFeed feed)
        {
            IEnumerable<SyndicationItem> feedItems = CreateSyndicationItemsFromIssueList(IssueManager.GetByProjectId(_projectId));
            Project p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AllIssuesTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AllIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By category
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void CategoryFeed(ref SyndicationFeed feed)
        {
            var objComps = new CategoryTree();
            List<Category> al = objComps.GetCategoryTreeByProjectId(_projectId);

            var feedItems = new List<SyndicationItem>();
            Project p = ProjectManager.GetById(_projectId);

            foreach (Category c in al)
            {
                var item = new SyndicationItem();

                item.Title = SyndicationContent.CreatePlaintextContent(c.Name);
                item.Links.Add(
                    SyndicationLink.CreateAlternateLink(
                        new Uri(
                            GetFullyQualifiedUrl(string.Format("~/Issues/IssueList.aspx?pid={0}&s=0&c={1}", _projectId,
                                                               c.Id)))));
                item.Summary =
                    SyndicationContent.CreatePlaintextContent(
                        string.Concat(IssueManager.GetCountByProjectAndCategoryId(_projectId, c.Id).ToString(),
                                      GetLocalResourceObject("OpenIssues").ToString()));
                item.PublishDate = DateTime.Now;
                // Add the item to the feed
                feedItems.Add(item);
            }
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByCategoryTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByCategoryDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By Status
        /// </summary>
        private void StatusFeed(ref SyndicationFeed feed)
        {
            var al = IssueManager.GetStatusCountByProjectId(_projectId);
            var p = ProjectManager.GetById(_projectId);

            var feedItems = CreateSyndicationItemsFromIssueCountList(al);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByStatusTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByStatusDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Priorities the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void PriorityFeed(ref SyndicationFeed feed)
        {
            var al = IssueManager.GetPriorityCountByProjectId(_projectId);
            var p = ProjectManager.GetById(_projectId);

            var feedItems = CreateSyndicationItemsFromIssueCountList(al);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByPriorityTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByPriorityDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Creates an RSS news feed for Issues By Type
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void TypeFeed(ref SyndicationFeed feed)
        {
            var al = IssueManager.GetTypeCountByProjectId(_projectId);
            var p = ProjectManager.GetById(_projectId);

            var feedItems = CreateSyndicationItemsFromIssueCountList(al);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByIssueTypeTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("IssuesByIssueTypeDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Assigneds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AssignedFeed(ref SyndicationFeed feed)
        {
            var issues = IssueManager.GetByAssignedUserName(_projectId, User.Identity.Name);
            var p = ProjectManager.GetById(_projectId);
            var feedItems = CreateSyndicationItemsFromIssueList(issues);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AssignedIssuesTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AssignedIssuesDescription").ToString(),
                                  Security.GetDisplayName()));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Filtereds the issues feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void FilteredIssuesFeed(ref SyndicationFeed feed)
        {
            var queryClauses = new List<QueryClause>();

            var isStatus = false;

            // add the disabled field as the first order of business
            var q = new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int);
            queryClauses.Add(q);

            if (!string.IsNullOrEmpty(IssueCategoryId))
            {
                q = IssueCategoryId == "0" ?
                    new QueryClause("AND", "iv.[IssueCategoryId]", "IS", null, SqlDbType.Int) :
                    new QueryClause("AND", "iv.[IssueCategoryId]", "=", IssueCategoryId, SqlDbType.Int);

                queryClauses.Add(q);
            }

            if (!string.IsNullOrEmpty(IssueTypeId))
            {
                q = IssueTypeId == "0" ?
                    new QueryClause("AND", "iv.[IssueTypeId]", "IS", null, SqlDbType.Int) :
                    new QueryClause("AND", "iv.[IssueTypeId]", "=", IssueTypeId, SqlDbType.Int);

                queryClauses.Add(q);
            }

            if (!string.IsNullOrEmpty(IssuePriorityId))
            {
                q = IssuePriorityId == "0" ?
                    new QueryClause("AND", "iv.[IssuePriorityId]", "IS", null, SqlDbType.Int) :
                    new QueryClause("AND", "iv.[IssuePriorityId]", "=", IssuePriorityId, SqlDbType.Int);

                queryClauses.Add(q);
            }

            if (!string.IsNullOrEmpty(IssueMilestoneId))
            {
                q = IssueMilestoneId == "0" ?
                    new QueryClause("AND", "iv.[IssueMilestoneId]", "IS", null, SqlDbType.Int) :
                    new QueryClause("AND", "iv.[IssueMilestoneId]", "=", IssueMilestoneId, SqlDbType.Int);

                queryClauses.Add(q);
            }

            if (!string.IsNullOrEmpty(IssueResolutionId))
            {
                q = IssueResolutionId == "0" ?
                    new QueryClause("AND", "iv.[IssueResolutionId]", "IS", null, SqlDbType.Int) :
                    new QueryClause("AND", "iv.[IssueResolutionId]", "=", IssueResolutionId, SqlDbType.Int);

                queryClauses.Add(q);
            }

            if (!string.IsNullOrEmpty(AssignedUserName))
            {
                queryClauses.Add(new QueryClause("AND", "iv.[AssignedUserName]", "=", AssignedUserName, SqlDbType.NVarChar));
            }

            if (!string.IsNullOrEmpty(OwnerUserName))
            {
                queryClauses.Add(new QueryClause("AND", "iv.[OwnerUserName]", "=", OwnerUserName, SqlDbType.NVarChar));
            }

            if (!string.IsNullOrEmpty(IssueStatusId))
            {
                if (IssueStatusId != "-1")
                {
                    isStatus = true;

                    q = IssueStatusId == "0" ?
                        new QueryClause("AND", "iv.[IssueStatusId]", "IS", null, SqlDbType.Int) :
                        new QueryClause("AND", "iv.[IssueStatusId]", "=", IssueStatusId, SqlDbType.Int);

                    queryClauses.Add(q);
                }
                else
                {
                    isStatus = true;
                    queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int));
                }
            }

            // exclude all closed status's
            if (!isStatus || ExcludeClosedIssues)
            {
                queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int));
            }

            var issueList = IssueManager.PerformQuery(queryClauses, null, _projectId);


            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            string title;
            if (_projectId > 0)
            {
                var p = ProjectManager.GetById(_projectId);
                title = p.Name;
            }
            else
            {
                title = Security.GetDisplayName();
            }

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("FilteredIssuesTitle").ToString(), title));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("FilteredIssuesDescription").ToString(), title));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Relevants the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void RelevantFeed(ref SyndicationFeed feed)
        {
            var issueList = IssueManager.GetByRelevancy(_projectId, User.Identity.Name);
            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            var p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("RelevantIssuesTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("RelevantIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Owneds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void OwnedFeed(ref SyndicationFeed feed)
        {
            var issueList = IssueManager.GetByOwnerUserName(_projectId, User.Identity.Name);
            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            var p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("OwnedIssuesTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("OwnedIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        private void MonitoredFeed(ref SyndicationFeed feed)
        {
            bool excludeClosedIssues = false;
            //get feed id
            if (Request.QueryString["ec"] != null)
                excludeClosedIssues = Convert.ToBoolean(Request.Params["ec"]);

            var issueList = IssueManager.GetMonitoredIssuesByUserName(Security.GetUserName(), excludeClosedIssues);
            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            var profile = new WebProfile().GetProfile(Security.GetUserName());

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("MonitoredIssuesTitle").ToString(), profile.DisplayName));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("MonitoredIssuesDescription").ToString(), profile.DisplayName));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Queries the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void QueryFeed(ref SyndicationFeed feed)
        {
            var issueList = IssueManager.PerformSavedQuery(_projectId, QueryId);
            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            var p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("SavedQueryTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("SavedQueryDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Createds the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void CreatedFeed(ref SyndicationFeed feed)
        {
            var issueList = IssueManager.GetByCreatorUserName(_projectId, User.Identity.Name);
            var feedItems = CreateSyndicationItemsFromIssueList(issueList);
            var p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("CreatedIssuesTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("CreatedIssuesDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Assignees the feed.
        /// </summary>
        /// <param name="feed">The feed.</param>
        private void AssigneeFeed(ref SyndicationFeed feed)
        {
            var al = IssueManager.GetUserCountByProjectId(_projectId);
            var feedItems = CreateSyndicationItemsFromIssueCountList(al);
            var p = ProjectManager.GetById(_projectId);

            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AssigneeTitle").ToString(), p.Name));
            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("AssigneeDescription").ToString(), p.Name));
            feed.Items = feedItems;
        }

        /// <summary>
        /// Gets feed for open issues.
        /// </summary>
        private void OpenIssueFeed(ref SyndicationFeed feed)
        {
            var openissueList = IssueManager.GetOpenIssues(_projectId);
            var feedItems = CreateSyndicationItemsFromIssueList(openissueList);
            var p = ProjectManager.GetById(_projectId);
            feed.Title =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("OpenIssuesTitle").ToString(), p.Name));

            feed.Description =
                SyndicationContent.CreatePlaintextContent(
                    string.Format(GetLocalResourceObject("OpenIssuesDescription").ToString(), p.Name));

            feed.Items = feedItems;
        }

        #endregion

        #region Querystring Properties

        /// <summary>
        /// Returns the component Id from the query string
        /// </summary>
        public string IssueCategoryId
        {
            get
            {
                return Request.Get("c", string.Empty);
            }
        }

        /// <summary>
        /// Returns the keywords from the query string
        /// </summary>
        public string Key
        {
            get
            {
                return Request.Get("key", string.Empty).Replace("+", " ");
            }
        }

        /// <summary>
        /// Returns the Milestone Id from the query string
        /// </summary>
        public string IssueMilestoneId
        {
            get
            {
                return Request.Get("m", string.Empty);
            }
        }

        /// <summary>
        /// Returns the priority Id from the query string
        /// </summary>
        public string IssuePriorityId
        {
            get
            {
                return Request.Get("p", string.Empty);
            }
        }

        /// <summary>
        /// Returns the Type Id from the query string
        /// </summary>
        public string IssueTypeId
        {
            get
            {
                return Request.Get("t", string.Empty);
            }
        }

        /// <summary>
        /// Returns the status Id from the query string
        /// </summary>
        public string IssueStatusId
        {
            get
            {
                return Request.Get("s", string.Empty);
            }
        }

        /// <summary>
        /// Returns the assigned to user Id from the query string
        /// </summary>
        public string AssignedUserName
        {
            get
            {
                return Request.Get("u", string.Empty);
            }
        }

        /// <summary>
        /// Gets the name of the owner user.
        /// </summary>
        /// <value>The name of the owner user.</value>
        public string OwnerUserName
        {
            get
            {
                return Request.Get("ou", string.Empty);
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
                return Request.Get("ru", string.Empty);
            }
        }

        /// <summary>
        /// Returns the hardware Id from the query string
        /// </summary>
        public string IssueResolutionId
        {
            get
            {
                return Request.Get("r", string.Empty);
            }
        }

        /// <summary>
        /// Gets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int QueryId
        {
            get
            {
                return Request.Get("q", -1);
            }
        }

        public bool ExcludeClosedIssues
        {
            get
            {
                return Request.Get("ec", true);
            }
        }

        #endregion
    }
}