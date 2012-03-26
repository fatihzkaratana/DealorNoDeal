<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.sql.*,java.text.*,javax.sql.*,java.util.*,javax.naming.*,oracle.jdbc.*" %>
<%!    
    Connection conn;
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
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/nicogame");
            conn = ds.getConnection();
            CallableStatement cs = conn.prepareCall("{?=call webscript_login(?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter(1, java.sql.Types.VARCHAR);
            cs.registerOutParameter(7, java.sql.Types.VARCHAR);
            cs.registerOutParameter(8, java.sql.Types.VARCHAR);
            cs.registerOutParameter(9, java.sql.Types.VARCHAR);
            cs.registerOutParameter(10, java.sql.Types.VARCHAR);
            cs.setString(2, "TR");
            cs.setString(3, checknull((String) request.getRemoteAddr()));
            cs.setString(4, checknullzero((String) session.getId()));
            cs.setString(5, checknullzero(request.getParameter("username")));
            cs.setString(6, checknullzero(request.getParameter("password")));
            cs.execute();

            if (!(checknullzero(cs.getString(7)).equals("0"))) {
                session.setAttribute("sub_id", checknullzero(cs.getString(7)));
                session.setAttribute("sub_nickname", checknullzero(cs.getString(9)));
                session.setAttribute("sub_avatar", checknullzero(cs.getString(10)));
                out.print("{\"success\": \"true\"}");
            } else {
                out.print("{\"success\": \"false\"}");
                //out.println("alert('Girdiğiniz bilgilerle ilgili herhangi bir kullanıcı bulunamamıştır. Lütfen tekrar deneyiniz.');");
            }
            cs.close();
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException eee) {
                }
                conn = null;
            }
        }
%>
