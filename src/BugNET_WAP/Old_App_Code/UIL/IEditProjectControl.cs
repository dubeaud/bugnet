namespace BugNET.UserInterfaceLayer
{
	/// <summary>
	/// Summary description for IEditProjectControl.
	/// </summary>
		public interface IEditProjectControl 
		{
            /// <summary>
            /// Gets or sets the project id.
            /// </summary>
            /// <value>The project id.</value>
			int ProjectId 
			{
				get;
				set;
			}

            /// <summary>
            /// Updates this instance.
            /// </summary>
            /// <returns></returns>
			bool Update();

            /// <summary>
            /// Initializes this instance.
            /// </summary>
			void Initialize();

            /// <summary>
            /// Gets a value indicating whether [show save button].
            /// </summary>
            /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
            bool ShowSaveButton
            {
                get;
            }

		}
}

