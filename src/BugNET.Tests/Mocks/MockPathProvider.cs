using System.Reflection;

namespace BugNET.Tests.Mocks
{
    public static class MockPathProvider
    {
        public static string MapPath(string pathin)
        {
            string tmpp = pathin.Replace("/", @"\").Replace("~", "").Trim();
            tmpp = Assembly.GetExecutingAssembly().Location + tmpp;

            return tmpp;
        }
    }
}
