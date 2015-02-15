namespace BugNET.Common
{
    public class ActionEventArgs
    {
        public ActionEventArgs() { }
        public bool Success;
        public ActionTriggers Trigger;
        public object ExtraData;
    }
}