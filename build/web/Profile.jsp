<%@page import="java.sql.ResultSet"%>
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>

<%! String username,mobile,gender,email,city; int count = 0; 
PreparedStatement ps,ps1;%>

<% 
    try
    {
        username = (String)session.getAttribute("username");
  
        if(username==null)
        {
             out.println("<script> alert('Please Login to Continue'); document.location.href='Greatdeal.jsp';</script>"); 
        }
   
         ps1=SqlUtil.connectDB().prepareStatement("select * from profile where username=?");
         ps1.setString(1, username);
         ResultSet rs =ps1.executeQuery();
         
        if(rs.next())
        {
            username=rs.getString("username");
            mobile = rs.getString("mobile");
            email = rs.getString("email");
            gender = rs.getString("gender");
            city = rs.getString("city");
        }
    }
    catch(Exception Ex)
    {
        System.out.printf("Problem in Profile " + Ex);
    }
%>

<html>
<head>
	<title>STOP N' SHOP</title>
	<link rel="stylesheet" type="text/css" href="Css/Profile.css">
</head>
<body>

<%    
    try
    {
          ps=SqlUtil.connectDB().prepareStatement("select * from cart where username=?");
         ps.setString(1, username);
         ResultSet rs = ps.executeQuery();
         
         count = 0;
         while(rs.next())
         {
             count++;
         }
         SqlUtil.close();
    }
    catch(Exception Ex)
    {
        System.out.print("Error in Cart Items" + Ex);
    }
%>
    
    <div class="header"> 
      <span>STOP N' SHOP</span>
      <form action="Product.jsp">
		<input required="" type="text" placeholder="Search for any products, brands and more" name="search" size="60">
                <button id="searchbutton" type="submit"><img src="Css/Images/SearchIcon.ico">Search</button>
      </form>
      <ul>
        <li><a href="Home.jsp" >Home</a></li> 
        <li><a id="selected">Profile</a></li>
        <li><a href="Cart.jsp">Cart<button id="cart"><%=count%></button></a></li>
        <li><a href="Logout.jsp" >Logout</a></li>
      </ul>
    </div>
    
    <div class="search">
      <ul class="main">
          <li><a href="Home.jsp">Home</a></li>
          <li id="abc"><a>Category</a>
          <ul class="sub">
                  <li>
                    <a>
                      <form action="Product.jsp">
                      <button name="category" value="mobile">Mobile</button>
                      </form>
                    </a>
                  </li>
                  <li>
                    <a>
                      <form action="Product.jsp">
                      <button name="category" value="laptops">Laptops</button>
                      </form>
                    </a>
                  </li>
                  <li>
                    <a>
                      <form action="Product.jsp">
                      <button name="category" value="menswear">Mens Wear</button>
                      </form>
                    </a>
                  </li>
                  <li>
                    <a>
                      <form action="Product.jsp">
                      <button name="category" value="shoes">Shoes</button>
                      </form>
                    </a>
                  </li>
                  <li>
                    <a>
                      <form action="Product.jsp">
                      <button name="category" value="game">Game</button>
                      </form>
                    </a>
                  </li>
        </ul>
        <li><a href="Cart.jsp">Cart</a></li>
        <li><a href="Orders.jsp">My Orders</a></li>
        </ul>
    </div>   
    
   <div class="container"> 
        <div class="loginbox">
           <img src="Css/Images/profile.png" class="logo">
           <br><br>
           <h1>PROFILE</h1>
           <p>Username :</p>
           <span><%= username %></span>
            <p>Email :</p>
           <span><%= email %></span>
           <p>Gender :</p>
           <span><%= gender %></span>
           <p>City :</p>
           <span><%= city %></span>
           <p>Mobile No. :</p>
           <span><%= mobile%></span>
         </div>
   </div>
</body>
</html>