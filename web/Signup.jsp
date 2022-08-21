<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
	<title>STOP N' SHOP</title>
	<link rel="stylesheet" type="text/css" href="Css/Signup.css">
</head>
<body>
  <div class="Top">
      <button id="mylogoi">STOP N' SHOP</button>
        <ul>
          <li><a href="Greatdeal.jsp">Home</a></li>
          <li><a href="Login.jsp">Login</a></li>
          <li><a class="active">Sign Up</a></li>
          <li><a href="Admin.jsp">ADMIN</a></li>
          <li><a href="Contact.jsp">Contact</a></li>
        </ul>
   </div>
   <div class="loginbox">
   	<img src="Css/Images/SignUpLogo1.png" class="logo">
   	<br><br>
   	<h1>Sign Up</h1>
   	<form >
        <br><br>
   		<p>Username</p>
   		<input type="text" name="username" placeholder="@username" required="">
   		<p>Password</p>
   		<input type="password" name="userpassword" placeholder="@password" required="">
        <p>Mobile Number</p>
        <input type="number" name="usermobile" placeholder="@mobilenumber" required="" min="0" max="9999999999">
        <p>Email ID</p>
        <input type="Email" name="useremail" placeholder="@email-id" required="">
        <span>Gender :    </span>
        <input type="radio" value="Male" name="gender" required=""><span> Male&nbsp&nbsp</span>
        <input type="radio" value="Female" name="gender" required=""><span> Female </span><br>
        <span>City &nbsp: </span>
   	<select name="usercity" required="">
        <option value="Indore" selected="">Indore</option>
        <option value="Mhow">Mhow</option>
        <option value="Gwalior">Gwalior</option>
        <option value="Ratlam">Ratlam</option>
        </select>
        <input type="checkbox" name="" required=""><span id="accept">I accept the Terms & Conditions.</span><br>
        <input type="submit" name="button" value="Sign Up"><br><br>
   	</form>
    </div>

<%! String username,mobile,email,city,gender,password; 
    int result1,result2;   
    PreparedStatement ps,ps1;
%>

<%  username = request.getParameter("username");
    password = request.getParameter("userpassword");
    mobile = request.getParameter("usermobile");
    email = request.getParameter("useremail");
    gender = request.getParameter("gender");
    city = request.getParameter("usercity");
    
    try
    { 
      if(request.getParameter("button")!=null) 
      {       
            System.out.println("debugging it");
     
        ps=SqlUtil.connectDB().prepareStatement("insert into profile values(?,?,?,?,?)");
        
        ps.setString(1,username);
        ps.setString(2,mobile);
        ps.setString(3,email);
        ps.setString(4,gender);
        ps.setString(5,city);
        result1 = ps.executeUpdate(); 
       
        ps1=SqlUtil.connectDB().prepareStatement("insert into login values(?,?)");
         System.out.println("values "+username+" "+password+" "+mobile+" "+email+" "+gender+" "+city);
        ps1.setString(1,username);
        ps1.setString(2,password);
        result2= ps1.executeUpdate();
        
        if(result1 == 1 && result2 == 1)
        {
%>
            <script src="Script/AlertScript.js"></script>
            <script>
                    Swal.fire({
                      title:"Successfully Signed Up",
                      text:"Continue shopping",
                      showConfirmButton : false,
                      type:'info',
                      footer :'<a href="Login.jsp" style="color:white; text-shadow:0px 0px 0.5px white ; letter-spacing:2px; font-weight:normal ; padding:10px 20px; border-radius:2px;  background:#3085d6 ; text-decoration:none;">OKAY</a>'
                    });
            </script> 
 <%
        }
        else
        { 
               System.out.println("Error in insertion");
        }   
      }
SqlUtil.close();
    }
    catch(Exception Ex)
    {
%>       
            <script src="Script/AlertScript.js"></script>
            <script>
                    Swal.fire({
                      type:"warning",
                      title:"Oops...",
                      text:"Username already exists",
                      showConfirmButton : false,
                      footer :'<a href="Signup.jsp" style="color:white; text-shadow:0px 0px 0.5px white ; letter-spacing:2px; font-weight:normal ; padding:10px 20px; border-radius:2px;  background:#3085d6 ; text-decoration:none;">OKAY</a>'
                    });
            </script>
<%
       System.out.printf("Problem in Signup " + Ex);
    }
%>

</body>
</html>