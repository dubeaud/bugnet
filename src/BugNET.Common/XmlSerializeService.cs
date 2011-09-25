using System;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using log4net;

namespace BugNET.Common
{
    /// <summary>
    /// 
    /// </summary>
    /// <typeparam name="T"></typeparam>
	public class XmlSerializeService<T>
	{
        readonly XmlSerializer _serializer;
        private static readonly ILog Log = LogManager.GetLogger(typeof(XmlSerializeService<T>));

        /// <summary>
        /// Initializes a new instance of the <see cref="XmlSerializeService&lt;T&gt;"/> class.
        /// </summary>
		public XmlSerializeService()
		{
			_serializer = new XmlSerializer(typeof(T));
		}

		/// <summary>
		/// Serialize the object to xml
		/// </summary>
        /// <param name="data">The object to be Serialized</param>
		/// <returns></returns>
		public string ToXml(T data)
		{
			var builder = new System.Text.StringBuilder();

			var settings = new XmlWriterSettings();
			settings.OmitXmlDeclaration = true;

			var xmlnsEmpty = new XmlSerializerNamespaces();
			xmlnsEmpty.Add("", ""); // kill any namespaces

			try
			{
				using (XmlWriter stringWriter = XmlWriter.Create(builder, settings))
				{
					_serializer.Serialize(stringWriter, data, xmlnsEmpty);
					return builder.ToString();
				}
			}
			catch (Exception ex) { Log.Fatal(ex); }

			return string.Format("<{0} />", typeof(T).Name);
		}

		/// <summary>
		/// Converts a Xml fragment to the generic object
		/// </summary>
		/// <param name="xml">Xml fragment representing the object</param>
		/// <returns>Generic object</returns>
		public T FromXml(string xml)
		{
			try
			{
				using (var sr = new StringReader(xml))
				{

					var item = (T)_serializer.Deserialize(sr);
					return item;
				}
			}
			catch (Exception ex) { Log.Fatal(ex); }

			return default(T);
		}
	}
}
