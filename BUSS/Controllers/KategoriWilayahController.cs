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
    public class KategoriWilayahController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: KategoriWilayah
        public ActionResult Index()
        {
            return View(db.Kategori_Wilayah.Where(k => k.Status == 1).ToList());
        }

        // GET: KategoriWilayah/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(id);
            if (kategori_Wilayah == null)
            {
                return HttpNotFound();
            }
            ViewBag.ID_Kota = new SelectList(db.Kotas.Where(k => k.Status == 1), "ID_Kota", "Nama_Kota");

            return View(kategori_Wilayah);
        }

        [HttpPost]
        public ActionResult AddDetails(int ID_KategoriWilayah, int ID_Kota)
        {
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(ID_KategoriWilayah);

            if (ModelState.IsValid)
            {
                Detail_Kategori d = new Detail_Kategori();
                d.ID_KategoriWilayah = ID_KategoriWilayah;
                d.ID_Kota = ID_Kota;

                db.Detail_Kategori.Add(d);

                int rowCount = db.Detail_Kategori.Where(k =>
                                (k.ID_KategoriWilayah == ID_KategoriWilayah) && (k.ID_Kota == ID_Kota)).Count();


                if (rowCount > 0)
                {
                    TempData["ErrorMessage"] = "Data kota gagal ditambahkan!";
                } else
                {
                    TempData["SuccessMessage"] = "Data kota berhasil ditambah!";
                    db.SaveChanges();
                }
            }
            return RedirectToAction("Details", "KategoriWilayah", new { @id = ID_KategoriWilayah });
        }

        [HttpPost]
        public ActionResult DeleteDetails(int ID_KategoriWilayah, int ID_Kota)
        {
            if (ModelState.IsValid)
            {
                Detail_Kategori detail = db.Detail_Kategori.Where(k =>
                                (k.ID_KategoriWilayah == ID_KategoriWilayah) && (k.ID_Kota == ID_Kota)).FirstOrDefault();

                db.Detail_Kategori.Remove(detail);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data kota berhasil dihapus!";

                return RedirectToAction("Details", "KategoriWilayah", new { @id = ID_KategoriWilayah });
            }

            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(ID_KategoriWilayah);

            return View("Details", kategori_Wilayah);
        }

        // GET: KategoriWilayah/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: KategoriWilayah/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_KategoriWilayah,Nama_Wilayah,Status")] Kategori_Wilayah kategori_Wilayah)
        {
            if (ModelState.IsValid)
            {
                kategori_Wilayah.Status = 1;
                kategori_Wilayah.CreatedBy = (int)Session["ID_Pegawai"];
                kategori_Wilayah.CreatedDate = DateTime.Now;
                kategori_Wilayah.ModifiedBy = (int)Session["ID_Pegawai"];
                kategori_Wilayah.ModifiedDate = DateTime.Now;
                db.Kategori_Wilayah.Add(kategori_Wilayah);
                db.SaveChanges();

                TempData["SuccessMessage"] = "Data berhasil ditambah!";

                return RedirectToAction("Details", "Destinasi", new { @id = kategori_Wilayah.ID_KategoriWilayah });
            }

            return View(kategori_Wilayah);
        }

        // GET: KategoriWilayah/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(id);
            if (kategori_Wilayah == null)
            {
                return HttpNotFound();
            }
            return View(kategori_Wilayah);
        }

        // POST: KategoriWilayah/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_KategoriWilayah,Nama_Wilayah,Status,CreatedBy,CreatedDate")] Kategori_Wilayah kategori_Wilayah)
        {
            if (ModelState.IsValid)
            {
                kategori_Wilayah.Status = 1;
                kategori_Wilayah.ModifiedBy = (int)Session["ID_Pegawai"];
                kategori_Wilayah.ModifiedDate = DateTime.Now;
                db.Entry(kategori_Wilayah).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(kategori_Wilayah);
        }

        // GET: KategoriWilayah/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(id);
            if (kategori_Wilayah == null)
            {
                return HttpNotFound();
            }
            return View(kategori_Wilayah);
        }

        // POST: KategoriWilayah/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(id);
            kategori_Wilayah.Status = 0;
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
