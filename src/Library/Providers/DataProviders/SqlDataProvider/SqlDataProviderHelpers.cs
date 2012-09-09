using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using BugNET.Common;
using log4net;

namespace BugNET.Providers.DataProviders
{
    public partial class SqlDataProvider
    {

        /// <summary>
        /// Gets a value indicating whether [supports project cloning].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [supports project cloning]; otherwise, <c>false</c>.
        /// </value>
        public override bool SupportsProjectCloning
        {
            get { return true; }
        }

        /// <summary>
        /// Gets the installed language resources.
        /// </summary>
        /// <returns></returns>
        public override List<string> GetInstalledLanguageResources()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_LANGUAGES_GETINSTALLEDLANGUAGES);
                    var cultureCodes = new List<string>();
                    ExecuteReaderCmd(sqlCmd, GenerateInstalledResourcesListFromReader, ref cultureCodes);
                    return cultureCodes;
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the provider path.
        /// </summary>
        /// <returns></returns>
        public override string GetProviderPath()
        {
            var context = HttpContext.Current;

            if (_providerPath != string.Empty)
            {
                if (_mappedProviderPath == string.Empty)
                {
                    _mappedProviderPath = context.Server.MapPath(_providerPath);
                    if (!Directory.Exists(_mappedProviderPath))
                        return string.Format("ERROR: providerPath folder {0} specified for SqlDataProvider does not exist on web server", _mappedProviderPath);
                }
            }
            else
            {
                return "ERROR: providerPath folder value not specified in web.config for SqlDataProvider";
            }
            return _mappedProviderPath;
        }

        /// <summary>
        /// Gets the database version.
        /// </summary>
        /// <returns></returns>
        public override string GetDatabaseVersion()
        {
            string currentVersion;

            using (var sqlCmd = new SqlCommand())
            {
                //Check For 0.7 Version
                try
                {
                    SetCommandType(sqlCmd, CommandType.Text, "SELECT SettingValue FROM HostSettings WHERE SettingName='Version'");
                    currentVersion = (string)ExecuteScalarCmd(sqlCmd);
                }
                catch (SqlException)
                {
                    currentVersion = "ERROR";
                }

                //check for version 0.8 if 0.7 has not already been found or threw an exception
                if (currentVersion == string.Empty || currentVersion == "ERROR")
                {
                    try
                    {
                        SetCommandType(sqlCmd, CommandType.Text, "SELECT SettingValue FROM BugNet_HostSettings WHERE SettingName='Version'");
                        currentVersion = (string)ExecuteScalarCmd(sqlCmd);
                    }
                    catch (SqlException e)
                    {
                        switch (e.Number)
                        {
                            case 4060:
                                return "ERROR " + e.Message;
                        }

                        currentVersion = string.Empty;
                    }

                }
            }

            return currentVersion;
        }

        /// <summary>
        /// Processes the exception.
        /// </summary>
        /// <param name="ex">The ex.</param>
        /// <returns></returns>
        public override DataAccessException ProcessException(Exception ex)
        {
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", HttpContext.Current.User.Identity.Name);

            if (Log.IsErrorEnabled)
                Log.Error(ex.Message, ex);

            return new DataAccessException("Database Error", ex);
        }

        //*********************************************************************
        //
        // SQL Helper Methods
        //
        // The following utility methods are used to interact with SQL Server.
        //
        //*********************************************************************

        /// <summary>
        /// Adds the param to SQL CMD.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="paramId">The param id.</param>
        /// <param name="sqlType">Type of the SQL.</param>
        /// <param name="paramSize">Size of the param.</param>
        /// <param name="paramDirection">The param direction.</param>
        /// <param name="paramvalue">The paramvalue.</param>
        private static void AddParamToSqlCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, ParameterDirection paramDirection, object paramvalue)
        {
            // Validate Parameter Properties
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));
            if (paramId == string.Empty) throw (new ArgumentOutOfRangeException("paramId"));

            // Add Parameter
            var newSqlParam = new SqlParameter { ParameterName = paramId, SqlDbType = sqlType, Direction = paramDirection };

            if (paramSize > 0)
                newSqlParam.Size = paramSize;

            if (paramvalue != null)
                newSqlParam.Value = paramvalue;

            sqlCmd.Parameters.Add(newSqlParam);
        }

        /// <summary>
        /// Executes the scalar CMD.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <returns></returns>
        private Object ExecuteScalarCmd(SqlCommand sqlCmd)
        {
            // Validate Command Properties
            if (string.IsNullOrEmpty(_connectionString)) throw new Exception("The connection string cannot be empty, please check the web.config for the proper settings");
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));

            Object result;

            using (var cn = new SqlConnection(_connectionString))
            {
                sqlCmd.Connection = cn;
                cn.Open();
                result = sqlCmd.ExecuteScalar();
            }

            return result;
        }

        /// <summary>
        /// Executes the SqlCommand via non-query.
        /// </summary>
        /// <param name="sqlCmd">The SqlCommand.</param>
        /// <returns></returns>
        private void ExecuteNonQuery(SqlCommand sqlCmd)
        {
            // Validate Command Properties
            if (string.IsNullOrEmpty(_connectionString)) throw new Exception("The connection string cannot be empty, please check the web.config for the proper settings");
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));

            using (var cn = new SqlConnection(_connectionString))
            {
                sqlCmd.Connection = cn;
                cn.Open();
                sqlCmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Ts the execute reader CMD.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="gcfr">The GCFR.</param>
        /// <param name="list">The list.</param>
        private void ExecuteReaderCmd<T>(SqlCommand sqlCmd, GenerateListFromReader<T> gcfr, ref List<T> list)
        {
            if (string.IsNullOrEmpty(_connectionString)) throw new Exception("The connection string cannot be empty, please check the web.config for the proper settings");
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));

            using (var cn = new SqlConnection(_connectionString))
            {
                sqlCmd.Connection = cn;
                cn.Open();
                gcfr(sqlCmd.ExecuteReader(), ref list);
            }
        }

        /// <summary>
        /// Sets the type of the command.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="cmdType">Type of the CMD.</param>
        /// <param name="cmdText">The CMD text.</param>
        private static void SetCommandType(IDbCommand sqlCmd, CommandType cmdType, string cmdText)
        {
            sqlCmd.CommandType = cmdType;
            sqlCmd.CommandText = cmdText;
        }

        /// <summary>
        /// Executes the script.
        /// </summary>
        /// <param name="sql">The SQL.</param>
        public override void ExecuteScript(IEnumerable<string> sql)
        {
            if (sql == null)
                throw new ArgumentNullException("sql");

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                foreach (var command in sql.Select(stmt => new SqlCommand(stmt, conn)))
                {
                    command.ExecuteNonQuery();
                }
                conn.Close();
            }
        }
    }
}
