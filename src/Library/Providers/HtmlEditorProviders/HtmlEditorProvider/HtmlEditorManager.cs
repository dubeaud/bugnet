using System;
using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;

namespace BugNET.Providers.HtmlEditorProviders
{
    public class HtmlEditorManager
    {
        //Initialization related variables and logic
        private static bool isInitialized = false;
        private static Exception initializationException;
        private static object initializationLock = new object();

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
            try
            {
                //Get the feature's configuration info
                HtmlEditorConfiguration qc =
                    (HtmlEditorConfiguration)ConfigurationManager.GetSection("HtmlEditorProvider");

                if (qc.DefaultProvider == null || qc.Providers == null || qc.Providers.Count < 1)
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
            catch (Exception ex)
            {
                initializationException = ex;
                isInitialized = true;
                throw ex;
            }

            isInitialized = true; //error-free initialization
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
