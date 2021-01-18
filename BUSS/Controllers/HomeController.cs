using BUSS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers
{
    public class HomeController : Controller
    {
        BUSSEntities db = new BUSSEntities();

        public ActionResult Index()
        {
            var paket = db.Pakets.Where(d => d.Status == 1 && d.Harga != null).ToList();
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
    }
}