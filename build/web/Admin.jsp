<%@page import="java.sql.ResultSet"%>
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
	<title>STOP N' SHOP</title>
	<link rel="stylesheet" type="text/css" href="Css/Admin.css">
</head>
<body>
   <div class="Top">
       <button id="mylogo">STOP N' SHOP</button>
        <ul>
          <li><a href="Greatdeal.jsp">Home</a></li>
          <li><a href="Login.jsp">Login</a></li>
          <li><a href="Signup.jsp">Sign Up</a></li>
          <li><a class="active">ADMIN</a></li>
          <li><a href="Contact.jsp">Contact</a></li>
        </ul>
   </div>
   <div class="loginbox">
   	<img src="Css/Images/AdminLogo2.jpg" class="logo">
   	<br><br>
   	<h1>ADMIN LOGIN</h1>
    <br>
    <form action="">
        <br>
   		<p>Username</p>
   		<input type="text" name="adminname" placeholder="@username" required="">
   		<p>Password</p>
   		<input type="password" name="adminpassword" placeholder="@password" required=""><br><br><br>
   	    <input type="submit" name="button" value="Login"><br><br>
   	</form>
    </div>
</body>
</html>

<%! String adminname,adminpassword; 
    PreparedStatement ps;
%>
<% 
   if(request.getParameter("button")!=null) 
   {
        adminname = request.getParameter("adminname");
        adminpassword = request.getParameter("adminpassword"); 
     

        try
        { 
          ps=SqlUtil.connectDB().prepareStatement("Select * from admin where adminname=? and adminpassword=?");
         ps.setString(1, adminname);
         ps.setString(2, adminpassword);
          
          
          ResultSet rs = ps.executeQuery(); 

          if(rs.next())
          {
              session.setAttribute("adminname",adminname);
              response.sendRedirect("AdminHome.jsp");
          }
          else
          {
%>
            <script src="Script/AlertScript.js"></script>
            <script>
                    Swal.fire({
                      type:"error",
                      title:"You are not ADMIN",
                      text:"Unauthorised Access",
                      showConfirmButton : false,
                      footer :'<a href="Login.jsp" style="color:white; text-shadow:0px 0px 0.5px white ; letter-spacing:2px; font-weight:normal ; padding:10px 20px; border-radius:2px;  background:#3085d6 ; text-decoration:none;">OKAY</a>'
                    });
            </script> 
 <%
          }
SqlUtil.close();
        }
        catch(Exception Ex)
        {
          System.out.print("Problem in Admin " + Ex);
        }
   }
%>