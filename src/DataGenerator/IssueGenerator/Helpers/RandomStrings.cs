using System;
using System.Text;

namespace IssueGenerator.Helpers
{
    class RandomStrings
    {
        private static Random random = new Random();

        public static string RandomString(int size)
        {
            // These symbols are setup to give a decent-ish sort of test data.
            // no HTML XSS injection as "<" and ">" and """ are not here
            string symbols = @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJ" +
                @"KLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmn" + 
                @"opqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQR" + 
            @"STUVWXYZabcdefghijklmnopqrstuvwxyz0192837465 ! =-+_ @#$ %^&*( )?, ./: ;'{}] [|\~`";
            
            var pass = new StringBuilder();

            for (var i = 0; i < size; i++)
            {
                pass.Append(symbols[random.Next(0, symbols.Length - 1)]);
            }

            return pass.ToString();
        }
    }
}
