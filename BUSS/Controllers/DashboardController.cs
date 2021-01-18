using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BUSS.Controllers.Admin
{
    public class DashboardController : Controller
    {
        // GET: Dashboard

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Pegawai()
        {
            return View();
        }

        public ActionResult Tourleader()
        {
            return View();
        }

        public ActionResult Manager()
        {
            return View();
        }
    }
}