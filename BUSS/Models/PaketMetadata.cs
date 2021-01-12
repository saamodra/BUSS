using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace BUSS.Models
{
    public class PaketMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PaketMetadata()
        {
            this.Detail_Paket = new HashSet<Detail_Paket>();
            this.Transaksis = new HashSet<Transaksi>();
        }

        public int ID_Paket { get; set; }

        [DisplayName("Nama Paket")]
        [Required(ErrorMessage = "Nama paket wajib diisi!")]
        public string Nama_Paket { get; set; }

        [DisplayName("Harga Paket")]
        [DisplayFormat(DataFormatString = "{0:C0}", ApplyFormatInEditMode = true)]
        public Nullable<decimal> Harga { get; set; }

        [DisplayName("Konsumsi")]
        public int Konsumsi { get; set; }

        [DisplayName("Lama Perjalanan")]
        [Required(ErrorMessage = "Lama perjalanan wajib diisi!")]
        public Nullable<int> Lama_Perjalanan { get; set; }

        [DisplayName("Jenis Paket")]
        public int Jenis_Paket { get; set; }
        public string Jadwal { get; set; }

        [DataType(DataType.MultilineText)]
        public string Keterangan { get; set; }
        public int Status { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Paket> Detail_Paket { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaksi> Transaksis { get; set; }
    }
}