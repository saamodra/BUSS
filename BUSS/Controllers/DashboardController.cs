using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers.Admin
{
    public class DashboardController : Controller
    {
        BUSSEntities db = new BUSSEntities();

        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Pegawai()
        {
            ViewBag.StatusTrans = db.view_StatusTransCount.Take(7).ToList();
            ViewBag.trCount = db.Transaksis.Count();

            return View();
        }

        public ActionResult Tourleader()
        {
            return View();
        }

        public ActionResult Manager()
        {
            ViewBag.grafikPenjualan = db.view_DashboardCustomer.ToList();
            ViewBag.Transaksi = db.view_TransaksiCount.OrderByDescending(x => x.jumlah_dipesan).Take(5).ToList();
            ViewBag.trCount = db.Transaksis.Count();
            ViewBag.trSum = db.Transaksis.Sum(x => x.Harga_total);
            ViewBag.JumlahDestinasiWilayah = db.view_JumlahDestinasiWilayah.OrderByDescending(x => x.JumlahDestinasi).Take(5).ToList();
            ViewBag.DestinasiTerlaris = db.view_DestinasiTerlaris.OrderByDescending(x => x.JumlahDipesan).Take(5).ToList();
            
            return View();
        }
    }
}