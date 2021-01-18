using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BUSS.Models;


namespace BUSS.Controllers
{
    public class Jenis_KendaraanController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Jenis_Kendaraan
        public ActionResult Index()
        {
            return View(db.Jenis_Kendaraan.Where(jk => jk.Status == 1).ToList());
        }


        // GET: Jenis_Kendaraan/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Jenis_Kendaraan/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Jenis,Nama_Jenis,Jumlah_Kursi,Status")] Jenis_Kendaraan jenis_Kendaraan)
        {
            if (db.Jenis_Kendaraan.Any(k => k.Nama_Jenis == jenis_Kendaraan.Nama_Jenis))
            {
                ModelState.AddModelError("Nama_Jenis", "Nama jenis kendaraan sudah ada.");
            }

            if (ModelState.IsValid)
            {
                jenis_Kendaraan.Status = 1;
                jenis_Kendaraan.CreatedBy = (int)Session["ID_Pegawai"];
                jenis_Kendaraan.CreatedDate = DateTime.Now;
                jenis_Kendaraan.ModifiedBy = (int)Session["ID_Pegawai"];
                jenis_Kendaraan.ModifiedDate = DateTime.Now;

                db.Jenis_Kendaraan.Add(jenis_Kendaraan);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil ditambah!";
                return RedirectToAction("Index");
            }

            return View(jenis_Kendaraan);
        }

        // GET: Jenis_Kendaraan/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Jenis_Kendaraan jenis_Kendaraan = db.Jenis_Kendaraan.Find(id);
            if (jenis_Kendaraan == null)
            {
                return HttpNotFound();
            }
            return View(jenis_Kendaraan);
        }

        // POST: Jenis_Kendaraan/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Jenis,Nama_Jenis,Jumlah_Kursi,CreatedBy,CreatedDate")] Jenis_Kendaraan jenis_Kendaraan)
        {
            if (db.Jenis_Kendaraan.Any(k => k.Nama_Jenis == jenis_Kendaraan.Nama_Jenis))
            {
                ModelState.AddModelError("Nama_Jenis", "Nama jenis kendaraan sudah ada.");
            }

            if (ModelState.IsValid)
            {
                jenis_Kendaraan.Status = 1;
                jenis_Kendaraan.ModifiedBy = (int)Session["ID_Pegawai"];
                jenis_Kendaraan.ModifiedDate = DateTime.Now;
                db.Entry(jenis_Kendaraan).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(jenis_Kendaraan);
        }

        // POST: Jenis_Kendaraan/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Jenis_Kendaraan jenis_Kendaraan = db.Jenis_Kendaraan.Find(id);
            jenis_Kendaraan.Status = 0;
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