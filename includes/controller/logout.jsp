<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%!    Connection conn;
    ArrayList data;

    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
    }%>
<%
    try {
        Context initCtx = new InitialContext();
        Context conEnv = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) conEnv.lookup("jdbc/nicogame");
        Connection conn = ds.getConnection();
        CallableStatement cs = conn.prepareCall("{?=call webscript_dealnodeal(?,?,?,?,?,?,?)}");
        cs.registerOutParameter(1, java.sql.Types.VARCHAR);
        cs.setString(2, checknull((String) request.getRemoteAddr()));
        cs.setString(3, session.getId());
        cs.setString(4, checknull((String)session.getAttribute("sub_id")));
        cs.setString(5, checknullzero(request.getParameter("option")));
        cs.setString(6, checknullzero(request.getParameter("value")));
        cs.setString(7, checknullzero(request.getParameter("gameId")));
        cs.setString(8, checknullzero(request.getParameter("boxused")));
        cs.execute();
        session.setAttribute("sub_id", "0");
        out.print(cs.getString(1).toString());
    } catch (Exception e) {
        out.println("{\"success\": \"false\", \"error\":\"" + e + "\"}");
    }
%>
