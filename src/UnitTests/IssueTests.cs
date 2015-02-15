using System;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
using System.Web;

namespace BugNET.UnitTests
{
    /// <summary>
    /// Test Fixture for Issue
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class IssueTests
    {
        private Issue TestIssue;
        private string AssignedDisplayName;
        private Guid AssignedUserId;
        private string CreatorDisplayName;
        private string CreatorUsername;
        private Guid CreatorUserId;
        private string LastUpdateDisplayName;
        private string LastUpdateUsername;
        private DateTime LastUpdate;
        private int CategoryId;
        private string CategoryName;
        private DateTime DateCreated;
        private int Id;
        private int MilestoneId;
        private string MilestoneName;
        private string MilestoneImageUrl;
        private int AffectedMilestoneId;
        private string AffectedMilestoneName;
        private string AffectedMilestoneImageUrl;
        private DateTime? MilestoneDueDate;
        private int PriorityId;
        private string PriorityName;
        private string PriorityImageUrl;
        private int StatusId;
        private string StatusName;
        private string StatusImageUrl;
        private int IssueTypeId;
        private string IssueTypeName;
        private string IssueTypeImageUrl;
        private int ResolutionId;
        private string ResolutionName;
        private string ResolutionImageUrl;
        private string ProjectName;
        private int ProjectId;
        private string Title;
        private string Description;
        private string Code;
        private DateTime DueDate;
        private int Visibility;
        private string AssignedUsername;
        private string OwnerUsername;
        private Guid OwnerUserId;
        private string OwnerDisplayName;
        private double TimeLogged;
        private decimal Estimation;
        private int Progress;
        private bool Disabled;
        private int Votes;
 

        /// <summary>
        /// Setup Values
        /// </summary>
        [SetUp]
        public void Init()
        {
            Id = 1;
            Description = "This is a test description for the new bug";
            ProjectId = 1;
            ProjectName = "IssueNet";
            Title = "This is a new title for the issue";
            CategoryId = 1;
            CategoryName = "Database";
            MilestoneId = 3;
            MilestoneName = "3.4.5";
            MilestoneImageUrl = "~/Images/Milestones/1.gif";
            AffectedMilestoneId = 1;
            AffectedMilestoneName = "1.0";
            AffectedMilestoneImageUrl = "~/Images/Milestones/3.gif";
            MilestoneDueDate = null;
            PriorityId = 5;
            PriorityName = "Critical";
            PriorityImageUrl = "~/Images/Priorities/1.gif";
            StatusId = 2;
            StatusName = "Open";
            StatusImageUrl = "~/Images/Status/1.gif";
            IssueTypeId = 1;
            IssueTypeName = "Issue";
            IssueTypeImageUrl = "~/Images/IssueType/1.gif";
            ResolutionId = 1;
            ResolutionName = "Resolved";
            ResolutionImageUrl = "~/Images/Resolutions/1.gif";
            AssignedUsername = "dubeaud";
            AssignedDisplayName = "Davin Dubeau";
            AssignedUserId = new Guid("AF60E5A8-E3B5-41b3-A97A-A948FC6299BA");
            CreatorDisplayName = "Mr Xylo";
            CreatorUserId = new Guid("AF60E5A8-E3B5-41b3-A97A-A948FC6299BA");
            CreatorUsername = "XYLOM";
            OwnerDisplayName = "Mr Xylo";
            OwnerUserId = new Guid("AF60E5A8-E3B5-41b3-A97A-A948FC6299BA");
            OwnerUsername = "XYLOM";
            DateCreated = DateTime.Parse("01-Jan-2005");
            LastUpdateUsername = "dubeaud";
            LastUpdateDisplayName = "Davin Dubeau";
            LastUpdate = DateTime.Now;
            Code = "BUG";
            DueDate = DateTime.Parse("01-Jan-2005");
            Visibility = 1;
            TimeLogged = 5.0;
            Estimation = 10.5m;
            Progress = 50;
            Disabled = false;
            Votes = 5;

        }

        /// <summary>
        /// Tests the creation.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            TestIssue = new Issue();
            Assert.IsNotNull(TestIssue);
        }

        /// <summary>
        /// Tests the creation1.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            TestIssue = new Issue(Id, ProjectId, ProjectName, Code, Title, Description,
                CategoryId, CategoryName, PriorityId, PriorityName,PriorityImageUrl, StatusId, StatusName,StatusImageUrl, IssueTypeId, IssueTypeName,IssueTypeImageUrl,
                ResolutionId, ResolutionName,ResolutionImageUrl, AssignedDisplayName, AssignedUsername, AssignedUserId,
                CreatorDisplayName, CreatorUsername, CreatorUserId, OwnerDisplayName, OwnerUsername, OwnerUserId, DueDate, MilestoneId,
                MilestoneName,MilestoneImageUrl, MilestoneDueDate,AffectedMilestoneId,AffectedMilestoneName,AffectedMilestoneImageUrl, Visibility, TimeLogged, Estimation, DateCreated, LastUpdate, LastUpdateUsername, LastUpdateDisplayName,Progress,Disabled, Votes);

            Assert.AreEqual(Code, TestIssue.ProjectCode);
            Assert.AreEqual(Id, TestIssue.Id);
            Assert.AreEqual(ProjectId, TestIssue.ProjectId);
            Assert.AreEqual(ProjectName, TestIssue.ProjectName);
            Assert.AreEqual(Title, TestIssue.Title);
            Assert.AreEqual(Description, TestIssue.Description);
            Assert.AreEqual(CategoryId, TestIssue.CategoryId);
            Assert.AreEqual(CategoryName, TestIssue.CategoryName);
            Assert.AreEqual(MilestoneId, TestIssue.MilestoneId);
            Assert.AreEqual(MilestoneName, TestIssue.MilestoneName);
            Assert.AreEqual(AffectedMilestoneId, TestIssue.AffectedMilestoneId);
            Assert.AreEqual(MilestoneName, TestIssue.MilestoneName);
            Assert.AreEqual(PriorityId, TestIssue.PriorityId);
            Assert.AreEqual(PriorityName, TestIssue.PriorityName);
            Assert.AreEqual(StatusId, TestIssue.StatusId);
            Assert.AreEqual(StatusName, TestIssue.StatusName);
            Assert.AreEqual(IssueTypeId, TestIssue.IssueTypeId);
            Assert.AreEqual(IssueTypeName, TestIssue.IssueTypeName);
            Assert.AreEqual(ResolutionId, TestIssue.ResolutionId);
            Assert.AreEqual(ResolutionName, TestIssue.ResolutionName);
            Assert.AreEqual(AssignedDisplayName, TestIssue.AssignedDisplayName);
            Assert.AreEqual(AssignedUserId, TestIssue.AssignedUserId);
            Assert.AreEqual(CreatorDisplayName, TestIssue.CreatorDisplayName);
            Assert.AreEqual(CreatorUserId, TestIssue.CreatorUserId);
            Assert.AreEqual(CreatorUsername, TestIssue.CreatorUserName);
            Assert.AreEqual(DateCreated, TestIssue.DateCreated);
            Assert.AreEqual(LastUpdateUsername, TestIssue.LastUpdateUserName);
            Assert.AreEqual(LastUpdate, TestIssue.LastUpdate);
            Assert.AreEqual(LastUpdateDisplayName, TestIssue.LastUpdateDisplayName);
            Assert.AreEqual(Estimation, TestIssue.Estimation);
        }

        /// <summary>
        /// Tests the creation2.
        /// </summary>
        [Test]
        public void TestCreation2()
        {
            //TestIssue = new Issue(ProjectId, Summary, Description, CategoryId, MilestoneId, PriorityId, StatusId, IssueTypeId,FixedInMilestoneId,AssignedToUsername, CreatorUsername,Estimation);

            //Assert.AreEqual(ProjectId, TestIssue.ProjectId);
            //Assert.AreEqual(Summary, TestIssue.Summary);
            //Assert.AreEqual(Description, TestIssue.Description);
            //Assert.AreEqual(CategoryId, TestIssue.CategoryId);
            //Assert.AreEqual(MilestoneId, TestIssue.MilestoneId);
            //Assert.AreEqual(PriorityId, TestIssue.PriorityId);
            //Assert.AreEqual(StatusId, TestIssue.StatusId);
            //Assert.AreEqual(IssueTypeId, TestIssue.IssueTypeId);
            //Assert.AreEqual(CreatorUsername, TestIssue.CreatorUsername);
            //Assert.AreEqual(CreatorUsername, TestIssue.LastUpdateUsername);
            //Assert.AreEqual(Estimation, TestIssue.Estimation);

            ////Test Empty Values
            //Assert.AreEqual(String.Empty, TestIssue.CategoryName);
            //Assert.AreEqual(String.Empty, TestIssue.MilestoneName);
            //Assert.AreEqual(String.Empty, TestIssue.PriorityName);
            //Assert.AreEqual(String.Empty, TestIssue.StatusName);
            //Assert.AreEqual(String.Empty, TestIssue.IssueTypeName);
            //Assert.AreEqual(String.Empty, TestIssue.ResolutionName);
            //Assert.AreEqual(AssignedToUsername, TestIssue.AssignedDisplayName);
            //Assert.AreEqual(String.Empty, TestIssue.CreatorDisplayName);
            //Assert.AreEqual(String.Empty, TestIssue.LastUpdateDisplayName);
        }

        //[Test]
        //public void TestAssignedDisplayName()
        //{
        //    TestIssue = new Issue();

        //    Assert.AreEqual(String.Empty, TestIssue.AssignedDisplayName);
        //    TestIssue.AssignedDisplayName = AssignedDisplayName;
        //    Assert.AreEqual(AssignedDisplayName, TestIssue.AssignedDisplayName);
        //}

        //[Test]
        //public void TestCategoryId()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(0, TestIssue.CategoryId);
        //    TestIssue.CategoryId = CategoryId;
        //    Assert.AreEqual(CategoryId, TestIssue.CategoryId);

        //}

        //[Test]
        //public void TestAssignedToUserId()
        //{
        //    TestIssue = new Issue();

        //    Assert.AreEqual(new Guid("00000000-0000-0000-0000-000000000000"), TestIssue.AssignedToUserId);
        //    TestIssue.AssignedToUserId = AssignedToUserId;
        //    Assert.AreEqual(AssignedToUserId, TestIssue.AssignedToUserId);
        //}

        //[Test]
        //public void TestLastUpdateUsername()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(String.Empty, TestIssue.LastUpdateUsername);
        //    TestIssue.LastUpdateUsername = LastUpdateUsername;
        //    Assert.AreEqual(LastUpdateUsername, TestIssue.LastUpdateUsername);
        //}

        //[Test]
        //public void TestMilestoneId()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(0, TestIssue.MilestoneId);
        //    TestIssue.MilestoneId = MilestoneId;
        //    Assert.AreEqual(MilestoneId, TestIssue.MilestoneId);
        //}

        //[Test]
        //public void TestIssueTypeId()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(0, TestIssue.IssueTypeId);
        //    TestIssue.IssueTypeId = IssueTypeId;
        //    Assert.AreEqual(IssueTypeId, TestIssue.IssueTypeId);
        //}

        //[Test]
        //public void TestResolutionId()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(0, TestIssue.ResolutionId);
        //    TestIssue.ResolutionId = ResolutionId;
        //    Assert.AreEqual(ResolutionId, TestIssue.ResolutionId);
        //}
        
        //[Test]
        //public void TestPriorityId()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(0, TestIssue.PriorityId);
        //    TestIssue.PriorityId = PriorityId;
        //    Assert.AreEqual(PriorityId, TestIssue.PriorityId);
        //}

        //[Test]
        //public void TestSummary()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(String.Empty, TestIssue.Summary);
        //    TestIssue.Summary = Summary;
        //    Assert.AreEqual(Summary, TestIssue.Summary);
        //}

        //[Test]
        //public void TestDescription()
        //{
        //    TestIssue = new Issue();
        //    Assert.AreEqual(String.Empty, TestIssue.Description);
        //    TestIssue.Description = Description;
        //    Assert.AreEqual(Description, TestIssue.Description);
        //}  
    }
}
