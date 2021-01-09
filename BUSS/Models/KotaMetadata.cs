using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class KotaMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KotaMetadata()
        {
            this.Destinasis = new HashSet<Destinasi>();
            this.Detail_Kategori = new HashSet<Detail_Kategori>();
        }

        public int ID_Kota { get; set; }

        [DisplayName("Nama Kota")]
        [Required(ErrorMessage = "Nama kota wajib diisi!")]
        public string Nama_Kota { get; set; }
        public int Status { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Destinasi> Destinasis { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Kategori> Detail_Kategori { get; set; }
    }
}