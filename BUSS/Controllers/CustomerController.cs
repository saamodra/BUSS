using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using BUSS.Models;

namespace BUSS.Controllers
{
    public class CustomerController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Customer
        public ActionResult Index()
        {
            return View(db.Customers.OrderBy(k => k.Nama).ToList());
        }

        // GET: Customer/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // GET: Customer/Create
        public ActionResult Create()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        // POST: Customer/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "NIK,Nama,Alamat,No_HP,Email,Password")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                db.Customers.Add(customer);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(customer);
        }

        // GET: Customer/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // POST: Customer/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "NIK,Nama,Alamat,No_HP,Email,Password")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                db.Entry(customer).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(customer);
        }

        // GET: Customer/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // POST: Customer/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Customer customer = db.Customers.Find(id);
            db.Customers.Remove(customer);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register([Bind(Include = "NIK,Nama,Alamat,No_HP,Email,Password")] Customer customer)
        {
            if (db.Customers.Any(k => k.Email == customer.Email))
            {
                ModelState.AddModelError("Email", "Email sudah terdaftar.");
            }

            if (ModelState.IsValid)
            {
                customer.CreatedDate = DateTime.Now;
                db.Customers.Add(customer);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Register berhasil";

                return RedirectToAction("Register");
            }

            return View(customer);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string email, string password)
        {
            if (ModelState.IsValid)
            {
                using (BUSSEntities db = new BUSSEntities())
                {
                    var obj = db.Customers.Where(a => a.Email.Equals(email) && a.Password.Equals(password)).FirstOrDefault();
                    if (obj != null)
                    {
                        TempData["SuccessMessage"] = "Login berhasil!";
                        Session["NIK"] = obj.NIK.ToString();
                        Session["Name"] = obj.Nama.ToString();
                        Session["UserName"] = obj.Email.ToString();
                        Session["Role"] = "4";
                        Session["IsCustomer"] = true;
                        return RedirectToAction("UserLogin");
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "Email dan Password tidak cocok!";
                    }
                }
            }

            return RedirectToAction("Login");
        }

        public ActionResult UserLogin()
        {
            if (Session["Role"].ToString() == "4")
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Abandon(); // it will clear the session at the end of request

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Dashboard()
        {
            string nik = Session["NIK"].ToString();
            ViewBag.dbData = db.view_DashboardCustomer.Where(x => x.ID_Customer == nik).ToList();
            ViewBag.trCount = db.Transaksis.Where(x => x.ID_Customer == nik).Count();
            ViewBag.trSum = db.Transaksis.Where(x => x.ID_Customer == nik).Select(t => t.Harga_total).DefaultIfEmpty(0).Sum();
            ViewBag.Transaksi = db.Transaksis.Where(x => x.ID_Customer == nik).OrderByDescending(x => x.CreatedDate).Take(5).ToList();
             
            return View();
        }

        public ActionResult Pesanan()
        {
            if(Session["NIK"] != null)
            {
                string nik = Session["NIK"].ToString();
                var pesanan = db.view_TransaksiCustomer.Where(k => k.ID_Customer == nik).ToList();
                return View(pesanan);
            } else
            {
                return RedirectToAction("Login", "Customer");
            }
        }

        public ActionResult Profil()
        {
            if (Session["NIK"] != null)
            {
                string nik = Session["NIK"].ToString();
                var customer = db.Customers.Find(nik);

                return View(customer);
            }
            else
            {
                return RedirectToAction("Login", "Pegawai");
            }

        }

        [HttpPost]
        public ActionResult Profil([Bind(Include = "NIK,Nama,Alamat,No_HP,Email,Password,CreatedDate")] Customer customer)
        {
            if (db.Customers.Where(k => k.NIK != customer.NIK).Any(k => k.Email == customer.Email))
            {
                ModelState.AddModelError("Email", "Email sudah terdaftar.");
            }

            if (ModelState.IsValid)
            {
                db.Entry(customer).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Profil berhasil diperbarui!";
                return RedirectToAction("Profil");
            }

            if (Session["NIK"] != null)
            {
                return RedirectToAction("Login", "Pegawai");
            }

            return View(customer);

        }

        [HttpPost]
        public ActionResult UbahPassword(string NIK, string password, string newpassword)
        {
            var customer = db.Customers.Find(NIK);

            if (db.Customers.Any(k => k.NIK == NIK && k.Password == password))
            {
                customer.Password = newpassword;
                db.Entry(customer).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Password berhasil diperbarui!";
                return RedirectToAction("Profil");

            }
            else
            {
                ModelState.AddModelError("Password", "Password sekarang tidak cocok.");
            }

            if (Session["NIK"] == null)
            {
                return RedirectToAction("Login", "Customer");
            }

            return View("Profil", customer);

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
