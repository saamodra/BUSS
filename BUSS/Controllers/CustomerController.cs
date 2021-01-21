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
                        Session["Role"] = "3";
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
            if (Session["Role"].ToString() == "3")
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
            return View();
        }

        public ActionResult Pesanan()
        {
            if(Session["NIK"] != null)
            {
                string nik = Session["NIK"].ToString();
                var pesanan = db.Transaksis.Where(k => k.ID_Customer == nik).ToList();
                return View(pesanan);
            } else
            {
                return RedirectToAction("Login", "Customer");
            }
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
