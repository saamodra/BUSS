using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BUSS.Models;

namespace BUSS.Controllers
{
    public class PaketController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Paket
        public ActionResult Index()
        {
            return View(db.Pakets.Where(p => p.Status == 1).ToList());
        }

        // GET: Paket/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Paket paket = db.Pakets.Find(id);
            if (paket == null)
            {
                return HttpNotFound();
            }

            ViewBag.ID_Destinasi = new SelectList(db.Destinasis.Where(k => k.Status == 1), "ID_Destinasi", "Nama_Destinasi");
            return View(paket);
        }

        [HttpPost]
        public ActionResult AddDetails(int ID_Paket, int ID_Destinasi)
        {
            Paket paket = db.Pakets.Find(ID_Paket);

            if (ModelState.IsValid)
            {
                Detail_Paket d = new Detail_Paket();
                d.ID_Paket = ID_Paket;
                d.ID_Destinasi = ID_Destinasi;

                int rowCount = db.Detail_Paket.Where(k =>
                                (k.ID_Paket == ID_Paket) && (k.ID_Destinasi == ID_Destinasi)).Count();

                if (rowCount > 0)
                {
                    TempData["ErrorMessage"] = "Data destinasi gagal ditambahkan!";
                }
                else
                {
                    db.Detail_Paket.Add(d);
                    db.SaveChanges();
                    TempData["SuccessMessage"] = "Data destinasi berhasil ditambah!";
                }
            }
            return RedirectToAction("Details", "Paket", new { @id = ID_Paket });
        }

        [HttpPost]
        public ActionResult DeleteDetails(int ID_Paket, int ID_Destinasi)
        {
            if (ModelState.IsValid)
            {
                Detail_Paket detail = db.Detail_Paket.Where(k =>
                                (k.ID_Paket == ID_Paket) && (k.ID_Destinasi == ID_Destinasi)).FirstOrDefault();

                db.Detail_Paket.Remove(detail);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data destinasi berhasil dihapus!";

                return RedirectToAction("Details", "Paket", new { @id = ID_Paket });
            }

            return RedirectToAction("Details", "Paket", new { @id = ID_Paket });
        }

        // GET: Paket/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Paket/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Paket,Nama_Paket,Lama_Perjalanan,Keterangan")] Paket paket)
        {
            if (db.Pakets.Any(k => k.Nama_Paket == paket.Nama_Paket))
            {
                ModelState.AddModelError("Nama_Paket", "Nama paket sudah ada.");
            }

            if (ModelState.IsValid)
            {
                paket.Konsumsi = (paket.Lama_Perjalanan == null ? 0 : paket.Lama_Perjalanan.Value) * 2;
                paket.Jenis_Paket = 0;
                paket.Status = 1;
                paket.CreatedBy = (int)Session["ID_Pegawai"];
                paket.CreatedDate = DateTime.Now;
                paket.ModifiedBy = (int)Session["ID_Pegawai"];
                paket.ModifiedDate = DateTime.Now;
                db.Pakets.Add(paket);
                db.SaveChanges();

                TempData["SuccessMessage"] = "Data berhasil ditambah!";

                return RedirectToAction("Details", "Paket", new { @id = paket.ID_Paket });
            }

            return View(paket);
        }

        // GET: Paket/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Paket paket = db.Pakets.Find(id);
            if (paket == null)
            {
                return HttpNotFound();
            }
            return View(paket);
        }

        // POST: Paket/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Paket,Nama_Paket,Lama_Perjalanan,Keterangan,Status,CreatedBy,CreatedDate")] Paket paket)
        {
            if (db.Pakets.Any(k => k.Nama_Paket == paket.Nama_Paket))
            {
                ModelState.AddModelError("Nama_Paket", "Nama paket sudah ada.");
            }

            if (ModelState.IsValid)
            {
                paket.Konsumsi = (paket.Lama_Perjalanan == null ? 0 : paket.Lama_Perjalanan.Value) * 2;
                paket.Status = 1;
                paket.ModifiedBy = (int)Session["ID_Pegawai"];
                paket.ModifiedDate = DateTime.Now;
                db.Entry(paket).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(paket);
        }

        // GET: Paket/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Paket paket = db.Pakets.Find(id);
            if (paket == null)
            {
                return HttpNotFound();
            }
            return View(paket);
        }

        // POST: Paket/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Paket paket = db.Pakets.Find(id);
            paket.Status = 0;
            db.SaveChanges();
            TempData["SuccessMessage"] = "Data berhasil dihapus!";
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
