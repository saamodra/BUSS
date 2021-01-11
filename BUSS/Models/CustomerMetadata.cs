using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class CustomerMetadata
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CustomerMetadata()
        {
            this.Detail_Rating_Destinasi = new HashSet<Detail_Rating_Destinasi>();
            this.Transaksis = new HashSet<Transaksi>();
        }

        [Required(ErrorMessage = "NIK wajib diisi!")]
        [MinLength(16, ErrorMessage = "NIK wajib diisi 16 angka!")]
        [MaxLength(16, ErrorMessage = "NIK wajib diisi 16 angka!")]
        [DataType(DataType.PhoneNumber)]
        public string NIK { get; set; }

        [Required(ErrorMessage = "Nama wajib diisi!")]
        [RegularExpression("^[a-zA-Z ]*$", ErrorMessage = "Nama hanya bisa diisi huruf!")]
        public string Nama { get; set; }

        [Required(ErrorMessage = "Alamat wajib diisi!")]
        [DataType(DataType.MultilineText)]
        public string Alamat { get; set; }

        [Required(ErrorMessage = "No. HP wajib diisi!")]
        [DataType(DataType.PhoneNumber)]
        public string No_HP { get; set; }

        [Required(ErrorMessage = "Email wajib diisi!")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password wajib diisi!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Rating_Destinasi> Detail_Rating_Destinasi { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaksi> Transaksis { get; set; }
    }
}