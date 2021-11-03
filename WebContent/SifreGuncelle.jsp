<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Yeni Şifre</title>
 
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
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
	
    <div class="container">
   		<h2 align="center" style="margin-top: 15px;"> Şifre yenile </h3>
   		
   		<form action="VeriTabaniSorgu.jsp">
   		 <input type="hidden" name="islem" value="KSifreGuncelle">
		  <div class="form-group">
		    <label for="exampleInputEmail1">Şuanki şifre</label>
		    <input type="password" class="form-control" name="kssifre" aria-describedby="emailHelp" placeholder="Aktfi şifre">
		  <div class="form-group">
		    <label for="exampleInputPassword1">Yeni şifre</label>
		    <input type="password" class="form-control" name="kysifre" placeholder="Yeni şifre">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputPassword1">Yeni şifre tekrar</label>
		    <input type="password" class="form-control" name="kysifret" placeholder="Yeni şifre tekrar">
		  </div>
		  <button type="submit" class="btn btn-primary">Güncelle</button>
		</form>
    </div>
		<%if(session.getAttribute("SGuncelle")!=null){
          	if(session.getAttribute("SGuncelle")=="false"){%>
            	<div class="alert alert-danger alert-dismissible fade show" role="alert">
                	Alanlar hatalı yada uyuşmuyor
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
 				<%}
		session.setAttribute("SGuncelle", null);
        }%>

</body>
</html>