using System;
using System.Data.SqlTypes;

namespace BugNET.BusinessLogicLayer {

    /// <summary>
    /// The DefaultValues class contains static properties which represent
    /// the minimum values for database identity fields.
    /// </summary>
	public class DefaultValues {

        /// <summary>
        /// Gets the category id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetCategoryIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the date time min value.
        /// </summary>
        /// <returns></returns>
        public static DateTime GetDateTimeMinValue() {
            DateTime MinValue= (DateTime)SqlDateTime.MinValue;
            MinValue.AddYears(1);
            return (MinValue);
        }

        /// <summary>
        /// Gets the custom field id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetCustomFieldIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the issue id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetIssueIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the issue comment id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetIssueCommentIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the issue attachment id min value.
        /// </summary>
        /// <returns></returns>
		public static int GetIssueAttachmentIdMinValue() 
		{
			return (0);
		}

        /// <summary>
        /// Gets the issue notification id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetIssueNotificationIdMinValue() 
		{
            return (0);
        }

        /// <summary>
        /// Ges the project notification id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetProjectNotificationIdMinValue()
        {
            return (0);
        }

        /// <summary>
        /// Gets the milestone id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetMilestoneIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the priority id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetPriorityIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the project id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetProjectIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the status id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetStatusIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the user id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetUserIdMinValue() {
            return (0);
        }

        /// <summary>
        /// Gets the query id min value.
        /// </summary>
        /// <returns></returns>
        public static int GetQueryIdMinValue() {
            return (0);
        }


  }
}
