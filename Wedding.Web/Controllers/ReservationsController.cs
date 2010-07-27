using System.Web.Mvc;
using Newtonsoft.Json;
using Wedding.Web.Models;
using System.Data.SQLite;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Wedding.Web.Controllers {
    public class ReservationsController : Controller {

        [HttpPost]
        public ActionResult MakeReservation(string guests) {
            var guestArray = JsonConvert.DeserializeObject<Guest[]>(guests);

            using (var connection = new SQLiteConnection("Data Source=" + MvcApplication.DatabaseFile + ";Version=3;")) {
                foreach (var guest in guestArray) {
                    if (string.IsNullOrEmpty(guest.Name))
                        continue;
                    var command = connection.CreateCommand();
                    command.CommandText = BuildInsertStatement(guest);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }

            return RedirectToAction("ThankYou", "Static");
        }

        private string BuildInsertStatement(Guest guest) {
            return string.Format("INSERT INTO reservations VALUES ('{0}', '{1}', '{2}', '{3}', '{4}')",
                Guid.NewGuid().ToString(),
                guest.Name,
                DateTime.UtcNow.ToString(),
                guest.Attending.ToString(),
                guest.Underage.ToString());
        }

        public ActionResult List() {
            var guests = new Guest[0];
            using (var connection = new SQLiteConnection("Data Source=" + MvcApplication.DatabaseFile + ";Version=3;")) {
                var command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM reservations";
                connection.Open();
                using (var reader = command.ExecuteReader())
                    guests = HydrateGuests(reader);
                connection.Close();
            }
            ViewData["guests"] = guests.OrderBy(x => x.ReservationDate).OrderBy(x => x.Name).ToArray();
            return View();
        }

        private Guest[] HydrateGuests(SQLiteDataReader reader) {
            var guests = new List<Guest>();
            while (reader.Read()) {
                var guest = new Guest();
                guest.Name = reader.GetString(1);
                guest.ReservationDate = DateTime.Parse(reader.GetString(2));
                guest.Attending = bool.Parse(reader.GetString(3));
                guest.Underage = bool.Parse(reader.GetString(4));
                guests.Add(guest);
            }
            return guests.ToArray();
        }
    }
}
