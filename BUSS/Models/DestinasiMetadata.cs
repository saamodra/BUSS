using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class DestinasiMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DestinasiMetadata()
        {
            this.Detail_Foto = new HashSet<Detail_Foto>();
        }

        public int ID_Destinasi { get; set; }

        [DisplayName("Nama Destinasi")]
        [Required(ErrorMessage = "Nama destinasi wajib diisi!")]
        public string Nama_Destinasi { get; set; }

        [DisplayName("Harga Tiket")]
        [Required(ErrorMessage = "Harga tiket wajib diisi!")]
        [DisplayFormat(DataFormatString = "{0:C0}", ApplyFormatInEditMode = true)]
        public decimal Harga_Tiket { get; set; }

        [DisplayName("Kota")]
        [Required(ErrorMessage = "Kota wajib diisi!")]
        public int ID_Kota { get; set; }
        
        public double Rating { get; set; }

        [DisplayName("Jam Buka")]
        [Required(ErrorMessage = "Jam buka wajib diisi!")]
        [DisplayFormat(DataFormatString = "{0:hh\\:mm}")]
        public System.TimeSpan Jam_buka { get; set; }

        [DisplayName("Jam Tutup")]
        [Required(ErrorMessage = "Jam tutup wajib diisi!")]
        [DisplayFormat(DataFormatString = "{0:hh\\:mm}")]
        public System.TimeSpan Jam_tutup { get; set; }

        [DataType(DataType.MultilineText)]
        public string Deskripsi { get; set; }
        public int Status { get; set; }

        public virtual Kota Kota { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Foto> Detail_Foto { get; set; }
    }
}