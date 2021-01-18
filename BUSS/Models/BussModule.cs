using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class BussModule
    {
        public static decimal getNumber(string text)
        {
            string numer = string.Empty;
            foreach (char str in text)
            {
                if (char.IsDigit(str))
                {
                    numer += str.ToString();
                }

            }

            return Convert.ToDecimal(numer);
        }

        private static Random random = new Random();
        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}