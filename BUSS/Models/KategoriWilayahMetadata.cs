using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class KategoriWilayahMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KategoriWilayahMetadata()
        {
            this.Detail_Kategori = new HashSet<Detail_Kategori>();
        }

        public int ID_KategoriWilayah { get; set; }
        public string Nama_Wilayah { get; set; }
        public int Status { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Kategori> Detail_Kategori { get; set; }
    }
}