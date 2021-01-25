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

        public ActionResult Paket()
        {
            var paket = db.Pakets.Where(k => k.Status == 1).ToList(); 

            return View(paket);
        }

        public ActionResult UbahJadwal(int id)
        {
            var paket = db.Pakets.Find(id);

            if (paket == null)
            {
                return HttpNotFound();
            }

            return View(paket);
        }

        [HttpPost]
        public ActionResult KirimJadwal(int id_paket, HttpPostedFileBase jadwal, int type)
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

            if (type == 1)
            {
                return RedirectToAction("Pesanan", "Tourleader");
            } else
            {
                return RedirectToAction("Paket", "Tourleader");
            }
        }


    }
}