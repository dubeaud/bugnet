// Altairis Web Security Toolkit
// Copyright © Michal A. Valasek - Altairis, 2006-2012 | www.altairis.cz 
// Licensed under terms of Microsoft Permissive License (MS-PL)

using System;
using System.Configuration;
using System.Configuration.Provider;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Hosting;
using System.Web.Profile;

namespace Altairis.Web.Security {

    [Obsolete("This class is no longer supported and developed. Use SqlTableProfileProvider instead - http://code.msdn.microsoft.com/aspnet4profile")]
    public class SimpleSqlProfileProvider : ProfileProvider {

        private const string CustomProviderDataFormat = "^[a-zA-Z0-9_]+;[a-zA-Z0-9_]+(;[0-9]{1,})?$";

        // Initialization and configuration

        private string applicationName, connectionString, tableName, keyColumnName, lastUpdateColumnName;

        private System.Collections.Specialized.NameValueCollection configuration;

        /// <summary>
        /// Initializes the provider.
        /// </summary>
        /// <param name="name">The friendly name of the provider.</param>
        /// <param name="config">A collection of the name/value pairs representing the provider-specific attributes specified in the configuration for this provider.</param>
        /// <exception cref="T:System.ArgumentNullException">The name of the provider is null.</exception>
        /// <exception cref="T:System.ArgumentException">The name of the provider has a length of zero.</exception>
        /// <exception cref="T:System.InvalidOperationException">An attempt is made to call <see cref="M:System.Configuration.Provider.ProviderBase.Initialize(System.String,System.Collections.Specialized.NameValueCollection)"/> on a provider after the provider has already been initialized.</exception>
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config) {
            // Validate arguments
            if (config == null) throw new ArgumentNullException("config");
            if (string.IsNullOrEmpty(name)) name = "SimpleSqlProfileProvider";
            if (String.IsNullOrEmpty(config["description"])) {
                config.Remove("description");
                config.Add("description", "Simple SQL profile provider");
            }

            // Initialize base class
            base.Initialize(name, config);

            // Basic init
            this.configuration = config;
            this.applicationName = GetConfig("applicationName", "");

            // Initialize connection string
            ConnectionStringSettings ConnectionStringSettings = ConfigurationManager.ConnectionStrings[config["connectionStringName"]];
            if (ConnectionStringSettings == null || ConnectionStringSettings.ConnectionString.Trim() == "") throw new ProviderException("Connection string cannot be blank.");
            this.connectionString = ConnectionStringSettings.ConnectionString;

            // Initialize table name
            this.tableName = GetConfig("tableName", "Profiles");

            // Initialize key column name
            this.keyColumnName = GetConfig("keyColumnName", "UserName");

            // Initialize last update column name
            this.lastUpdateColumnName = GetConfig("lastUpdateColumnName", "LastUpdate");
        }

        /// <summary>
        /// Gets or sets the name of the currently running application.
        /// </summary>
        /// <value></value>
        /// <returns>A <see cref="T:System.String"/> that contains the application's shortened name, which does not contain a full path or extension, for example, SimpleAppSettings.</returns>
        public override string ApplicationName {
            get { return this.applicationName; }
            set { this.applicationName = value; }
        }

        /// <summary>
        /// Gets the name of the database table to store profile data into.
        /// </summary>
        /// <value>The name of the table.</value>
        public string TableName {
            get { return tableName; }
        }

        /// <summary>
        /// Gets the name of the table column used as primary search key (user name).
        /// </summary>
        /// <value>The name of the key column.</value>
        public string KeyColumnName {
            get { return this.keyColumnName; }
        }

        /// <summary>
        /// Gets the name of the table column used for storing last update time.
        /// </summary>
        /// <value>The name of the last update time column.</value>
        public string LastUpdateColumnName {
            get { return this.lastUpdateColumnName; }
        }

        // Profile provider implementation

        /// <summary>
        /// Deletes profile properties and information for profiles that match the supplied list of user names.
        /// </summary>
        /// <param name="usernames">A string array of user names for profiles to be deleted.</param>
        /// <returns>
        /// The number of profiles deleted from the data source.
        /// </returns>
        public override int DeleteProfiles(string[] usernames) {
            if (usernames == null) throw new ArgumentNullException();
            if (usernames.Length == 0) return 0; // no work here

            int count = 0;
            try {
                using (HostingEnvironment.Impersonate())
                using (SqlConnection db = OpenDatabase())
                using (SqlCommand cmd = new SqlCommand(this.ExpandCommand("DELETE FROM $Profiles WHERE $UserName=@UserName"), db)) {
                    cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 100);
                    foreach (string userName in usernames) {
                        cmd.Parameters["@UserName"].Value = userName;
                        count += cmd.ExecuteNonQuery();
                    }
                }
            }
            catch {
                throw;
            }
            return count;
        }

        /// <summary>
        /// Deletes profile properties and information for the supplied list of profiles.
        /// </summary>
        /// <param name="profiles">A <see cref="T:System.Web.Profile.ProfileInfoCollection"/>  of information about profiles that are to be deleted.</param>
        /// <returns>
        /// The number of profiles deleted from the data source.
        /// </returns>
        public override int DeleteProfiles(ProfileInfoCollection profiles) {
            if (profiles == null) throw new ArgumentNullException();
            if (profiles.Count == 0) return 0; // no work here

            int count = 0;
            try {
                using (HostingEnvironment.Impersonate())
                using (SqlConnection db = OpenDatabase())
                using (SqlCommand cmd = new SqlCommand(this.ExpandCommand("DELETE FROM $Profiles WHERE $UserName=@UserName"), db)) {
                    cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 100);
                    foreach (ProfileInfo pi in profiles) {
                        cmd.Parameters["@UserName"].Value = pi.UserName;
                        count += cmd.ExecuteNonQuery();
                    }
                }
            }
            catch {
                throw;
            }
            return count;
        }

        /// <summary>
        /// Returns the collection of settings property values for the specified application instance and settings property group.
        /// </summary>
        /// <param name="context">A <see cref="T:System.Configuration.SettingsContext"/> describing the current application use.</param>
        /// <param name="collection">A <see cref="T:System.Configuration.SettingsPropertyCollection"/> containing the settings property group whose values are to be retrieved.</param>
        /// <returns>
        /// A <see cref="T:System.Configuration.SettingsPropertyValueCollection"/> containing the values for the specified settings property group.
        /// </returns>
        public override SettingsPropertyValueCollection GetPropertyValues(SettingsContext context, SettingsPropertyCollection collection) {
            SettingsPropertyValueCollection svc = new SettingsPropertyValueCollection();

            // Validate arguments
            if (collection == null || collection.Count < 1 || context == null) return svc;
            string userName = (string)context["UserName"];
            if (String.IsNullOrEmpty(userName)) return svc;

            using (DataTable dt = new DataTable()) {
                try {
                    // Get profile row from db
                    using (HostingEnvironment.Impersonate())
                    using (SqlConnection db = OpenDatabase())
                    using (SqlCommand cmd = new SqlCommand(this.ExpandCommand("SELECT * FROM $Profiles WHERE $UserName=@UserName"), db)) {
                        cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 100).Value = userName;
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd)) da.Fill(dt);
                    }
                }
                catch {
                    throw;
                }

                // Process properties
                foreach (SettingsProperty prop in collection) {
                    SettingsPropertyValue value = new SettingsPropertyValue(prop);
                    if (dt.Rows.Count == 0) {
                        if(value.Property.PropertyType == typeof(System.DateTime))
                        { 
                            value.PropertyValue = null; 
                        }
                        else
                        {
                            value.PropertyValue = System.Convert.ChangeType(value.Property.DefaultValue, value.Property.PropertyType);
                        }

                        value.IsDirty = false;
                        value.Deserialized = true;
                    }
                    else {
                        string columnName = GetPropertyMapInfo(prop).ColumnName; if (dt.Columns.IndexOf(columnName) == -1) throw new ProviderException(string.Format("Column '{0}' required for property '{1}' was not found in table '{2}'.", columnName, prop.Name, this.TableName));
                        object columnValue = dt.Rows[0][columnName];

                        value.IsDirty = false;
                        value.Deserialized = true;
                        if (!(columnValue is DBNull || columnValue == null)) {
                            value.PropertyValue = columnValue;
                        }
                        else {
                        	value.PropertyValue = null;
                        }
                    }
                    svc.Add(value);
                }
            }
            return svc;
        }

        /// <summary>
        /// Sets the values of the specified group of property settings.
        /// </summary>
        /// <param name="context">A <see cref="T:System.Configuration.SettingsContext"/> describing the current application usage.</param>
        /// <param name="collection">A <see cref="T:System.Configuration.SettingsPropertyValueCollection"/> representing the group of property settings to set.</param>
        public override void SetPropertyValues(SettingsContext context, SettingsPropertyValueCollection collection) {
            // Validate arguments
            if (!(bool)context["IsAuthenticated"]) throw new NotSupportedException("This provider does not support anonymous profiles");
            string userName = (string)context["UserName"];
            if (string.IsNullOrEmpty(userName) || collection.Count == 0 || !this.HasDirtyProperties(collection)) return; // no work here

            // Construct command
            using (SqlCommand cmd = new SqlCommand()) {
                StringBuilder insertCommandText1 = new StringBuilder("INSERT INTO $Profiles ($UserName, $LastUpdate");
                StringBuilder insertCommandText2 = new StringBuilder(" VALUES (@UserName, GETDATE()");
                StringBuilder updateCommandText = new StringBuilder("UPDATE $Profiles SET $LastUpdate=GETDATE()");
                cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 100).Value = userName;

                // Cycle trough collection
                int i = 0;
                foreach (SettingsPropertyValue propVal in collection) {
                    PropertyMapInfo pmi = GetPropertyMapInfo(propVal.Property);

                    // Always add parameter
                    SqlParameter p = new SqlParameter("@Param" + i, pmi.Type);
                    if (pmi.Length != 0) p.Size = pmi.Length;
                    if (propVal.Deserialized && propVal.PropertyValue == null) p.Value = DBNull.Value;
                    else p.Value = propVal.PropertyValue;
                    cmd.Parameters.Add(p);

                    // Always add to insert
                    insertCommandText1.Append(", " + pmi.ColumnName);
                    insertCommandText2.Append(", @Param" + i);

                    // Add dirty properties to update
                    if (propVal.IsDirty) updateCommandText.Append(", " + pmi.ColumnName + "=@Param" + i);

                    i++;
                }

                // Complete command
                insertCommandText1.Append(")");
                insertCommandText2.Append(")");
                updateCommandText.Append(" WHERE $UserName=@UserName");
                cmd.CommandText = this.ExpandCommand("IF EXISTS (SELECT * FROM $Profiles WHERE $UserName=@UserName) BEGIN " + updateCommandText.ToString() + " END ELSE BEGIN " + insertCommandText1.ToString() + insertCommandText2.ToString() + " END");

                // Execute command
                try {
                    using (HostingEnvironment.Impersonate())
                    using (SqlConnection db = OpenDatabase()) {
                        cmd.Connection = db;
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception) {
                    throw;
                }
            }
        }

        /// <summary>
        /// Retrieves profile information for profiles in which the user name matches the specified user names.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are returned.</param>
        /// <param name="usernameToMatch">The user name to search for.</param>
        /// <param name="pageIndex">The index of the page of results to return.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">When this method returns, contains the total number of profiles.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Profile.ProfileInfoCollection"/> containing user-profile information for profiles where the user name matches the supplied <paramref name="usernameToMatch"/> parameter.
        /// </returns>
        public override ProfileInfoCollection FindProfilesByUserName(ProfileAuthenticationOption authenticationOption, string usernameToMatch, int pageIndex, int pageSize, out int totalRecords) {
            // Validate arguments
            if (pageIndex < 0) throw new ArgumentOutOfRangeException("pageIndex");
            if (pageSize < 1) throw new ArgumentOutOfRangeException("pageSize");
            if (authenticationOption == ProfileAuthenticationOption.Anonymous) {
                // Anonymous profiles not supported
                totalRecords = 0;
                return new ProfileInfoCollection();
            }

            using (DataTable dt = new DataTable()) {
                // Prepare sql command
                using (SqlConnection db = this.OpenDatabase())
                using (SqlCommand cmd = new SqlCommand("", db)) {
                    if (string.IsNullOrEmpty(usernameToMatch)) {
                        cmd.CommandText = this.ExpandCommand("SELECT $UserName AS UserName, $LastUpdate AS LastUpdate FROM $Profiles WHERE $UserName=@UserName ORDER BY $UserName");
                    }
                    else {
                        cmd.CommandText = this.ExpandCommand("SELECT $UserName AS UserName, $LastUpdate AS LastUpdate FROM $Profiles WHERE $UserName=@UserName ORDER BY $UserName");
                        cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 100).Value = usernameToMatch;
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd)) da.Fill(dt);
                }

                // Prepare paging
                ProfileInfoCollection pic = new ProfileInfoCollection();
                totalRecords = dt.Rows.Count;
                int minIndex = pageIndex * pageSize; if (minIndex > totalRecords - 1) return pic;
                int maxIndex = minIndex + pageSize - 1; if (maxIndex > totalRecords - 1) maxIndex = totalRecords - 1;

                // Populate collection from data table
                for (int i = minIndex; i <= maxIndex; i++) {
                    pic.Add(new ProfileInfo(System.Convert.ToString(dt.Rows[i]["UserName"]),
                            false,
                            DateTime.Now,
                            System.Convert.ToDateTime(dt.Rows[i]["LastUpdate"]),
                            0));
                }
                return pic;
            }
        }

        /// <summary>
        /// Retrieves user profile data for all profiles in the data source.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are returned.</param>
        /// <param name="pageIndex">The index of the page of results to return.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">When this method returns, contains the total number of profiles.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Profile.ProfileInfoCollection"/> containing user-profile information for all profiles in the data source.
        /// </returns>
        public override ProfileInfoCollection GetAllProfiles(ProfileAuthenticationOption authenticationOption, int pageIndex, int pageSize, out int totalRecords) {
            return FindProfilesByUserName(authenticationOption, string.Empty, pageIndex, pageSize, out totalRecords);
        }

        // Private support functions

        private struct PropertyMapInfo {
            public string ColumnName;
            public SqlDbType Type;
            public int Length;
        }

        /// <summary>
        /// Gets information about how the property value is stored in database (column name, type, size).
        /// </summary>
        /// <param name="prop">The property.</param>
        /// <returns></returns>
        private PropertyMapInfo GetPropertyMapInfo(SettingsProperty prop) {
            // Perform general validation
            if (prop == null) throw new ArgumentNullException();
            string cpd = System.Convert.ToString(prop.Attributes["CustomProviderData"]);
            if (string.IsNullOrEmpty(cpd)) throw new ProviderException(string.Format("CustomProviderData is missing or empty for property {0}.", prop.Name));
            if (!System.Text.RegularExpressions.Regex.IsMatch(cpd, CustomProviderDataFormat)) throw new ProviderException(string.Format("Invalid format of CustomProviderData for property {0}.", prop.Name));
            string[] parts = cpd.Split(';');

            PropertyMapInfo pmi = new PropertyMapInfo();
            pmi.ColumnName = parts[0];
            try {
                pmi.Type = (SqlDbType)Enum.Parse(typeof(SqlDbType), parts[1], true);
            }
            catch {
                throw new ProviderException(string.Format("SqlDbType '{0}' specified for property {1} is invalid.", parts[1], prop.Name));
            }
            if (parts.Length == 3) pmi.Length = System.Convert.ToInt32(parts[2]);
            return pmi;
        }

        /// <summary>
        /// Determines whether property collection contains dirty properties.
        /// </summary>
        /// <param name="props">The property collection.</param>
        /// <returns>
        /// 	<c>true</c> if collection has dirty properties; otherwise, <c>false</c>.
        /// </returns>
        private bool HasDirtyProperties(SettingsPropertyValueCollection props) {
            foreach (SettingsPropertyValue prop in props) {
                if (prop.IsDirty) return true;
            }
            return false;
        }

        /// <summary>
        /// Expands the SQL command placeholders ($Something) with configured name.
        /// </summary>
        /// <param name="sql">The SQL command text.</param>
        /// <returns>Expanded SQL command text.</returns>
        private string ExpandCommand(string sql) {
            sql = sql.Replace("$Profiles", this.TableName);
            sql = sql.Replace("$UserName", this.KeyColumnName);
            sql = sql.Replace("$LastUpdate", this.LastUpdateColumnName);
            return sql;
        }

        /// <summary>
        /// Opens the database connection.
        /// </summary>
        /// <returns></returns>
        private SqlConnection OpenDatabase() {
            SqlConnection db = new SqlConnection(this.connectionString);
            db.Open();
            return db;
        }

        /// <summary>
        /// Reads configuration value. If not present, returns default value.
        /// </summary>
        /// <param name="name">The configuration property name.</param>
        /// <param name="defaultValue">The default value.</param>
        /// <returns></returns>
        private string GetConfig(string name, string defaultValue) {
            // Validate input arguments
            if (string.IsNullOrEmpty(name)) throw new ArgumentNullException("Name");

            // Get value from configuration
            string Value = this.configuration[name];
            if (string.IsNullOrEmpty(Value)) Value = defaultValue;
            return Value;
        }

        #region Inactive profiles - not implemented

        /// <summary>
        /// When overridden in a derived class, deletes all user-profile data for profiles in which the last activity date occurred before the specified date.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are deleted.</param>
        /// <param name="userInactiveSinceDate">A <see cref="T:System.DateTime"/> that identifies which user profiles are considered inactive. If the <see cref="P:System.Web.Profile.ProfileInfo.LastActivityDate"/>  value of a user profile occurs on or before this date and time, the profile is considered inactive.</param>
        /// <returns>
        /// The number of profiles deleted from the data source.
        /// </returns>
        public override int DeleteInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate) {
            throw new NotImplementedException();
        }

        /// <summary>
        /// When overridden in a derived class, retrieves profile information for profiles in which the last activity date occurred on or before the specified date and the user name matches the specified user name.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are returned.</param>
        /// <param name="usernameToMatch">The user name to search for.</param>
        /// <param name="userInactiveSinceDate">A <see cref="T:System.DateTime"/> that identifies which user profiles are considered inactive. If the <see cref="P:System.Web.Profile.ProfileInfo.LastActivityDate"/> value of a user profile occurs on or before this date and time, the profile is considered inactive.</param>
        /// <param name="pageIndex">The index of the page of results to return.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">When this method returns, contains the total number of profiles.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Profile.ProfileInfoCollection"/> containing user profile information for inactive profiles where the user name matches the supplied <paramref name="usernameToMatch"/> parameter.
        /// </returns>
        public override ProfileInfoCollection FindInactiveProfilesByUserName(ProfileAuthenticationOption authenticationOption, string usernameToMatch, DateTime userInactiveSinceDate, int pageIndex, int pageSize, out int totalRecords) {
            throw new NotImplementedException();
        }

        /// <summary>
        /// When overridden in a derived class, retrieves user-profile data from the data source for profiles in which the last activity date occurred on or before the specified date.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are returned.</param>
        /// <param name="userInactiveSinceDate">A <see cref="T:System.DateTime"/> that identifies which user profiles are considered inactive. If the <see cref="P:System.Web.Profile.ProfileInfo.LastActivityDate"/>  of a user profile occurs on or before this date and time, the profile is considered inactive.</param>
        /// <param name="pageIndex">The index of the page of results to return.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">When this method returns, contains the total number of profiles.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Profile.ProfileInfoCollection"/> containing user-profile information about the inactive profiles.
        /// </returns>
        public override ProfileInfoCollection GetAllInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate, int pageIndex, int pageSize, out int totalRecords) {
            throw new NotImplementedException();
        }

        /// <summary>
        /// When overridden in a derived class, returns the number of profiles in which the last activity date occurred on or before the specified date.
        /// </summary>
        /// <param name="authenticationOption">One of the <see cref="T:System.Web.Profile.ProfileAuthenticationOption"/> values, specifying whether anonymous, authenticated, or both types of profiles are returned.</param>
        /// <param name="userInactiveSinceDate">A <see cref="T:System.DateTime"/> that identifies which user profiles are considered inactive. If the <see cref="P:System.Web.Profile.ProfileInfo.LastActivityDate"/>  of a user profile occurs on or before this date and time, the profile is considered inactive.</param>
        /// <returns>
        /// The number of profiles in which the last activity date occurred on or before the specified date.
        /// </returns>
        public override int GetNumberOfInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate) {
            throw new NotImplementedException();
        }

        #endregion

    }
}
