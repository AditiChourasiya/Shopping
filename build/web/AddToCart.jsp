
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String username,productid,category; int result;
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
      System.out.printf("Problem in Add To Cart " + Ex);
   }
%>

<%
        productid = request.getParameter("productid"); 
        category = request.getParameter("category"); 
       
        try
        { 
           
            
            if(request.getParameter("productid")!=null)
            {
                 ps=SqlUtil.connectDB().prepareStatement("insert into cart values(?,?,1)");
            ps.setString(1, username);
            ps.setString(2,productid);
            result=ps.executeUpdate();
               // result = SqlUtil.insert("insert into cart values('"+username+"','"+productid+"',1);");
            }

            if(result == 1)
            {
                out.println("<script> alert('Added to cart'); document.location.href='Product.jsp?category="+category+"';</script>");  
            }          
            SqlUtil.close();
        }
        catch(Exception Ex)
        {
              out.println("<script> alert('Already added to cart'); document.location.href='Product.jsp?category="+category+"';</script>"); 
        }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STOP N' SHOP</title>
    </head>
    <body>
        <h1>SERVER WENT DOWN!! Please Wait for a while......</h1>
    </body>
</html>
