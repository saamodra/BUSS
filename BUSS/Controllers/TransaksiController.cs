using BUSS.Models;
using System;
using System.Collections.Generic;
using System.IO;
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
            if(tgl_sewa < DateTime.Now.AddDays(3))
            {
                TempData["ErrorMessage"] = "Pemesanan harus minimal 4 hari sebelum keberangkatan!";

                return RedirectToAction("LihatPaket", "Home", new { id = id });
            } else
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

                    foreach (var tr in db.Transaksis.Where(k => k.Tanggal_Pesanan == tgl_sewa).ToList())
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

            return RedirectToAction("Pembayaran", "Transaksi", new { id = transaksi.ID_Transaksi });
        }

        [HttpPost]
        public ActionResult CheckoutCustom(Paket paket, DateTime tgl_sewa, int[] ID_Destinasi)
        {
            if (tgl_sewa < DateTime.Now.AddDays(3))
            {
                TempData["ErrorMessage"] = "Pemesanan harus minimal 4 hari sebelum keberangkatan!";

                return RedirectToAction("CustomPaket", "Home");
            }
            else
            {
                paket.Konsumsi = (paket.Lama_Perjalanan == null ? 0 : paket.Lama_Perjalanan.Value) * 2;

                Transaksi transaksi = new Transaksi
                {
                    Paket = paket,
                    Tanggal_Pesanan = tgl_sewa
                };

                if (db.Transaksis.Any(k => k.Tanggal_Pesanan == tgl_sewa))
                {
                    List<int> id_kendaraan = new List<int>();

                    foreach (var tr in db.Transaksis.Where(k => k.Tanggal_Pesanan == tgl_sewa).ToList())
                    {
                        foreach (var kend in tr.Transaksi_Kendaraan)
                        {
                            id_kendaraan.Add(kend.ID_Kendaraan);
                        }
                    }

                    ViewBag.Kendaraan = db.Kendaraans.Where(k => k.Status == 1 && !(id_kendaraan.Contains(k.ID_Kendaraan))).OrderBy(k => k.Nama_Kendaraan).ToList();

                }
                else
                {
                    ViewBag.Kendaraan = db.Kendaraans.Where(k => k.Status == 1).OrderBy(k => k.Nama_Kendaraan).ToList();
                }

                ViewBag.ID_Destinasi = ID_Destinasi;

                return View("Checkout", transaksi);
            }
            
        }

        [HttpPost]
        public ActionResult CustomConfirmed(Transaksi transaksi, int[] ID_Destinasi, int[] ID_Kendaraan)
        {
            if (ModelState.IsValid)
            {
                transaksi.Paket.Jenis_Paket = 1;
                transaksi.Paket.Status = 1;
                transaksi.Paket.CreatedBy = 2;
                transaksi.Paket.CreatedDate = DateTime.Now;
                transaksi.Paket.ModifiedBy = 2;
                transaksi.Paket.ModifiedDate = DateTime.Now;
                db.Pakets.Add(transaksi.Paket);
                db.SaveChanges();

                foreach(var dest in ID_Destinasi)
                {
                    Detail_Paket detail_Paket = new Detail_Paket();
                    detail_Paket.ID_Paket = transaksi.Paket.ID_Paket;
                    detail_Paket.ID_Destinasi = dest;
                    detail_Paket.Status = 1;
                    db.Detail_Paket.Add(detail_Paket);
                    db.SaveChanges();
                }

                transaksi.ID_Customer = Session["NIK"].ToString();
                transaksi.ID_Pegawai = null;
                transaksi.Status_Transaksi = 0;
                transaksi.CreatedDate = DateTime.Now;

                db.Transaksis.Add(transaksi);
                db.SaveChanges();

                foreach (var kend in ID_Kendaraan)
                {
                    Transaksi_Kendaraan transaksi_Kendaraan = new Transaksi_Kendaraan();
                    transaksi_Kendaraan.ID_Kendaraan = kend;
                    transaksi_Kendaraan.ID_Transaksi = transaksi.ID_Transaksi;
                    transaksi_Kendaraan.Status = 1;
                    db.Transaksi_Kendaraan.Add(transaksi_Kendaraan);
                    db.SaveChanges();
                }
            }

            return RedirectToAction("Pembayaran", "Transaksi", new { id = transaksi.ID_Transaksi });
        }

        public ActionResult Pembayaran(int id)
        {
            Transaksi transaksi = db.Transaksis.Find(id);

            return View(transaksi);
        }


        [HttpPost]
        public ActionResult Pembatalan(int id)
        {
            Transaksi transaksi = db.Transaksis.Find(id);
            transaksi.Status_Transaksi = 4;
            db.SaveChanges();
            TempData["SuccessMessage"] = "Pesanan berhasil dibatalkan!";

            return RedirectToAction("Pesanan", "Customer");
        }

        public ActionResult UploadDP(int id)
        {
            var transaksi = db.Transaksis.Find(id);

            return View(transaksi);
        }

        [HttpPost]
        public ActionResult UploadDP(int ID_Transaksi, HttpPostedFileBase BuktiDP)
        {
            var transaksi = db.Transaksis.Find(ID_Transaksi);
            if(transaksi == null)
            {
                return HttpNotFound();
            }

            if (BuktiDP != null)
            {
                var ext = Path.GetExtension(BuktiDP.FileName);
                var InputFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
                var ServerSavePath = Path.Combine(Server.MapPath("~/Content/upload/") + InputFileName);
                //Save BuktiDP to server folder  
                BuktiDP.SaveAs(ServerSavePath);

                transaksi.Bukti_DP = InputFileName;
                transaksi.Status_Transaksi = 1;
                db.SaveChanges();
            }

            TempData["SuccessMessage"] = "Pembayaran DP diproses.";

            return RedirectToAction("Pesanan", "Customer");

        }

        public ActionResult UploadPelunasan(int id)
        {
            var transaksi = db.Transaksis.Find(id);

            return View(transaksi);
        }

        [HttpPost]
        public ActionResult UploadPelunasan(int ID_Transaksi, HttpPostedFileBase BuktiDP)
        {
            var transaksi = db.Transaksis.Find(ID_Transaksi);
            if (transaksi == null)
            {
                return HttpNotFound();
            }

            if (BuktiDP != null)
            {
                var ext = Path.GetExtension(BuktiDP.FileName);
                var InputFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
                var ServerSavePath = Path.Combine(Server.MapPath("~/Content/upload/") + InputFileName);
                //Save BuktiDP to server folder  
                BuktiDP.SaveAs(ServerSavePath);

                transaksi.Bukti_Pelunasan = InputFileName;
                transaksi.Status_Transaksi = 3;
                db.SaveChanges();
            }

            TempData["SuccessMessage"] = "Pelunasan diproses.";

            return RedirectToAction("Pesanan", "Customer");

        }


        [HttpPost]
        public ActionResult KonfirmasiDP(int ID_Transaksi, string submit)
        {
            var transaksi = db.Transaksis.Find(ID_Transaksi);

            if (submit == "Valid")
            {
                transaksi.Status_Transaksi = 2;
                TempData["SuccessMessage"] = "Pembayaran DP Valid";
            } else
            {
                string fullPath = Request.MapPath("~/Content/upload/" + transaksi.Bukti_DP);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }

                transaksi.Status_Transaksi = 0;
                transaksi.Bukti_DP = null;
                TempData["ErrorMessage"] = "Pembayaran DP Tidak Valid";
            }

            db.SaveChanges();

            return RedirectToAction("Pesanan", "Pegawai");
        }

        [HttpPost]
        public ActionResult KonfirmasiPelunasan(int ID_Transaksi, string submit)
        {
            var transaksi = db.Transaksis.Find(ID_Transaksi);

            if (submit == "Valid")
            {
                transaksi.Status_Transaksi = 4;
                TempData["SuccessMessage"] = "Pembayaran Pelunasan Valid";
            }
            else
            {
                string fullPath = Request.MapPath("~/Content/upload/" + transaksi.Bukti_Pelunasan);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }

                transaksi.Status_Transaksi = 2;
                transaksi.Bukti_Pelunasan = null;
                TempData["ErrorMessage"] = "Pembayaran Pelunasan Tidak Valid";
            }

            db.SaveChanges();

            return RedirectToAction("Pesanan", "Pegawai");
        }

        public ActionResult Details(int id)
        {
            Transaksi transaksi = db.Transaksis.Find(id);
            ViewBag.Feedback = db.Feedbacks.FirstOrDefault(k => k.ID_Transaksi == id);

            return View(transaksi);
        }

        public ActionResult DetailTransaksi(int id)
        {
            Transaksi transaksi = db.Transaksis.Find(id);
            ViewBag.Feedback = db.Feedbacks.FirstOrDefault(k => k.ID_Transaksi == id);

            return View(transaksi);
        }

        public ActionResult Penyelesaian(int id)
        {
            //Transaksi transaksi = db.Transaksis.Find(id);

            return View();
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Penyelesaian(int id, decimal Biaya_Tambahan)
        {
            var trans = db.Transaksis.Find(id);

            if (Biaya_Tambahan != null)
            {
                trans.Harga_total = trans.Harga_total + Biaya_Tambahan;
                trans.Status_Transaksi = 5;
                db.Transaksis.Add(trans);
            }
            else
            {
                trans.Status_Transaksi = 5;
            }

            db.Entry(trans).State = EntityState.Modified;
            db.SaveChanges();

            TempData["SuccessMessage"] = "Pesanan telah selesai.";
            return RedirectToAction("Pesanan", "Pegawai");
        }
    }
}
