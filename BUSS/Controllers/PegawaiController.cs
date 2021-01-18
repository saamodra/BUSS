using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using BUSS.Models;

namespace BUSS.Controllers
{
    public class PegawaiController : Controller
    {
        private BUSSEntities db = new BUSSEntities();

        // GET: Pegawai
        public ActionResult Index()
        {
            return View(db.Pegawais.Where(s => s.Status == 1).ToList());
        }

        // GET: Pegawai/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pegawai pegawai = db.Pegawais.Find(id);
            if (pegawai == null)
            {
                return HttpNotFound();
            }
            return View(pegawai);
        }

        // GET: Pegawai/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Pegawai/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Pegawai,Nama,Alamat,No_HP,Email,Password,Role,Status")] Pegawai pegawai)
        {
            if (db.Pegawais.Any(k => k.Email == pegawai.Email))
            {
                ModelState.AddModelError("Email", "Email sudah terdaftar.");
            }

            if (ModelState.IsValid)
            {
                pegawai.Password = BussModule.RandomString(8);
                pegawai.CreatedDate = DateTime.Now;
                pegawai.ModifiedDate = DateTime.Now;
                pegawai.Status = 1;
                db.Pegawais.Add(pegawai);
                db.SaveChanges();

                sendEmail(pegawai);

                TempData["SuccessMessage"] = "Data berhasil ditambah!";

                return RedirectToAction("Index");
            }

            return View(pegawai);
        }

        public void sendEmail(Pegawai pegawai)
        {
            var message = "<h2>Selamat datang, {0}</h2><p>Terima kasih telah bergabung dengan BUSS. Berikut data awal anda : </p><br><table> <tr> <td>Email</td> <td>:</td> <td><b>{1}</b></td> </tr> <tr> <td>Password</td> <td>:</td> <td><b>{2}</b></td> </tr></table><br><h4><i>Segera ganti password anda demi keamanan!</i></h4>";

            var senderEmail = new MailAddress("travelbussofficial@gmail.com", "Travel BUSS Official");
            var receiverEmail = new MailAddress(pegawai.Email, pegawai.Nama);
            var password = "projectprg4";
            var sub = "Registrasi Pegawai BUSS Berhasil";
            var body = string.Format(message, pegawai.Nama, pegawai.Email, pegawai.Password);
            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(senderEmail.Address, password)
            };
            using (var mess = new MailMessage(senderEmail, receiverEmail)
            {
                Subject = sub,
                IsBodyHtml = true,
                Body = body
            })
            {
                smtp.Send(mess);
            }
        }

        // GET: Pegawai/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pegawai pegawai = db.Pegawais.Find(id);
            if (pegawai == null)
            {
                return HttpNotFound();
            }
            return View(pegawai);
        }

        // POST: Pegawai/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Pegawai,Nama,Alamat,No_HP,Email,Password,Role,Status")] Pegawai pegawai)
        {
            if (db.Pegawais.Any(k => k.Email == pegawai.Email))
            {
                ModelState.AddModelError("Email", "Email sudah terdaftar.");
            }

            if (ModelState.IsValid)
            {
                pegawai.Status = 1;
                pegawai.ModifiedDate = DateTime.Now;
                db.Entry(pegawai).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Data berhasil diubah!";
                return RedirectToAction("Index");
            }
            return View(pegawai);
        }

        // POST: Pegawai/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pegawai pegawai = db.Pegawais.Find(id);
            pegawai.Status = 0;
            db.SaveChanges();
            TempData["SuccessMessage"] = "Data berhasil dihapus!";
            return RedirectToAction("Index");
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string email, string password)
        {
            if (ModelState.IsValid)
            {
                using (BUSSEntities db = new BUSSEntities())
                {
                    var obj = db.Pegawais.Where(a => a.Email.Equals(email) && a.Password.Equals(password)).FirstOrDefault();
                    if (obj != null)
                    {
                        TempData["SuccessMessage"] = "Login berhasil!";
                        Session["ID_Pegawai"] = obj.ID_Pegawai;
                        Session["Name"] = obj.Nama.ToString();
                        Session["Email"] = obj.Email.ToString();
                        Session["Role"] = obj.Role.ToString();
                        return RedirectToAction("UserLogin");
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "Username dan Password tidak cocok!";
                    }
                }
            }

            return View();
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Abandon(); // it will clear the session at the end of request
            return RedirectToAction("Index", "Home");
        }

        public ActionResult UserLogin()
        {
            if (Session["Role"].ToString() == "1")
            {
                return RedirectToAction("Pegawai", "Dashboard");
            }
            else if (Session["Role"].ToString() == "2")
            {
                return RedirectToAction("Tourleader", "Dashboard");
            }
            else if (Session["Role"].ToString() == "3")
            {
                return RedirectToAction("Manager", "Dashboard");
            }
            else
            {
                return RedirectToAction("Login");
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
