using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class Kendaraan_Metadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Kendaraan_Metadata()
        {
            this.Transaksis = new HashSet<Transaksi>();
        }

        public int ID_Kendaraan { get; set; }

        [DisplayName("Nama Kendaraan")]
        [Required(ErrorMessage = "Nama kendaraan wajib diisi!")]
        public string Nama_Kendaraan { get; set; }

        [DisplayName("Jenis Kendaraan")]
        [Required(ErrorMessage = "Jenis kendaraan wajib diisi!")]
        public int ID_Jenis { get; set; }

        [DisplayName("No. Kendaraan")]
        [Required(ErrorMessage = "No.Kendaraan wajib diisi!")]
        public string No_Kendaraan { get; set; }

        [DisplayName("Harga Sewa")]
        [Required(ErrorMessage = "Harga sewa wajib diisi!")]
        [DisplayFormat(DataFormatString = "{0:C0}", ApplyFormatInEditMode = true)]
        public decimal Harga_kendaraan { get; set; }
        public int Status { get; set; }

        public virtual Jenis_Kendaraan Jenis_Kendaraan { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaksi> Transaksis { get; set; }
    }
}