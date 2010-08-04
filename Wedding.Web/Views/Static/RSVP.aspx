<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ContentPlaceHolderID="javascript" runat="server">
    <script src="<%= Url.Content("~/Scripts/json2.js") %>" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var addNewGuests = function () {
                $(".example.guest").clone().removeClass("example").appendTo($("#guests"));
                if ($("#guests").find(".guest").length > 1)
                    $(".button.fewerGuests").show();
            };

            var removeGuests = function () {
                if ($("#guests").find(".guest").length == 1) {
                    $(".button.fewerGuests").hide();
                    return;
                }
                $("#guests").find(".guest").last().remove();
                if ($("#guests").find(".guest").length == 1)
                    $(".button.fewerGuests").hide();
            };

            var gatherGuests = function () {
                var guests = new Array();
                $("#guests").find(".guest").not(".example").each(function (index_g) {
                    var guest = new Object();
                    guest.name = $(this).find("[name=guest_name]").val();
                    guest.attending = $(this).find("[name=attending]").is(':checked');
                    guest.underage = $(this).find("[name=underage]").is(':checked');
                    guests.push(guest);
                });
                return guests;
            }

            $(".button.moreGuests").click(function (e) {
                e.preventDefault();
                addNewGuests();
            });

            $(".button.fewerGuests").click(function (e) {
                e.preventDefault();
                removeGuests();
            });

            $("#submit_button").click(function (e) {
                e.preventDefault();
                var form = $("form[name=rsvp_form]");
                $("#guest_data").val(JSON.stringify(gatherGuests()));
                form.submit();
            });

            addNewGuests();
        });
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Guest RSVP</h1>
    <p>
        Please indicate all guests that will be attending. If you were invited but cannot attend then please
        indicate that below as well. If you are bringing a child under the age of 6, please let us know
        so we can coordinate with the caterer.
    </p>
    <div style="width: 400px; text-align:left; margin: 0px auto;font-family:Tahoma, Verdana, san-serif;color: #333333;font-size:14px;">        
        <div id="guests">
        </div>
        <div style="margin-top:10px;">
            <a href="#" class="button moreGuests">Add One More Guest</a><br />
            <a href="#" class="button fewerGuests" style="display:none;">Remove A Guest</a>
        </div>
        <div style="text-align:right;">            
            <button id="submit_button" type="submit" value="Submit" title="Click to RSVP">Submit</button>
        </div>
        <div class="example guest" style="margin-bottom:10px;">
            <div>
                <label>Guest Name</label>
                <input type="text" name="guest_name" />
            </div>
            <div style="margin-left:20px;">
                <label>
                    <input type="checkbox" name="attending" checked />
                    Attending   
                </label>
                <label>
                    <input type="checkbox" name="underage" />
                    Under age 6
                </label>
            </div>
        </div>
    </div>        
    <form method="post" name="rsvp_form" action="<%= Url.Action("MakeReservation", "Reservations") %>">
        <input type="hidden" id="guest_data" name="guests" />
    </form>
</asp:Content>
