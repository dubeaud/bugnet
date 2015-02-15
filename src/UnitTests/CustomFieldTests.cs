using System;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
using System.Web.UI.WebControls;

namespace BugNET.UnitTests
{
    /// <summary>
    /// Unit tests for the custom field class
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class CustomFieldTests
    {
        private int _Id;
        private int _ProjectId;
        private string _Name;
        ValidationDataType _DataType;
        bool _Required;
        private string _Value;
        private CustomField.CustomFieldType _FieldType;

        /// <summary>
        /// Inits this instance.
        /// </summary>
        [SetUp]
        public void Init()
        {
            _Id = 1;
            _Name = "New Custom Field";
            _Required = true;
            _Value = "ValueTest";
            _DataType = ValidationDataType.String;
            _FieldType = CustomField.CustomFieldType.Text;
        }

        /// <summary>
        /// Tests the creation.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            CustomField cf = new CustomField(_Id, _Value);
            Assert.IsNotNull(cf);
            Assert.AreEqual(_Id,cf.Id);
            Assert.AreEqual(_Value, cf.Value);
        }

        /// <summary>
        /// Tests the creation1.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            CustomField cf = new CustomField(_ProjectId,_Name,_DataType,_Required,_FieldType);
            Assert.IsNotNull(cf);
            Assert.AreEqual(_ProjectId, cf.ProjectId);
            Assert.AreEqual(_Name, cf.Name);
            Assert.AreEqual(_DataType, cf.DataType);
            Assert.AreEqual(_Required, cf.Required);
            Assert.AreEqual(_FieldType, cf.FieldType);
        }

        /// <summary>
        /// Tests the creation2.
        /// </summary>
        [Test]
        public void TestCreation2()
        {
            CustomField cf = new CustomField(_Id,_ProjectId, _Name, _DataType, _Required,_Value, _FieldType);
            Assert.IsNotNull(cf);
            Assert.AreEqual(_Id, cf.Id);
            Assert.AreEqual(_ProjectId, cf.ProjectId);
            Assert.AreEqual(_Name, cf.Name);
            Assert.AreEqual(_Value, cf.Value);
            Assert.AreEqual(_DataType, cf.DataType);
            Assert.AreEqual(_Required, cf.Required);
            Assert.AreEqual(_FieldType, cf.FieldType);
        }

        /// <summary>
        /// Tests the name property.
        /// </summary>
        [Test]
        public void TestNameProperty()
        {
            CustomField cf = new CustomField(_Id, _ProjectId, _Name, _DataType, _Required, _Value, _FieldType);
            Assert.AreEqual(_Name, cf.Name);
            cf.Name = "Testing123";
            Assert.AreEqual("Testing123", cf.Name);
        }

        /// <summary>
        /// Tests the value property.
        /// </summary>
        [Test]
        public void TestValueProperty()
        {
            CustomField cf = new CustomField(_Id, _ProjectId, _Name, _DataType, _Required, _Value, _FieldType);
            Assert.AreEqual(_Value, cf.Value);
            cf.Value = "This is a new value";
            Assert.AreEqual("This is a new value", cf.Value);
        }
    }
}
