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
    public class KendaraanController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Kendaraan
        public ActionResult Index()
        {
            var kendaraans = db.Kendaraans.Include(k => k.Jenis_Kendaraan)
                .Where(k => k.Status == 1);
            return View(kendaraans.ToList());
        }

        // GET: Kendaraan/Create
        public ActionResult Create()
        {
            ViewBag.ID_Jenis = new SelectList(db.Jenis_Kendaraan.Where(k => k.Status == 1), "ID_Jenis", "Nama_Jenis");
            return View();
        }

        // POST: Kendaraan/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Kendaraan,Nama_Kendaraan,ID_Jenis,No_Kendaraan,Harga_kendaraan")] Kendaraan kendaraan)
        {
            if (db.Kendaraans.Any(k => k.Nama_Kendaraan == kendaraan.Nama_Kendaraan))
            {
                ModelState.AddModelError("Nama_Kendaraan", "Nama kendaraan sudah ada.");
            }

            if (ModelState.IsValid)
            {
                kendaraan.Status = 1;
                kendaraan.CreatedBy = (int)Session["ID_Pegawai"];
                kendaraan.CreatedDate = DateTime.Now;
                kendaraan.ModifiedBy = (int)Session["ID_Pegawai"];
                kendaraan.ModifiedDate = DateTime.Now;
                db.Kendaraans.Add(kendaraan);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil ditambah!";
                return RedirectToAction("Index");
            }

            ViewBag.ID_Jenis = new SelectList(db.Jenis_Kendaraan.Where(k => k.Status == 1), "ID_Jenis", "Nama_Jenis", kendaraan.ID_Jenis);
            return View(kendaraan);
        }

        // GET: Kendaraan/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Kendaraan kendaraan = db.Kendaraans.Find(id);
            if (kendaraan == null)
            {
                return HttpNotFound();
            }
            ViewBag.ID_Jenis = new SelectList(db.Jenis_Kendaraan.Where(k => k.Status == 1), "ID_Jenis", "Nama_Jenis", kendaraan.ID_Jenis);
            return View(kendaraan);
        }

        // POST: Kendaraan/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Kendaraan,Nama_Kendaraan,ID_Jenis,No_Kendaraan,Harga_kendaraan,CreatedBy,CreatedDate")] Kendaraan kendaraan)
        {
            if (db.Kendaraans.Any(k => k.Nama_Kendaraan == kendaraan.Nama_Kendaraan))
            {
                ModelState.AddModelError("Nama_Kendaraan", "Nama kendaraan sudah ada.");
            }

            if (ModelState.IsValid)
            {
                kendaraan.Status = 1;
                kendaraan.ModifiedBy = (int)Session["ID_Pegawai"];
                kendaraan.ModifiedDate = DateTime.Now;
                db.Entry(kendaraan).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            ViewBag.ID_Jenis = new SelectList(db.Jenis_Kendaraan.Where(k => k.Status == 1), "ID_Jenis", "Nama_Jenis", kendaraan.ID_Jenis);
            return View(kendaraan);
        }

        // POST: Kendaraan/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Kendaraan kendaraan = db.Kendaraans.Find(id);
            kendaraan.Status = 0;
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
