using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Xml;
using System.Xml.Serialization;

namespace BugNET.Common
{
    // some of these taken from http://extensionoverflow.codeplex.com/

    /// <summary>
    /// Common extension methods
    /// </summary>
    public static class Extensions
    {

        #region XmlSerialize XmlDeserialize

        /// <summary>Serialises an object of type T in to an xml string</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="obj">Object to serialise</param>
        /// <returns>A string that represents Xml, empty oterwise</returns>
        public static string ToXml<T>(this T obj) where T : class
        {
            var settings = new XmlWriterSettings { OmitXmlDeclaration = true };
            var builder = new StringBuilder();
            var xmlnsEmpty = new XmlSerializerNamespaces();
            xmlnsEmpty.Add("", ""); // kill any namespaces

            var xs = new XmlSerializer(obj.GetType());

            using (var stringWriter = XmlWriter.Create(builder, settings))
            {
                xs.Serialize(stringWriter, obj, xmlnsEmpty);
                return builder.ToString();
            }
        }

        /// <summary>Deserialises an xml string in to an object of Type T</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="xml">Xml as string to deserialise from</param>
        /// <returns>A new object of type T is successful, null if failed</returns>
        public static T FromXml<T>(this string xml) where T : class
        {
            var xs = new XmlSerializer(typeof(T));
            using (var memoryStream = new MemoryStream(new UTF8Encoding().GetBytes(xml)))
            {
                return (T)xs.Deserialize(memoryStream);
            }
        }
        #endregion

        #region To X conversions

        public static T To<T>(this IConvertible obj)
        {
            var t = typeof(T);

            if (!t.IsGenericType || (t.GetGenericTypeDefinition() != typeof (Nullable<>)))
            {
                return (T) Convert.ChangeType(obj, t);
            }

            if (obj == null)
            {
                return (T)(object)null;
            }

            return (T) Convert.ChangeType(obj, Nullable.GetUnderlyingType(t));
        }

        public static T ToOrDefault<T>(this IConvertible obj, T defaultValue)
        {
            try
            {
                return To<T>(obj);
            }
            catch
            {
                return defaultValue;
            }
        }

        /// <summary>
        /// Checks to see if an int is a valid bool, used when the number 1 is stored as a true value
        /// </summary>
        /// <param name="input">THe int value to check</param>
        /// <returns></returns>
        public static bool ToBool(this int input)
        {
            return input.Equals(1);
        }

        /// <summary>
        /// Parses a string into an Enum
        /// </summary>
        /// <typeparam name="T">The type of the Enum</typeparam>
        /// <param name="value">String value to parse</param>
        /// <returns>The Enum corresponding to the stringExtensions</returns>
        public static T ToEnum<T>(this string value)
        {
            return ToEnum<T>(value, false);
        }

        /// <summary>
        /// Parses a string into an Enum
        /// </summary>
        /// <typeparam name="T">The type of the Enum</typeparam>
        /// <param name="value">String value to parse</param>
        /// <param name="ignorecase">Ignore the case of the string being parsed</param>
        /// <returns>The Enum corresponding to the stringExtensions</returns>
        public static T ToEnum<T>(this string value, bool ignorecase)
        {
            if (value == null) throw new ArgumentNullException("value");

            value = value.Trim();

            if (value.Length == 0) throw new ArgumentNullException("value", "Must specify valid information for parsing in the string.");

            var t = typeof(T);

            if (!t.IsEnum) throw new ArgumentException("Type provided must be an Enum.", "value");

            return (T)Enum.Parse(t, value, ignorecase);
        }
        #endregion

        /// <summary>
        /// Extension method for the getting typed values from the viewstate
        /// </summary>
        /// <typeparam name="T">The type of the value</typeparam>
        /// <param name="viewState">The viewstate bag</param>
        /// <param name="key">The key of the viewstate item</param>
        /// <param name="defaultValue">A default value if the key item is not in the viewstate</param>
        /// <returns></returns>
        public static T Get<T>(this StateBag viewState, string key, T defaultValue)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            return Get(viewState[key], defaultValue);
        }

        /// <summary>
        /// Extension method for setting typed values to the viewstate
        /// </summary>
        /// <param name="viewState">The viewstate bag</param>
        /// <param name="key">The key of the viewstate item</param>
        /// <param name="value">The value to set in the viewstate for the supplied key</param>
        public static void Set(this StateBag viewState, string key, object value)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            if (value != null)
                viewState[key] = value;
        }

        /// <summary>
        /// Generic method to see if a string value is a specific type or not
        /// </summary>
        /// <typeparam name="T">The type to test for</typeparam>
        /// <param name="input">The input string</param>
        /// <returns>True if the string is of the certain type, otherwise false</returns>
        public static bool Is<T>(this string input) where T : IConvertible
        {
            if (string.IsNullOrEmpty(input)) return false;
            var conv = TypeDescriptor.GetConverter(typeof(T));

            if (conv != null && conv.CanConvertFrom(typeof(string)))
            {
                try
                {
                    conv.ConvertFrom(input);
                    return true;
                }
                catch { } //hacky yes but the only way to deal with the typeconverter not being to conver the type
            }
            return false;
        }


        /// <summary>
        /// Sorts the specified source.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="source">The source.</param>
        /// <param name="sortExpression">The sort expression.</param>
        /// <returns></returns>
        public static IEnumerable<T> Sort<T>(this IEnumerable<T> source, string sortExpression)
        {
            if (source == null) throw new ArgumentNullException("source");

            var sortParts = sortExpression.Split(' ');
            var param = Expression.Parameter(typeof(T), string.Empty);

            try
            {
                var property = Expression.Property(param, sortParts[0]);
                var sortLambda = Expression.Lambda<Func<T, object>>(Expression.Convert(property, typeof(object)), param);

                if (sortParts.Length > 1 && sortParts[1].Equals("desc", StringComparison.OrdinalIgnoreCase))
                {
                    return source.AsQueryable().OrderByDescending(sortLambda);
                }
                return source.AsQueryable().OrderBy(sortLambda);
            }
            catch (ArgumentException)
            {
                return source;
            }
        }

        /// <summary>
        /// Extension method for name value collections to get a typed value from the collection
        /// </summary>
        /// <typeparam name="T">The type to be returned</typeparam>
        /// <param name="collection">The name value collection</param>
        /// <param name="key">The key of the item in the collection</param>
        /// <returns></returns>
        public static T Get<T>(this NameValueCollection collection, string key)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            return Get<T>(collection[key]);
        }

        /// <summary>
        /// Extension method for name value collections to get a typed value from the collection
        /// </summary>
        /// <typeparam name="T">The type to be returned</typeparam>
        /// <param name="collection">The name value collection</param>
        /// <param name="key">The key of the item in the collection</param>
        /// <param name="defaultValue">The default value if the item does not exist</param>
        /// <returns></returns>
        public static T Get<T>(this NameValueCollection collection, string key, T defaultValue)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            return Get(collection[key], defaultValue);
        }

        /// <summary>
        /// Extension method for the request object to get a typed value from the collection
        /// </summary>
        /// <typeparam name="T">The type to be returned</typeparam>
        /// <param name="request">The request object</param>
        /// <param name="key">The key of the item in the request collection</param>
        /// <returns></returns>
        public static T Get<T>(this HttpRequest request, string key)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            return Get<T>(request[key]);
        }

        /// <summary>
        /// Extension method for the request object to get a typed value from the collection
        /// </summary>
        /// <typeparam name="T">The type to be returned</typeparam>
        /// <param name="request">The request object</param>
        /// <param name="key">The key of the item in the request collection</param>
        /// <param name="defaultValue">The default value if the item does not exist</param>
        /// <returns></returns>
        public static T Get<T>(this HttpRequest request, string key, T defaultValue)
        {
            if (string.IsNullOrEmpty(key)) throw new ArgumentNullException("key");

            return Get(request[key], defaultValue);
        }

        private static T Get<T>(object input, T defaultValue = default(T))
        {
            var value = defaultValue;

            if (input != null)
            {
                if (input.ToString().Replace(" ", string.Empty).ToLower() == "true,false")
                {
                    var inputs = input.ToString().Split(',');
                    var value0 = Boolean.Parse(inputs[0]);
                    var value1 = Boolean.Parse(inputs[1]);

                    value = (T)Convert.ChangeType(value0 || value1, typeof(T));
                }
                else
                {
                    if (typeof(T).IsEnum)
                    {
                        int v;
                        if (int.TryParse(input.ToString(), out v))
                            value = (T)Convert.ChangeType(input, typeof(int));
                        else
                            value = (T)Enum.Parse(typeof(T), input.ToString());
                    }
                    else if (typeof(T) == typeof(bool))
                    {
                        var v = input.ToString().ToLower();

                        switch (v)
                        {
                            case "true":
                            case "1":
                                value = (T)Convert.ChangeType("true", typeof(bool));
                                break;
                            case "false":
                            case "0":
                                value = (T)Convert.ChangeType("false", typeof(bool));
                                break;
                        }
                    }
                    else if (typeof(T).IsGenericType &&
                             typeof(T).GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
                    {
                        var nc = new NullableConverter(typeof(T));
                        var underlyingType = nc.UnderlyingType;

                        if (underlyingType.IsEnum)
                        {
                            int v;
                            if (int.TryParse(input.ToString(), out v))
                                value = (T)Convert.ChangeType(input, typeof(int));
                            else
                                value = (T)Enum.Parse(typeof(T), input.ToString());
                        }
                        else if (underlyingType == typeof(bool))
                        {
                            var v = input.ToString().ToLower();

                            switch (v)
                            {
                                case "true":
                                case "1":
                                    value = (T)Convert.ChangeType("true", typeof(bool));
                                    break;
                                case "false":
                                case "0":
                                    value = (T)Convert.ChangeType("false", typeof(bool));
                                    break;
                            }
                        }
                        else
                        {
                            value = (T)Convert.ChangeType(input, underlyingType);
                        }
                    }
                    else
                        value = (T)Convert.ChangeType(input, typeof(T));
                }
            }
            return value;
        }
    }
}