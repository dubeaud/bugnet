namespace BugNET.Entities
{
    public class IssueCount
    {
        private object _Id;
        private string _Name;
        private int _Count;
        private string _ImageUrl;
        private decimal _Percentage;

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueCount"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="count">The count.</param>
        /// <param name="percentage">The percentage.</param>
        public IssueCount(object id, string name, int count, string imageUrl, decimal percentage)
        {
            _Id = id;
            _Name = name;
            _Count = count;
            _ImageUrl = imageUrl;
            _Percentage = percentage;

        }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueCount"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="count">The count.</param>
        public IssueCount(object id, string name, int count, string imageUrl)
            : this(id, name, count, imageUrl, -1)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueCount"/> class.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="count">The count.</param>
        public IssueCount(string name, int count)
            : this(-1, name, count, string.Empty, -1)
        { }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public object Id
        {
            get { return _Id; }
        }

        /// <summary>
        /// Gets the count.
        /// </summary>
        /// <value>The count.</value>
        public int Count
        {
            get { return _Count; }
        }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name
        {
            get { return _Name; }
        }

        /// <summary>
        /// Gets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
        public string ImageUrl
        {
            get { return _ImageUrl; }
        }

        /// <summary>
        /// Gets the percentage.
        /// </summary>
        /// <value>The percentage.</value>
        public decimal Percentage
        {
            get { return _Percentage; }
            set { _Percentage = value; }
        }

    }
}
