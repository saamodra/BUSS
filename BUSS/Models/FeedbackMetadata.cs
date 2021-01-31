using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class FeedbackMetadata
    {
        public int ID_Feedback { get; set; }
        
        [Required]
        public int ID_Transaksi { get; set; }

        [Required(ErrorMessage = "Rating wajib diisi.")]
        public int Rating { get; set; }

        [DisplayName("Isi Feedback")]
        [DataType(DataType.MultilineText)]
        public string Isi_Feedback { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm}")]
        public System.DateTime CreatedDate { get; set; }

        public virtual Transaksi Transaksi { get; set; }
    }
}