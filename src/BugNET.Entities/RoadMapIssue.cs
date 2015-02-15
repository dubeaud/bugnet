using AutoMapper;

namespace BugNET.Entities
{
    public class RoadMapIssue : Issue
    {
        /// <summary>
        /// Gets or sets the milestone sort order.
        /// </summary>
        /// <value>The milestone sort order.</value>
        public int MilestoneSortOrder { get; set; }

        public RoadMapIssue(Issue issue, int milestoneSortOrder)
        {
            Mapper.CreateMap<Issue, RoadMapIssue>();
            Mapper.Map(issue, this);
            MilestoneSortOrder = milestoneSortOrder;
        }
    }
}
