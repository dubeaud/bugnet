using System;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
namespace BugNET.UnitTests
{
    /// <summary>
    /// 
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class CustomFieldSelectionTests
    {
        private int _Id;
        private int _CustomFieldId;
        private string _Name;
        private string _Value;
        private int _SortOrder;

        /// <summary>
        /// Inits this instance.
        /// </summary>
        [SetUp]
        public void Init()
        {
            _Id = 1;
            _Name = "New Custom Field Selection";
            _CustomFieldId = 45;
            _Value = "ValueTest";
            _SortOrder = 5;
        }

        /// <summary>
        /// Tests the creation.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            CustomFieldSelection cfs = new CustomFieldSelection(_CustomFieldId, _Name, _Value);
            Assert.IsNotNull(cfs);
            Assert.AreEqual(_CustomFieldId, cfs.CustomFieldId);
            Assert.AreEqual(_Name, cfs.Name);
            Assert.AreEqual(_Value,cfs.Value);
        }

        /// <summary>
        /// Tests the creation1.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            CustomFieldSelection cfs = new CustomFieldSelection(_Id,_CustomFieldId, _Name, _Value,_SortOrder);
            Assert.IsNotNull(cfs);
            Assert.AreEqual(_Id, cfs.Id);
            Assert.AreEqual(_CustomFieldId, cfs.CustomFieldId);
            Assert.AreEqual(_Name, cfs.Name);
            Assert.AreEqual(_Value, cfs.Value);
            Assert.AreEqual(_SortOrder, cfs.SortOrder);
        }

        /// <summary>
        /// Tests the name property.
        /// </summary>
        [Test]
        public void TestNameProperty()
        {
            CustomFieldSelection cfs = new CustomFieldSelection(_Id, _CustomFieldId, _Name, _Value, _SortOrder);
            Assert.IsNotNull(cfs);
            Assert.AreEqual(_Name, cfs.Name);
            cfs.Name = "This is a name";
            Assert.AreEqual("This is a name", cfs.Name);
        }

        /// <summary>
        /// Tests the value property.
        /// </summary>
        [Test]
        public void TestValueProperty()
        {
            CustomFieldSelection cfs = new CustomFieldSelection(_Id, _CustomFieldId, _Name, _Value, _SortOrder);
            Assert.IsNotNull(cfs);
            Assert.AreEqual(_Value, cfs.Value);
            cfs.Value = "This is a value";
            Assert.AreEqual("This is a value", cfs.Value);
        }

        /// <summary>
        /// Tests the sort order property.
        /// </summary>
        [Test]
        public void TestSortOrderProperty()
        {
            CustomFieldSelection cfs = new CustomFieldSelection(_Id, _CustomFieldId, _Name, _Value, _SortOrder);
            Assert.IsNotNull(cfs);
            Assert.AreEqual(_SortOrder, cfs.SortOrder);
            cfs.SortOrder = 56;
            Assert.AreEqual(56, cfs.SortOrder);
        }
    }
}
