using BugNET.BLL;

namespace BugNET.Tests
{
    public class MockPathProvider : IPathProvider
    {
        private readonly string baseUrl;

        public MockPathProvider(string baseUrl)
        {
            this.baseUrl = baseUrl;
        }

        public string GetAbsolutePath(string path)
        {
            string tmpp = path.Replace("~", "").Trim();
            tmpp = baseUrl + tmpp;
            return tmpp;
        }
    }
}
