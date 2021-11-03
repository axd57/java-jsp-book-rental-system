<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Kitap Kira</title>
 
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
 <link href="assets/css/font-awesome.css" rel="stylesheet" />
 
</head>
<body>
<%if(session.getAttribute("AKId")==null)
    	response.sendRedirect("index.jsp"); 
%>



<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container">
		<a class="navbar-brand" href="Anasayfa.jsp">Kitap Kira</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      <li class="nav-item active">
		        <a class="nav-link" href="Anasayfa.jsp">AnaSayfa</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="Kategoriler.jsp?alan=hepsi">Kategoriler</a>
		      </li>
		    </ul>
		    <form class="form-inline my-2 my-lg-0">
		      <a class="nav-link text-white" href="#">Hoş geldiniz, <%=session.getAttribute("AKAd")%></a>
		      <a class="btn btn-outline-danger my-2 my-sm-0" href="VeriTabaniSorgu.jsp?islem=cikis" role="button">Güvenli Çıkış</a>
		    </form>
		    <a class="btn btn-outline-primary my-2 my-sm-0" href="SifreGuncelle.jsp" role="button" style="margin-left: 15px;"><i class="fa fa-gears"></i></a>
		  
		  </div>
		</div>
	</nav>
	
	
	<section class="jumbotron text-center">
        <div class="container">
            <jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
            <%int[] Bilgiler=Db.A_Bilgi(); %>
            <h1 class="jumbotron-heading">Kitap Kira</h1>
            <p class="lead text-muted mb-0"><%=Bilgiler[2] %> Kategoride <%=Bilgiler[0] %> Kitap ve <%=Bilgiler[1] %> Üye bulunmaktadır.</p>
        </div>
    </section>
    
    <div class="container">
    <%ResultSet Rs=Db.A_Veri_Getir("Kitaplar", "Hepsi");
	while(Rs.next()){%>
	    <a href="Kitap.jsp?id=<%=Rs.getString("id")%>" style="color: inherit;">
			<div class="card" style="width: 18rem;  margin:0 5px 10px 5px; display: inline-block;">
				<img src="pictures/<%=Rs.getString("resim")%>" class="card-img-top" alt="..." height="350px;">
				<div class="card-body">
					<h5 class="card-title"><%=Rs.getString("ad")%></h5>
					<p class="card-text">Yazar: <%=Rs.getString("yazar")%></p>
					<p class="card-text">Kategori: <%=Rs.getString("kategoriadi")%></p>
				</div>
			</div>
		</a>
    <%} %>
    </div>





</body>
</html>