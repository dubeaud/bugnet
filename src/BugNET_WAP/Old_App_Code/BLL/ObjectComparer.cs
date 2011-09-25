using System;
using System.Collections.Generic;
using System.Reflection;
using System.Collections;

namespace BugNET.BusinessLogicLayer
{
    /// http://aadreja.wordpress.com/2009/02/09/c-sorting-with-objects-on-multiple-fields/
    /// http://www.codeproject.com/KB/recipes/Sorting_with_Objects.aspx
    /// <summary>
    /// Allows multi column sorting of an object
    /// </summary>
    /// <typeparam name="ComparableObject">The type of the comparable object.</typeparam>
    [Serializable]
    public class ObjectComparer<ComparableObject> : IComparer<ComparableObject>
    {
        private string _propertyName;
        private bool _MultiColumn;

        #region Constructor
        /// <summary>
        /// Initializes a new instance of the <see cref="ObjectComparer&lt;ComparableObject&gt;"/> class.
        /// </summary>
        public ObjectComparer()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ObjectComparer&lt;ComparableObject&gt;"/> class.
        /// </summary>
        /// <param name="p_propertyName">Name of the p_property.</param>
        public ObjectComparer(string p_propertyName)
        {    
            //We must have a property name for this comparer to work
            this.PropertyName = p_propertyName;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ObjectComparer&lt;ComparableObject&gt;"/> class.
        /// </summary>
        /// <param name="p_propertyName">Name of the p_property.</param>
        /// <param name="p_MultiColumn">if set to <c>true</c> [p_ multi column].</param>
        public ObjectComparer(string p_propertyName, bool p_MultiColumn)
        {
            //We must have a property name for this comparer to work
            this.PropertyName = p_propertyName;
            this.MultiColumn = p_MultiColumn;
        }
        #endregion

        #region Property
    
        /// <summary>
        /// Gets or sets a value indicating whether [multi column].
        /// </summary>
        /// <value><c>true</c> if [multi column]; otherwise, <c>false</c>.</value>
        public bool MultiColumn
        {
            get { return _MultiColumn; }
            set { _MultiColumn = value; }
        }

     
        /// <summary>
        /// Gets or sets the name of the property.
        /// </summary>
        /// <value>The name of the property.</value>
        public string PropertyName
        {
            get { return _propertyName; }
            set { _propertyName = value; }
        }
        #endregion 

        #region IComparer<ComparableObject> Members
        /// <summary>
        /// This comparer is used to sort the generic comparer
        /// The constructor sets the PropertyName that is used
        /// by reflection to access that property in the object to 
        /// object compare.
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <returns></returns>
        public int Compare(ComparableObject x, ComparableObject y)
        {
            Type t = x.GetType();
            if (_MultiColumn) // Multi Column Sorting
            {
                string[] sortExpressions = _propertyName.Trim().Split(',');
                for (int i = 0; i < sortExpressions.Length; i++)
                {
                    string fieldName, direction = "ASC";
                    if (sortExpressions[i].Trim().EndsWith(" DESC"))
                    {fieldName = sortExpressions[i].Replace(" DESC", "").Trim();
                    direction = "DESC";
                }
                else
                {
                    fieldName = sortExpressions[i].Replace(" ASC", "").Trim();
                }

                //Get property by name
                PropertyInfo val = t.GetProperty(fieldName);
                if (val != null)
                {
                    //Compare values, using IComparable interface of the property's type
                    int iResult = Comparer.DefaultInvariant.Compare
				    (val.GetValue(x, null), val.GetValue(y, null));
                    if (iResult != 0)
                    {
                        //Return if not equal
                        if (direction == "DESC")
                        {
                            //Invert order
                            return -iResult;
                        }
                        else
                        {
                            return iResult;
                        }
                    }
                }
                else
                {
                    throw new Exception(fieldName + " is not a valid property to sort on. It doesn't exist in the Class.");
                }
            }
            //Objects have the same sort order
            return 0;
        }
        else
        {
            PropertyInfo val = t.GetProperty(this.PropertyName);
            if (val != null)
            {
                return Comparer.DefaultInvariant.Compare
		    (val.GetValue(x, null), val.GetValue(y, null));
            }
            else
            {
                throw new Exception(this.PropertyName + "is not a valid property to sort on. It doesn't exist in the Class.");
            }
        }
    }
    #endregion

    }
}