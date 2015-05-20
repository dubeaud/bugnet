namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for building the IssueReferenceToLinkConverter
    /// </summary>
    public static class IssueReferenceToLinkConverterBuilder
    {
        public static IssueReferenceToLinkConverter Build()
        {
            return new IssueReferenceToLinkConverter(
                new IssueReferenceParser(), 
                new IssueReferenceToIssueLink(new PathProvider()),
                new IssueReferenceReplacer(), 
                new IssueReferenceValidator());
        }
    }
}
