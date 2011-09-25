using System.Configuration;

namespace BugNET.Providers.HtmlEditorProviders
{
    /// <summary>
    /// Configuration handler for the html editor provider
    /// </summary>
    /// <example>
    /// <?xml version="1.0"?>
    /// <configuration>
    ///    <configSections>
    ///      <section name="HtmlEditorProvider" 
    ///         type="BugNET.Providers.HtmlEditorProviders.HtmlEditorConfiguration, BugNET.Providers.HtmlEditorProviders" 
    ///         allowDefinition="MachineToApplication"/>
    ///    </configSections>
    ///  <HtmlEditorProvider defaultProvider="FckHtmlEditorProvider">
    ///    <providers>
    ///      <add name="TextboxHTMLProvider" type="BugNET.Providers.HtmlEditorProviders.TextboxHtmlEditorProvider, BugNET.Providers.TextboxHtmlEditorProvider" Height="600" Width="800"/>
    ///      <add name="FreeTextBoxHTMLProvider"  type="MyCompany2.FreeTextBoxHTMLProvider, FreeTextBoxHTMLProvider"  Height="600" Width="800"/>
    ///      <add name="FCKEditorHTMLProvider" type="BugNET.Providers.HtmlEditorProviders.FckHtmlEditorProvider, BugNET.Providers.FckHtmlEditorProvider" Height="600" Width="800"/>
    ///    </providers>
    ///  </HtmlEditorProvider>
    ///</configuration>
    /// </example>
    public class HtmlEditorConfiguration : ConfigurationSection
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
        [ConfigurationProperty("defaultProvider", DefaultValue = "TextboxHtmlEditorProvider")]
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
