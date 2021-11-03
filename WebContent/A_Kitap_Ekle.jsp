<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
    
    <title>Kitap Kira Admin Panel</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="assets/materialize/css/materialize.min.css" media="screen,projection" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="assets/js/Lightweight-Chart/cssCharts.css">


</head>
<body>
	<div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                 <a class="navbar-brand waves-effect waves-dark" href="A_Anasayfa.jsp"><strong>Kitap Kira</strong></a>

                <div id="sideNav" href=""><i class="material-icons dp48">toc</i></div>
            </div>

           <ul class="nav navbar-top-links navbar-right">
                <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b>Hoş geldiniz, <%=session.getAttribute("AYAd")%></b> <i class="material-icons right">arrow_drop_down</i></a></li>
            </ul>
        </nav>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
           <li>
                <a href="VeriTabaniSorgu.jsp?islem=acikis"><i class="fa fa-sign-out fa-fw"></i> Çıkış yap</a>
            </li>
        </ul>
       
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

                    <li>
                        <a class="active-menu waves-effect waves-dark" href="A_Anasayfa.jsp"><i class="fa fa-dashboard"></i> Gösterge Paneli</a>
                    </li>
                    <li>
                        <a href="A_Kitaplar.jsp" class="waves-effect waves-dark"><i class="fa fa-book"></i> Kitaplar</a>
                    </li>
                    <li>
                        <a href="A_Uyeler.jsp" class="waves-effect waves-dark"><i class="fa fa-user"></i> Üyeler</a>
                    </li>
                    <li>
                        <a href="A_Kategoriler.jsp" class="waves-effect waves-dark"><i class="fa fa-bars"></i> Kategoriler</a>
                    </li>

                    <li>
                        <a href="A_Kayitlar.jsp" class="waves-effect waves-dark"><i class="fa fa-check-circle"></i> Kayıtlar</a>
                    </li>
                    <li>
                        <a href="A_GecikenKayitlar.jsp" class="waves-effect waves-dark"><i class="fa fa-exclamation-triangle"></i> Gecikmiş Kitaplar </a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  ALANLARIN İÇERİKLERİ BÖLÜMÜ LAYOUT-->
       
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">
            Kitap Ekle
        </h1>
    </div>
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="card">
                   <div class="card-content">
                     	<% session.setAttribute("resim_guncelle", "yok"); %>
                     	<form enctype="multipart/form-data" action="dosyayukle.jsp" method="post">
								
                                
                                <label for="exampleFormControlFile1" style="display: block;">Resim Ekle</label>
                                <input type="file" name=file" required="required" style="display: inline-block;">
                            
							
							<input type="submit" value="Seç" class="btn btn-warning">
							
							<%if(session.getAttribute("resim_adi")!=null){ %>
							<img src="pictures/<%=session.getAttribute("resim_adi")%>" alt="Resim" width="80">
							<%}%>
						</form>
                     	
                     	
                     	<form action="VeriTabaniSorgu.jsp">
                           <input type="hidden" name="islem" value="EkleGuncelle"> <!--  Hepsinde aynı -->
							<input type="hidden" name="post" value="A_Kitaplar.jsp"> <!--  jsp adı -->
                            <input type="hidden" name="guncelle" value="yok">
                            
                            <div class="form-group">
                                <label for="exampleInputEmail1">Adı</label>
                                <input type="text" class="form-control"  name="k_e_ad" required="required">
                            </div>
                            
                            <div class="form-group">
                                <label for="exampleInputEmail1">Kategoriler</label>
                                <select name="k_e_kategori" class="form-control custom-select my-1 mr-sm-2">
									<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
									<%ResultSet Rs= Db.A_Veri_Getir("Kategoriler", "Hepsi");
									while(Rs.next()){ %>
										<option  value=<%=Rs.getString("id")%> ><%=Rs.getString("ad")%></option>
									<%}%>
  								</select>
                            </div>
                            
                            <div class="form-group">
                                <label for="exampleInputEmail1">Yazarı</label>
                               	<input type="text" class="form-control"  name="k_e_yazar" required="required">
                            </div>
                            
                           	<div class="form-group">
                                <label for="exampleInputEmail1">Adeti</label>
                               	<input type="number" class="form-control"  name="k_e_adet" required="required">
                          	</div>

                             <div class="form-group">
                                <label for="exampleInputEmail1">Sayfa sayısı</label>
                               	<input type="number" class="form-control"  name="k_e_sayfa_sayisi" required="required">
                            </div>
                            
                            
							<button type="submit" class="btn btn-success">Ekle</button>
                        </form>
						
						
					
					</div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>

     



        <footer>
            <p>Kitap Kira</p>
        </footer>
    </div>

</div>






        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>

    <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>

    <script src="assets/materialize/js/materialize.min.js"></script>

    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
    <!-- Morris Chart Js -->
    <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="assets/js/morris/morris.js"></script>


    <script src="assets/js/easypiechart.js"></script>
    <script src="assets/js/easypiechart-data.js"></script>

    <script src="assets/js/Lightweight-Chart/jquery.chart.js"></script>

    <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
 
</body>
</html>