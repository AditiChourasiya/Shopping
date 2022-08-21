

<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%! String username,productid; int result;
PreparedStatement ps;%>
<% try
   {
      username = (String)session.getAttribute("username");
     
      if(username==null)
      {
         out.println("<script> alert('Please Login to Continue'); document.location.href='Greatdeal.jsp';</script>"); 
      }
   }
   catch(Exception Ex)
   {
      System.out.printf("Problem in Delete From Cart " + Ex);
   }
%>

<%
        try
        {
            
            
            productid=request.getParameter("productid");
            
            ps=SqlUtil.connectDB().prepareStatement("delete from cart where username=? and productid=?");
            ps.setString(1, username);
            ps.setString(2, productid);
            result =ps.executeUpdate();
            
            out.println("<script> alert('Deleted from Cart'); document.location.href='Cart.jsp';</script>");  
            SqlUtil.close();
        }
        catch(Exception Ex)
        {
             System.out.printf("Problem in Deleting " + Ex); 
        }
        
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STOP N' SHOP</title>
    </head>
    <body>
        <h1>Server Went Down!!</h1>
    </body>
</html>
