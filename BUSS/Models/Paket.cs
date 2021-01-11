//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BUSS.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    [MetadataType(typeof(PaketMetadata))]
    public partial class Paket
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Paket()
        {
            this.Detail_Paket = new HashSet<Detail_Paket>();
            this.Transaksis = new HashSet<Transaksi>();
        }
    
        public int ID_Paket { get; set; }
        public string Nama_Paket { get; set; }
        public decimal Harga { get; set; }
        public int Konsumsi { get; set; }
        public Nullable<int> Lama_Perjalanan { get; set; }
        public int Jenis_Paket { get; set; }
        public string Jadwal { get; set; }
        public string Keterangan { get; set; }
        public int Status { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Detail_Paket> Detail_Paket { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transaksi> Transaksis { get; set; }
    }
}
