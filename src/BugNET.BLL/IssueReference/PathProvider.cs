namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for converting a virtual path to an application absolute path.
    /// </summary>
    public class PathProvider : IPathProvider
    {
        public string GetAbsolutePath(string path)
        {
            return System.Web.VirtualPathUtility.ToAbsolute(path);
        }
    }
}
