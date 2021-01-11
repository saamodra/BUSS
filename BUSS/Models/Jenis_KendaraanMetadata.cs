using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class Jenis_KendaraanMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Jenis_KendaraanMetadata()
        {
            this.Kendaraans = new HashSet<Kendaraan>();
        }

        public int ID_Jenis { get; set; }

        [DisplayName("Jenis Kendaraan")]
        [Required(ErrorMessage = "Jenis kendaraan wajib diisi!")]
        public string Nama_Jenis { get; set; }

        [DisplayName("Jumlah Kursi")]
        [Required(ErrorMessage = "Jumlah kursi wajib diisi!")]
        public int Jumlah_Kursi { get; set; }
        public int Status { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Kendaraan> Kendaraans { get; set; }
    }
}