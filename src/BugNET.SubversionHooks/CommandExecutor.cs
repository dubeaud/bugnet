using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace BugNET.SubversionHooks
{
    public static class CommandExecutor
    {
      
        private static Dictionary<int, string> errors = new Dictionary<int, string>();


        /// <summary>
        /// Runs a seperate process and returns the standard outout and error text. This is intended for command line apps only.
        /// If the process does not end in 5minutes it will be killed.
        /// </summary>
        /// <param name="command"></param>
        /// <param name="args"></param>
        /// <returns></returns>
        public static string RunCommand(string command, string args)
        {
            return RunCommand(command, args, 300, true);
        }

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
        /// Runs a seperate process and returns the standard outout and error text. This is intended for command line apps only.
        /// </summary>
        /// <param name="command"></param>
        /// <param name="args"></param>
        /// <param name="killAfterSeconds"></param>
        /// <returns></returns>
        public static string RunCommand(string command, string args, int killAfterSeconds, bool echoCommand)
        {
            Process proc = null;
            log4net.ILog logger = log4net.LogManager.GetLogger("CommandExecutor");

            if (logger.IsDebugEnabled) logger.DebugFormat("Running Commandline: {0} {1}",command,args);

            try
            {
                var startInfo = new ProcessStartInfo(command, args);
                startInfo.CreateNoWindow = true;
                startInfo.WindowStyle = ProcessWindowStyle.Hidden;
                startInfo.UseShellExecute = false;
                startInfo.RedirectStandardOutput = true;
                startInfo.RedirectStandardError = true;

                proc = new Process();
                proc.StartInfo = startInfo;
                proc.ErrorDataReceived += new DataReceivedEventHandler(CommandProcess_ErrorDataReceived);
                proc.Start();

                proc.BeginErrorReadLine();

                string retVal = proc.StandardOutput.ReadToEnd();

                if (!proc.WaitForExit(killAfterSeconds * 1000))
                    proc.Kill();

                if (errors.ContainsKey(proc.Id))
                    retVal += Environment.NewLine + "Error: " + Environment.NewLine + errors[proc.Id];

                if (echoCommand)
                {
                    // hide password from being displayed
                    Regex RegexObj = new Regex("--password\\s+\\S+\\s", RegexOptions.IgnoreCase);
                    args = RegexObj.Replace(args, "--password **** ");


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
                    if (errors.ContainsKey(proc.Id))
                        errors.Remove(proc.Id);

                    proc.Dispose();
                }
            }

        }

        /// <summary>
        /// Event handler to capture error data. At least one of the output streams has to be read asyncronously
        /// to avoid a deadlock.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static void CommandProcess_ErrorDataReceived(object sender, DataReceivedEventArgs e)
        {
            // RC: Sometimes an error occurres in here. I think the process is ending while we are getting the data, but Im not sure.
            // I'm stuffing it for now.
            try
            {
                if (sender != null)
                {
                    if (e.Data != null && e.Data.Length > 0)
                    {
                        int id = ((Process)sender).Id;

                        if (errors.ContainsKey(id))
                            errors[id] += Environment.NewLine + e.Data;
                        else
                            errors.Add(id, e.Data);
                    }
                }
            }
            catch { }
        }
    }
}
