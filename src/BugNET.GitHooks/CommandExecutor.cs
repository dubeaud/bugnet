using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace BugNET.GitHooks
{
    /// <summary>
    /// 
    /// </summary>
    public static class CommandExecutor
    {
      
        private static readonly Dictionary<int, string> Errors = new Dictionary<int, string>();


        /// <summary>
        /// Runs the command.
        /// </summary>
        /// <param name="command">The command.</param>
        /// <param name="args">The args.</param>
        /// <param name="echoCommand">if set to <c>true</c> [echo command].</param>
        /// <returns></returns>
        public static string RunCommand(string command, string args, bool echoCommand)
        {
            return RunCommand(command, args, 300, echoCommand);
        }


        /// <summary>
        /// Runs a separate process and returns the standard output and error text. This is intended for command line apps only.
        /// </summary>
        /// <param name="command"></param>
        /// <param name="args"></param>
        /// <param name="killAfterSeconds"></param>
        /// <param name="echoCommand"> </param>
        /// <returns></returns>
        public static string RunCommand(string command, string args, int killAfterSeconds = 300, bool echoCommand = true)
        {
            Process proc = null;
            log4net.ILog logger = log4net.LogManager.GetLogger("CommandExecutor");

            if (logger.IsDebugEnabled) logger.DebugFormat("Running Commandline: {0} {1}",command,args);

            try
            {
                var startInfo = new ProcessStartInfo(command, args)
                    {
                        CreateNoWindow = true,
                        WindowStyle = ProcessWindowStyle.Hidden,
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        RedirectStandardError = true,
                        StandardOutputEncoding = System.Text.Encoding.Default
                    };

                proc = new Process {StartInfo = startInfo};
                proc.ErrorDataReceived += CommandProcessErrorDataReceived;
                proc.Start();

                proc.BeginErrorReadLine();

                var retVal = proc.StandardOutput.ReadToEnd();

                if (!proc.WaitForExit(killAfterSeconds * 1000))
                    proc.Kill();

                if (Errors.ContainsKey(proc.Id))
                    retVal += Environment.NewLine + "Error: " + Environment.NewLine + Errors[proc.Id];

                if (echoCommand)
                {
                    // hide password from being displayed
                    var regexObj = new Regex("--password\\s+\\S+\\s", RegexOptions.IgnoreCase);
                    args = regexObj.Replace(args, "--password **** ");


                    return command + " " + args + Environment.NewLine + retVal;
                }
                else
                {
                    return retVal;
                }

            }
            catch (Exception ex)
            {
                logger.ErrorFormat("An error occurred running the command line: {2} {3}\n\n {0} \n\n {1}", ex.Message, ex.StackTrace, command, args);
                return string.Empty;
            }
            finally
            {
                if (proc != null)
                {
                    if (Errors.ContainsKey(proc.Id))
                        Errors.Remove(proc.Id);

                    proc.Dispose();
                }
            }

        }

        /// <summary>
        /// Event handler to capture error data. At least one of the output streams has to be read asynchronously
        /// to avoid a deadlock.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static void CommandProcessErrorDataReceived(object sender, DataReceivedEventArgs e)
        {
            // RC: Sometimes an error occurres in here. I think the process is ending while we are getting the data, but Im not sure.
            // I'm stuffing it for now.
            try
            {
                if (sender == null) return;

                if (string.IsNullOrEmpty(e.Data)) return;

                var id = ((Process)sender).Id;

                if (Errors.ContainsKey(id))
                    Errors[id] += Environment.NewLine + e.Data;
                else
                    Errors.Add(id, e.Data);
            }
            catch (Exception)
            { }
        }
    }
}
