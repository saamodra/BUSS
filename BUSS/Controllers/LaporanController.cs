using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers
{
    public class LaporanController : Controller
    {
        BUSSEntities db = new BUSSEntities();

        // GET: Laporan
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Pesanan()
        {
            var transaksi = db.Transaksis.ToList();

            return View(transaksi);
        }
    }
}