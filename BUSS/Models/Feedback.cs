//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BUSS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Feedback
    {
        public int ID_Feedback { get; set; }
        public int ID_Transaksi { get; set; }
        public int Rating { get; set; }
        public string Isi_Feedback { get; set; }
    
        public virtual Transaksi Transaksi { get; set; }
    }
}