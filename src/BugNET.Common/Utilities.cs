using System;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Web;

namespace BugNET.Common
{
    public static class Utilities
    {
        public enum AppSettingKeys
        {
                InstallationDate,
                NotFoundUrl,
                SomethingMissingUrl,
                SessionExpiredUrl,
                ErrorUrl,
                AccessDeniedUrl
        }

        public static string GetAppSetting(AppSettingKeys key, string defaultValue)
        {
            return ConfigurationManager.AppSettings.Get(key.ToString(), defaultValue);
        }

        public static string GetBooleanAsString(bool value)
        {
            var boolString = (value) ? bool.TrueString : bool.FalseString;
            return ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, boolString);
        }

        /// <summary>
        /// Estimations to string.
        /// </summary>
        /// <param name="estimation">The estimation.</param>
        /// <returns></returns>
        public static string EstimationToString(decimal estimation)
        {
            return estimation >= 0 ? estimation.ToString() : ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Empty", "Empty").ToLower();
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
        public static string StripHTML(string sInputString)
        {
            try
            {
                var sOutputString = sInputString;
                //Initial Cleaning Step
                //Replace new line and carriage return with Spaces
                sOutputString = sOutputString.Replace("\r", " ");
                sOutputString = sOutputString.Replace("\n", " ");
                // Remove sTabs
                sOutputString = sOutputString.Replace("\t", String.Empty);

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
            dtCleaningCollection.Rows.Add(4, "(<head>).*(</head>)", String.Empty);

            // Prepare and clean Script Tag
            dtCleaningCollection.Rows.Add(5, @"<( )*script([^>])*>", "<script>");
            dtCleaningCollection.Rows.Add(6, @"(<( )*(/)( )*script( )*>)", "</script>");
            dtCleaningCollection.Rows.Add(7, @"(<script>).*(</script>)", String.Empty);

            // Prepare and clean Style Tag
            dtCleaningCollection.Rows.Add(8, @"<( )*style([^>])*>", "<style>");
            dtCleaningCollection.Rows.Add(9, @"(<( )*(/)( )*style( )*>)", "</style>");
            dtCleaningCollection.Rows.Add(10, "(<style>).*(</style>)", String.Empty);

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
            dtCleaningCollection.Rows.Add(17, @"<[^>]*>", String.Empty);

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
            dtCleaningCollection.Rows.Add(35, @"&(.{2,6});", String.Empty);

            // Remove extra line sBreaks and sTabs
            dtCleaningCollection.Rows.Add(36, "(\r)( )+(\r)", "\r\r");
            dtCleaningCollection.Rows.Add(37, "(\t)( )+(\t)", "\t\t");
            dtCleaningCollection.Rows.Add(38, "(\t)( )+(\r)", "\t\r");
            dtCleaningCollection.Rows.Add(39, "(\r)( )+(\t)", "\r\t");
            dtCleaningCollection.Rows.Add(40, "(\r)(\t)+(\r)", "\r\r");
            dtCleaningCollection.Rows.Add(41, "(\r)(\t)+", "\r\t");

            return dtCleaningCollection;
        }
    }
}
