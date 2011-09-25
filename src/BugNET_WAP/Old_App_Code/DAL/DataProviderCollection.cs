using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration.Provider;

namespace BugNET.DataAccessLayer
{
    public class DataProviderCollection : ProviderCollection
    {
        // Return an instance of DataProvider  
        // for a specified provider name  
        new public DataProvider this[string name]
        {
            get { return (DataProvider)base[name]; }
        }  
    }
}
