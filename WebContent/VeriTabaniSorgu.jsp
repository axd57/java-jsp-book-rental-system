<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />

<%
String Islem=request.getParameter("islem");

//Kullanıcı------------------

//Giriş
if(Islem.equals("Giris")){
	String ad=request.getParameter("g_ka");  
	String sifre=request.getParameter("g_s"); 
	
	String[] GKBilgisi=Db.GirisKontrol(ad, sifre);
	session.setAttribute("login",GKBilgisi[2]);
	
	if(GKBilgisi[2]=="true"){
		session.setAttribute("AKId",GKBilgisi[0]);
		session.setAttribute("AKAd",GKBilgisi[1]);
		
		response.sendRedirect("Anasayfa.jsp");
	}
		
	else
		response.sendRedirect("index.jsp");  
}


//Kayıtol
if(Islem.equals("KayitOl")){
	String ad=request.getParameter("k_ad");
	String sifre=request.getParameter("k_sifre"); 
	String tc=request.getParameter("k_tc");
	String email=request.getParameter("k_email"); 
	String tel=request.getParameter("k_tel");
	
	Boolean donus= Db.Kayitkontrol(ad, sifre, tc, email, tel);
	session.setAttribute("sign",donus);
	if(donus==true)
		response.sendRedirect("index.jsp");
	else
		response.sendRedirect("Kayitol.jsp");  
}

//Güvenli çıkış
if(Islem.equals("cikis")){
	session.setAttribute("AKId", null);
	session.setAttribute("AKAd", null);
	response.sendRedirect("index.jsp");  
}

//Şifre Güncelle
if(Islem.equals("KSifreGuncelle")){
	String ASifre=request.getParameter("kssifre");
	String YSifre=request.getParameter("kysifre"); 
	String YSifreT=request.getParameter("kysifret");
	Boolean Sonuc=true;
	
	if(YSifre.equals(YSifreT)){
		Sonuc=Db.Sifre_Guncelle(ASifre, YSifre, String.valueOf(session.getAttribute("AKId")));
		
		if(Sonuc.equals(true))
			response.sendRedirect("Anasayfa.jsp"); 
		
		else{
			session.setAttribute("SGuncelle", "false");
			response.sendRedirect("SifreGuncelle.jsp");  
		}
	}
	else{
		session.setAttribute("SGuncelle", "false");
		response.sendRedirect("SifreGuncelle.jsp");  
	}
	
}

//Sifre e postası
if(Islem.equals("SifreAl")){
	String Eposta=request.getParameter("k_eposta");
	Boolean durum= Db.EMailSend(Eposta);
	
	if(durum.equals(false)){
		session.setAttribute("SAlMail", "false");
		response.sendRedirect("SifreAl.jsp"); 
	}
	if(durum.equals(true))
		response.sendRedirect("index.jsp"); 
	
}

// e posta yeni sifre
if(Islem.equals("EmailSifre")){
	String YeniS=request.getParameter("ys");
	String YeniST=request.getParameter("yst");
	String YeniSUid=request.getParameter("ysuid");
	
	if(YeniS.equals(YeniST)){
		Db.SifreEposta(YeniS, YeniSUid);
		response.sendRedirect("index.jsp"); 
	}
	else{
		session.setAttribute("MYSK", "false");
		response.sendRedirect("YeniSifre.jsp?id="+YeniSUid); 
	}
}



%>

<%

//Yönetici--------------------

//Giris
if(Islem.equals("YoneticiGiris")){
	String ad=request.getParameter("a_g_ka");  
	String sifre=request.getParameter("a_g_s"); 
	
	String[] GYBilgisi=Db.A_GirisKontrol(ad, sifre);
	session.setAttribute("a_login",GYBilgisi[2]);
	
	if(GYBilgisi[2]=="true"){
		session.setAttribute("AYId",GYBilgisi[0]);
		session.setAttribute("AYAd",GYBilgisi[1]);
		
		response.sendRedirect("A_Anasayfa.jsp");
	}
	else
		response.sendRedirect("A_Giris.jsp");  
}

//Güvenli çıkış
if(Islem.equals("acikis")){
	session.setAttribute("AYId", null);
	session.setAttribute("AYAd", null);
	response.sendRedirect("A_Giris.jsp");  
}

//Tablolar için veri listeleme ve arama
if(Islem.equals("Ara")){
	String Alan=request.getParameter("alan");
	String Kelime=request.getParameter("kelime");
	
	String Sorgu=Db.A_Ara(Alan, Kelime);
	
	session.setAttribute("ozelsorgu", Sorgu);
	response.sendRedirect(Alan);  
}


//Veri ekleme işlemleri
if(Islem.equals("EkleGuncelle")){
	String post=request.getParameter("post");
	
	//Kitaplar
	if(post.equals("A_Kitaplar.jsp")){
		String Ad=request.getParameter("k_e_ad");
		String Kategori=request.getParameter("k_e_kategori");
		String Yazar=request.getParameter("k_e_yazar");
		String Adet=request.getParameter("k_e_adet");
		String Sayfa_sayisi=request.getParameter("k_e_sayfa_sayisi");
		String Resim_yol=String.valueOf(session.getAttribute("resim_adi"));
		
		if(request.getParameter("guncelle").equals("yok")){
			if(Resim_yol=="null")
				Resim_yol=Resim_yol+".png";
			
			Db.A_Kitap_Ekle_Guncelle(Ad, Kategori, Yazar, Adet, Sayfa_sayisi, Resim_yol,"yok", "-1");
		}
		else{
			if(session.getAttribute("resim_adi")==null)
				Resim_yol=String.valueOf(session.getAttribute("resim_tut"));
			
			Db.A_Kitap_Ekle_Guncelle(Ad, Kategori, Yazar, Adet, Sayfa_sayisi, Resim_yol,"evet", request.getParameter("gid"));
		}
			
		
		session.setAttribute("resim_adi", null);
		session.setAttribute("resim_guncelle", "yok");
		session.setAttribute("resim_tut", null);
		
		response.sendRedirect(post);
		
	}
	
	//Üyeler
	if(post.equals("A_Uyeler.jsp")){
		String Ad=request.getParameter("u_e_ad");
		String Sifre=request.getParameter("u_e_sifre");
		String Tc=request.getParameter("u_e_tc");
		String Email=request.getParameter("u_e_email");
		String Tel=request.getParameter("u_e_tel");
		
		if(request.getParameter("guncelle").equals("yok"))
			Db.A_Uye_Ekle_Guncelle(Ad, Sifre, Tc, Email, Tel, "yok", "-1");
		else
			Db.A_Uye_Ekle_Guncelle(Ad, Sifre, Tc, Email, Tel, "evet", request.getParameter("gid"));
		
		response.sendRedirect(post);
	}  
	
	//Kategoriler
	if(post.equals("A_Kategoriler.jsp")){
		String Ad=request.getParameter("k_e_ad");
		
		if(request.getParameter("guncelle").equals("yok"))
			Db.A_Kategori_Ekle_Guncelle(Ad, "yok", "-1");
		else
			Db.A_Kategori_Ekle_Guncelle(Ad, "evet", request.getParameter("gid"));
		
		response.sendRedirect(post);
	}
	
	//Kayıtlar
	if(post.equals("A_Kayitlar.jsp")){
			String Uye=request.getParameter("kyt_e_uye");
			String Kitap=request.getParameter("kyt_e_kitap");
			Boolean status;
			
			if(request.getParameter("guncelle").equals("yok"))
				status=Db.A_Kayit_Ekle_Guncelle(Uye, Kitap, "yok", "-1");
			else
				status=Db.A_Kayit_Ekle_Guncelle(Uye, Kitap, "evet", request.getParameter("gid"));
				
			
			if(status==true){
				session.setAttribute("kitap_yok", null);
				response.sendRedirect(post);
			}
			else{
				if(request.getParameter("guncelle").equals("yok")){
					session.setAttribute("kitap_yok", "true");
					response.sendRedirect("A_Kayit_Ekle.jsp");
				}
				else{
					session.setAttribute("kitap_yok", "true");
					response.sendRedirect("a_Kayit_Guncelle.jsp?id="+request.getParameter("gid"));
				}
			}
	}  
}
%>

