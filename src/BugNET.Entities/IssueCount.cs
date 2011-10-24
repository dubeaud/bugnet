namespace BugNET.Entities
{
    public class IssueCount
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="IssueCount"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="count">The count.</param>
        /// <param name="imageUrl"></param>
        /// <param name="percentage">The percentage.</param>
        public IssueCount(object id, string name, int count, string imageUrl, decimal percentage = -1)
        {
            Id = id;
            Name = name;
            Count = count;
            ImageUrl = imageUrl;
            Percentage = percentage;

        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public object Id { get; private set; }

        /// <summary>
        /// Gets the count.
        /// </summary>
        /// <value>The count.</value>
        public int Count { get; private set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; private set; }

        /// <summary>
        /// Gets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
        public string ImageUrl { get; private set; }

        /// <summary>
        /// Gets the percentage.
        /// </summary>
        /// <value>The percentage.</value>
        public decimal Percentage { get; set; }
    }
}
