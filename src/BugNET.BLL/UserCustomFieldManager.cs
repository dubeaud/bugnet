using System;
using System.Collections.Generic;
using System.Text;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class UserCustomFieldManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The custom field to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(UserCustomField entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The custom field name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                if (DataProviderManager.Provider.UpdateUserCustomField(entity))
                {
                    UpdateCustomFieldView();
                    return true;
                }

            var tempId = DataProviderManager.Provider.CreateNewUserCustomField(entity);

            if (tempId <= 0)
                return false;

            entity.Id = tempId;
            UpdateCustomFieldView();
            return true;
        }

        /// <summary>
        /// Deletes the custom field.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static bool Delete(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));
            var entity = GetById(customFieldId);

            if (entity == null) return true;

            if (DataProviderManager.Provider.DeleteUserCustomField(entity.Id))
            {
                UpdateCustomFieldView();
                return true;
            }

            return false;
        }

        /// <summary>
        /// Saves the custom field values.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="fields">The fields.</param>
        /// <returns></returns>
        public static bool SaveCustomFieldValues(Guid userId, List<UserCustomField> fields, bool isNewIssue = false)
        {
            if (fields == null) throw (new ArgumentOutOfRangeException("fields"));

            try
            {
                //var issueChanges = GetUserCustomFieldChanges(userId, fields);
                DataProviderManager.Provider.SaveUserCustomFieldValues(userId, fields);

                /*
                if(!isNewIssue)
                { 
                    UpdateHistory(issueChanges);
                }
                */

                return true;
            }
            catch(Exception ex)
            {
                Log.Error(LoggingManager.GetErrorMessageResource("SaveCustomFieldValuesError"), ex);
                return false;
            }
        }

        /// <summary>
        /// Gets the custom fields by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<UserCustomField> Get()
        {
            return (DataProviderManager.Provider.GetUserCustomFields());
        }

        /// <summary>
        /// Gets the custom field by id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static UserCustomField GetById(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            return DataProviderManager.Provider.GetUserCustomFieldById(customFieldId);
        }

        /// <summary>
        /// Creates a PIVOT view for the custom fields to make loading them easier for the UI
        /// this will only work with SQL 2005 and higher
        /// </summary>
        /// <param name="projectId">THe project id for the custom fields</param>
        public static bool UpdateCustomFieldView()
        {
            /* not implemented!
            var customFields = Get();
            var sb = new StringBuilder();
            var viewName = Globals.USER_CUSTOM_FIELDS_VIEW_NAME;

            sb.AppendFormat("SET ANSI_NULLS ON {0}SET XACT_ABORT ON {0}SET QUOTED_IDENTIFIER ON {0}", Environment.NewLine);
            sb.AppendFormat("IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[{0}]') AND OBJECTPROPERTY(id, N'IsView') = 1) {1}", viewName, Environment.NewLine);
            sb.AppendFormat("DROP VIEW [{0}] {1}", viewName, Environment.NewLine);

            sb.AppendFormat("EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[{0}]{1} ", viewName, Environment.NewLine);
            sb.AppendFormat("AS {0} ", Environment.NewLine);
            sb.AppendFormat("SELECT i.ProjectId, i.IssueId, i.[IsClosed], i.[Disabled]{0}", Environment.NewLine);

            foreach (var customField in customFields)
            {
                sb.AppendFormat(",ISNULL(p.[{0}], '''') AS [{2}{0}]{1} ", customField.Name.Replace("'", "''"), Environment.NewLine, Globals.PROJECT_CUSTOM_FIELDS_PREFIX);
            }

            sb.AppendFormat("FROM{0} ", Environment.NewLine);
            sb.AppendFormat("BugNet_IssuesView i{0} ", Environment.NewLine);

            if (customFields.Count > 0)
            {
                sb.AppendFormat("LEFT JOIN{0} ", Environment.NewLine);
                sb.AppendFormat("({0}", Environment.NewLine);
                sb.AppendFormat("SELECT ucfv.UserId, ucf.CustomFieldName, ucfv.CustomFieldValue{0}", Environment.NewLine);
                sb.AppendFormat("FROM BugNet_UserCustomFields ucf {0}", Environment.NewLine);
                sb.AppendFormat("INNER JOIN BugNet_UserCustomFieldValues ucfv ON ucf.CustomFieldId = ucfv.CustomFieldId{0} ", Environment.NewLine);
                sb.AppendFormat(") AS data{0} ", Environment.NewLine);
                sb.AppendFormat("PIVOT{0} ", Environment.NewLine);
                sb.AppendFormat("({0} ", Environment.NewLine);
                sb.AppendFormat("MAX(data.CustomFieldValue) FOR data.CustomFieldName IN {0} ", Environment.NewLine);
                sb.AppendFormat("({0} ", Environment.NewLine);

                foreach (var customField in customFields)
                {
                    sb.AppendFormat("[{0}],", customField.Name.Replace("'", "''"));
                }

                sb.Remove(sb.Length - 1, 1);

                sb.AppendFormat("){0} ", Environment.NewLine);
                sb.AppendFormat(") AS p ON i.IssueId = p.IssueId AND i.ProjectId = p.ProjectId{0} ", Environment.NewLine);
            }

            try
            {
#if (DEBUG)
                System.Diagnostics.Debug.WriteLine(sb.ToString());
#endif
                DataProviderManager.Provider.ExecuteScript(new[] { sb.ToString() });
                return true;
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }
            */

            return false;
        }

        /*
        private static List<IssueHistory> GetCustomFieldChanges(int issueId, List<CustomField> originalFields, List<CustomField> newFields)
        {
            var fieldChanges = new List<IssueHistory>();
            foreach(CustomField cf in newFields)
            {
                var field = originalFields.Find(f => f.Id == cf.Id);
                if(field != null && field.Value != cf.Value)
                {
                    var history = new IssueHistory { CreatedUserName = Security.GetUserName(), IssueId = issueId, DateChanged = DateTime.Now };
                    fieldChanges.Add(GetNewIssueHistory(history, cf.Name, field.Value, cf.Value));
                }
                else if(field == null)
                {
                    // new field added - do we want to track history for this since a value wasn't selected
                    var history = new IssueHistory { CreatedUserName = Security.GetUserName(), IssueId = issueId, DateChanged = DateTime.Now };
                    fieldChanges.Add(GetNewIssueHistory(history, cf.Name, string.Empty, cf.Value));                 
                }
            }

            return fieldChanges;
        }

        private static IssueHistory GetNewIssueHistory(IssueHistory history, string fieldChanged, string oldValue, string newValue)
        {
            return new IssueHistory
            {
                CreatedUserName = history.CreatedUserName,
                CreatorDisplayName = string.Empty,
                DateChanged = history.DateChanged,
                FieldChanged = fieldChanged,
                IssueId = history.IssueId,
                NewValue = newValue,
                OldValue = oldValue
            };
        }

        private static void UpdateHistory(IEnumerable<IssueHistory> issueChanges)
        {
            if (issueChanges == null) return;

            foreach (var issueHistory in issueChanges)
            {
                issueHistory.TriggerLastUpdateChange = false; // set this to false since we don't trigger it from here
                IssueHistoryManager.SaveOrUpdate(issueHistory);
            }
        }
        */
    }
}
