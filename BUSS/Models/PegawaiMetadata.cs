using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BUSS.Models
{
    public class PegawaiMetadata
    {
        public int ID_Pegawai { get; set; }

        [Required(ErrorMessage = "Nama wajib diisi!")]
        public string Nama { get; set; }

        [Required(ErrorMessage = "Alamat wajib diisi!")]
        public string Alamat { get; set; }

        [DisplayName("No. HP")]
        [Required(ErrorMessage = "No. HP wajib diisi!")]
        public string No_HP { get; set; }

        [Required(ErrorMessage = "Username wajib diisi!")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Password wajib diisi!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Role wajib diisi!")]
        public int Role { get; set; }

        [DefaultValue(1)]
        public int Status { get; set; }
    }
}