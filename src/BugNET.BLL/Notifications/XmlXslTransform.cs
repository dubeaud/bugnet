using System.Xml;
using System.Xml.Xsl;

namespace BugNET.BLL.Notifications
{
    public static class XmlXslTransform
    {
        /// <summary>
        /// Transforms the specified XML.
        /// </summary>
        /// <param name="xml">The XML.</param>
        /// <param name="xsl">The XSL.</param>
        /// <returns></returns>
        public static string Transform(string xml, string xsl)
        {
            var transformer = new XslCompiledTransform();
            var xmlReader = XmlReader.Create(new System.IO.StringReader(xml));
            var xslReader = XmlReader.Create(new System.IO.StringReader(xsl));
            var helpers = new XsltArgumentList();

            var args = new XslHelpers();
            helpers.AddExtensionObject("urn:xsl-helpers", args);

            using (var writer = new System.IO.StringWriter())
            {
                transformer.Load(xslReader);
                transformer.Transform(xmlReader, helpers, writer);
                return writer.ToString();
            }
        }

        /// <summary>
        /// Loads the email XSL template.
        /// </summary>
        /// <param name="template">The template.</param>
        /// <param name="path">The path.</param>
        /// <returns></returns>
        public static string LoadEmailXslTemplate(string template, string path)
        {
            const string ext = ".xslt";

            if (!template.EndsWith(ext))
                template += ext;

            return System.IO.File.ReadAllText(string.Concat(path, template));
        }
    }
}
