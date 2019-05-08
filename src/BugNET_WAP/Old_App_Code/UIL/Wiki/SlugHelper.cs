using System;
using System.Text;
using System.Text.RegularExpressions;

namespace BugNET.UserInterfaceLayer.Wiki
{
    // Code taken from Jeff Atwood at
    // http://stackoverflow.com/questions/25259/how-do-you-include-a-webpage-title-as-part-of-a-webpage-url
    public static class SlugHelper
    {
        private static readonly Regex EntityRegex = new Regex(@"&\w+;", RegexOptions.Compiled);

        public static string Generate(string input)
        {
            if (String.IsNullOrEmpty(input)) return "";

            // to lowercase, trim extra spaces
            input = input.ToLower().Trim();
            
            // remove entities
            input = EntityRegex.Replace(input, "");

            int len = input.Length;
            var sb = new StringBuilder(len);
            bool prevdash = false;
            char c;

            for (int i = 0; i < input.Length; i++)
            {
                c = input[i];
                if (c == ' ' || c == ',' || c == '.' || c == '/' || c == '\\' || c == '-')
                {
                    if (!prevdash)
                    {
                        sb.Append('-');
                        prevdash = true;
                    }
                }
                else if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
                {
                    sb.Append(c);
                    prevdash = false;
                }
                if (i == 255) break;
            }

            input = sb.ToString(); 
            
            // remove trailing dash, if there is one
            if (input.EndsWith("-"))    
                input = input.Substring(0, input.Length - 1);

            return input;
        }
    }
}