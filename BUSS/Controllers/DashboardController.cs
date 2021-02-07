﻿using BUSS.Models;
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

        public ActionResult Index()
        {
            string role = Session["Role"].ToString();
            if (Session["Name"] != null)
            {
                if (role == "1")
                {
                    return RedirectToAction("Pegawai");
                } else if (role == "2")
                {
                    return RedirectToAction("Tourleader");
                } else if (role == "3")
                {
                    return RedirectToAction("Manager");
                } else if (role == "5")
                {
                    return RedirectToAction("Dashboard", "Customer");
                } else
                {
                    return HttpNotFound();
                }
            } else
            {
                return RedirectToAction("Login", "Customer");
            }
        }

        public ActionResult Pegawai()
        {
            ViewBag.StatusTrans = db.view_StatusTransCount.Take(7).ToList();
            ViewBag.trCount = db.Transaksis.Count();

            return View();
        }

        public ActionResult Tourleader()
        {
            ViewBag.Transaksi = db.Transaksis.Where(k => k.Status_Transaksi > 1 && k.Status_Transaksi != 7 && k.Paket.Jadwal == null).Take(5).ToList();
            ViewBag.Paket = db.Pakets.Where(k => k.Jadwal == null && k.Status == 1).Take(5).ToList();

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