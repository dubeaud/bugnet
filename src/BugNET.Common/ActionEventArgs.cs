namespace BugNET.Common
{
    public class ActionEventArgs
    {
        public ActionEventArgs() { }
        public bool Success;
        public Globals.ActionTriggers Trigger;
        public object ExtraData;
    }
}