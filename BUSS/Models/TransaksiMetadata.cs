using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class TransaksiMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TransaksiMetadata()
        {
            this.Feedbacks = new HashSet<Feedback>();
            this.Transaksi_Kendaraan = new HashSet<Transaksi_Kendaraan>();
        }

        public int ID_Transaksi { get; set; }
        public int ID_Paket { get; set; }
        public string ID_Customer { get; set; }
        public Nullable<int> ID_Pegawai { get; set; }
        public decimal Harga_total { get; set; }
        public int Jumlah_Penumpang { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public System.DateTime Tanggal_Pesanan { get; set; }
        public string Bukti_DP { get; set; }
        public string Bukti_Pelunasan { get; set; }
        public int Status_Transaksi { get; set; }
        public Nullable<double> PaketLama_Perjalanan { get; set; }
        public System.DateTime CreatedDate { get; set; }

        public virtual Customer Customer { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Feedback> Feedbacks { get; set; }
        public virtual Paket Paket { get; set; }
        public virtual Pegawai Pegawai { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaksi_Kendaraan> Transaksi_Kendaraan { get; set; }
    }
}