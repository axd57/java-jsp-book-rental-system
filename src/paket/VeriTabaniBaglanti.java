package paket;
//sql date
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

//import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.mail.Transport;

import java.util.ArrayList;
import java.util.Date;


public class VeriTabaniBaglanti {
	Connection Baglanti;
	Statement Stm;
	ResultSet Rs;
	
	public VeriTabaniBaglanti() {
		try {
			Baglanti= DriverManager.getConnection("jdbc:sqlserver://DORUK57\\SQLEXPRESSSP3;databaseName=KitapKiraDB;integratedSecurity=true;");
			Stm = Baglanti.createStatement();
			System.out.println("Baglandý");
			
		}
		catch(Exception e) {
			System.out.print("Baðlantý hatasý: "+e);
		}
		
	}
		
	//Kullanýcý-----------------------------------------------------
	
	//Giriþ
	public String[] GirisKontrol(String ad, String sifre) {
		int Count=0;
		String[] KBilgi= new String[3];
		
		try {
			 Rs=Stm.executeQuery("select * from uyeler where ad='"+ad+"' and sifre='"+sifre+"'");
			 while(Rs.next()) {
				Count++;
				
				KBilgi[0]=Rs.getString("id");
				KBilgi[1]=Rs.getString("ad");
				
		}
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		if(Count==1)
			KBilgi[2]="true";
		else
			KBilgi[2]="false";
		
		return KBilgi;
	}


	//Kayýt
	public Boolean Kayitkontrol(String ad, String sifre, String tc, String email, String tel) {
		String[] kontrol=GirisKontrol(ad, sifre);
		
		if(kontrol[2]=="false") {
			try {
			 Stm.executeUpdate("insert into uyeler values('"+ad+"','"+sifre+"','"+tc+"', '"+email+"','"+tel+"')");
			 return true;
			}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			return false;
			}
		}
		else
			return false;
		
	}

	// Kitap filtrele
	public ResultSet KitapKategoriSec(String Kategori){
		try {
			if(Kategori.equals("hepsi"))
				Rs=Stm.executeQuery("select ki.id, ka.ad as kategoriadi, ki.ad, ki.yazar, ki.adet, ki.resim, ki.sayfa_sayisi from Kitaplar as ki, kategoriler as ka where ki.kategoriid=ka.id");
			else
				Rs=Stm.executeQuery("select ki.id, ka.ad as kategoriadi, ki.ad, ki.yazar, ki.adet, ki.resim, ki.sayfa_sayisi from Kitaplar as ki, kategoriler as ka where ki.kategoriid=ka.id and ki.kategoriid="+Kategori+"");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return Rs;
	}
	
	
	//Kitap getirme
	public ResultSet KitapSec(String id){
		try {
			Rs=Stm.executeQuery("select ki.id, ka.ad as kategoriadi, ki.ad, ki.yazar, ki.adet, ki.resim, ki.sayfa_sayisi from Kitaplar as ki, kategoriler as ka where ki.kategoriid=ka.id and ki.id="+id+"");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return Rs;
	}
	
	//Sifre Guncelleme
	public Boolean Sifre_Guncelle(String ESifre, String YSifre, String AKullanicicId){
		String AKSifre="";
		Boolean Durum=true;
		
		try {
			 Rs=Stm.executeQuery("select * from uyeler where id="+AKullanicicId+"");
			 while(Rs.next()) {
				AKSifre=Rs.getString("sifre");
			 }
			 
			 if(ESifre.equals(AKSifre)){
				 Stm.executeUpdate("update uyeler set sifre="+YSifre+"where id="+AKullanicicId+"");
			 }
			 else
				 Durum=false;
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return Durum;
	}
	
	//Sifre e postasý
	public Boolean EMailSend(String eposta){
		final String username = "ahmetalper57doruk@gmail.com";
		final String password = "ahmet1999alper1z3";
		
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
		}});
		
		
		Boolean durum=true;
		String Uid="",UAdi="";
		
		try {
			Rs=Stm.executeQuery("select * from uyeler where email='"+eposta+"'");
			while(Rs.next()) {
				Uid=Rs.getString("id");
				UAdi=Rs.getString("ad");
			}
			 
			if(!Uid.equals("")){
				try {
					Message message = new MimeMessage(session);
					message.setFrom(new InternetAddress("ahmetalper57doruk@gmail.com"));
					message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(eposta));
					message.setSubject(UAdi+" Þifre Yenileme Ýsteði");
					message.setText("Þifre yenileme baðlantýsý: http://localhost:8080/KitapKira/YeniSifre.jsp?id="+Uid+"");
					Transport.send(message);
						
					System.out.println("Eposta gönderildi");
				} 
				catch (MessagingException e) {
					throw new RuntimeException(e);
				}
			}
			else
				durum=false;
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		return durum;
	}
	
	
	//E posta sifre guncelle
	public void SifreEposta(String Sifre, String id){
		try {
			Rs=Stm.executeQuery("update uyeler set sifre='"+Sifre+"'where id='"+id+"'");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	
	
	//Yönetici-----------------------------------------------------
	
	//Giriþ
	public String[] A_GirisKontrol(String ad, String sifre) {
		int Count=0;
		String[] YBilgi= new String[3];
		
		try {
			 Rs=Stm.executeQuery("select * from yoneticiler where ad='"+ad+"' and sifre='"+sifre+"'");
			 while(Rs.next()) {
				Count++;
				YBilgi[0]=Rs.getString("id");
				YBilgi[1]=Rs.getString("ad");
				
			}
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		    }
		if(Count==1)
			YBilgi[2]="true";
		else
			YBilgi[2]="false";
		
		return YBilgi;
	}
	
	
	//Anasayfa bilgiler
	public int[] A_Bilgi() {
		int[] Bilgiler= new int[5];
		String[] Tablolar= {"Kitaplar", "Uyeler", "Kategoriler", "Kayitlar", "GecikenKayitlar"};
		
		for(int i=0; i<5; i++)
		{
			try {
				 Rs=Stm.executeQuery("SELECT COUNT(*) as sayi FROM "+Tablolar[i]);
				 Rs.next();
				 Bilgiler[i]=Rs.getInt("sayi");
				 
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
		return Bilgiler;
	}
	
	
	//Tablolar için arama
	public String A_Ara(String Alan, String Kelime) {
		String Sorgu="";
		if(Alan.equals("A_Kitaplar.jsp"))
			Sorgu="select ki.id, ka.ad as kategoriadi, ki.ad, ki.yazar, ki.adet, ki.resim, ki.sayfa_sayisi from Kitaplar as ki, kategoriler as ka where ki.kategoriid=ka.id and ki.ad LIKE '"+Kelime+"%'";
		
		if(Alan.equals("A_Uyeler.jsp"))
			Sorgu="select * from uyeler where ad like'"+Kelime+"%'";
		
		if(Alan.equals("A_Kategoriler.jsp"))
			Sorgu="select * from Kategoriler where ad like'"+Kelime+"%'";
		
		if(Alan.equals("A_Kayitlar.jsp"))
			Sorgu="select k.id, u.id uyeid, ki.id kitapid, k.alis_tarihi, k.veris_tarihi, ki.ad, u.ad uyead, u.tel from kayitlar k, uyeler u, kitaplar ki where k.uyeid=u.id and k.kitapid= ki.id and ki.ad like '"+Kelime+"%'";
		
		if(Alan.equals("A_GecikenKayitlar.jsp"))
			Sorgu="select g.id, k.id kid, k.veris_tarihi, ki.ad kadi, u.ad uadi, u.tel, u.email from gecikenkayitlar as g, kayitlar as k, kitaplar as ki, uyeler as u where g.kayitid=k.id and k.kitapid=ki.id and k.uyeid=u.id and ki.ad like '"+Kelime+"%'";
		
		
		System.out.println("");
		System.out.println("Alan: "+ Alan);
		System.out.println("Sorgu: "+ Sorgu);
		
		return Sorgu;
		
	}
	
	
	//Tablolar için veri listeleme
	public ResultSet A_Veri_Getir(String Tablo, String Sorgu) {
		
		//System.out.println("Veri Getir- Tablo:"+Tablo+" Sorgu: "+ Sorgu);
		
		//Kitaplar
		if(Tablo.equals("Kitaplar")) {
			if(Sorgu!="Hepsi")
			{
				try {
					Rs=Stm.executeQuery(Sorgu);
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
			else {
				try {
					Rs=Stm.executeQuery("select ki.id, ka.ad as kategoriadi, ki.ad, ki.yazar, ki.adet, ki.resim, ki.sayfa_sayisi from Kitaplar as ki, kategoriler as ka where ki.kategoriid=ka.id");
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
		}
		
		//Uyeler
		if(Tablo.equals("Uyeler")) {
			if(Sorgu!="Hepsi")
			{
				try {
					Rs=Stm.executeQuery(Sorgu);
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
			else {
				try {
					Rs=Stm.executeQuery("select * from uyeler");
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
		}
		
		
		//Kategoriler
		if(Tablo.equals("Kategoriler")) {
			if(Sorgu!="Hepsi")
			{
				try {
					Rs=Stm.executeQuery(Sorgu);
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
			else {
				try {
					Rs=Stm.executeQuery("select * from Kategoriler");
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
		}
		
		//Kayýtlar
		if(Tablo.equals("Kayitlar")) {
			if(Sorgu!="Hepsi")
			{
				try {
					Rs=Stm.executeQuery(Sorgu);
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
			else {
				try {
					Rs=Stm.executeQuery("select k.id, u.id uyeid, ki.id kitapid, k.alis_tarihi, k.veris_tarihi, ki.ad, u.ad uyead, u.tel from kayitlar k, uyeler u, kitaplar ki where k.uyeid=u.id and k.kitapid= ki.id");
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
		}
		
		//Gecikmiþ kayýtlar
		if(Tablo.equals("GecikmisKayitlar")) {
			if(Sorgu!="Hepsi")
			{
				try {
					Rs=Stm.executeQuery(Sorgu);
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
			else {
				try {
					Rs=Stm.executeQuery("select g.id, k.id kid, k.veris_tarihi, ki.ad kadi, u.ad uadi, u.tel, u.email from gecikenkayitlar as g, kayitlar as k, kitaplar as ki, uyeler as u where g.kayitid=k.id and k.kitapid=ki.id and k.uyeid=u.id");
					}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					}
			}
		}
		
		
		
		
		
		return Rs;
	}
	
	
	//Veri ekleme ve güncelleme iþlemleri
	
	//Kitaplar
	public void A_Kitap_Ekle_Guncelle(String ad, String kategori, String yazar, String adet, String sayfa_sayisi, String resim_yol, String Guncelle, String gid) {
		
		//System.out.println("Kategori id: "+kategori);
		try {
			if(Guncelle=="yok")
				Stm.executeUpdate("insert into kitaplar values("+kategori+", '"+ad+"', '"+yazar+"', "+adet+", '"+resim_yol+"', "+sayfa_sayisi+")");
			else
				Stm.executeUpdate("update kitaplar set kategoriid='"+kategori+"', ad='"+ad+"', yazar='"+yazar+"', adet='"+adet+"', resim='"+resim_yol+"', sayfa_sayisi='"+sayfa_sayisi+"' where id="+gid+"");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	//Üyeler
	public void A_Uye_Ekle_Guncelle(String ad, String sifre, String tc, String email, String tel, String Guncelle, String gid) {
		try {
			if(Guncelle=="yok")
				Stm.executeUpdate("insert into uyeler values('"+ad+"', '"+sifre+"', '"+tc+"', '"+email+"', '"+tel+"')");
			else
				Stm.executeUpdate("update uyeler set ad='"+ad+"', sifre='"+sifre+"', tc='"+tc+"', email='"+email+"', tel='"+tel+"' where id="+gid+"");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}	
	
	//Kategoriler
	public void A_Kategori_Ekle_Guncelle(String ad, String Guncelle, String gid) {
		try {
			if(Guncelle=="yok")
				Stm.executeUpdate("insert into kategoriler values('"+ad+"')");
			else
				Stm.executeUpdate("update kategoriler set ad='"+ad+"' where id="+gid+"");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	//Kayýtlar
	public Boolean A_Kayit_Ekle_Guncelle(String uye, String kitap, String Guncelle, String gid) {
		try {
			Rs=Stm.executeQuery("select ad, adet from kitaplar where id="+kitap+"");
			Rs.next();
			int adet= Integer.valueOf(Rs.getString("adet"));
			String ad= Rs.getString("ad");
			
			System.out.println("Seçili kitap adeti: "+ String.valueOf(adet));
			System.out.println("Seçili kitap adý: "+ ad);
			
			if(adet>0){
				DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
					
				LocalDateTime a_tarihi=LocalDateTime.now();
				LocalDateTime v_tarihi=a_tarihi.plusDays(15);
			
			
				if(Guncelle=="yok") {
						Stm.executeUpdate("insert into kayitlar values("+uye+", "+kitap+",'"+String.valueOf(dateFormat.format(a_tarihi))+"', '"+String.valueOf(dateFormat.format(v_tarihi))+"')");
					     
					    Stm.executeUpdate("update kitaplar set adet="+String.valueOf(adet-1)+" where id="+kitap+"");
					 
					    
				}
				
				else {
					Rs=Stm.executeQuery("select Kitaplar.ad as kadi, Kitaplar.adet as kadet from kayitlar, Kitaplar where kayitlar.kitapid=Kitaplar.id and Kayitlar.id="+gid+"");
					Rs.next();
					String eski_ad= Rs.getString("kadi");
					int eski_adet= Integer.valueOf(Rs.getString("kadet"));
					
					System.out.println("eski Seçili kitap adeti: "+ String.valueOf(eski_adet));
					System.out.println("eski Seçili kitap adý: "+ eski_ad);
					
					
					
							
					if(eski_ad.equals(ad)) {
						Stm.executeUpdate("update kayitlar set uyeid="+uye+", kitapid="+kitap+", alis_tarihi='"+String.valueOf(dateFormat.format(a_tarihi))+"', veris_tarihi='"+String.valueOf(dateFormat.format(v_tarihi))+"'where id="+gid+"");
						
					}
					
					else {
						Stm.executeUpdate("update kayitlar set uyeid="+uye+", kitapid="+kitap+", alis_tarihi='"+String.valueOf(dateFormat.format(a_tarihi))+"', veris_tarihi='"+String.valueOf(dateFormat.format(v_tarihi))+"'where id="+gid+"");
						Stm.executeUpdate("update kitaplar set adet="+String.valueOf(adet-1)+" where id="+kitap+"");
						Stm.executeUpdate("update kitaplar set adet="+String.valueOf(eski_adet+1)+" where ad='"+eski_ad+"'");
					}
						
						
				}
				
				return true;
			}
			else
				return false;
		
			
		}
			
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			return false;
		}
	}
	

	//Veri güncelleme veri getirme
	
	public ResultSet A_Veri_Guncelle(String tablo, String id){
		//Kitaplar
		if(tablo.equals("Kitaplar")) {
			try {
				Rs=Stm.executeQuery("select *, Kategoriler.ad as kad from Kitaplar, Kategoriler where Kitaplar.kategoriid=Kategoriler.id and Kitaplar.id="+id+"");
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
		
		if(tablo.equals("Uyeler")) {
			try {
				Rs=Stm.executeQuery("select * from Uyeler where id="+id+"");
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
		
		if(tablo.equals("Kategoriler")) {
			try {
				Rs=Stm.executeQuery("select * from Kategoriler where id="+id+"");
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
		
		if(tablo.equals("Kayitlar")) {
			try {
				Rs=Stm.executeQuery("select Uyeler.ad as uadi, Kitaplar.ad as kadi from Uyeler, Kitaplar, Kayitlar Where Kayitlar.uyeid=Uyeler.id and Kayitlar.kitapid=Kitaplar.id and Kayitlar.id="+id+"");
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
		
	return Rs;
	}
	
	
	//Gecikme kontrol
	
	public void A_GecikmeKontrol() {
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		TimeUnit time = TimeUnit.DAYS; 
		
		LocalDateTime tarih=LocalDateTime.now();
		String bugun=String.valueOf(df.format(tarih));
		
		try {
			Stm.executeUpdate("truncate table gecikenkayitlar");
		} 
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		ArrayList<String> values = new ArrayList<>();
		try {
			Rs=Stm.executeQuery("select * from kayitlar");
			
			while(Rs.next()) {
				Date bugun_tarih = sdf.parse(bugun);
				Date veris_tarhi = sdf.parse(Rs.getString("veris_tarihi"));
				
				long diff = veris_tarhi.getTime() - bugun_tarih.getTime();
				long diffrence = time.convert(diff, TimeUnit.MILLISECONDS);
				
				System.out.println("Fark: "+ diffrence);
				
				if(diffrence<0) {
					values.add(Rs.getString("id"));
				}
			}
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		GecikmisGuncelle(values);
	}
	
	public void GecikmisGuncelle(ArrayList list) {
		try {
			for(var id: list) {
				Stm.executeUpdate("insert into gecikenkayitlar values("+String.valueOf(id)+")");
			}
		} 
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	
	
	
	//Veri silme iþlemleri
	
		public void A_Veri_Sil(String tablo, String id){
			try {
				if(tablo.equals("Kayitlar")) {
					Rs=Stm.executeQuery("select Kitaplar.adet as kadet from kayitlar, Kitaplar where kayitlar.kitapid=Kitaplar.id and Kayitlar.id="+id+"");
					Rs.next();
					int adet= Integer.valueOf(Rs.getString("kadet"));
					
					Stm.executeUpdate("update Kitaplar set adet="+String.valueOf(adet+1)+" from Kitaplar, Kayitlar where Kayitlar.kitapid=Kitaplar.id and Kayitlar.id="+id+"");
				}
				
				Stm.executeUpdate("delete from "+tablo+" where id="+id+"");
				
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}


}

