<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <div style="text-align:left">        
        <% Wedding.Web.Models.Guest[] guests = ViewData["guests"] as Wedding.Web.Models.Guest[]; %>
        <h3 style="margin-top:0px;">Guest Count</h3>
        <p>
            <b><%= guests.Count(x => x.Attending) %></b> attending and <b><%= guests.Count(x => !x.Attending) %></b> declined.<br />
            <b><%= guests.Count(x => !x.Underage) %></b> adults and <b><%= guests.Count(x => x.Underage) %></b> children under 6.
        </p>
        <h3>Guest List</h3>
        <% foreach (var guest in guests) { %>        
        <div style="padding: 5px;">
            <b><%= guest.Name %></b> confirmed on <%= guest.ReservationDate.ToShortDateString() %> that he/she <b><%= guest.Attending ? "is" : "is not" %> planning to attend</b> and <%= guest.Underage ? "is" : "is not" %> under age 6.
        </div>
        <% } %>
    </div>
</asp:Content>
