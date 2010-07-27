using System;
namespace Wedding.Web.Models {
    public class Guest {
        public string Name { get; set; }
        public bool Attending { get; set; }
        public bool Underage { get; set; }
        public DateTime ReservationDate { get; set; }
    }
}