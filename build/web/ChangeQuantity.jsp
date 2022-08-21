
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String username,productid,quantity; int result;
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
      System.out.printf("Problem in Change Quantity " + Ex);
   }
%>

<%
        try
        {
            
            
            productid = request.getParameter("productid");
            quantity = request.getParameter("quantity");
            
              ps=SqlUtil.connectDB().prepareStatement("update cart set quantity=? where username=? and productid=?");
              ps.setString(1,quantity);
              ps.setString(2, username);
              ps.setString(3, productid);
            result = ps.executeUpdate();
                    //SqlUtil.update("'"+quantity+"' '"+username+"' '"+productid+"';");
            
            out.println("<script>document.location.href='Cart.jsp';</script>");  
            SqlUtil.close();
        }
        catch(Exception Ex)
        {
             System.out.printf("Problem in Deleting " + Ex); 
        }
        
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STOP N' SHOP</title>
    </head>
    <body>
        <h1>Server Went Down!!!</h1>
    </body>
</html>
