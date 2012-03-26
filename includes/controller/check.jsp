<%-- 
    Document   : select
    Created on : Dec 30, 2011, 11:25:49 AM
    Author     : fatih
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="org.omg.CORBA.SystemException"%>
<%@page import="com.google.gson.*" %>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
    }
%>
<%
    try {
        Context initCtx = new InitialContext();
        Context conEnv = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) conEnv.lookup("jdbc/nicogame");
        Connection conn = ds.getConnection();
        CallableStatement cs = conn.prepareCall("{?=call webscript_dealnodeal_check(?,?,?,?,?,?)}");
        cs.registerOutParameter(1, java.sql.Types.VARCHAR);
        cs.setString(2, checknull((String) request.getRemoteAddr()));
        cs.setString(3, session.getId());
        cs.setString(4, checknull((String)session.getAttribute("sub_id")));
        cs.setString(5, "3");
        cs.setString(6, request.getParameter("tableid"));
        cs.setString(7, request.getParameter("tablevalue"));
        cs.execute();
        session.setAttribute("deposit", request.getParameter("tablevalue"));
        session.setAttribute("gameId", cs.getString(1));
        out.print(cs.getString(1).toString());
    } catch (Exception err) {
        out.println("Error occured on main: " + err);
    }
%>