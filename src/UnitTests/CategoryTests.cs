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
    public class CategoryTests
    {
        private int _Id;
        private string _Name;
        private int _ParentCategoryId;
        private int _ProjectId;
        private int _ChildCount;

        /// <summary>
        /// Inits this instance.
        /// </summary>
        [SetUp]
        public void Init()
        {
            _Id = 1;
            _Name = "Business Layer";
            _ParentCategoryId = 0;
            _ProjectId = 1;
            _ChildCount = 5;
        }


        /// <summary>
        /// Tests the creation.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            Category TestCategory = new Category(_ProjectId, _Name);
            Assert.IsNotNull(TestCategory);
            Assert.AreEqual(_ProjectId, TestCategory.ProjectId);
            Assert.AreEqual(_Name, TestCategory.Name);
        }

        /// <summary>
        /// Tests the creation1.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            Category TestCategory = new Category(_Name, _Id);
            Assert.IsNotNull(TestCategory);
            Assert.AreEqual(_Id, TestCategory.Id);
            Assert.AreEqual(_Name, TestCategory.Name);
        }

        /// <summary>
        /// Tests the creation2.
        /// </summary>
        [Test]
        public void TestCreation2()
        {
            Category TestCategory = new Category( _Name, _Id, _ChildCount);
            Assert.IsNotNull(TestCategory);
            Assert.AreEqual(_Id, TestCategory.Id);
            Assert.AreEqual(_Name, TestCategory.Name);
            Assert.AreEqual(_ChildCount, TestCategory.ChildCount);
        }

        /// <summary>
        /// Tests the creation3.
        /// </summary>
        [Test]
        public void TestCreation3()
        {
            Category TestCategory = new Category(_ProjectId,_ParentCategoryId,_Name, _ChildCount);
            Assert.IsNotNull(TestCategory);
            Assert.AreEqual(_ProjectId, TestCategory.ProjectId);
            Assert.AreEqual(_ParentCategoryId ,TestCategory.ParentCategoryId);
            Assert.AreEqual(_Name, TestCategory.Name);
            Assert.AreEqual(_ChildCount, TestCategory.ChildCount);
        }

        /// <summary>
        /// Tests the creation4.
        /// </summary>
        [Test]
        public void TestCreation4()
        {
            Category TestCategory = new Category(_Id,_ProjectId, _ParentCategoryId, _Name, _ChildCount);
            Assert.IsNotNull(TestCategory);
            Assert.AreEqual(_Id, TestCategory.Id);
            Assert.AreEqual(_ProjectId, TestCategory.ProjectId);
            Assert.AreEqual(_ParentCategoryId, TestCategory.ParentCategoryId);
            Assert.AreEqual(_Name, TestCategory.Name);
            Assert.AreEqual(_ChildCount, TestCategory.ChildCount);
        }

        /// <summary>
        /// Tests the name property.
        /// </summary>
        [Test]
        public void TestNameProperty()
        {
            Category c = new Category(_ProjectId, _Name);
            c.Name = "NewName";
            Assert.AreEqual("NewName", c.Name);
        }

        /// <summary>
        /// Tests the parent category id property.
        /// </summary>
        [Test]
        public void TestParentCategoryIdProperty()
        {
            Category c = new Category(_ProjectId, _Name);
            c.ParentCategoryId = _ParentCategoryId;
            Assert.AreEqual(_ParentCategoryId, c.ParentCategoryId);
        }
    }
}
