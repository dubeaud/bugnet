using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BugNET.Entities
{
    public class IssueCustomField
    {
        public string FieldName { get; set; }
        public string FieldValue { get; set; }       
        public string DatabaseFieldName { get; set; } 
    }
}
