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
            System.Xml.Xsl.XslCompiledTransform transformer = new System.Xml.Xsl.XslCompiledTransform();
            XmlReaderSettings settings = new XmlReaderSettings();
            XmlReader xmlReader = XmlReader.Create(new System.IO.StringReader(xml));
            XmlReader xslReader = XmlReader.Create(new System.IO.StringReader(xsl));
            XsltArgumentList helpers = new XsltArgumentList();

            XslHelpers args = new XslHelpers();
            helpers.AddExtensionObject("urn:xsl-helpers", args);

            using (System.IO.StringWriter writer = new System.IO.StringWriter())
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
        public static string LoadEmailXslTemplate(string template,string path)
        {
            string ext = ".xslt";

            if (!template.EndsWith(ext))
                template += ext;

            return System.IO.File.ReadAllText(string.Concat(path, template));
        }
    }
}
