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

            
            if(date_1 == null)
            {
                var transaksi = db.Transaksis.ToList();
                return View("Pesanan_2", transaksi);
            } else
            {
                var transaksi = db.Transaksis.Where(x => x.Tanggal_Pesanan >= date_1 && x.Tanggal_Pesanan <= date_2).ToList();
                return View("Pesanan_2", transaksi);
            }
        }

        public ActionResult LaporanPesanan()
        {
            var transaksi = db.Transaksis.ToList();

            return View(transaksi);
        }


        public ActionResult Destinasi()
        {
            var destinasi = db.Destinasis.ToList();

            return View(destinasi);
        }

        public ActionResult Feedback()
        {
            var feedback = db.Feedbacks.ToList();

            return View(feedback);
        }

        public ActionResult PdfPesanan()
        {
            var transaksi = db.Transaksis.ToList();
            ViewBag.sumTransaksi = db.Transaksis.Select(x => x.Harga_total).DefaultIfEmpty(0).Sum();

            return View(transaksi);
        }

        public ActionResult PrintPesanan()
        {
            var report = new ActionAsPdf("PdfPesanan")
            {
                FileName = "Laporan Pesanan " + DateTime.Now.ToString("dd-MM-yyyy") + ".pdf",
                CustomSwitches = "--disable-smart-shrinking"
            };
            return report;
        }


        public ActionResult PrintPartialViewToPdf(int id)
        {
            var transaksi = db.Transaksis.ToList();

            var report = new PartialViewAsPdf("~/Views/Shared/DetailCustomer.cshtml", transaksi);
            return report;
        }
    }
}