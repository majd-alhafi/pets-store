<%@ page import="java.util.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="classes.*" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Product Page - Admin HTML Template</title>
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Roboto:400,700"
    />
    <!-- https://fonts.google.com/specimen/Roboto -->
    <link rel="stylesheet" href="css/fontawesome.min.css" />
    <!-- https://fontawesome.com/ -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <!-- https://getbootstrap.com/ -->
    <link rel="stylesheet" href="css/templatemo-style.css">
    <!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
  </head>
 <%
		String query = new String ("Select * from pet ORDER BY price DESC");
		ArrayList<Pet> pets = new ArrayList<Pet>();
		try {
		// set the driver
		Class.forName("com.mysql.jdbc.Driver");
		//make connection
		Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/petsstore","root","");
		// create a statement
		Statement stmt = dbConnect.createStatement();
		// make a query	
		ResultSet rs = stmt.executeQuery(query);
		//ResultSet rs2 = stmt.executeQuery(query2);
		if(rs.next()) {
		do {
			// Pet Info
			int id = (int)rs.getInt("id");
			String name = (String)rs.getString("name");
			String type = (String)rs.getString("type");
			float age= (float)rs.getFloat("age");
			float price= (float)rs.getFloat("price");
				
		Pet pet = new Pet(id,name,"",type,age,price,"","");
				pets.add(pet);
				} while (rs.next());
			stmt.close();
			dbConnect.close();
		  }//end of else
		//session.setAttribute("Pets", pets);
		} catch (Exception e) {
		out.println(e.getMessage());
		}
		 //}
	%>
  <body id="reportsPage">
    <nav class="navbar navbar-expand-xl">
      <div class="container h-100">
        <a class="navbar-brand" href="index.html">
          <h1 class="tm-site-title mb-0">Product Admin</h1>
        </a>
        <button
          class="navbar-toggler ml-auto mr-0"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <i class="fas fa-bars tm-nav-icon"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mx-auto h-100">
            <li class="nav-item">
              <a class="nav-link" href="index.html">
                <i class="fas fa-tachometer-alt"></i> Dashboard
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdown"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false">
                <i class="far fa-file-alt"></i>
                <span> Reports <i class="fas fa-angle-down"></i> </span>
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Daily Report</a>
                <a class="dropdown-item" href="#">Weekly Report</a>
                <a class="dropdown-item" href="#">Yearly Report</a>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="products.jsp">
                <i class="fas fa-shopping-cart"></i> Products
              </a>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="accounts.html">
                <i class="far fa-user"></i> Accounts
              </a>
            </li>
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdown"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false">
                <i class="fas fa-cog"></i>
                <span> Settings <i class="fas fa-angle-down"></i> </span>
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Profile</a>
                <a class="dropdown-item" href="#">Billing</a>
                <a class="dropdown-item" href="#">Customize</a>
              </div>
            </li>
          </ul>
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link d-block" href="login.jsp">
                Admin, <b>Logout</b>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="container mt-5">
      <div class="row tm-content-row">
        <div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
          <div class="tm-bg-primary-dark tm-block tm-block-products">
            <div class="tm-product-table-container">
              <table class="table table-hover tm-table-small tm-product-table">
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">PET NAME</th>
                    <th scope="col">PRICE</th>
                    <th scope="col">AGE</th>
                    <th scope="col">CATEGORY</th>
                    <th scope="col">&nbsp;</th>
                  </tr>
                </thead>
                <tbody>
                <%
					for (Pet p : pets){
						int id = p.getID();
						out.print("<tr>");
						out.print("<th scope='row'><input type='checkbox' /></th>");
						out.print("<td class='tm-product-name'> <a  style='color:white;' href='edit-product.jsp?id="+id+"'>" + p.getName() + "</a> </td>");
						out.print("<td>"+p.getPrice()+"</td>");
						out.print("<td>"+p.getAge()+"</td>");
						out.print("<td>"+p.getType()+"</td>");
						out.print("<td>");
						out.print("<a href='../DeleteServlet?id=" + id + "'" + "class='tm-product-delete-link'>");
						out.print("<i class='far fa-trash-alt tm-product-delete-icon'></i>");
						out.print("</a>");
						out.print("</td>");
						out.print("</tr>");
					}
				%>
                  
                </tbody>
              </table>
            </div>
            <!-- table container -->
            <a
              href="add-product.html"
              class="btn btn-primary btn-block text-uppercase mb-3">Add new product</a>
          </div>
        </div>
      </div>
    </div>
    <footer class="tm-footer row tm-mt-small">
      <div class="col-12 font-weight-light">
        <p class="text-center text-white mb-0 px-4 small">
          Copyright &copy; <b>2018</b> All rights reserved. 
          
          Design: <a rel="nofollow noopener" href="https://templatemo.com" class="tm-footer-link">Template Mo</a>
        </p>
      </div>
    </footer>

    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
    
  </body>
</html>