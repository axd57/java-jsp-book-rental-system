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
<%if(session.getAttribute("AYId")==null)
    response.sendRedirect("A_Giris.jsp"); 
%>


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
                            Panel
                        </h1>
                </div>
                
                <jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
                <%
                int[] Bilgiler=Db.A_Bilgi();
                %>
                <div id="page-inner">
        
                        <div class="dashboard-cards">
                            <div class="row">
                                
                                <a href="A_Kitaplar.jsp">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image red">
                                                <i class="material-icons dp48">library_books</i>
                                            </div>
                                            <div class="card-stacked red">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[0] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>KİTAPLAR</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                
                                <a href="A_Uyeler.jsp">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image orange">
                                                <i class="material-icons dp48">assignment_ind</i>
                                            </div>
                                            <div class="card-stacked orange">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[1] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>ÜYELER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </a>
        
                                <a href="A_Kategoriler.jsp">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
        
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image blue">
                                                <i class="material-icons dp48">list</i>
                                            </div>
                                            <div class="card-stacked blue">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[2] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>KATEGORİLER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </a>
        
                                <a href="A_Kayitlar.jsp">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image green">
                                                <i class="material-icons dp48">offline_pin</i>
                                            </div>
                                            <div class="card-stacked green">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[3] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>KAYITLAR</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </a>
                                    
                                <a href="A_GecikenKayitlar.jsp">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image purple">
                                                <i class="material-icons dp48">warning</i>
                                            </div>
                                            <div class="card-stacked purple">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[4] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>GECİKMİŞ KİTAPLAR</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </a>
                            
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