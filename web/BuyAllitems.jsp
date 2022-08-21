

<%@page import="java.sql.ResultSet"%>
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String username,productid,mode,date,time; int result,quantity=0,price = 0,totalprice=0,counter=0, count =0; 
PreparedStatement ps,ps1,ps2,ps3,ps4;%>

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
      System.out.printf("Problem in Buy ALL Items " + Ex);
   }
%>

<!DOCTYPE html>

<%
   
        try
        { 
            if(request.getParameter("totalprice")!=null)
            {
               
                mode = request.getParameter("mode"); 
 
                ps=SqlUtil.connectDB().prepareStatement("select * from cart where username=?");
                ps.setString(1,username);
                ResultSet rs = ps.executeQuery();

                count = 0;
                while(rs.next())
                {
                    count++;
                }
 
                ps1=SqlUtil.connectDB().prepareStatement("select sysdate ,to_char(sysdate, 'hh24:mi:ss')from dual");
                ResultSet gn = ps1.executeQuery();

                if(gn.next())
                {
                    date = gn.getString("curdate()");
                    time = gn.getString("curtime()");
                }
                
                for(counter =0; counter<count; counter++)
                {
                    ps2=SqlUtil.connectDB().prepareStatement("select * from cart natural join product where username=?");
                    ps2.setString(1, username);
                    ResultSet ll = ps2.executeQuery();

                    if(ll.next())
                    {
                        quantity = ll.getInt("quantity");
                        price = ll.getInt("price");
                        totalprice = price*quantity;
                        productid = ll.getString("productid");

                        ps3=SqlUtil.connectDB().prepareStatement("insert into orders values(?,?,?,?,?,?,?)");
                        ps3.setString(1,username);
                        ps3.setString(2,productid);
                        ps3.setInt(3,quantity);
                        ps3.setInt(4,totalprice);
                        ps3.setString(5,mode);
                        ps3.setString(6,date);
                        ps3.setString(7,time);

                                                
                        
                        result = ps3.executeUpdate();
                                //SqlUtil.insert("insert into orders values('"+username+"','"+productid+"',"+quantity+","+totalprice+",'"+mode+"','"+date+"','"+time+"');");   
                         ps4=SqlUtil.connectDB().prepareStatement("delete from cart where username=? and productid=?");
                         ps4.setString(1, username);
                         ps4.setString(2, productid);
                         result = ps4.executeUpdate();
                                //SqlUtil.delete("delete from cart where username='"+username+"' and productid='"+productid+"';");
                    }
                }
                
                if(result == 1)
                {
                    out.println("<script> alert('Thanks for Buying'); document.location.href='Home.jsp';</script>"); 
                   //SqlUtil.close();
                }
            }
            SqlUtil.close();
        }
        catch(Exception Ex)
        {
            System.out.print("Problem in Buy All Items" + Ex);
        }   
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STOP N' SHOP</title>
    </head>
    <body>
        <h1>Server Down!! </h1>
    </body>
</html>

