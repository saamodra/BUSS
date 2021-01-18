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
    public class KotaController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Kota
        public ActionResult Index()
        {
            return View(db.Kotas.Where(k => k.Status == 1).ToList());
        }


        // GET: Kota/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Kota/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Kota,Nama_Kota,Status")] Kota kota)
        {
            if (db.Kotas.Any(k => k.Nama_Kota == kota.Nama_Kota))
            {
                ModelState.AddModelError("Nama_Kota", "Nama kota sudah ada.");
            }

            if (ModelState.IsValid)
            {
                kota.Status = 1;
                kota.CreatedBy = (int)Session["ID_Pegawai"];
                kota.CreatedDate = DateTime.Now;
                kota.ModifiedBy = (int)Session["ID_Pegawai"];
                kota.ModifiedDate = DateTime.Now;
                db.Kotas.Add(kota);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil ditambah!";
                return RedirectToAction("Index");
            }

            return View(kota);
        }

        // GET: Kota/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Kota kota = db.Kotas.Find(id);
            if (kota == null)
            {
                return HttpNotFound();
            }
            return View(kota);
        }

        // POST: Kota/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Kota,Nama_Kota,CreatedBy,CreatedDate")] Kota kota)
        {
            if (db.Kotas.Any(k => k.Nama_Kota == kota.Nama_Kota))
            {
                ModelState.AddModelError("Nama_Kota", "Nama kota sudah ada.");
            }

            if (ModelState.IsValid)
            {
                kota.Status = 1;
                kota.ModifiedBy = (int)Session["ID_Pegawai"];
                kota.ModifiedDate = DateTime.Now;
                db.Entry(kota).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(kota);
        }

        // POST: Kota/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Kota kota = db.Kotas.Find(id);
            kota.Status = 0;
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
