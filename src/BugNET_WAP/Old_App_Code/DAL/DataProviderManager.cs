using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Web.Configuration;
using System.Configuration.Provider;

namespace BugNET.DataAccessLayer
{
    /// <summary>
    /// Data provider manager class
    /// </summary>
    public class DataProviderManager
    {

        private static DataProvider defaultProvider;
        private static DataProviderCollection providers;

        /// <summary>
        /// Initializes the <see cref="DataProviderManager"/> class.
        /// </summary>
        static DataProviderManager()
        {
            Initialize();
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        private static void Initialize()
        {
            DataProviderConfiguration configuration = (DataProviderConfiguration)ConfigurationManager.GetSection("DataProvider");

            if (configuration == null || configuration.DefaultProvider == null || configuration.Providers == null || configuration.Providers.Count < 1)
                throw new ProviderException("You must specify a valid default data provider.");           

            providers = new DataProviderCollection();
            ProvidersHelper.InstantiateProviders(configuration.Providers, providers, typeof(DataProvider));
            providers.SetReadOnly();
            defaultProvider = providers[configuration.DefaultProvider];

            if (defaultProvider == null)
            {
                throw new ConfigurationErrorsException(
                    "You must specify a default provider for the feature.",
                    configuration.ElementInformation.Properties["defaultProvider"].Source,
                    configuration.ElementInformation.Properties["defaultProvider"].LineNumber);
            }
        }

        /// <summary>
        /// Gets the provider.
        /// </summary>
        /// <value>The provider.</value>
        public static DataProvider Provider
        {
            get
            {
                return defaultProvider;
            }
        }

        /// <summary>
        /// Gets the providers.
        /// </summary>
        /// <value>The providers.</value>
        public static DataProviderCollection Providers
        {
            get
            {
                return providers;
            }
        }  
    }
}
