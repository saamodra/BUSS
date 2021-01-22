using BUSS.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers
{
    public class TourleaderController : Controller
    {
        BUSSEntities db = new BUSSEntities();
        // GET: Tourleader
        public ActionResult Pesanan()
        {
            var transaksi = db.Transaksis.Where(k => k.Status_Transaksi > 1 && k.Status_Transaksi != 7).ToList();

            return View(transaksi);
        }

        [HttpPost]
        public ActionResult KirimJadwal(int id_paket, HttpPostedFileBase jadwal)
        {
            var paket = db.Pakets.Find(id_paket);

            if (jadwal != null)
            {
                var ext = Path.GetExtension(jadwal.FileName);
                var InputFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ext;
                var ServerSavePath = Path.Combine(Server.MapPath("~/Content/jadwal/") + InputFileName);
                //Save BuktiDP to server folder  
                jadwal.SaveAs(ServerSavePath);

                if (paket.Jadwal != null)
                {
                    string fullPath = Request.MapPath("~/Content/jadwal/" + paket.Jadwal);
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }

                paket.Jadwal = InputFileName;
                db.SaveChanges();
            }

            TempData["SuccessMessage"] = "Jadwal berhasil diunggah";

            return RedirectToAction("Pesanan", "Tourleader");
        }


    }
}