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
    public class PegawaiController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Pegawai
        public ActionResult Index()
        {
            return View(db.Pegawais.Where(s => s.Status == 1).ToList());
        }

        // GET: Pegawai/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pegawai pegawai = db.Pegawais.Find(id);
            if (pegawai == null)
            {
                return HttpNotFound();
            }
            return View(pegawai);
        }

        // GET: Pegawai/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Pegawai/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Pegawai,Nama,Alamat,No_HP,Username,Password,Role,Status")] Pegawai pegawai)
        {
            if (ModelState.IsValid)
            {
                db.Pegawais.Add(pegawai);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil ditambah!";
                return RedirectToAction("Index");
            }

            return View(pegawai);
        }

        // GET: Pegawai/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pegawai pegawai = db.Pegawais.Find(id);
            if (pegawai == null)
            {
                return HttpNotFound();
            }
            return View(pegawai);
        }

        // POST: Pegawai/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Pegawai,Nama,Alamat,No_HP,Username,Password,Role,Status")] Pegawai pegawai)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pegawai).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(pegawai);
        }

        // POST: Pegawai/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pegawai pegawai = db.Pegawais.Find(id);
            pegawai.Status = 0;
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
