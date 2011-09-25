using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace BugNET.Common
{
    public static class Extensions
    {       
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

        
    }
}