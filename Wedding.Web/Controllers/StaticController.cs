using System.Web.Mvc;

namespace Wedding.Web.Controllers {
    public class StaticController : Controller {

        public ActionResult Welcome() {
            return View();
        }

        public ActionResult AboutUs() {
            return View();
        }

        public ActionResult WeddingParty() {
            return View();
        }

        public ActionResult GuestInfo() {
            return View();
        }

        public ActionResult RSVP() {
            return View();
        }
    }
}
