<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Kitap Kira</title>
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	<link href="assets/css/font-awesome.css" rel="stylesheet" />
 	


</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container">
		<a class="navbar-brand" href="Anasayfa.jsp">Kütüphane</a>
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
		      <a class="btn btn-outline-danger my-2 my-sm-0" href="index.jsp" role="button">Güvenli Çıkış</a>
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
		<%String id=request.getParameter("id"); 
		ResultSet Rs=Db.KitapSec(id);
		while(Rs.next()){
		%>
		
        <div class="row">
            <div class="col-md-5 col-sm-12 col-xs-12">
                <div class="product-image">
                <img src="pictures/<%=Rs.getString("resim")%>" class="img-responsive" width="400px;"/>
               </div>
            </div>

            <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                <h2><%=Rs.getString("ad")%></h2>
                <h4><%=Rs.getString("yazar")%></h4>
                <hr />
                <h4>Kategori: <%=Rs.getString("kategoriadi")%></h4>
                <h4>Sayfasayısı: <%=Rs.getString("sayfa_sayisi")%></h4>
                
                <hr />
       
                <div class="row">
                    <%int adet=Integer.valueOf(Rs.getString("adet"));
                    if(adet>0){%>
                    
                    <div class="col-sm-12 col-md-6 col-lg-6">
                        <p class=" btn-success btn-lg">Stokda <%=Rs.getString("adet")%> adet</p>
                    </div>
                    <%}else{ %>
                     <div class="col-sm-12 col-md-6 col-lg-6">
                        <p class=" btn-danger btn-lg">Stokta yok</p>
                    </div>
                    <%} %>
                </div>
             
		<%} %>  
            </div>
        </div>
    </div>
   


</body>
</html>