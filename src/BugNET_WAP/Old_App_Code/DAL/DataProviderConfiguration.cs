using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace BugNET.DataAccessLayer
{
    /// <summary>
    /// 
    /// </summary>
    /// <example>
    /// <?xml version="1.0"?>
    /// <configuration>
    ///    <configSections>
    ///      <section name="DataProvider" 
    ///         type="BugNET.Providers.DataProviders.DataProviderConfiguration, BugNET.Providers.DataProviders" 
    ///         allowDefinition="MachineToApplication"/>
    ///    </configSections>
    ///    <DataProvider>
    ///    <add name="SqlDataProvider"
    ///         type="BugNET.Providers.DataAccessProviders.SqlDataProvider, BugNET.Providers.SqlDataProvider" connectionString="BugNET" /> 
    ///    </DataProvider>
    ///</configuration>
    /// </example>
    public class DataProviderConfiguration : ConfigurationSection
    {
        /// <summary>
        /// Gets the providers.
        /// </summary>
        /// <value>The providers.</value>
        [ConfigurationProperty("providers")]
        public ProviderSettingsCollection Providers
        {
            get
            {
                return (ProviderSettingsCollection)base["providers"];
            }
        }

        /// <summary>
        /// Gets or sets the default provider.
        /// </summary>
        /// <value>The default provider.</value>
        [ConfigurationProperty("defaultProvider", DefaultValue = "SqlDataProvider")]
        [StringValidator(MinLength = 1)]
        public string DefaultProvider
        {
            get
            {
                return (string)base["defaultProvider"];
            }
            set
            {
                base["defaultProvider"] = value;
            }
        }
    }
}
