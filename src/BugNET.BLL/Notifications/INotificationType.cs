namespace BugNET.BLL.Notifications
{
    public interface INotificationType
    {
        string Name{get;}
        bool Enabled{get;}
        void SendNotification(INotificationContext context);
    }
}
