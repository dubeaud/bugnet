using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BugNET.Startup))]
namespace BugNET
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
