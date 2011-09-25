namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// Interface for issue tabs
    /// </summary>
	public interface IIssueTab 
	{

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
		int IssueId 
		{
			get;
			set;
		}
        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		int ProjectId
		{
			get;
			set;
		}

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        void Initialize();

	}
}
