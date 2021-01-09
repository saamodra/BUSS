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
    }
}