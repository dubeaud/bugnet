using System;
using System.Configuration.Provider;

namespace BugNET.Providers.HtmlEditorProviders
{
    public class HtmlEditorProviderCollection : ProviderCollection
    {
        /// <summary>
        /// Adds a provider to the collection.
        /// </summary>
        /// <param name="provider">The provider to be added.</param>
        /// <exception cref="T:System.NotSupportedException">The collection is read-only.</exception>
        /// <exception cref="T:System.ArgumentNullException">
        /// 	<paramref name="provider"/> is null.</exception>
        /// <exception cref="T:System.ArgumentException">The <see cref="P:System.Configuration.Provider.ProviderBase.Name"/> of <paramref name="provider"/> is null.- or -The length of the <see cref="P:System.Configuration.Provider.ProviderBase.Name"/> of <paramref name="provider"/> is less than 1.</exception>
        /// <PermissionSet>
        /// 	<IPermission class="System.Security.Permissions.SecurityPermission, mscorlib, Version=2.0.3600.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" version="1" Flags="UnmanagedCode, ControlEvidence"/>
        /// </PermissionSet>
        public override void Add(ProviderBase provider)
        {
            if (provider == null)
                throw new ArgumentNullException("The provider parameter cannot be null.");

            if (!(provider is HtmlEditorProvider))
                throw new ArgumentException("The provider parameter must be of type HTMLEditorProvider.");

            base.Add(provider);
        }

        /// <summary>
        /// Gets the <see cref="BugNET.Providers.HtmlEditorProvider.HtmlEditorProvider"/> with the specified name.
        /// </summary>
        /// <value></value>
        new public HtmlEditorProvider this[string name]
        {
            get { return (HtmlEditorProvider)base[name]; }
        }

        /// <summary>
        /// Copies to.
        /// </summary>
        /// <param name="array">The array.</param>
        /// <param name="index">The index.</param>
        public void CopyTo(HtmlEditorProvider[] array, int index)
        {
            base.CopyTo(array, index);
        }
    }
}
