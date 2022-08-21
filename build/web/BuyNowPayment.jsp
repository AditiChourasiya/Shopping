
<%@page import="java.sql.ResultSet"%>
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String username,productid,mode,date,time; int result = 0,price = 0,quantity=0,totalprice=0;
PreparedStatement ps,ps1,ps2,ps3;%>

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
      System.out.printf("Problem in BuyNow Payment " + Ex);
   }
%>

<%
        try
        { 
            if(request.getParameter("productid")!=null)
            {
                productid = request.getParameter("productid");
                mode = request.getParameter("mode"); 

                ps=SqlUtil.connectDB().prepareStatement("select sysdate ,to_char(sysdate, 'hh24:mi:ss') from dual");
                ResultSet rs = ps.executeQuery();

                if(rs.next())
                {
                    date = rs.getString(1);
                    time = rs.getString(2);
                }
                ps1=SqlUtil.connectDB().prepareStatement("select * from cart natural join product where username=? and productid=?");
                ps1.setString(1, username);
                ps1.setString(2,productid);
                ResultSet ss = ps1.executeQuery();

                if(ss.next())
                {
                    quantity = Integer.parseInt(ss.getString("quantity"));
                    price = ss.getInt("price");
                    totalprice = price*quantity;

                    ps3=SqlUtil.connectDB().prepareStatement("insert into orders values(?,?,?,?,?,?,?)");
                     ps3.setString(1, username);
                      ps3.setString(2,productid);
                       ps3.setInt(3, quantity);
                        ps3.setInt(4, totalprice);
                         ps3.setString(5, mode);
                          ps3.setString(6, date);
                       ps3.setString(7, time);
                    result = ps3.executeUpdate();
                            //SqlUtil.insert("insert into orders values('"+username+"','"+productid+"',"+quantity+","+totalprice+",'"+mode+"','"+date+"','"+time+"');"); 
                    ps2=SqlUtil.connectDB().prepareStatement("delete from cart where username=? and productid=?");
                    ps2.setString(1, username);
                    ps2.setString(2,productid);
                    result = ps2.executeUpdate();
                            //SqlUtil.delete("delete from cart where username='"+username+"' and productid='"+productid+"';");

                }
                    
                if(result == 1)
                {
                    out.println("<script> alert('Thanks for Buying'); document.location.href='Home.jsp';</script>"); 
                }
            }
            SqlUtil.close();
        }
        catch(Exception Ex)
        {
            System.out.print("Problem in BuyNow Payment Single Buy" + Ex);
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
