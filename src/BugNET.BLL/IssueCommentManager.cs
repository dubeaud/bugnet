using System;
using System.Collections.Generic;
using System.Data;
using System.Text.RegularExpressions;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueCommentManager 
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// The default length of short comments (if not specified).
        /// </summary>
        private const int CNST_DEFAULTSHORT_COMMENT_LENGTH = 100;

        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveIssueComment(IssueComment issueCommentToSave)
        {
            if (issueCommentToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdateIssueComment(issueCommentToSave);
            }
            var tempId = DataProviderManager.Provider.CreateNewIssueComment(issueCommentToSave);

            if (tempId <= Globals.NEW_ID)
                return false;

            issueCommentToSave.Id = tempId;

            IssueNotificationManager.SendNewIssueCommentNotification(
                issueCommentToSave.IssueId,
                GetIssueCommentById(
                issueCommentToSave.Id));

            return true;
        }

        /// <summary>
        /// Gets a "short text" version of the comment.
        /// This is handy for lists or summary data. (perhaps something in notifications too).
        /// The returned text is "howmuch" chars long, and is centered on the middle-point
        /// (if the string is long enough).
        /// This strips HTML from the comment and does a bit of cleaning of the output.
        /// BGN-1732 - IssueComment needs a new Property to read short comments for list displays
        /// </summary>
        /// <param name="comment">The comment.</param>
        /// <param name="howmuch">How long must the string be.</param>
        /// <returns></returns>
        public static string GetShortTextComment(string comment, int howmuch = CNST_DEFAULTSHORT_COMMENT_LENGTH)
        {

            string tmpcomment = comment.Trim();

            if (tmpcomment == "") return tmpcomment;

            tmpcomment = StripHTML(tmpcomment).Trim();

            // Now fix up any other characters we dont want. 
            // This is a quick summary of a comment after all.
            tmpcomment = tmpcomment.Replace("\t", " ");
            tmpcomment = tmpcomment.Replace("\r", " ");
            tmpcomment = tmpcomment.Replace("\n", " ");

            // Keep replacing double-spaces until there are none left.
            while (tmpcomment.IndexOf("  ") != -1)
            {
                tmpcomment = tmpcomment.Replace("  ", " ");
            }

            // Give it one last trim
            tmpcomment = tmpcomment.Trim();

            // Now find the centre of the string
            int tmplen = tmpcomment.Length;
            int tmpint = tmplen / 2;

            // and create a string "howmuch" chars long centred on the middle-point
            // if the string is long enough.
            if (tmpint > howmuch)
            {
                // Longer than the string
                tmpcomment = tmpcomment.Substring(tmpint - (howmuch / 2), howmuch);
            }

            return tmpcomment;
        }



        /// <summary>
        /// Gets all comments for a issue
        /// </summary>
        /// <param name="issueId"></param>
        /// <returns>List of Comment Objects</returns>
        public static List<IssueComment> GetIssueCommentsByIssueId(int issueId)
        {
            return DataProviderManager.Provider.GetIssueCommentsByIssueId(issueId);
        }

        /// <summary>
        /// Delete a comment by Id
        /// </summary>
        /// <param name="commentId"></param>
        /// <returns>True if successful</returns>
        public static bool DeleteIssueCommentById(int commentId)
        {
            return DataProviderManager.Provider.DeleteIssueCommentById(commentId);
        }

        /// <summary>
        /// Gets the issue comment by id.
        /// </summary>
        /// <param name="issueCommentId">The issue comment id.</param>
        /// <returns></returns>
        public static IssueComment GetIssueCommentById(int issueCommentId)
        {
            return DataProviderManager.Provider.GetIssueCommentById(issueCommentId);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 
        /// 
        /// Performs a query containing any number of query clauses on a certain IssueID
        /// </summary>
        /// <param name="issueId"></param>
        /// <param name="queryClauses"></param>
        /// <returns></returns>
        public static List<IssueComment> PerformQuery(int issueId, List<QueryClause> queryClauses)
        {
            if (issueId < 0)
                throw new ArgumentOutOfRangeException("issueId", "issueId must be bigger than 0");
            queryClauses.Add(new QueryClause("AND", "IssueId", "=", issueId.ToString(), SqlDbType.Int, false));

            return PerformQuery(queryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueComment table, regardless of 
        /// project level privledges. (thats why its private for now)
        /// </summary>        
        /// <param name="queryClauses"></param>
        /// <returns></returns>
        private static List<IssueComment> PerformQuery(List<QueryClause> queryClauses)
        {
            if (queryClauses == null)
                throw new ArgumentNullException("queryClauses");

            var lst = new List<IssueComment>();
            DataProviderManager.Provider.PerformGenericQuery(ref lst, queryClauses, @"SELECT a.*, b.UserName as CreatorUserName, a.Userid as CreatorUserID, b.Username as CreatorDisplayName from BugNet_IssueComments as a, aspnet_Users as b  WHERE a.UserId=b.UserID ", @" ORDER BY IssueCommentId DESC");

            return lst;
        }

        /// <summary>
        /// Strips the HTML. BGN-1732
        /// 
        /// This should be in a helper classer
        /// 
        /// From http://www.codeproject.com/Articles/68222/Strip-HTML-Tags-from-Text.aspx
        /// Copyright Raymund Macaalay | 25 Mar 2010
        /// http://nz.linkedin.com/in/macaalay
        /// http://anyrest.wordpress.com/
        /// </summary>
        /// <param name="sInputString">The s input string.</param>
        /// <returns></returns>
        private static string StripHTML(string sInputString)
        {
            try
            {
                var sOutputString = sInputString;
                //Initial Cleaning Step
                //Replace new line and carriage return with Spaces
                sOutputString = sOutputString.Replace("\r", " ");
                sOutputString = sOutputString.Replace("\n", " ");
                // Remove sTabs
                sOutputString = sOutputString.Replace("\t", string.Empty);

                //Tag Removal
                var myDataTable = GetTableDefinition();
                myDataTable.DefaultView.Sort = "iID ASC";
                foreach (DataRow drCleaningItem in myDataTable.Rows)
                {
                    var sOriginalString = (drCleaningItem["sOriginalString"]).ToString();
                    var sReplacementString = (drCleaningItem["sReplacementString"]).ToString();
                    sOutputString = Regex.Replace
                       (sOutputString, sOriginalString, sReplacementString, RegexOptions.IgnoreCase);
                }

                //Initial replacement target string for linebreaks
                var sBreaks = "\r\r\r";

                // Initial replacement target string for sTabs
                var sTabs = "\t\t\t\t\t";
                for (var x = 0; x < sOutputString.Length; x++)
                {
                    sOutputString = sOutputString.Replace(sBreaks, "\r\r");
                    sOutputString = sOutputString.Replace(sTabs, "\t\t\t\t");
                    sBreaks = sBreaks + "\r";
                    sTabs = sTabs + "\t";
                }

                return sOutputString;
            }
            catch
            {
                return sInputString;
            }
        }

        /// <summary>
        /// Gets the table definition. BGN-1732
        /// 
        /// Needs System.Data :(
        /// 
        /// This should be in a helper classer
        /// 
        /// From http://www.codeproject.com/Articles/68222/Strip-HTML-Tags-from-Text.aspx
        /// Copyright Raymund Macaalay | 25 Mar 2010
        /// http://nz.linkedin.com/in/macaalay
        /// http://anyrest.wordpress.com/
        /// </summary>
        /// <returns></returns>
        private static DataTable GetTableDefinition()
        {
            var dtCleaningCollection = new DataTable();
            dtCleaningCollection.Columns.Add("iID", typeof(int));
            dtCleaningCollection.Columns.Add("sOriginalString", typeof(string));
            dtCleaningCollection.Columns.Add("sReplacementString", typeof(string));

            // Replace repeating spaces with single space
            dtCleaningCollection.Rows.Add(1, @"( )+", " ");

            // Prepare and clean Header Tag
            dtCleaningCollection.Rows.Add(2, @"<( )*head([^>])*>", "<head>");
            dtCleaningCollection.Rows.Add(3, @"(<( )*(/)( )*head( )*>)", "</head>");
            dtCleaningCollection.Rows.Add(4, "(<head>).*(</head>)", string.Empty);

            // Prepare and clean Script Tag
            dtCleaningCollection.Rows.Add(5, @"<( )*script([^>])*>", "<script>");
            dtCleaningCollection.Rows.Add(6, @"(<( )*(/)( )*script( )*>)", "</script>");
            dtCleaningCollection.Rows.Add(7, @"(<script>).*(</script>)", string.Empty);

            // Prepare and clean Style Tag
            dtCleaningCollection.Rows.Add(8, @"<( )*style([^>])*>", "<style>");
            dtCleaningCollection.Rows.Add(9, @"(<( )*(/)( )*style( )*>)", "</style>");
            dtCleaningCollection.Rows.Add(10, "(<style>).*(</style>)", string.Empty);

            // Replace <td> with sTabs
            dtCleaningCollection.Rows.Add(11, @"<( )*td([^>])*>", "\t");

            // Replace <BR> and <LI> with Line sBreaks
            dtCleaningCollection.Rows.Add(12, @"<( )*br( )*>", "\r");
            dtCleaningCollection.Rows.Add(13, @"<( )*li( )*>", "\r");

            // Replace <P>, <DIV> and <TR> with Double Line sBreaks
            dtCleaningCollection.Rows.Add(14, @"<( )*div([^>])*>", "\r\r");
            dtCleaningCollection.Rows.Add(15, @"<( )*tr([^>])*>", "\r\r");
            dtCleaningCollection.Rows.Add(16, @"<( )*p([^>])*>", "\r\r");

            // Remove Remaining tags enclosed in < >
            dtCleaningCollection.Rows.Add(17, @"<[^>]*>", string.Empty);

            // Replace special characters:
            dtCleaningCollection.Rows.Add(18, @" ", " ");
            dtCleaningCollection.Rows.Add(19, @"&bull;", " * ");
            dtCleaningCollection.Rows.Add(20, @"&lsaquo;", "<");
            dtCleaningCollection.Rows.Add(21, @"&rsaquo;", ">");
            dtCleaningCollection.Rows.Add(22, @"&trade;", "(tm)");
            dtCleaningCollection.Rows.Add(23, @"&frasl;", "/");
            dtCleaningCollection.Rows.Add(24, @"&lt;", "<");
            dtCleaningCollection.Rows.Add(25, @"&gt;", ">");
            dtCleaningCollection.Rows.Add(26, @"&copy;", "(c)");
            dtCleaningCollection.Rows.Add(27, @"&reg;", "(r)");
            dtCleaningCollection.Rows.Add(28, @"&frac14;", "1/4");
            dtCleaningCollection.Rows.Add(29, @"&frac12;", "1/2");
            dtCleaningCollection.Rows.Add(30, @"&frac34;", "3/4");
            dtCleaningCollection.Rows.Add(31, @"&lsquo;", "'");
            dtCleaningCollection.Rows.Add(32, @"&rsquo;", "'");
            dtCleaningCollection.Rows.Add(33, @"&ldquo;", "\"");
            dtCleaningCollection.Rows.Add(34, @"&rdquo;", "\"");

            // Remove all others remianing special characters
            // you dont want to replace with another string
            dtCleaningCollection.Rows.Add(35, @"&(.{2,6});", string.Empty);

            // Remove extra line sBreaks and sTabs
            dtCleaningCollection.Rows.Add(36, "(\r)( )+(\r)", "\r\r");
            dtCleaningCollection.Rows.Add(37, "(\t)( )+(\t)", "\t\t");
            dtCleaningCollection.Rows.Add(38, "(\t)( )+(\r)", "\t\r");
            dtCleaningCollection.Rows.Add(39, "(\r)( )+(\t)", "\r\t");
            dtCleaningCollection.Rows.Add(40, "(\r)(\t)+(\r)", "\r\r");
            dtCleaningCollection.Rows.Add(41, "(\r)(\t)+", "\r\t");

            return dtCleaningCollection;
        }



        #endregion

       
    }
}
