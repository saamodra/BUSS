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
    public class DestinasiController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Destinasi
        public ActionResult Index()
        {
            var destinasis = db.Destinasis.Include(d => d.Kota)
                .Where(d => d.Status == 1);
            return View(destinasis.ToList());
        }

        // GET: Destinasi/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Destinasi destinasi = db.Destinasis.Find(id);
            if (destinasi == null)
            {
                return HttpNotFound();
            }
            return View(destinasi);
        }

        // GET: Destinasi/Create
        public ActionResult Create()
        {
            ViewBag.ID_Kota = new SelectList(db.Kotas.Where(k => k.Status == 1), "ID_Kota", "Nama_Kota");
            return View();
        }

        // POST: Destinasi/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Destinasi,Nama_Destinasi,Harga_Tiket,ID_Kota,Jam_Buka,Jam_Tutup,Deskripsi")] Destinasi destinasi)
        {
            if (db.Destinasis.Any(k => k.Nama_Destinasi == destinasi.Nama_Destinasi))
            {
                ModelState.AddModelError("Nama_Destinasi", "Nama destinasi sudah ada");
            }
           
            if (ModelState.IsValid)
            {
                
                destinasi.Rating = 0;
                destinasi.Status = 1;
                destinasi.CreatedBy = (int)Session["ID_Pegawai"];
                destinasi.CreatedDate = DateTime.Now;
                destinasi.ModifiedBy = (int)Session["ID_Pegawai"];
                destinasi.ModifiedDate = DateTime.Now;

                db.Destinasis.Add(destinasi);
                db.SaveChanges();

                TempData["SuccessMessage"] = "Data berhasil ditambah!";

                return RedirectToAction("Details", "Destinasi", new { @id = destinasi.ID_Destinasi });
                
            }

            ViewBag.ID_Kota = new SelectList(db.Kotas.Where(k => k.Status == 1), "ID_Kota", "Nama_Kota", destinasi.ID_Kota);
            return View(destinasi);
        }

        // GET: Destinasi/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Destinasi destinasi = db.Destinasis.Find(id);
            if (destinasi == null)
            {
                return HttpNotFound();
            }

            ViewBag.ID_Kota = new SelectList(db.Kotas.Where(k => k.Status == 1), "ID_Kota", "Nama_Kota", destinasi.ID_Kota);
            return View(destinasi);
        }

        // POST: Destinasi/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Destinasi,Nama_Destinasi,Harga_Tiket,ID_Kota,Rating,Jam_Buka,Jam_Tutup,Deskripsi,CreatedBy,CreatedDate")] Destinasi destinasi)
        {
            if (db.Destinasis.Any(k => k.Nama_Destinasi == destinasi.Nama_Destinasi))
            {
                ModelState.AddModelError("Nama_Destinasi", "Nama destinasi sudah ada.");
            }

            if (ModelState.IsValid)
            {
                destinasi.Status = 1;
                destinasi.ModifiedBy = (int)Session["ID_Pegawai"];
                destinasi.ModifiedDate = DateTime.Now;

                db.Entry(destinasi).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            ViewBag.ID_Kota = new SelectList(db.Kotas, "ID_Kota", "Nama_Kota", destinasi.ID_Kota);
            return View(destinasi);
        }

        // POST: Destinasi/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Destinasi destinasi = db.Destinasis.Find(id);
            destinasi.Status = 0;
            db.SaveChanges();
            TempData["SuccessMessage"] = "Data berhasil dihapus!";
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult Details(IEnumerable<HttpPostedFileBase> files, int id)
        {
            //Ensure model state is valid  
            if (ModelState.IsValid)
            {   //iterating through multiple file collection
                int fileId = 0;
                foreach (HttpPostedFileBase file in files)
                {
                    //Checking file is available to save.  
                    if (file != null)
                    {
                        var ext = Path.GetExtension(file.FileName);
                        var InputFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + fileId + ext;
                        var ServerSavePath = Path.Combine(Server.MapPath("~/Content/upload/") + InputFileName);
                        //Save file to server folder  
                        file.SaveAs(ServerSavePath);

                        Detail_Foto detail_Foto = new Detail_Foto();
                        detail_Foto.ID_Destinasi = id;
                        detail_Foto.Foto = InputFileName;
                        db.Detail_Foto.Add(detail_Foto);
                        db.SaveChanges();
                    }
                    fileId++;
                }
            }

            Destinasi destinasi = db.Destinasis.Find(id);

            //assigning file uploaded status to ViewBag for showing message to user.  
            TempData["SuccessMessage"] = files.Count().ToString() + " berhasil diunggah.";

            return View(destinasi);
        }

        [HttpPost]
        public ActionResult HapusFoto(int detailId, int ID_Destinasi)
        {
            Detail_Foto detail = db.Detail_Foto.Find(detailId);
            string fullPath = Request.MapPath("~/Content/upload/" + detail.Foto);
            if (System.IO.File.Exists(fullPath))
            {
                System.IO.File.Delete(fullPath);
            }

            db.Detail_Foto.Remove(detail);
            db.SaveChanges();
            TempData["SuccessMessage"] = "Foto berhasil dihapus";

            return RedirectToAction("Details", "Destinasi", new { @id = ID_Destinasi });
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
