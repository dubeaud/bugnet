using System.Globalization;
using System.Threading;
using System.Web;

namespace BugNET.Common
{
    public enum GlobalResources
    {
        SharedResources,
        Exceptions,
        Notifications
    }

    public static class ResourceStrings
    {
        /// <summary>
        /// Gets an application-level resource string based on the specified ClassKey and ResourceKey properties
        /// </summary>
        /// <param name="classKey">A string that represents the ClassKey property of the requested resource object.</param>
        /// <param name="resourceKey">A string that represents the ResourceKey property of the requested resource object.</param>
        /// <param name="defaultValue">A string the represents a default value if the resource cannot be found.</param>
        /// <returns></returns>
        public static string GetGlobalResource(GlobalResources classKey, string resourceKey, string defaultValue = "")
        {
            var cultureInfo = Thread.CurrentThread.CurrentUICulture;
            return GetGlobalResource(classKey, resourceKey, cultureInfo, defaultValue);
        }

        public static string GetGlobalResource(GlobalResources classKey, string resourceKey, CultureInfo culture, string defaultValue = "")
        {
            if (HttpContext.Current != null)
            {
                var resource = HttpContext.GetGlobalResourceObject(classKey.ToString(), resourceKey, culture);
                if (resource != null) return resource.ToString();
            }

            return defaultValue;
        }

        /// <summary>
        /// Gets a page-level resource object based on the specified VirtualPath and ResourceKey properties.
        /// </summary>
        /// <param name="virtualPath">The VirtualPath property for the local resource object.</param>
        /// <param name="resourceKey">A string that represents a ResourceKey property of the requested resource object.</param>
        /// <param name="defaultValue">A string the represents a default value if the resource cannot be found.</param>
        /// <returns></returns>
        public static string GetLocalResource(string virtualPath, string resourceKey, string defaultValue = "")
        {
            if (HttpContext.Current != null)
            {
                var resource = HttpContext.GetLocalResourceObject(virtualPath, resourceKey);
                if (resource != null) return resource.ToString();
            }

            return defaultValue;
        }
    }
}
