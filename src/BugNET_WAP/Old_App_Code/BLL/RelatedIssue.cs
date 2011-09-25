using System;
using BugNET.DataAccessLayer;
using System.Collections;
using System.Collections.Generic;

namespace BugNET.BusinessLogicLayer
{
	/// <Summary>
	/// Summary description for RelatedIssue.
	/// </Summary>
	public class RelatedIssue
	{
		#region Private Variables
            private int _IssueId;
            private string _Title;
            private DateTime _DateCreated;
            private string _Status;
            private string _Resolution;
		#endregion
		
		#region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="RelatedIssue"/> class.
            /// </summary>
            /// <param name="issueId">The bug id.</param>
            /// <param name="title">The title.</param>
            /// <param name="dateCreated">The reported date.</param>
            /// <Summary>
            /// Initializes a new instance of the <see cref="RelatedIssue"/> class.
            /// </Summary>
            public RelatedIssue(int issueId, string title,string status,string resolution, DateTime dateCreated)
            {
                _IssueId          = issueId;
                _Title        = title;
                _DateCreated    = dateCreated;
                _Status = status;
                _Resolution = resolution;
            }
		#endregion

        /// <Summary>
        /// Gets the reported date.
        /// </Summary>
        /// <value>The reported date.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
        }


        /// <Summary>
        /// Gets the bug id.
        /// </Summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return (_IssueId); }
        }

        /// <summary>
        /// Gets the status.
        /// </summary>
        /// <value>The status.</value>
        public string Status
        {
            get { return _Status; ;}
        }

        /// <summary>
        /// Gets the resolution.
        /// </summary>
        /// <value>The resolution.</value>
        public string Resolution
        {
            get { return _Resolution; }
        }

        /// <Summary>
        /// Gets or sets the Summary.
        /// </Summary>
        /// <value>The Summary.</value>
        public string Title
        {
            get
            {
                if (_Title == null || _Title.Length == 0)
                    return string.Empty;
                else
                    return _Title;
            }
            set { _Title = value; }
        }
       

		#region Static Methods

        /// <summary>
        /// Gets the child bugs.
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        /// <returns></returns>
            public static List<RelatedIssue> GetChildIssues(int issueId)
            {
                if (issueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("issueId"));

                return DataProviderManager.Provider.GetChildIssues(issueId);
            }

            /// <Summary>
            /// Gets the related bugs by bug id.
            /// </Summary>
            /// <param name="issueId">The bug id.</param>
            /// <returns></returns>
            public static List<RelatedIssue> GetRelatedIssues(int issueId) 
			{
				if (issueId <= Globals.NewId)
					throw (new ArgumentOutOfRangeException("issueId"));
	
                return DataProviderManager.Provider.GetRelatedIssues(issueId);
			}

            /// <Summary>
            /// Gets the parent bugs.
            /// </Summary>
            /// <param name="issueId">The bug id.</param>
            /// <returns></returns>
            public static List<RelatedIssue> GetParentIssues(int issueId)
            {
                if (issueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("issueId"));

                return DataProviderManager.Provider.GetParentIssues(issueId);
            }

            /// <Summary>
            /// Deletes the related bug.
            /// </Summary>
            /// <param name="issueId">The bug id.</param>
            /// <param name="linkedIssueId">The linked bug id.</param>
            /// <returns></returns>
			public static bool DeleteRelatedIssue(int issueId, int linkedIssueId) 
			{
				if (issueId <= Globals.NewId )
					throw (new ArgumentOutOfRangeException("issueId"));
				if (linkedIssueId <= Globals.NewId )
					throw (new ArgumentOutOfRangeException("linkedIssueId"));

				return DataProviderManager.Provider.DeleteRelatedIssue(issueId,linkedIssueId);
			}

            /// <Summary>
            /// Creates the new related bug.
            /// </Summary>
            /// <param name="primaryIssueId">The primary bug id.</param>
            /// <param name="secondaryIssueId">The secondary bug id.</param>
            /// <returns></returns>
            public static int CreateNewRelatedIssue(int primaryIssueId, int secondaryIssueId)
            {
                if (primaryIssueId == secondaryIssueId)
                    return 0;

                if (primaryIssueId <= 0)
                    throw (new ArgumentOutOfRangeException("primaryIssueId"));

                if (secondaryIssueId <= 0)
                    throw (new ArgumentOutOfRangeException("secondaryIssueId"));


                return  DataProviderManager.Provider.CreateNewRelatedIssue(primaryIssueId, secondaryIssueId);
            }

            /// <Summary>
            /// Creates the new parent bug.
            /// </Summary>
            /// <param name="primaryIssueId">The primary bug id.</param>
            /// <param name="secondaryIssueId">The secondary bug id.</param>
            /// <returns></returns>
            public static int CreateNewParentIssue(int primaryIssueId, int secondaryIssueId)
            {
                if (primaryIssueId == secondaryIssueId)
                    return 0;

                if (primaryIssueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("primaryIssueId"));

                if (secondaryIssueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("secondaryIssueId"));

                return DataProviderManager.Provider.CreateNewParentIssue(primaryIssueId, secondaryIssueId);
            }

            /// <Summary>
            /// Deletes the child bug.
            /// </Summary>
            /// <param name="primaryIssueId">The primary bug id.</param>
            /// <param name="secondaryIssueId">The secondary bug id.</param>
            /// <returns></returns>
            public static bool DeleteChildIssue(int primaryIssueId, int secondaryIssueId)
            {
                if (primaryIssueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("primaryIssueId"));

                if (secondaryIssueId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("secondaryIssueId"));

                return DataProviderManager.Provider.DeleteChildIssue(primaryIssueId, secondaryIssueId);
            }

           
        /// <Summary>
        /// Creates the new child bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static int CreateNewChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId)
                return 0;

            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewChildIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Deletes the parent bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static bool DeleteParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));   
            return DataProviderManager.Provider.DeleteParentIssue(primaryIssueId, secondaryIssueId);
        }


		#endregion
		
	}
}
