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
    public class FeedbacksController : Controller
    {
        private BUSSEntities db = new BUSSEntities();


        // GET: Feedbacks/Create
        public ActionResult Create(int id)
        {
            if (db.Transaksis.Any(k => k.ID_Transaksi == id))
            {
                ViewBag.ID_Transaksi = id;
                return View();
            } else
            {
                return HttpNotFound();
            }
        }

        // POST: Feedbacks/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Feedback,ID_Transaksi,Rating,Isi_Feedback,CreatedDate")] Feedback feedback)
        {
            if (ModelState.IsValid)
            {
                feedback.CreatedDate = DateTime.Now;
                db.Feedbacks.Add(feedback);
                db.SaveChanges();

                Transaksi transaksi = db.Transaksis.Find(feedback.ID_Transaksi);
                transaksi.Status_Transaksi = 5;
                db.SaveChanges();

                TempData["SuccessMessage"] = "Ulasan berhasil dikirim.";


                return RedirectToAction("Pesanan", "Customer");
            }

            return View(feedback);
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
