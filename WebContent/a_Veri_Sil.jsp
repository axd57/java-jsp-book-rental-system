<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
<%

String id=request.getParameter("id"); 
String alan=request.getParameter("alan");

Db.A_Veri_Sil(alan, id);


response.sendRedirect("A_"+alan+".jsp");
%>