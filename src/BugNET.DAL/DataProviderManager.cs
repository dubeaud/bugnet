using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;

namespace BugNET.DAL
{
    /// <summary>
    /// Data provider manager class
    /// </summary>
    public class DataProviderManager
    {

        private static DataProvider _defaultProvider;
        private static DataProviderCollection _providers;

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
            var configuration = (DataProviderConfiguration)ConfigurationManager.GetSection("DataProvider");

            if (configuration == null || configuration.DefaultProvider == null || configuration.Providers == null || configuration.Providers.Count < 1)
                throw new ProviderException("You must specify a valid default data provider.");           

            _providers = new DataProviderCollection();
            ProvidersHelper.InstantiateProviders(configuration.Providers, _providers, typeof(DataProvider));
            _providers.SetReadOnly();
            _defaultProvider = _providers[configuration.DefaultProvider];

            if (_defaultProvider == null)
            {
                var propertyInformation = configuration.ElementInformation.Properties["defaultProvider"];

                if (propertyInformation != null)
                    throw new ConfigurationErrorsException(
                        "You must specify a default provider for the feature.",
                        propertyInformation.Source,
                        propertyInformation.LineNumber);
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
                return _defaultProvider;
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
                return _providers;
            }
        }  
    }
}
