using System;

namespace BugNET.Entities
{
	/// <summary>
	/// Summary description for ProjectMailbox.
	/// </summary>
	public class ProjectMailbox
	{
		#region Constructors

        public ProjectMailbox()
        {
            Mailbox = string.Empty;
            AssignToUserName = string.Empty;
            AssignToDisplayName = string.Empty;
            IssueTypeName = string.Empty;
        }

		#endregion

		#region Properties

	    /// <summary>
	    /// Gets the id.
	    /// </summary>
	    /// <value>The id.</value>
	    public int Id { get; set; }

	    /// <summary>
	    /// Gets the mailbox.
	    /// </summary>
	    /// <value>The mailbox.</value>
	    public string Mailbox { get; set; }

	    /// <summary>
	    /// Gets the project id.
	    /// </summary>
	    /// <value>The project id.</value>
	    public int ProjectId { get; set; }

	    /// <summary>
	    /// Gets the assign to ID.
	    /// </summary>
	    /// <value>The assign to ID.</value>
	    public Guid AssignToId { get; set; }

	    /// <summary>
	    /// Gets the issue type id.
	    /// </summary>
	    /// <value>The issue type id.</value>
	    public int IssueTypeId { get; set; }

	    /// <summary>
	    /// Gets the name of the assign to.
	    /// </summary>
	    /// <value>The name of the assign to.</value>
	    public string AssignToDisplayName { get; set; }

	    /// <summary>
	    /// Gets the assign to UserName.
	    /// </summary>
	    /// <value>The assign to UserName.</value>
	    public string AssignToUserName { get; set; }

	    /// <summary>
	    /// Gets the name of the issue type.
	    /// </summary>
	    /// <value>The name of the issue type.</value>
	    public string IssueTypeName { get; set; }

	    #endregion



	}
}
