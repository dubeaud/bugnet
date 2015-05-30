using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for parsing the given description into
    /// issue tokens. When a token is found in the text that corresponds to 
    /// "[project code]-[issue id]" it is translated into an IssueReference.
    /// </summary>
    public class IssueReferenceParser
    {
        public List<IssueReference> Parse(string projectCode, string description)
        {
            if (string.IsNullOrWhiteSpace(projectCode))
            {
                throw new ArgumentException("Cannot parse a description without a project code", "projectCode");
            }

            var parsedProjectIssueNumbers = new List<IssueReference>();

            var projectIssueNumberRegEx = new Regex(CreateRegExPattern(projectCode));
            foreach (Match projectCodeIssueNumberMatch in projectIssueNumberRegEx.Matches(description))
            {
                if (projectCodeIssueNumberMatch.Success)
                {
                    parsedProjectIssueNumbers.Add(new IssueReference
                    {
                        ProjectCode = projectCode,
                        IssueId = projectCodeIssueNumberMatch.Groups[1].ToString(),
                        Token = projectCodeIssueNumberMatch.ToString()
                    });
                }
            }

            return parsedProjectIssueNumbers;
        }

        private string CreateRegExPattern(object projectCode)
        {
            return projectCode + "-(\\d+)";
        }
    }
}