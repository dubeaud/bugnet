using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;

namespace BugNET.Providers.HtmlEditorProviders
{
    /// <summary>
    /// 
    /// </summary>
    public class HtmlEditorManager
    {
        //Initialization related variables and logic

        /// <summary>
        /// Initializes the <see cref="HtmlEditorManager"/> class.
        /// </summary>
        static HtmlEditorManager()
        {
           // Initialize();
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        private static void Initialize()
        {
            //Get the feature's configuration info
            var qc = ConfigurationManager.GetSection("HtmlEditorProvider") as HtmlEditorConfiguration;

            if (qc != null && (qc.DefaultProvider == null || qc.Providers == null || qc.Providers.Count < 1))
                throw new ProviderException("You must specify a valid default provider.");

            //Instantiate the providers
            providerCollection = new HtmlEditorProviderCollection();
            ProvidersHelper.InstantiateProviders(qc.Providers, providerCollection, typeof(HtmlEditorProvider));
            providerCollection.SetReadOnly();
            defaultProvider = providerCollection[qc.DefaultProvider];

            if (defaultProvider == null)
            {
                throw new ConfigurationErrorsException(
                    "You must specify a default provider for the feature.",
                    qc.ElementInformation.Properties["defaultProvider"].Source,
                    qc.ElementInformation.Properties["defaultProvider"].LineNumber);
            }
        }

        //Public feature API
        private static HtmlEditorProvider defaultProvider;
        private static HtmlEditorProviderCollection providerCollection;

        /// <summary>
        /// Gets the provider.
        /// </summary>
        /// <value>The provider.</value>
        public static HtmlEditorProvider Provider
        {
            get
            {
                Initialize();
                return defaultProvider;
            }
        }

        /// <summary>
        /// Gets the providers.
        /// </summary>
        /// <value>The providers.</value>
        public static HtmlEditorProviderCollection Providers
        {
            get
            {
                return providerCollection;
            }
        }
    }
}
