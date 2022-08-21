
<%@page import="java.sql.ResultSet"%>
<%@page import="util.SqlUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String username,productid,model,mode,total; int result =0,price = 0,quantity = 0,totalprice = 0,count = 0;
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
      System.out.printf("Problem in Buy Now " + Ex);
   }
%>

<% 
        if(request.getParameter("productid")!=null)
        {
            productid = request.getParameter("productid");
           
            try
            { 
                ps=SqlUtil.connectDB().prepareStatement("insert into cart values(?,?,1)");
                ps.setString(1,username);
                ps.setString(2,productid);
                result = ps.executeUpdate();
               
            }
            catch(Exception Ex)
            {
                System.out.printf("Problem in Buy Now Insertion " + Ex);
            }
        }
        
        try
        {
            if(request.getParameter("productid")!=null)
            {
                ps1=SqlUtil.connectDB().prepareStatement("select * from cart natural join product where username=? and productid=?");
                ps1.setString(1, username);
                ps1.setString(2,productid);
                ResultSet ks = ps1.executeQuery();
                        //SqlUtil.read("'"+username+"' '"+productid+"'");

                if(ks.next())
                {
                   price = ks.getInt("price");
                   quantity = ks.getInt("quantity");
                   totalprice = price*quantity;
                } 
            }
        }
        catch(Exception Ex)
        {
            System.out.printf("Problem in Buy Now " + Ex);
        }    
%>

<html>
<head>
	<title>STOP N' SHOP</title>
	<link rel="stylesheet" type="text/css" href="Css/BuyNow.css">
</head>
<body>

<%    
    try
    {
        ps2=SqlUtil.connectDB().prepareStatement("select * from cart where username=?");
        ps2.setString(1,username);
         ResultSet rs = ps2.executeQuery();
         
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
        <li><a href="Profile.jsp">Profile</a></li>
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
        
<%                  
     if(request.getParameter("productid")!=null)
     {   
%> 
    <div class="container"> 
         <div class="loginbox">
            <img src="Css/Images/PaymentIcon.ico" class="logo">
            <br><br>
                 <h1>Payment</h1>
                 <form action="BuyNowPayment.jsp?">
                     <p>USER NAME : </p>
                     <label><%=username%></label>
                     <input type="text" name="productid" value="<%=productid%>">
                     <p>TOTAL PRICE : </p>
                     <label><%=totalprice%></label>
                     <p>PAYMENT MODE : </p>
                     <input type="radio" name="mode" required="" value="COD"><label id="mode"> COD</label><br>
                     <input type="radio" name="mode" value="Debit Card"><label id="mode"> Debit Card</label><br>
                     <input type="radio" name="mode" value="EMI"><label id="mode"> EMI</label><br><br>
                     <input type="submit" value="Submit" name="button">
                 </form>
          </div>
    </div>   
<%
     }
     else
     {
        totalprice = Integer.parseInt(request.getParameter("totalprice"));                 
%>
        <div class="container"> 
                <div class="loginbox">
                   <img src="Css/Images/PaymentIcon.ico" class="logo">
                   <br><br>
                        <h1>Payment</h1>
                        <form action="BuyAllitems.jsp?">
                            <p>USER NAME : </p>
                            <label><%=username%></label>
                            <input type="text" name="totalprice" value="<%=totalprice%>">
                            <p>TOTAL PRICE : </p>
                            <label><%=totalprice%></label>
                            <p>PAYMENT MODE : </p>
                            <input type="radio" name="mode" required="" value="COD"><label id="mode"> COD</label><br>
                            <input type="radio" name="mode" value="Debit Card"><label id="mode"> Debit Card</label><br>
                            <input type="radio" name="mode" value="EMI"><label id="mode"> EMI</label><br><br>
                            <input type="submit" value="Submit" name="button">
                        </form>
                 </div>
           </div>   
<%
     }
%>
</body>
</html>
