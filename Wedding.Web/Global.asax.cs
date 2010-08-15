using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.IO;
using System.Data.SQLite;

namespace Wedding.Web {
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication {
        public static void RegisterRoutes(RouteCollection routes) {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                string.Empty,
                "guestlist/{orderBy}",
                new { controller = "reservations", action = "list", orderBy = "name" }
                );

            routes.MapRoute(
                string.Empty,
                "reservations/{action}",
                new { controller = "reservations" }
                );

            routes.MapRoute(
                "Default", // Route name
                "{action}/{id}", // URL with parameters
                new { controller = "Static", action = "Welcome", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        public static string DatabaseFile;

        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);

            // Setup database and schema            
            DatabaseFile = HttpRuntime.AppDomainAppPath + "wedding.sqlite";
            if (!File.Exists(DatabaseFile))
                CreateDatabaseAndSchema();
        }

        private void CreateDatabaseAndSchema() {
            SQLiteConnection.CreateFile(DatabaseFile);
            using (var connection = new SQLiteConnection("Data Source=" + DatabaseFile + ";Version=3;")) {
                var command = connection.CreateCommand();
                command.CommandText = "CREATE TABLE reservations ( id varchar(35) not null, name varchar(100) not null, reservationdate datetime not null, attending bool not null, underage bool not null )";
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}