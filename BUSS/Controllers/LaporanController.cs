using Rotativa;
using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;

namespace BUSS.Controllers
{
    public class LaporanController : Controller
    {
        BUSSEntities db = new BUSSEntities();

        // GET: Laporan
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Pesanan(DateTime? date_1, DateTime? date_2, string Status)
        {
            ViewBag.date_1 = date_1;
            ViewBag.date_2 = date_2;
            ViewBag.status = Status;

            if (date_1 != null && Status != "")
            {
                int itStatus = Convert.ToInt32(Status);
                var dt = db.Transaksis.Where(x => x.Tanggal_Pesanan >= date_1 && x.Tanggal_Pesanan <= date_2 && x.Status_Transaksi == itStatus).ToList();
                return View(dt);
            } else if (date_1 != null)
            {
                var dt = db.Transaksis.Where(x => x.Tanggal_Pesanan >= date_1 && x.Tanggal_Pesanan <= date_2).ToList();
                return View(dt);
            }

            var transaksi = db.Transaksis.ToList();
            return View(transaksi);
        }

        public ActionResult LaporanPesanan()
        {
            var transaksi = db.Transaksis.ToList();

            return View(transaksi);
        }


        public ActionResult Destinasi(string ID_Kota)
        {
            ViewBag.ID_Kota = new SelectList(db.Kotas.Where(k => k.Status == 1).OrderBy(k => k.Nama_Kota), "ID_Kota", "Nama_Kota");

            if (ID_Kota != null && ID_Kota != "")
            {
                int it_Kota = Convert.ToInt32(ID_Kota);
                var dt = db.Destinasis.Where(x => x.ID_Kota == it_Kota).OrderBy(x => x.Nama_Destinasi).ToList();
                ViewBag.Kota_Terpilih = ID_Kota;

                return View("Destinasi_2", dt);
            }

            var destinasi = db.Destinasis.OrderBy(x => x.Nama_Destinasi).ToList();

            return View("Destinasi_2", destinasi);
        }

        public ActionResult Feedback(string ID_Paket)
        {
            ViewBag.ID_Paket = new SelectList(db.Pakets.Where(k => k.Status == 1).OrderBy(k => k.Nama_Paket), "ID_Paket", "Nama_Paket");

            if (ID_Paket != null && ID_Paket != "")
            {
                int it_Paket = Convert.ToInt32(ID_Paket);
                var dt = db.Feedbacks.Where(x => x.Transaksi.Paket.ID_Paket == it_Paket).OrderBy(x => x.Transaksi.Paket.Nama_Paket).ToList();
                ViewBag.Paket_Terpilih = ID_Paket;

                return View("Feedback_2", dt);
            }

            var feedback = db.Feedbacks.OrderBy(x => x.Transaksi.Paket.Nama_Paket).ToList();

            return View("Feedback_2", feedback);
        }

        public ActionResult PdfPesanan(DateTime? _date_1, DateTime? _date_2, string _Status)
        {
            if (_date_1 != null && _Status != null && _Status != "")
            {
                int it_Status = Convert.ToInt32(_Status);
                var dt = db.Transaksis.Where(x => x.Tanggal_Pesanan >= _date_1 && x.Tanggal_Pesanan <= _date_2 && x.Status_Transaksi == it_Status).ToList();
                ViewBag.sumTransaksi = dt.Select(x => x.Harga_total).DefaultIfEmpty(0).Sum();
                ViewBag.date_1 = _date_1;
                ViewBag.date_2 = _date_2;
                ViewBag.Status = _Status;

                return View(dt);
            }
            else if (_date_1 != null)
            {
                var dt = db.Transaksis.Where(x => x.Tanggal_Pesanan >= _date_1 && x.Tanggal_Pesanan <= _date_2).ToList();
                ViewBag.sumTransaksi = dt.Select(x => x.Harga_total).DefaultIfEmpty(0).Sum();
                ViewBag.date_1 = _date_1;
                ViewBag.date_2 = _date_2;

                return View(dt);
            }

            var transaksi = db.Transaksis.ToList();
            ViewBag.sumTransaksi = transaksi.Select(x => x.Harga_total).DefaultIfEmpty(0).Sum();

            return View(transaksi);
        }

        public ActionResult PdfDestinasi(string _ID_Kota)
        {
            if (_ID_Kota != null && _ID_Kota != "")
            {
                int it_Kota = Convert.ToInt32(_ID_Kota);
                var dt = db.Destinasis.Where(x => x.Kota.ID_Kota == it_Kota && x.Status == 1).OrderBy(x => x.Nama_Destinasi).ToList();
                ViewBag.avgRating = dt.Select(x => x.Rating).DefaultIfEmpty(0).Average();
                ViewBag.avgHarga = dt.Select(x => x.Harga_Tiket).DefaultIfEmpty(0).Average();
                
                ViewBag.Kota = db.Kotas.Find(it_Kota).Nama_Kota;

                return View(dt);
            }

            var destinasi = db.Destinasis.Where(x => x.Status == 1).OrderBy(x => x.Nama_Destinasi).ToList();
            ViewBag.avgHarga = destinasi.Select(x => x.Harga_Tiket).DefaultIfEmpty(0).Average();
            ViewBag.avgRating = destinasi.Select(x => x.Rating).DefaultIfEmpty(0).Average();

            return View(destinasi);
        }

        public ActionResult PdfFeedback(string _ID_Paket)
        {
            if (_ID_Paket != null && _ID_Paket != "")
            {
                int id_Paket = Convert.ToInt32(_ID_Paket);
                var dt = db.Feedbacks.Where(x => x.Transaksi.Paket.ID_Paket == id_Paket).OrderBy(x => x.Transaksi.Paket.Nama_Paket).ToList();
                ViewBag.avgRating = dt.Select(x => x.Rating).DefaultIfEmpty(0).Average();

                ViewBag.Paket = db.Pakets.Find(id_Paket).Nama_Paket;

                return View(dt);
            }

            var feedback = db.Feedbacks.OrderBy(x => x.Transaksi.Paket.Nama_Paket).ToList();
            ViewBag.avgRating = feedback.Select(x => x.Rating).DefaultIfEmpty(0).Average();

            return View(feedback);
        }

        public ActionResult PrintPesanan(DateTime? date_1, DateTime? date_2, string Status)
        {
            
            var report = new ActionAsPdf("PdfPesanan", new { _date_1 = date_1, _date_2 = date_2, _Status = Status})
            {
                FileName = "Laporan Pesanan " + DateTime.Now.ToString("dd-MM-yyyy") + ".pdf",
                CustomSwitches = "--disable-smart-shrinking"
            };
            return report;
        }

        public ActionResult PrintDestinasi(string Kota)
        {

            var report = new ActionAsPdf("PdfDestinasi", new { _ID_Kota = Kota })
            {
                FileName = "Laporan Destinasi " + DateTime.Now.ToString("dd-MM-yyyy") + ".pdf",
                CustomSwitches = "--disable-smart-shrinking"
            };
            return report;
        }

        public ActionResult PrintFeedback(string Paket)
        {

            var report = new ActionAsPdf("PdfFeedback", new { _ID_Paket = Paket })
            {
                FileName = "Laporan Feedback " + DateTime.Now.ToString("dd-MM-yyyy") + ".pdf",
                CustomSwitches = "--disable-smart-shrinking"
            };
            return report;
        }
    }
}