﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="Logout.aspx.cs" Inherits="Logout" %>

<asp:Content ID="headContent" ContentPlaceHolderID="HeadPlaceholder" runat="Server">
    <script>    
        $(function () {
            setTimeout(function () { fblogout(); }, 1000);
        });
</script>
</asp:Content>

<asp:Content ID="bodyContent" ContentPlaceHolderID="BodyPlaceholder" runat="Server">

</asp:Content>