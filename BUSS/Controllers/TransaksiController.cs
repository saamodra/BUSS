using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers
{
    public class TransaksiController : Controller
    {
        BUSSEntities db = new BUSSEntities();
        // GET: Transaksi
        public ActionResult Index()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Checkout(int id, DateTime tgl_sewa)
        {
            var paket = db.Pakets.Find(id);

            Transaksi transaksi = new Transaksi
            {
                Paket = paket,
                Tanggal_Pesanan = tgl_sewa
            };

            if(db.Transaksis.Any(k => k.Tanggal_Pesanan == tgl_sewa))
            {
                List<int> id_kendaraan = new List<int>();

                foreach(var tr in db.Transaksis.Where(k => k.Tanggal_Pesanan == tgl_sewa).ToList())
                {
                    foreach(var kend in tr.Transaksi_Kendaraan)
                    {
                        id_kendaraan.Add(kend.ID_Kendaraan);
                    }
                }

                ViewBag.Kendaraan = db.Kendaraans.Where(k => k.Status == 1 && !(id_kendaraan.Contains(k.ID_Kendaraan))).OrderBy(k => k.Nama_Kendaraan).ToList();

            } else
            {
                ViewBag.Kendaraan = db.Kendaraans.Where(k => k.Status == 1).OrderBy(k => k.Nama_Kendaraan).ToList();
            }
            
            return View(transaksi);
        }

        [HttpPost]
        public ActionResult CheckoutConfirmed(Transaksi transaksi, int[] ID_Kendaraan)
        {
            if(ModelState.IsValid)
            {
                transaksi.ID_Customer = Session["NIK"].ToString();
                transaksi.ID_Pegawai = null;
                transaksi.Status_Transaksi = 0;
                transaksi.CreatedDate = DateTime.Now;
                
                db.Transaksis.Add(transaksi);
                db.SaveChanges();

                foreach(var kend in ID_Kendaraan)
                {
                    Transaksi_Kendaraan transaksi_Kendaraan = new Transaksi_Kendaraan();
                    transaksi_Kendaraan.ID_Kendaraan = kend;
                    transaksi_Kendaraan.ID_Transaksi = transaksi.ID_Transaksi;
                    transaksi_Kendaraan.Status = 1;
                    db.Transaksi_Kendaraan.Add(transaksi_Kendaraan);
                    db.SaveChanges();
                }
            }

            return RedirectToAction("LihatPaket", "Home", new { id = transaksi.ID_Paket });
        }
    }
}