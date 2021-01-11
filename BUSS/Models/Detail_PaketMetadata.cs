using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace BUSS.Models
{
    public class Detail_PaketMetadata
    {
        public int ID_Paket { get; set; }
        public int ID_Destinasi { get; set; }
        public int Status { get; set; }

        public virtual Destinasi Destinasi { get; set; }
        public virtual Paket Paket { get; set; }
    }
}