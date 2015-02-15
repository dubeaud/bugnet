namespace BugNET.Entities
{
    /// <summary>
    /// Class for project images
    /// </summary>
    public class ProjectImage
    {
        public int ProjectId { get; set; }
        public byte[] ImageContent { get; set; }
        public string ImageFileName { get; set; }
        public long ImageFileLength { get; set; }
        public string ImageContentType { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectImage"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="imageContent">Content of the image.</param>
        /// <param name="imageFileName">Name of the image file.</param>
        /// <param name="imageFileLength">Length of the image file.</param>
        /// <param name="imageContentType">Type of the image content.</param>
        public ProjectImage(int projectId, byte[] imageContent, string imageFileName, long imageFileLength, string imageContentType)
        {
            ProjectId = projectId;
            ImageContent = imageContent;
            ImageFileName = imageFileName;
            ImageFileLength = imageFileLength;
            ImageContentType = imageContentType;
        }
    }
}
