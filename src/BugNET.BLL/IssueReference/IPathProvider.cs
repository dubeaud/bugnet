namespace BugNET.BLL
{
    /// <summary>
    /// This interface abstracts a provider for providing absolute paths.
    /// </summary>
    public interface IPathProvider
    {
        string GetAbsolutePath(string path);
    }
}