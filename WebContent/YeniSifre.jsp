<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Mail Doğrulama</title>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    
    <link rel="stylesheet" type="text/css" href="css/customstyle.css">


</head>
<body>

<%
String Uid=request.getParameter("id");
System.out.println("Güncelleme id: "+ Uid);
if(Uid==null)
	response.sendRedirect("index.jsp");

%>


<div class="container">
        <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h3>Yeni Şifre</h3>
                </div>
                <form action="VeriTabaniSorgu.jsp">
                <input type="hidden" name="islem" value="EmailSifre">
                <input type="hidden" name="ysuid" value="<%=Uid%>">
                <div class="card-body">
                   
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Yeni şifre" name="ys" required="required">
                         </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Yeni şifre tekrar" name="yst" required="required">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Güncelle" class="btn float-right login_btn">
                        </div>
                    </form>
                </div>
                <p>
             	<%if(session.getAttribute("MYSK")!=null){
             	if(session.getAttribute("MYSK")=="false"){%>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    Şifreler uyuşmuyor
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
 				<%}
 				
             	session.setAttribute("MYSK", null);
             	}%>
            </div>
        </div>
  
</body>
</html>