// Copyright (C) CodeAscent.

namespace BugNET.UserInterfaceLayer.Wiki
{
    using System.Collections.Generic;
    using WikiPlex.Compilation;
    using WikiPlex.Compilation.Macros;
    using System.Text.RegularExpressions;
    using WikiPlex;

    public class IssueLinkMacro : IMacro
    {

        public string Id
        {
            get { return "Issue Link"; }
        }

        public IList<MacroRule> Rules
        {
            get
            {
                return new List<MacroRule>
                           {
                               new MacroRule(EscapeRegexPatterns.CurlyBraceEscape),
                               new MacroRule(@"(?i)(\[)(issue:[\w\W\s\]\|?[a-z]{1,50}-\d+)(\])",
                                             new Dictionary<int, string>
                                                 {
                                                     {1, ScopeName.Remove},
                                                     {2, WikiScopeName.IssueLink},
                                                     {3, ScopeName.Remove}
                                                 }
                                   )
                           };
            }
        }
    }
}