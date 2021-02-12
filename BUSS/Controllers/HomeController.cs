﻿using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers
{
    public class HomeController : Controller
    {
        BUSSEntities db = new BUSSEntities();

        public ActionResult Index()
        {
            var paket = db.view_PaketHome.Where(d => d.Status == 1).Take(8).OrderByDescending(k => k.Rating).ToList();
            return View(paket);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Paket()
        {
            var paket = db.view_PaketHome.Where(k => k.Status == 1).ToList();
            return View(paket);
        }

        //Get one paket 
        public ActionResult LihatPaket(int? id)
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


        public ActionResult CustomPaket()
        {
            ViewBag.Kategori_Wilayah = db.Kategori_Wilayah.Where(k => k.Status == 1).ToList();
            return View();
        }

        [HttpPost]
        public ActionResult CustomPaket(int id)
        {
            Kategori_Wilayah kategori_Wilayah = db.Kategori_Wilayah.Find(id);

            List<int> id_kota = new List<int>();

            foreach (var kota in kategori_Wilayah.Detail_Kategori)
            {
                id_kota.Add(kota.ID_Kota);
            }

            ViewBag.Destinasi = db.Destinasis.Where(k => k.Status == 1 && (id_kota.Contains(k.ID_Kota)))
                .ToList();
            ViewBag.Kategori_Wilayah = db.Kategori_Wilayah.Where(k => k.Status == 1).ToList();
            ViewBag.SelectedKategori = id;
            return View();
        }

        public ActionResult Destinasi()
        {
            var destinasi = db.Destinasis.Where(k => k.Status == 1).ToList();
            return View(destinasi);
        }

        public ActionResult LihatDestinasi(int id)
        {
            var destinasi = db.Destinasis.Find(id);
            var sess_nik = Session["NIK"];
            if(sess_nik == null)
            {
                ViewBag.RatingUser = null;
            } else 
            {
                ViewBag.RatingUser = db.Detail_Rating_Destinasi.FirstOrDefault(k => k.ID_Destinasi == id && k.NIK == sess_nik.ToString());
            }

            if (destinasi == null)
            {
                return HttpNotFound();
            }
            return View(destinasi);
        }

        [HttpPost]
        public ActionResult UpdateStar(Destinasi dest)
        {
            if (Session["NIK"] == null)
            {
                TempData["ErrorMessage"] = "Silahkan login terlebih dahulu untuk memberikan rating.";

                return RedirectToAction("LihatDestinasi", "Home", new { id = dest.ID_Destinasi });
            } else
            {
                var sess_nik = Session["NIK"];

                var rating = db.Detail_Rating_Destinasi.FirstOrDefault(k => k.ID_Destinasi == dest.ID_Destinasi && k.NIK == sess_nik.ToString());

                if (rating == null)
                {
                    Detail_Rating_Destinasi drd = new Detail_Rating_Destinasi();
                    drd.ID_Destinasi = dest.ID_Destinasi;
                    drd.NIK = Session["NIK"].ToString();
                    drd.Rating = dest.Rating;
                    db.Detail_Rating_Destinasi.Add(drd);
                    
                } else
                {
                    Detail_Rating_Destinasi drd = rating;
                    drd.Rating = dest.Rating;
                }

                db.SaveChanges();

                TempData["SuccessMessage"] = "Berhasil memberikan rating.";

                return RedirectToAction("LihatDestinasi", "Home", new { id = dest.ID_Destinasi });
                //return Json(new { result = true, data = drd }, JsonRequestBehavior.AllowGet);
            }
            
        }
    }
}