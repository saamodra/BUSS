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

        public ActionResult Pesanan()
        {
            var transaksi = db.Transaksis.ToList();

            return View("Pesanan_3", transaksi);
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

            return View(transaksi);
        }

        public ActionResult PrintPesanan()
        {
            var report = new ActionAsPdf("PdfPesanan");
            return report;
        }

        //[HttpPost]
        [ValidateInput(false)]
        public FileResult Export()
        {
            using (MemoryStream stream = new MemoryStream())
            {
                string html = System.IO.File.ReadAllText(Server.MapPath("~/Views/Laporan/PdfPesanan.cshtml"));
                StringReader sr = new StringReader(html);
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
                pdfDoc.Open();
                XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                pdfDoc.Close();
                return File(stream.ToArray(), "application/pdf", "Grid.pdf");
            }
        }


        public ActionResult PrintPartialViewToPdf(int id)
        {
            var transaksi = db.Transaksis.ToList();

            var report = new PartialViewAsPdf("~/Views/Shared/DetailCustomer.cshtml", transaksi);
            return report;
        }
    }
}