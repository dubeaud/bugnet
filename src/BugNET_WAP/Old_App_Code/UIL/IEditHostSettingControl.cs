namespace BugNET.UserInterfaceLayer
{
    public interface IEditHostSettingControl
    {
        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
       bool Update();

        /// <summary>
        /// Inits this instance.
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
