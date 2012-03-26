<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.util.*, java.text.*" %>
<%@ include file="includes/controller/variables.jsp" %>
<%!
    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
    }

    public Integer mathRandom() {
        return ((int) (Math.random() * 750));
    }
    public DecimalFormat df = new DecimalFormat("#,##.##");
%>
<!DOCTYPE HTML>
<html lang="en">
    <head>
        <title><%= siteTitle %></title>
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta content="text/html; charset=utf-8" http-equiv=Content-Type>
        <link rel="stylesheet" type="text/css" href="assets/css/css.css" />
        <script type="text/javascript" src="assets/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="assets/js/app.js?v=<%= Math.round(Math.random() * 9999999) %>"></script>
<% 
    if ( 
         checknullzero((String) session.getAttribute("sub_id")).equals("0") ||
         checknullzero((String) session.getAttribute("sub_id")).equals("1") ||
         checknullzero((String) session.getAttribute("sub_id")) == null
       )
    {
    %>
    <%@include file="includes/view/login.jsp" %>
<%  }else{ %>
    <%@include file="includes/view/game.jsp" %>
<%  }
/*
 * 
 * head tag will end in other view pages
 * 
 */
%>

