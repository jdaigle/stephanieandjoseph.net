<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ContentPlaceHolderID="javascript" runat="server">
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

            $(".button.moreGuests").click(function (e) {
                e.preventDefault();
                addNewGuests();
            });

            $(".button.fewerGuests").click(function (e) {
                e.preventDefault();
                removeGuests();
            });

            addNewGuests();
        });
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <form name="rsvp_form" method="post" style="width: 400px; text-align:left; margin: 0px auto;">
        <div id="guests">
        </div>
        <div style="margin-top:10px;">
            <a href="#" class="button moreGuests">Add One More Guest</a><br />
            <a href="#" class="button fewerGuests" style="display:none;">Remove A Guest</a>
        </div>
        <div style="text-align:right;">            
            <button type="submit" value="Submit" title="Click to RSVP">Submit</button>
        </div>
        <div class="example guest">
            <label>Guest Name</label>
            <input type="text" name="guest_name" />
            <label>
                <input type="checkbox" name="underage" />
                Under age 6
            </label>
        </div>
    </form>
</asp:Content>
