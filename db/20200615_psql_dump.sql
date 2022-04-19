PGDMP         '    
            x            referans    12.3    12.3 y   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16393    referans    DATABASE     �   CREATE DATABASE referans WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';
    DROP DATABASE referans;
                postgres    false                        3079    16394    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2            ;           1255    16431    fibonacci(integer)    FUNCTION     �  CREATE FUNCTION public.fibonacci(n integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE
   counter INTEGER := 0 ; 
   i INTEGER := 0 ; 
   j INTEGER := 1 ;
BEGIN
    IF (n < 1) THEN
      RETURN 0 ;
   END IF; 
   
   LOOP 
      EXIT WHEN counter = n ; 
      counter := counter + 1 ; 
      SELECT j, i + j INTO i,   j ;
   END LOOP ; 
   
   RETURN i ;
END ; 
$$;
 +   DROP FUNCTION public.fibonacci(n integer);
       public          postgres    false            H           1255    16432 4   fn_bakım_modeli_surec_birim_sure(character varying)    FUNCTION     l  CREATE FUNCTION public."fn_bakım_modeli_surec_birim_sure"(surec character varying) RETURNS TABLE(surec_name character varying, varlik_carpani character varying, varlik_carpani_label character varying, br_i double precision, per_i double precision, bakim_periyoduna_gore_yillik_islem_sayisi double precision)
    LANGUAGE plpgsql
    AS $$
begin
	return query execute '
select 
surec,
varlik_carpani,
varlik_carpani_label, 
calc.br_i,
calc.per_i,
case 
when varlik_carpani = ''AG Ağaç Direk Sayısı'' then ag_dir.kod_2 +  calc.kod_2 + ag_dir.kod_0 +  calc.kod_0 + (greatest((ag_dir.kod_1 +  calc.kod_1) -  (ag_dir.kod_0 +  calc.kod_0),0))/ (select '||surec||'_ag_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''AG Demir Direk Sayısı'' then ag_dir.kod_2 +  calc.kod_2 + ag_dir.kod_0 +  calc.kod_0 + (greatest((ag_dir.kod_1 +  calc.kod_1) -  (ag_dir.kod_0 +  calc.kod_0),0))/ (select '||surec||'_ag_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'') 
when varlik_carpani = ''AG Beton Direk Sayısı'' then ag_dir.kod_2 +  calc.kod_2 + ag_dir.kod_0 +  calc.kod_0 + (greatest((ag_dir.kod_1 +  calc.kod_1) -  (ag_dir.kod_0 +  calc.kod_0),0))/ (select '||surec||'_ag_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Armatür Sayısı'' then calc.kod_2 +  calc.kod_0 + (greatest((calc.kod_1) -  (calc.kod_0),0))/ (select '||surec||'_aydinlatma_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Aydınlatma Direği Sayısı'' then calc.kod_2 +  calc.kod_0 + (greatest((calc.kod_1) -  (calc.kod_0),0))/ (select '||surec||'_aydinlatma_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Açık Şalt Bina Sayısı'' then top_bin.kod_2 +  calc.kod_2 + top_bin.kod_0 +  calc.kod_0 + (greatest((top_bin.kod_1 +  calc.kod_1) -  (top_bin.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Açık Şalt Bina için Hücre Sayısı'' then top_hüc.kod_2 +  calc.kod_2 + top_hüc.kod_0 +  calc.kod_0 + (greatest((top_hüc.kod_1 +  calc.kod_1) -  (top_hüc.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Modüler Bina Sayısı'' then top_bin.kod_2 +  calc.kod_2 + top_bin.kod_0 +  calc.kod_0 + (greatest((top_bin.kod_1 +  calc.kod_1) -  (top_bin.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Modüler Bina için Hücre Sayısı'' then top_hüc.kod_2 +  calc.kod_2 + top_hüc.kod_0 +  calc.kod_0 + (greatest((top_hüc.kod_1 +  calc.kod_1) -  (top_hüc.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Bina içi Yağlı Tip Dağıtım Trafosu Sayısı'' then bina_ici.kod_2 +  calc.kod_2 + bina_ici.kod_0 +  calc.kod_0 + (greatest((bina_ici.kod_1 +  calc.kod_1) -  (bina_ici.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Bina içi Kuru Tip Dağıtım Trafosu Sayısı'' then bina_ici.kod_2 +  calc.kod_2 + bina_ici.kod_0 +  calc.kod_0 + (greatest((bina_ici.kod_1 +  calc.kod_1) -  (bina_ici.kod_0 +  calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Güç Transformatörü Sayısı'' then calc.kod_2 +  calc.kod_0 + (greatest((calc.kod_1) -  (calc.kod_0),0))/ (select '||surec||'_bina_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Açık Şalt Binadaki Dağıtım Trafosu Sayısı'' then 0
when varlik_carpani = ''Toplam Bina Sayısı (DM,İM,KÖK, Bina Tipi Trafo DAHİL)'' then 0
when varlik_carpani = ''Bina içi Dağıtım Trafosu Sayısı'' then 0
when varlik_carpani = ''Toplam Hücre Sayısı'' then 0
when varlik_carpani = ''Direk Üstü Dağıtım Trafosu Sayısı'' then 0 
when varlik_carpani = ''Direk Üstü Kuru Tip Dağıtım Trafosu Sayısı'' then dut_say.kod_2 +  calc.kod_2 + dut_say.kod_0 +  calc.kod_0 + (greatest((dut_say.kod_1 +  calc.kod_1) -  (dut_say.kod_0 +  calc.kod_0),0))/ (select '||surec||'_direk_ustu_trafo_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Direk Üstü Yağlı Tip Dağıtım Trafosu Sayısı'' then dut_say.kod_2 +  calc.kod_2 + dut_say.kod_0 +  calc.kod_0 + (greatest((dut_say.kod_1 +  calc.kod_1) -  (dut_say.kod_0 +  calc.kod_0),0))/ (select '||surec||'_direk_ustu_trafo_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''OG Direk Sayısı'' then 0
when varlik_carpani = ''OG Ağaç Direk Sayısı'' then og_say.kod_2 +  calc.kod_2 + og_say.kod_0 +  calc.kod_0 + (greatest((og_say.kod_1 +  calc.kod_1) -  (og_say.kod_0 +  calc.kod_0),0))/ (select '||surec||'_og_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''OG Demir Direk Sayısı'' then og_say.kod_2 +  calc.kod_2 + og_say.kod_0 +  calc.kod_0 + (greatest((og_say.kod_1 +  calc.kod_1) -  (og_say.kod_0 +  calc.kod_0),0))/ (select '||surec||'_og_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''OG Beton Direk Sayısı'' then og_say.kod_2 +  calc.kod_2 + og_say.kod_0 +  calc.kod_0 + (greatest((og_say.kod_1 +  calc.kod_1) -  (og_say.kod_0 +  calc.kod_0),0))/ (select '||surec||'_og_havai_hat_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'')
when varlik_carpani = ''Saha Dağıtım Kutusu'' then calc.kod_2 +  calc.kod_0 + (greatest((calc.kod_1) -  (calc.kod_0),0))/ (select '||surec||'_saha_dagitim_kutusu_aktif_calisan_sayisi from bakim_modeli_girdiler where senaryo = ''AF'') 
else 0
end as bakim_periyoduna_gore_yillik_islem_sayisi
from bakim_modeli_varlik_carpani, 
lateral fn_sil('''||surec||''',varlik_carpani) calc,
lateral fn_sil('''||surec||''',''AG Direk Sayısı'') ag_dir,
lateral fn_sil('''||surec||''',''Toplam Bina Sayısı (DM,İM,KÖK, Bina Tipi Trafo DAHİL)'') top_bin,
lateral fn_sil('''||surec||''',''Toplam Hücre Sayısı'') top_hüc,
lateral fn_sil('''||surec||''',''Bina içi Dağıtım Trafosu Sayısı'') bina_ici,
lateral fn_sil('''||surec||''',''Direk Üstü Dağıtım Trafosu Sayısı'') dut_say,
lateral fn_sil('''||surec||''',''OG Direk Sayısı'') og_say
where surec = '''||surec||'''';
end
$$;
 S   DROP FUNCTION public."fn_bakım_modeli_surec_birim_sure"(surec character varying);
       public          postgres    false            I           1255    16433 ,   fn_sil(character varying, character varying)    FUNCTION     l  CREATE FUNCTION public.fn_sil(surec character varying, envanter character varying) RETURNS TABLE(br_i double precision, per_i double precision, kod_2 double precision, kod_1 double precision, kod_0 double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select
coalesce(birim_islem_süreleri_toplami_tek_kisi, 0) as birim_islem_süresi_toplami,
coalesce(birim_islem_sureleri_toplami, 0) as bakim_periyoduna_gore_yillik_birim_islem_suleri, 
coalesce(kod_2, 0) as kod_2,
coalesce(kod_1, 0) as kod_1,
coalesce(kod_0, 0) as kod_0
from bakim_modeli_varlik_carpani a  left join (select 
bakım_turu,ekipman, envanter, 
sum(birim_islem_süresi)/60 as birim_islem_süreleri_toplami_tek_kisi, 
sum(frekansa_gore_yillik_ortalama_gereken_islem_süresi)/60 as birim_islem_sureleri_toplami
from bakim_modeli_islem_tablosu_view  
where bakım_turu = '''||surec||''' 
group by bakım_turu,ekipman, envanter 
order by bakım_turu, envanter asc) b on a.varlik_carpani = b.envanter 
left join (select bakım_turu,ekipman, envanter, sum(fr_kod_2)/60 as kod_2, sum(fr_kod_1)/60 as kod_1, sum(fr_kod_0)/60 as kod_0 from bakim_modeli_islem_tablosu_kod_toplam_view where bakım_turu = '''||surec||'''
 group by bakım_turu,ekipman, envanter ) kod on a.varlik_carpani = kod.envanter 
where a.surec = '''||surec||''' and a.varlik_carpani = '''||envanter||''''; 
end
$$;
 R   DROP FUNCTION public.fn_sil(surec character varying, envanter character varying);
       public          postgres    false            J           1255    16434    fn_ulasim_sureleri(integer)    FUNCTION     ]  CREATE FUNCTION public.fn_ulasim_sureleri(integer) RETURNS TABLE(ilce character varying, sayac_sayac_arasi_ulasim_kirsal_arti_tarimsal double precision)
    LANGUAGE sql
    AS $_$ 
select ilc.ilce, ul.sayac_sayac_arasi_ulasim_kirsal_arti_tarimsal 
from ilceler ilc
inner join ulasim_sureleri ul on ul.ilce_id = ilc.id
where dag_fir_id=$1
$_$;
 2   DROP FUNCTION public.fn_ulasim_sureleri(integer);
       public          postgres    false            K           1255    16435 R   fn_yillik_bakim_ara_girdi(character varying, character varying, character varying)    FUNCTION     T  CREATE FUNCTION public.fn_yillik_bakim_ara_girdi(model character varying, envanter character varying, senaryo character varying) RETURNS TABLE(value double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select 1/'||model||'_'||envanter||' from bakim_modeli_girdiler where senaryo = '''||senaryo||''''; 
end
$$;
 �   DROP FUNCTION public.fn_yillik_bakim_ara_girdi(model character varying, envanter character varying, senaryo character varying);
       public          postgres    false            L           1255    16436 '   get_kar_at_max_yagis(character varying)    FUNCTION     +  CREATE FUNCTION public.get_kar_at_max_yagis(column_name character varying) RETURNS TABLE(id integer, column_name_outer double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select id, '||column_name||' as column_name_outer from kar_buz_ortulu_gun_sayisi_data'; 
end
$$;
 J   DROP FUNCTION public.get_kar_at_max_yagis(column_name character varying);
       public          postgres    false            M           1255    16437 0   get_kar_at_max_yagis(integer, character varying)    FUNCTION     e  CREATE FUNCTION public.get_kar_at_max_yagis(id_in integer, column_name character varying) RETURNS TABLE(id integer, column_name_outer double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select id, coalesce('||column_name||',0 ) as column_name_outer from kar_buz_ortulu_gun_sayisi_data where sehir_id= '|| id_in ||''; 
end
$$;
 Y   DROP FUNCTION public.get_kar_at_max_yagis(id_in integer, column_name character varying);
       public          postgres    false            N           1255    16438 6   get_kirsal_sayac_sayac_arasi_ulasim_ort_deger(integer)    FUNCTION     �   CREATE FUNCTION public.get_kirsal_sayac_sayac_arasi_ulasim_ort_deger(id_in integer) RETURNS TABLE(val double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select kume_'||id_in::text||'_ort_deger as a from girdiler'; 
end
$$;
 S   DROP FUNCTION public.get_kirsal_sayac_sayac_arasi_ulasim_ort_deger(id_in integer);
       public          postgres    false            O           1255    16439 &   get_kus_ucusu_kirsal_arit_ort(integer)    FUNCTION       CREATE FUNCTION public.get_kus_ucusu_kirsal_arit_ort(id_in integer) RETURNS TABLE(val double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select kus_ucusu_kirsal_ulasim_kume_'||id_in::text||'_aritmetik_ort as a from girdiler'; 
end
$$;
 C   DROP FUNCTION public.get_kus_ucusu_kirsal_arit_ort(id_in integer);
       public          postgres    false            P           1255    16440 &   get_kus_ucusu_merkez_arit_ort(integer)    FUNCTION       CREATE FUNCTION public.get_kus_ucusu_merkez_arit_ort(id_in integer) RETURNS TABLE(val double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select kus_ucusu_merkez_ulasim_kume_'||id_in::text||'_aritmetik_ort as a from girdiler'; 
end
$$;
 C   DROP FUNCTION public.get_kus_ucusu_merkez_arit_ort(id_in integer);
       public          postgres    false            Q           1255    16441 0   get_yagis_at_max_kar(integer, character varying)    FUNCTION     ^  CREATE FUNCTION public.get_yagis_at_max_kar(id_in integer, column_name character varying) RETURNS TABLE(id integer, column_name_outer double precision)
    LANGUAGE plpgsql
    AS $$
begin 
	return query execute 'select id, coalesce('||column_name||',0 ) as column_name_outer from yagisli_gun_sayisi_data where sehir_id= '|| id_in ||''; 
end
$$;
 Y   DROP FUNCTION public.get_yagis_at_max_kar(id_in integer, column_name character varying);
       public          postgres    false            R           1255    16442 	   upd_baz()    FUNCTION     �   CREATE FUNCTION public.upd_baz() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
	refresh materialized view ozet_1;
	return new;
END; $$;
     DROP FUNCTION public.upd_baz();
       public          postgres    false            �            1259    16443    bakim_girdiler    TABLE     �
  CREATE TABLE public.bakim_girdiler (
    id integer NOT NULL,
    gunlukmesaisuresi double precision DEFAULT 7.5 NOT NULL,
    aktifcalismaorani double precision DEFAULT 0.8 NOT NULL,
    aylikmesaigunu double precision DEFAULT 18.875 NOT NULL,
    "og_hat_yürümekatsayisi" double precision DEFAULT 1.5 NOT NULL,
    isemrialmasuresi double precision DEFAULT 20 NOT NULL,
    bakimfrekans_ag_havai double precision DEFAULT 0.5 NOT NULL,
    bakimfrekans_ayd double precision DEFAULT 0.5 NOT NULL,
    bakimfrekans_bina double precision DEFAULT 0.5 NOT NULL,
    bakimfrekans_dut double precision DEFAULT 0.5 NOT NULL,
    bakimfrekans_og_havai double precision DEFAULT 0.5 NOT NULL,
    bakimfrekans_sdk double precision DEFAULT 0.5 NOT NULL,
    bakim_ekipyapisi_aghat double precision DEFAULT 2 NOT NULL,
    bakim_ekipyapisi_ayd double precision DEFAULT 2 NOT NULL,
    bakim_ekipyapisi_bina double precision DEFAULT 3 NOT NULL,
    bakim_ekipyapisi_dut double precision DEFAULT 3 NOT NULL,
    bakim_ekipyapisi_oghat double precision DEFAULT 2 NOT NULL,
    bakim_ekipyapisi_sdk double precision DEFAULT 2 NOT NULL,
    dag_fir_id integer,
    bakimsure_ag_agacdirek double precision DEFAULT 13.2 NOT NULL,
    bakimsure_ag_demirdirek double precision DEFAULT 7.2 NOT NULL,
    bakimsure_ag_betondirek double precision DEFAULT 13.1 NOT NULL,
    bakimsure_ayd_armatur double precision DEFAULT 0.3 NOT NULL,
    bakimsure_ayd_direk double precision DEFAULT 6.3 NOT NULL,
    bakimsure_bina_aciksalt double precision DEFAULT 71 NOT NULL,
    bakimsure_hucre_aciksalt double precision DEFAULT 64 NOT NULL,
    bakimsure_trafo_yagli double precision DEFAULT 40 NOT NULL,
    bakimsure_bina_moduler double precision DEFAULT 65 NOT NULL,
    bakimsure_hucre_moduler double precision DEFAULT 7 NOT NULL,
    bakimsure_trafo_kuru double precision DEFAULT 32 NOT NULL,
    bakimsure_guctrafo double precision DEFAULT 67 NOT NULL,
    bakimsure_dut double precision DEFAULT 93 NOT NULL,
    bakimsure_og_agacdirek double precision DEFAULT 14.4 NOT NULL,
    bakimsure_og_demirdirek double precision DEFAULT 8.4 NOT NULL,
    bakimsure_og_betondirek double precision DEFAULT 14.3 NOT NULL,
    bakimsure_sdk double precision DEFAULT 6.8 NOT NULL,
    koordinator_ekipbasina double precision DEFAULT 10 NOT NULL,
    bakimoncesi_manevrasuresi double precision DEFAULT 30 NOT NULL,
    hatbakimioncesi_topraklama double precision DEFAULT 9 NOT NULL,
    hatbakimisonrasi_topraklamaalma double precision DEFAULT 6 NOT NULL,
    aydbakimi_panosuresi double precision DEFAULT 20 NOT NULL,
    ekipsefi_kacekipicin double precision DEFAULT 3 NOT NULL,
    karligun_utilizasyonkaybi double precision DEFAULT 1 NOT NULL
);
 "   DROP TABLE public.bakim_girdiler;
       public         heap    postgres    false            �           0    0 0   COLUMN bakim_girdiler."og_hat_yürümekatsayisi"    COMMENT     �   COMMENT ON COLUMN public.bakim_girdiler."og_hat_yürümekatsayisi" IS 'OG Hat yürümelerinin kırsal yürümeye göre ne kada az olacağı';
          public          postgres    false    203            �           0    0 +   COLUMN bakim_girdiler.bakimfrekans_ag_havai    COMMENT     ^   COMMENT ON COLUMN public.bakim_girdiler.bakimfrekans_ag_havai IS 'Yıllık gözlem sayısı';
          public          postgres    false    203            �           0    0 *   COLUMN bakim_girdiler.ekipsefi_kacekipicin    COMMENT     u   COMMENT ON COLUMN public.bakim_girdiler.ekipsefi_kacekipicin IS '3 ekip için ilave 1 kişi ekip şefi olacaktır.';
          public          postgres    false    203            �           0    0 /   COLUMN bakim_girdiler.karligun_utilizasyonkaybi    COMMENT     �   COMMENT ON COLUMN public.bakim_girdiler.karligun_utilizasyonkaybi IS 'Karlı günlerde çalışma performansının ne kadar düşeceği';
          public          postgres    false    203            �            1259    16487    bakim_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bakim_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.bakim_girdiler_id_seq;
       public          postgres    false    203            �           0    0    bakim_girdiler_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.bakim_girdiler_id_seq OWNED BY public.bakim_girdiler.id;
          public          postgres    false    204            �            1259    16489    bakim_modeli_girdiler    TABLE     3  CREATE TABLE public.bakim_modeli_girdiler (
    id integer NOT NULL,
    senaryo character varying(30) NOT NULL,
    gunluk_mesai_suresi double precision NOT NULL,
    personel_utilizasyon_orani double precision NOT NULL,
    "aylik_mesai_günü" double precision NOT NULL,
    "yillik_calisma_günü" double precision NOT NULL,
    saatlik_ortalama_hiz double precision NOT NULL,
    saatlik_ortalama_kisa_mesafe_hiz double precision NOT NULL,
    "arac_akaryakit_tüketimi_gözlem" double precision NOT NULL,
    "arac_akaryakit_tüketimi_sepetli" double precision NOT NULL,
    "og_havai_hat_yürüyüs_indirgeme_katsayisi" double precision NOT NULL,
    "arac_indi_bindi_süresi" double precision NOT NULL,
    "is_emri_alma_süresi" double precision NOT NULL,
    bakim_oncesi_enerji_kesintisi_ve_manevra_icin_beklenilmesi double precision NOT NULL,
    "hat_bakimi_oncesi_topraklama_yapilmasi_icin_gecen_süre" double precision NOT NULL,
    hat_bakimi_sonrasi_topraklama_kablosunun_alinmasi double precision NOT NULL,
    personelin_sepetli_araci_sabitlemesi_ekipman_almasi_isg_onlemle double precision NOT NULL,
    iki_direk_arasi_mesafe double precision NOT NULL,
    ag_durdurucu_direk_orani double precision NOT NULL,
    og_durdurucu_direk_orani double precision NOT NULL,
    ayirici_sayisi double precision NOT NULL,
    parafudr_sayisi double precision NOT NULL,
    kar_ortulu_gun_etkisi_uygulanmasi double precision NOT NULL,
    "planlı_bakim_ag_havai_hat" double precision NOT NULL,
    "planlı_bakim_aydinlatma" double precision NOT NULL,
    "planlı_bakim_bina" double precision NOT NULL,
    "planlı_bakim_direk_ustu_trafo" double precision NOT NULL,
    "planlı_bakim_og_havai_hat" double precision NOT NULL,
    "planlı_bakim_saha_dagitim_kutusu" double precision NOT NULL,
    gozlem_ag_havai_hat double precision NOT NULL,
    gozlem_aydinlatma double precision NOT NULL,
    gozlem_bina double precision NOT NULL,
    gozlem_direk_ustu_trafo double precision NOT NULL,
    gozlem_og_havai_hat double precision NOT NULL,
    gozlem_saha_dagitim_kutusu double precision NOT NULL,
    ag_agac_direkler_saglamlik_test_periyodu double precision NOT NULL,
    ag_beton_direkler_saglamlik_test_periyodu double precision NOT NULL,
    og_agac_direkler_saglamlik_test_periyodu double precision NOT NULL,
    og_beton_direkler_saglamlik_test_periyodu double precision NOT NULL,
    "planlı_bakim_ag_havai_hat_ekipteki_personel_sayisi" double precision NOT NULL,
    "planlı_bakim_aydinlatma_ekipteki_personel_sayisi" double precision NOT NULL,
    "planlı_bakim_bina_ekipteki_personel_sayisi" double precision NOT NULL,
    "planlı_bakim_direk_ustu_trafo_ekipteki_personel_sayisi" double precision NOT NULL,
    "planlı_bakim_og_havai_hat_ekipteki_personel_sayisi" double precision NOT NULL,
    "planlı_bakim_saha_dagitim_kutusu_ekipteki_personel_sayisi" double precision NOT NULL,
    gozlem_ag_havai_hat_ekipteki_personel_sayisi double precision NOT NULL,
    gozlem_aydinlatma_ekipteki_personel_sayisi double precision NOT NULL,
    gozlem_bina_ekipteki_personel_sayisi double precision NOT NULL,
    gozlem_direk_ustu_trafo_ekipteki_personel_sayisi double precision NOT NULL,
    gozlem_og_havai_hat_ekipteki_personel_sayisi double precision NOT NULL,
    gozlem_saha_dagitim_kutusu_ekipteki_personel_sayisi double precision NOT NULL,
    "planlı_bakim_ag_havai_hat_aktif_calisan_sayisi" double precision NOT NULL,
    "planlı_bakim_aydinlatma_aktif_calisan_sayisi" double precision NOT NULL,
    "planlı_bakim_bina_aktif_calisan_sayisi" double precision NOT NULL,
    "planlı_bakim_direk_ustu_trafo_aktif_calisan_sayisi" double precision NOT NULL,
    "planlı_bakim_og_havai_hat_aktif_calisan_sayisi" double precision NOT NULL,
    "planlı_bakim_saha_dagitim_kutusu_aktif_calisan_sayisi" double precision NOT NULL,
    gozlem_ag_havai_hat_aktif_calisan_sayisi double precision NOT NULL,
    gozlem_aydinlatma_aktif_calisan_sayisi double precision NOT NULL,
    gozlem_bina_aktif_calisan_sayisi double precision NOT NULL,
    gozlem_direk_ustu_trafo_aktif_calisan_sayisi double precision NOT NULL,
    gozlem_og_havai_hat_aktif_calisan_sayisi double precision NOT NULL,
    gozlem_saha_dagitim_kutusu_aktif_calisan_sayisi double precision NOT NULL,
    "direk_ustu_yagli_tip_dagitim_trafosu_oranı" double precision DEFAULT 1 NOT NULL,
    dag_fir_id integer
);
 )   DROP TABLE public.bakim_modeli_girdiler;
       public         heap    postgres    false            �            1259    16493    bakim_modeli_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bakim_modeli_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.bakim_modeli_girdiler_id_seq;
       public          postgres    false    205            �           0    0    bakim_modeli_girdiler_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.bakim_modeli_girdiler_id_seq OWNED BY public.bakim_modeli_girdiler.id;
          public          postgres    false    206            �            1259    16495 $   bakim_modeli_islem_tablosu_constants    TABLE     �  CREATE TABLE public.bakim_modeli_islem_tablosu_constants (
    id integer NOT NULL,
    "gozlem_bakımın_uygulanacagi_varlık_orani" double precision NOT NULL,
    "bakım_turu" character varying(1000) NOT NULL,
    ekipman character varying(1000) NOT NULL,
    ekipman_alt_tipi character varying(1000) NOT NULL,
    ekipman_alt_tipi_2 character varying(1000) NOT NULL,
    "bakım_isi" character varying(1000) NOT NULL,
    envanter character varying(1000) NOT NULL,
    enerji_kesintisi_gerekiyor_mu character varying(1000) NOT NULL,
    "birim_islem_süresi" double precision NOT NULL,
    "is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" double precision NOT NULL
);
 8   DROP TABLE public.bakim_modeli_islem_tablosu_constants;
       public         heap    postgres    false            �            1259    16501 +   bakim_modeli_islem_tablosu_constants_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bakim_modeli_islem_tablosu_constants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.bakim_modeli_islem_tablosu_constants_id_seq;
       public          postgres    false    207            �           0    0 +   bakim_modeli_islem_tablosu_constants_id_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.bakim_modeli_islem_tablosu_constants_id_seq OWNED BY public.bakim_modeli_islem_tablosu_constants.id;
          public          postgres    false    208            �            1259    16503    bakim_modeli_islem_tablosu_view    VIEW       CREATE VIEW public.bakim_modeli_islem_tablosu_view AS
 SELECT bakim_modeli_islem_tablosu_constants.id,
        CASE
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[14, 15, 16, 253])) THEN (0.2)::double precision
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[22, 23])) THEN ( SELECT ((1)::double precision / bakim_modeli_girdiler.ag_beton_direkler_saglamlik_test_periyodu)
               FROM public.bakim_modeli_girdiler
              WHERE ((bakim_modeli_girdiler.senaryo)::text = 'AF'::text))
            WHEN (bakim_modeli_islem_tablosu_constants.id = 41) THEN LEAST((0.2)::double precision, v1.value)
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[270, 271])) THEN ( SELECT ((1)::double precision / bakim_modeli_girdiler.og_agac_direkler_saglamlik_test_periyodu)
               FROM public.bakim_modeli_girdiler
              WHERE ((bakim_modeli_girdiler.senaryo)::text = 'AF'::text))
            ELSE v1.value
        END AS yillik_gozlem_bakim_frekansi,
    bakim_modeli_islem_tablosu_constants."gozlem_bakımın_uygulanacagi_varlık_orani",
    bakim_modeli_islem_tablosu_constants."bakım_turu",
    bakim_modeli_islem_tablosu_constants.ekipman,
    bakim_modeli_islem_tablosu_constants.ekipman_alt_tipi,
    bakim_modeli_islem_tablosu_constants.ekipman_alt_tipi_2,
    bakim_modeli_islem_tablosu_constants."bakım_isi",
    bakim_modeli_islem_tablosu_constants.envanter,
    bakim_modeli_islem_tablosu_constants.enerji_kesintisi_gerekiyor_mu,
    bakim_modeli_islem_tablosu_constants."birim_islem_süresi",
    ((
        CASE
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[14, 15, 16, 253])) THEN (0.2)::double precision
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[22, 23])) THEN ( SELECT ((1)::double precision / bakim_modeli_girdiler.ag_beton_direkler_saglamlik_test_periyodu)
               FROM public.bakim_modeli_girdiler
              WHERE ((bakim_modeli_girdiler.senaryo)::text = 'AF'::text))
            WHEN (bakim_modeli_islem_tablosu_constants.id = 41) THEN LEAST((0.2)::double precision, v1.value)
            WHEN (bakim_modeli_islem_tablosu_constants.id = ANY (ARRAY[270, 271])) THEN ( SELECT ((1)::double precision / bakim_modeli_girdiler.og_agac_direkler_saglamlik_test_periyodu)
               FROM public.bakim_modeli_girdiler
              WHERE ((bakim_modeli_girdiler.senaryo)::text = 'AF'::text))
            ELSE v1.value
        END * bakim_modeli_islem_tablosu_constants."gozlem_bakımın_uygulanacagi_varlık_orani") * bakim_modeli_islem_tablosu_constants."birim_islem_süresi") AS "frekansa_gore_yillik_ortalama_gereken_islem_süresi",
    bakim_modeli_islem_tablosu_constants."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab"
   FROM public.bakim_modeli_islem_tablosu_constants,
    LATERAL public.fn_yillik_bakim_ara_girdi(bakim_modeli_islem_tablosu_constants."bakım_turu", bakim_modeli_islem_tablosu_constants.ekipman, 'AF'::character varying) v1(value)
  ORDER BY bakim_modeli_islem_tablosu_constants.id;
 2   DROP VIEW public.bakim_modeli_islem_tablosu_view;
       public          postgres    false    207    331    205    205    205    207    207    207    207    207    207    207    207    207    207            �            1259    16508 *   bakim_modeli_islem_tablosu_kod_toplam_view    VIEW     	  CREATE VIEW public.bakim_modeli_islem_tablosu_kod_toplam_view AS
 SELECT bakim_modeli_islem_tablosu_view.id,
    bakim_modeli_islem_tablosu_view.yillik_gozlem_bakim_frekansi,
    bakim_modeli_islem_tablosu_view."frekansa_gore_yillik_ortalama_gereken_islem_süresi",
    bakim_modeli_islem_tablosu_view."bakım_turu",
    bakim_modeli_islem_tablosu_view.ekipman,
    bakim_modeli_islem_tablosu_view.ekipman_alt_tipi,
    bakim_modeli_islem_tablosu_view.ekipman_alt_tipi_2,
    bakim_modeli_islem_tablosu_view.envanter,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (2)::double precision) THEN bakim_modeli_islem_tablosu_view."frekansa_gore_yillik_ortalama_gereken_islem_süresi"
            ELSE (0)::double precision
        END AS fr_kod_2,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (1)::double precision) THEN bakim_modeli_islem_tablosu_view."frekansa_gore_yillik_ortalama_gereken_islem_süresi"
            ELSE (0)::double precision
        END AS fr_kod_1,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (0)::double precision) THEN bakim_modeli_islem_tablosu_view."frekansa_gore_yillik_ortalama_gereken_islem_süresi"
            ELSE (0)::double precision
        END AS fr_kod_0,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (2)::double precision) THEN bakim_modeli_islem_tablosu_view."birim_islem_süresi"
            ELSE (0)::double precision
        END AS br_kod_2,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (1)::double precision) THEN bakim_modeli_islem_tablosu_view."birim_islem_süresi"
            ELSE (0)::double precision
        END AS br_kod_1,
        CASE
            WHEN (bakim_modeli_islem_tablosu_view."is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab" = (0)::double precision) THEN bakim_modeli_islem_tablosu_view."birim_islem_süresi"
            ELSE (0)::double precision
        END AS br_kod_0
   FROM public.bakim_modeli_islem_tablosu_view;
 =   DROP VIEW public.bakim_modeli_islem_tablosu_kod_toplam_view;
       public          postgres    false    209    209    209    209    209    209    209    209    209    209            �            1259    16513    bakim_modeli_lut_eszamanlilik    TABLE     �   CREATE TABLE public.bakim_modeli_lut_eszamanlilik (
    id integer NOT NULL,
    eszamanlilik character varying(1000) NOT NULL
);
 1   DROP TABLE public.bakim_modeli_lut_eszamanlilik;
       public         heap    postgres    false            �            1259    16519    bakim_modeli_varlik_carpani    TABLE     �   CREATE TABLE public.bakim_modeli_varlik_carpani (
    id integer NOT NULL,
    surec character varying,
    ilgili_varlik character varying,
    varlik_carpani character varying,
    varlik_carpani_label character varying
);
 /   DROP TABLE public.bakim_modeli_varlik_carpani;
       public         heap    postgres    false            �            1259    16525 "   bakim_modeli_varlik_carpani_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bakim_modeli_varlik_carpani_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.bakim_modeli_varlik_carpani_id_seq;
       public          postgres    false    212            �           0    0 "   bakim_modeli_varlik_carpani_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.bakim_modeli_varlik_carpani_id_seq OWNED BY public.bakim_modeli_varlik_carpani.id;
          public          postgres    false    213            �            1259    16527    cbs_girdiler    TABLE     "  CREATE TABLE public.cbs_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    dag_fir_id integer,
    verioperator_capex integer DEFAULT 40000000 NOT NULL,
    planlama_min integer DEFAULT 1 NOT NULL,
    planlama_max integer DEFAULT 3 NOT NULL,
    verikontrolofis_kacoperator integer DEFAULT 4 NOT NULL,
    verikontrolsaha_capex integer DEFAULT 50000000 NOT NULL,
    sondestek_kactrafo integer DEFAULT 10000 NOT NULL,
    baglantidegisim_kactrafo integer DEFAULT 10000 NOT NULL,
    diger_personel integer DEFAULT 5 NOT NULL
);
     DROP TABLE public.cbs_girdiler;
       public         heap    postgres    false            �            1259    16538    cbs_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cbs_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cbs_girdiler_id_seq;
       public          postgres    false    214            �           0    0    cbs_girdiler_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.cbs_girdiler_id_seq OWNED BY public.cbs_girdiler.id;
          public          postgres    false    215            �            1259    16540    dagitik_uretim_girdiler    TABLE     s  CREATE TABLE public.dagitik_uretim_girdiler (
    id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 9 NOT NULL,
    "aktifCalismaOrani_Mrk" double precision DEFAULT 0.7 NOT NULL,
    "aktifCalismaOrani_Kir" double precision DEFAULT 0.65 NOT NULL,
    "aylikMesaiGunu" double precision DEFAULT 18.875 NOT NULL,
    onkabul_sure_mesken double precision DEFAULT 120 NOT NULL,
    gecicikabul_sure_mesken double precision DEFAULT 120 NOT NULL,
    onkabul_red_orani double precision DEFAULT 0.5 NOT NULL,
    ofis_kabul_sure_mesken double precision DEFAULT 120 NOT NULL,
    ofis_kabul_sure_diger double precision DEFAULT 600 NOT NULL,
    ofis_red_sure_mesken double precision DEFAULT 25 NOT NULL,
    ofis_red_sure_diger double precision DEFAULT 160 NOT NULL,
    ofis_mahsuplasma_suresi double precision DEFAULT 15 NOT NULL,
    basvuru_imdatgrubu_aylik double precision DEFAULT 5 NOT NULL,
    hedef_kuruluguc_mw double precision DEFAULT 5000 NOT NULL,
    hedef_mesken_payi double precision DEFAULT 0.1 NOT NULL,
    hedef_diger_payi double precision DEFAULT 0.9 NOT NULL,
    gecicikabul_red_orani double precision DEFAULT 1 NOT NULL,
    paylasimorani_binasayisi double precision DEFAULT 0.5 NOT NULL,
    paylasimorani_guneslenme double precision DEFAULT 0.2 NOT NULL,
    paylasimorani_mevcutguc double precision DEFAULT 0.3 NOT NULL,
    "isEmriAlmaSuresi" double precision DEFAULT 20 NOT NULL,
    onkabul_sure_diger double precision DEFAULT 120 NOT NULL,
    gecicikabul_sure_diger double precision DEFAULT 120 NOT NULL,
    basvuru_birimkuruluguc_mesken double precision DEFAULT 5 NOT NULL,
    basvuru_birimkuruluguc_diger double precision DEFAULT 20 NOT NULL,
    paylasimorani_sanayiticaret double precision DEFAULT 0.2 NOT NULL,
    paylasimorani_tarimsal double precision DEFAULT 0.3 NOT NULL,
    ekipyapisi_onkabul integer DEFAULT 1 NOT NULL,
    ekipyapisi_gecicikabul integer DEFAULT 1 NOT NULL,
    ofis_digerisler_sure double precision DEFAULT 2580 NOT NULL,
    ofis_basvuru_red_orani double precision DEFAULT 0 NOT NULL,
    onkabul_ziyaret_orani double precision DEFAULT 0.5 NOT NULL
);
 +   DROP TABLE public.dagitik_uretim_girdiler;
       public         heap    postgres    false            �           0    0 1   COLUMN dagitik_uretim_girdiler.hedef_kuruluguc_mw    COMMENT     g   COMMENT ON COLUMN public.dagitik_uretim_girdiler.hedef_kuruluguc_mw IS '5 yıllık toplam hedef (MW)';
          public          postgres    false    216            �           0    0 0   COLUMN dagitik_uretim_girdiler.hedef_mesken_payi    COMMENT     }   COMMENT ON COLUMN public.dagitik_uretim_girdiler.hedef_mesken_payi IS 'Hedefin % kaçının meskenlerden karşılanacağı';
          public          postgres    false    216            �           0    0 /   COLUMN dagitik_uretim_girdiler.hedef_diger_payi    COMMENT     �   COMMENT ON COLUMN public.dagitik_uretim_girdiler.hedef_diger_payi IS 'Hedefinin % kaçının sanayi, ticarethane, tarımsal sulamadan karşılanacağı';
          public          postgres    false    216            �           0    0 7   COLUMN dagitik_uretim_girdiler.paylasimorani_binasayisi    COMMENT     �   COMMENT ON COLUMN public.dagitik_uretim_girdiler.paylasimorani_binasayisi IS 'İlçelere başvuru sayısını dağıtırken kullanılan ağırlıklar';
          public          postgres    false    216            �           0    0 1   COLUMN dagitik_uretim_girdiler.onkabul_sure_diger    COMMENT     p   COMMENT ON COLUMN public.dagitik_uretim_girdiler.onkabul_sure_diger IS 'Sanayi, Ticarethane, Tarımsal Sulama';
          public          postgres    false    216            �           0    0 5   COLUMN dagitik_uretim_girdiler.gecicikabul_sure_diger    COMMENT     i   COMMENT ON COLUMN public.dagitik_uretim_girdiler.gecicikabul_sure_diger IS 'Sanayi, Ticarethane, Diger';
          public          postgres    false    216            �           0    0 <   COLUMN dagitik_uretim_girdiler.basvuru_birimkuruluguc_mesken    COMMENT     �   COMMENT ON COLUMN public.dagitik_uretim_girdiler.basvuru_birimkuruluguc_mesken IS 'kW cinsinden ortalama başvuru kurulu gücü';
          public          postgres    false    216            �           0    0 ;   COLUMN dagitik_uretim_girdiler.basvuru_birimkuruluguc_diger    COMMENT     �   COMMENT ON COLUMN public.dagitik_uretim_girdiler.basvuru_birimkuruluguc_diger IS 'kW cinsinden ortalama başvuru kurulu gücü';
          public          postgres    false    216            �            1259    16575    dagitik_uretim_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dagitik_uretim_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.dagitik_uretim_girdiler_id_seq;
       public          postgres    false    216            �           0    0    dagitik_uretim_girdiler_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.dagitik_uretim_girdiler_id_seq OWNED BY public.dagitik_uretim_girdiler.id;
          public          postgres    false    217            �            1259    16577    dagitik_uretim_il_girdiler    TABLE     �  CREATE TABLE public.dagitik_uretim_il_girdiler (
    id integer NOT NULL,
    sehir_id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    sehir character varying NOT NULL,
    yearly_pv_energy_production double precision,
    sege_2011 double precision,
    bin_kisi_endeksi double precision,
    kurulu_guc_2016 double precision,
    pay_2016 double precision,
    kurulu_guc_2017 double precision,
    pay_2017 double precision,
    edas_toplam integer
);
 .   DROP TABLE public.dagitik_uretim_il_girdiler;
       public         heap    postgres    false            �            1259    16583    dagitim_firmalari    TABLE       CREATE TABLE public.dagitim_firmalari (
    id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    dag_fir character varying NOT NULL,
    explanation character varying,
    opex_2019 double precision DEFAULT 0 NOT NULL,
    capex_2019 double precision DEFAULT 0 NOT NULL,
    depo_sayisi double precision DEFAULT 1 NOT NULL,
    kik_tabi boolean DEFAULT false NOT NULL,
    hissedarsayisi_gt100 boolean DEFAULT false NOT NULL,
    kacakbolgesi boolean DEFAULT false NOT NULL,
    cagrimerkezi_personel double precision DEFAULT 0 NOT NULL,
    "güvenlikpersoneli" double precision DEFAULT 0 NOT NULL,
    sebekearizapersoneli integer DEFAULT 0 NOT NULL,
    yatirim_opex_maliyeti double precision DEFAULT 0.06 NOT NULL,
    capex double precision DEFAULT 0 NOT NULL
);
 %   DROP TABLE public.dagitim_firmalari;
       public         heap    postgres    false            �           0    0 $   COLUMN dagitim_firmalari.depo_sayisi    COMMENT     ~   COMMENT ON COLUMN public.dagitim_firmalari.depo_sayisi IS 'Güvenlik hariç en az 3 kişinin çalıştığı değo sayısı';
          public          postgres    false    219            �           0    0 !   COLUMN dagitim_firmalari.kik_tabi    COMMENT     a   COMMENT ON COLUMN public.dagitim_firmalari.kik_tabi IS 'KİK mevzuatına tabi olup olmadığı';
          public          postgres    false    219            �           0    0 %   COLUMN dagitim_firmalari.kacakbolgesi    COMMENT     �   COMMENT ON COLUMN public.dagitim_firmalari.kacakbolgesi IS 'Bölgenin kaçak oranının >%20 (Dicle, Vangölü, Aras) olup olmadığı';
          public          postgres    false    219            �           0    0 -   COLUMN dagitim_firmalari."güvenlikpersoneli"    COMMENT     u   COMMENT ON COLUMN public.dagitim_firmalari."güvenlikpersoneli" IS 'Bölgedeki toplam güvenlik personeli sayısı';
          public          postgres    false    219            �            1259    16600    dagitim_firmalari_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dagitim_firmalari_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.dagitim_firmalari_id_seq;
       public          postgres    false    219            �           0    0    dagitim_firmalari_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.dagitim_firmalari_id_seq OWNED BY public.dagitim_firmalari.id;
          public          postgres    false    220            �            1259    16602    endex_okuma_girdiler    TABLE     �  CREATE TABLE public.endex_okuma_girdiler (
    id integer NOT NULL,
    year_ integer DEFAULT 2020 NOT NULL,
    "sayacOkumaSuresi" double precision DEFAULT 0.4166 NOT NULL,
    "veriAkisSuresi" double precision DEFAULT 0.25 NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 7.5 NOT NULL,
    "aktifCalismaOrani_Mrk" double precision DEFAULT 0.7 NOT NULL,
    "aktifCalismaOrani_Kir" double precision DEFAULT 0.65 NOT NULL,
    "aylikMesaiGunu" double precision DEFAULT 22.75 NOT NULL,
    "sosyalEtki_MinKayipOraniEsikDegeri" double precision DEFAULT 0.08 NOT NULL,
    "sosyalEtki_MaxUtilizasyonKaybi" double precision DEFAULT 0.2 NOT NULL,
    "OSOS_sahadaOkumaOrani" double precision DEFAULT 0.05 NOT NULL,
    "isEmriAlmaSuresi" double precision DEFAULT 20 NOT NULL,
    "aracBasinaEkipSayisi" double precision DEFAULT 4 NOT NULL,
    dagitim_firma_id integer DEFAULT 0 NOT NULL,
    "sosyaletki_MaxKayipOraniEsikDegeri" double precision DEFAULT 0.40 NOT NULL,
    osos_sahadaokumasuresi double precision DEFAULT 0.42 NOT NULL,
    "OSOS_SahadaOkumaOrani_Tarimsal_Max" double precision DEFAULT 0.25 NOT NULL,
    "OSOS_SahadaOkumaOrani_tarimsal_Min" double precision DEFAULT 0.05 NOT NULL,
    endekskontrolorani double precision DEFAULT 0.01 NOT NULL,
    koordinator_kacpersonelbasina double precision DEFAULT 20 NOT NULL,
    sosyaletki_minutilizasyonkaybi double precision DEFAULT 0.0 NOT NULL
);
 (   DROP TABLE public.endex_okuma_girdiler;
       public         heap    postgres    false            �           0    0 .   COLUMN endex_okuma_girdiler."sayacOkumaSuresi"    COMMENT     f   COMMENT ON COLUMN public.endex_okuma_girdiler."sayacOkumaSuresi" IS 'dk. birim endeks okuma süresi';
          public          postgres    false    221            �           0    0 ,   COLUMN endex_okuma_girdiler."veriAkisSuresi"    COMMENT     w   COMMENT ON COLUMN public.endex_okuma_girdiler."veriAkisSuresi" IS 'dk. Endeksör cihazından veri alma-verme süresi';
          public          postgres    false    221            �           0    0 /   COLUMN endex_okuma_girdiler."gunlukMesaiSuresi"    COMMENT     M   COMMENT ON COLUMN public.endex_okuma_girdiler."gunlukMesaiSuresi" IS 'saat';
          public          postgres    false    221            �           0    0 2   COLUMN endex_okuma_girdiler.osos_sahadaokumasuresi    COMMENT     w   COMMENT ON COLUMN public.endex_okuma_girdiler.osos_sahadaokumasuresi IS 'OSOS sayaçların sahada okuma süresi (dk)';
          public          postgres    false    221            �           0    0 @   COLUMN endex_okuma_girdiler."OSOS_SahadaOkumaOrani_Tarimsal_Max"    COMMENT     �   COMMENT ON COLUMN public.endex_okuma_girdiler."OSOS_SahadaOkumaOrani_Tarimsal_Max" IS 'Tarımsal OSOS''ların maximum sahada okunma ihtiyacı (%)';
          public          postgres    false    221            �           0    0 @   COLUMN endex_okuma_girdiler."OSOS_SahadaOkumaOrani_tarimsal_Min"    COMMENT     g   COMMENT ON COLUMN public.endex_okuma_girdiler."OSOS_SahadaOkumaOrani_tarimsal_Min" IS 'Oran (Yüzde)';
          public          postgres    false    221            �           0    0 .   COLUMN endex_okuma_girdiler.endekskontrolorani    COMMENT     �   COMMENT ON COLUMN public.endex_okuma_girdiler.endekskontrolorani IS 'Endeks okumanın, ayrı bir personelle sahada tekrar kontrol oranı';
          public          postgres    false    221            �           0    0 9   COLUMN endex_okuma_girdiler.koordinator_kacpersonelbasina    COMMENT     |   COMMENT ON COLUMN public.endex_okuma_girdiler.koordinator_kacpersonelbasina IS '20 saha personeli başına 1 koordinatör';
          public          postgres    false    221            �            1259    16625    endex_okuma_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.endex_okuma_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.endex_okuma_girdiler_id_seq;
       public          postgres    false    221            �           0    0    endex_okuma_girdiler_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.endex_okuma_girdiler_id_seq OWNED BY public.endex_okuma_girdiler.id;
          public          postgres    false    222            �            1259    16627    genel_aydinlatma_girdiler    TABLE       CREATE TABLE public.genel_aydinlatma_girdiler (
    id integer NOT NULL,
    year_ integer DEFAULT 2020 NOT NULL,
    dag_fir_id integer DEFAULT 1 NOT NULL,
    lamba_ariza_orani double precision DEFAULT 0.3 NOT NULL,
    direk_ariza_orani double precision DEFAULT 0.01 NOT NULL,
    aylikmesaigunu double precision DEFAULT 22.75 NOT NULL,
    gunlukmesaisuresi double precision DEFAULT 7.5 NOT NULL,
    aktifcalismaorani double precision DEFAULT 0.7 NOT NULL,
    ekipyapisi_lamba double precision DEFAULT 3 NOT NULL,
    aynipano_ariza_sayisi double precision DEFAULT 2 NOT NULL,
    pano_suresi double precision DEFAULT 20 NOT NULL,
    arizagidermesuresi_lamba double precision DEFAULT 15 NOT NULL,
    aracbasinaekipsayisi_lamba double precision DEFAULT 2 NOT NULL,
    arizagidermesuresi_kablo double precision DEFAULT 180 NOT NULL,
    ekipyapisi_kablo double precision DEFAULT 4 NOT NULL,
    kablo_vinckirasuresi double precision DEFAULT 180 NOT NULL,
    vinckirabedeli double precision DEFAULT 150 NOT NULL,
    malzeme_fiyati_lamba double precision DEFAULT 16.2 NOT NULL,
    isemrialmasuresi double precision DEFAULT 20 NOT NULL,
    koordinator_kacekipbasina double precision DEFAULT 10 NOT NULL,
    aracbasinaekipsayisi_kablo double precision DEFAULT 1 NOT NULL
);
 -   DROP TABLE public.genel_aydinlatma_girdiler;
       public         heap    postgres    false            �           0    0 ,   COLUMN genel_aydinlatma_girdiler.pano_suresi    COMMENT     x   COMMENT ON COLUMN public.genel_aydinlatma_girdiler.pano_suresi IS 'Pano İSG önlemleri ve pano-lamba arası ulaşım';
          public          postgres    false    223            �           0    0 /   COLUMN genel_aydinlatma_girdiler.vinckirabedeli    COMMENT     a   COMMENT ON COLUMN public.genel_aydinlatma_girdiler.vinckirabedeli IS 'Saatlik kira bedeli (TL)';
          public          postgres    false    223            �            1259    16650     genel_aydinlatma_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genel_aydinlatma_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.genel_aydinlatma_girdiler_id_seq;
       public          postgres    false    223            �           0    0     genel_aydinlatma_girdiler_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.genel_aydinlatma_girdiler_id_seq OWNED BY public.genel_aydinlatma_girdiler.id;
          public          postgres    false    224            �            1259    16652    genel_yonetim_girdiler    TABLE     s  CREATE TABLE public.genel_yonetim_girdiler (
    id integer NOT NULL,
    year_ integer DEFAULT 2020 NOT NULL,
    dag_fir_id integer DEFAULT 1 NOT NULL,
    satin_alma_sabit double precision DEFAULT 2.5 NOT NULL,
    satin_alma_butce_basina double precision DEFAULT 40000000 NOT NULL,
    mhm_kacmusteri double precision DEFAULT 25000 NOT NULL,
    depo_sabit double precision DEFAULT 4 NOT NULL,
    depo_butcebasina double precision DEFAULT 80000000 NOT NULL,
    stok_sabit double precision DEFAULT 2 NOT NULL,
    stok_butcebasina double precision DEFAULT 160000000 NOT NULL,
    filo_kacarac double precision DEFAULT 50 NOT NULL,
    arac_kacbeyazyaka double precision DEFAULT 30 NOT NULL,
    arac_genelmuduryrd double precision DEFAULT 6 NOT NULL,
    arac_misafir double precision DEFAULT 2 NOT NULL,
    sofor_kacbeyazyakaaraci double precision DEFAULT 20 NOT NULL,
    sofor_genelmudur double precision DEFAULT 1 NOT NULL,
    sofor_misafir double precision DEFAULT 2 NOT NULL,
    satinalma_kik_ilave double precision DEFAULT 1 NOT NULL,
    finans_sabit double precision DEFAULT 9 NOT NULL,
    muhasebe_sabit double precision DEFAULT 4 NOT NULL,
    muhasebe_butcebasina double precision DEFAULT 100000000 NOT NULL,
    muhasebe_hissedar double precision DEFAULT 1 NOT NULL,
    regulasyon_sabit double precision DEFAULT 4 NOT NULL,
    insankaynaklari_sabit double precision DEFAULT 0 NOT NULL,
    insankaynaklari_0_100 double precision DEFAULT 0.027 NOT NULL,
    insankaynaklari_100_249 double precision DEFAULT 0.0126 NOT NULL,
    insankaynaklari_250_499 double precision DEFAULT 0.0107 NOT NULL,
    insankaynaklari_500_999 double precision DEFAULT 0.0082 NOT NULL,
    insankaynaklari_1000_2500 double precision DEFAULT 0.0079 NOT NULL,
    insankaynaklari_2500_7499 double precision DEFAULT 0.0053 NOT NULL,
    hukuk_sabit double precision DEFAULT 5 NOT NULL,
    hukuk_kacpersonel double precision DEFAULT 500 NOT NULL,
    hukuk_kacmusteri double precision DEFAULT 500000 NOT NULL,
    tahakkuk_aydinlatma_sabit double precision DEFAULT 2 NOT NULL,
    tahakkuk_aydinlatma_kactesisat double precision DEFAULT 5000 NOT NULL,
    tahakkuk_skb_sabit double precision DEFAULT 2 NOT NULL,
    veri_raporlama_sabit double precision DEFAULT 1 NOT NULL,
    veri_raporlama_kacilce double precision DEFAULT 20 NOT NULL,
    veri_kacak_sistem double precision DEFAULT 2 NOT NULL,
    veri_kacak_raporlama_kacilce double precision DEFAULT 20 NOT NULL,
    veri_kacak_analizci_kackacakekibi double precision DEFAULT 40 NOT NULL,
    arsiv_sabit double precision DEFAULT 2 NOT NULL,
    arsiv_buyukisletme double precision DEFAULT 1 NOT NULL,
    muhaberat_sabit double precision DEFAULT 1 NOT NULL,
    muhaberat_kacmusteri double precision DEFAULT 150000 NOT NULL,
    idari_diger_sabit double precision DEFAULT 3 NOT NULL,
    temizlik_sabit double precision DEFAULT 3 NOT NULL,
    temizlik_kacpersonel double precision DEFAULT 50 NOT NULL,
    guvenlik_genelmudurluk double precision DEFAULT 32 NOT NULL,
    guvenlik_genelmudurluk_kacak double precision DEFAULT 60 NOT NULL,
    guvenlik_kameraodasi double precision DEFAULT 4 NOT NULL,
    guvenlik_kameraodasi_kacak double precision DEFAULT 12 NOT NULL,
    guvenlik_scadamerkezi double precision DEFAULT 4 NOT NULL,
    guvenlik_buyukisletme double precision DEFAULT 2 NOT NULL,
    guvenlik_buyukisletme_kacak double precision DEFAULT 4 NOT NULL,
    guvenlik_kucukisletme_kacak20 double precision DEFAULT 1 NOT NULL,
    guvenlik_kucukisletme_kacak40 double precision DEFAULT 2 NOT NULL,
    guvenlik_anadepo double precision DEFAULT 8 NOT NULL,
    guvenlik_depo_buyukisletme double precision DEFAULT 8 NOT NULL,
    tesisyonetimi_kacpersonel double precision DEFAULT 300 NOT NULL,
    kalite_sabit double precision DEFAULT 4 NOT NULL,
    cevre_sabit double precision DEFAULT 1 NOT NULL,
    strateji_kurumsalperformans_sabit double precision DEFAULT 2 NOT NULL,
    strateji_isgelistirme_sabit double precision DEFAULT 1 NOT NULL,
    strateji_sureciyilestirme_sabit double precision DEFAULT 5 NOT NULL,
    strateji_surecharitalari_sabit double precision DEFAULT 2 NOT NULL,
    kurumsal_disiliskiler_sabit double precision DEFAULT 1 NOT NULL,
    kurumsal_basin_sabit double precision DEFAULT 2 NOT NULL,
    kurumsal_iletisim_sabit double precision DEFAULT 2 NOT NULL,
    musteriiliski_cagrimerkezi_kaccagripersoneli double precision DEFAULT 30 NOT NULL,
    musteriiliski_sosyal_minpersonel double precision DEFAULT 3 NOT NULL,
    musteriiliski_sosyal_cagrioperatorbasina double precision DEFAULT 0.02 NOT NULL,
    musteriiliski_dilekce_kacmusteri double precision DEFAULT 500000 NOT NULL,
    musteriiliski_memnuniyet_sabit double precision DEFAULT 1 NOT NULL,
    musteriiliski_ticarikalite_sabit double precision DEFAULT 2 NOT NULL,
    piyasa_taleptedarik_sabit double precision DEFAULT 1 NOT NULL,
    piyasa_epias_sabit double precision DEFAULT 4 NOT NULL,
    piyasa_dengesizlik_sabit double precision DEFAULT 2 NOT NULL,
    piyasa_kayiphesap_sabit double precision DEFAULT 1 NOT NULL,
    st_aktarim_sabit double precision DEFAULT 1 NOT NULL,
    st_veriyukleme_sabit double precision DEFAULT 1 NOT NULL,
    st_lisanssiz_sabit double precision DEFAULT 1 NOT NULL,
    st_teminat_sabit double precision DEFAULT 1 NOT NULL,
    st_tarife_sabit double precision DEFAULT 1 NOT NULL,
    mth_sabit double precision DEFAULT 5 NOT NULL,
    mth_kacmusteri double precision DEFAULT 250000 NOT NULL,
    icdenetim_sabit double precision DEFAULT 3 NOT NULL,
    icdenetim_kacpersonel double precision DEFAULT 2000 NOT NULL,
    arge_sabit double precision DEFAULT 2 NOT NULL,
    ustyonetim_min double precision DEFAULT 8000000 NOT NULL,
    sivilsavunma_sabit double precision DEFAULT 1 NOT NULL,
    ustyonetim_max double precision DEFAULT 12000000 NOT NULL,
    isletme_buyuklugu_ort double precision DEFAULT 750000 NOT NULL,
    insankaynaklari_gt7500 double precision DEFAULT 0.0042 NOT NULL,
    kacaktahakkuk_icraorani double precision DEFAULT 0.9 NOT NULL,
    kacakicra_dosyabiriktirme double precision DEFAULT 2 NOT NULL,
    hukuk_kacakicra_katip_dosya double precision DEFAULT 1000 NOT NULL,
    hukuk_kacakicra_avukat_katipsayisi double precision DEFAULT 2 NOT NULL,
    hukuk_sucduyurusu_katip_dosya double precision DEFAULT 6794 NOT NULL,
    hukuk_sucduyurusu_avukat_dosya double precision DEFAULT 3397 NOT NULL,
    isg_uzman_kacpersonelicin double precision DEFAULT 150 NOT NULL,
    isg_hekim_kacpersonelicin double precision DEFAULT 750 NOT NULL,
    isg_sef_kacuzman double precision DEFAULT 4 NOT NULL,
    isg_maliyet_maviyakabasina double precision DEFAULT 3964 NOT NULL,
    tahsilat_sabit double precision DEFAULT 2 NOT NULL,
    tahakkuk_kacak_borcyapilandirmaorani double precision DEFAULT 0.1 NOT NULL,
    anketbutcesi double precision DEFAULT 595238 NOT NULL,
    gunlukmesaisuresi double precision DEFAULT 7.5 NOT NULL,
    aktifcalismaorani double precision DEFAULT 0.7 NOT NULL,
    aylikmesaigunu double precision DEFAULT 18.40 NOT NULL,
    tahsilat_borcyapilandirmasuresi double precision DEFAULT 15 NOT NULL,
    tahsilat_kacak_borcyapilandirmaorani double precision DEFAULT 0.1 NOT NULL,
    tahsilat_icraoncesidegerlendirmesuresi double precision DEFAULT 10 NOT NULL,
    tahsilat_eslestirmesuresi double precision DEFAULT 8 NOT NULL,
    tahsilat_bedeli double precision DEFAULT 2.0 NOT NULL,
    idari_ilbasina double precision DEFAULT 1 NOT NULL,
    idari_buyukilcebasina double precision DEFAULT 2 NOT NULL,
    akaryakit_aracbasinatuketim_lt integer DEFAULT 675 NOT NULL,
    hukuk_sucduyurusu_avukat_katipsayisi double precision DEFAULT 0.5 NOT NULL,
    st_sabit double precision DEFAULT 16.0 NOT NULL,
    st_kacstbasina double precision DEFAULT 0.0 NOT NULL
);
 *   DROP TABLE public.genel_yonetim_girdiler;
       public         heap    postgres    false            �           0    0 5   COLUMN genel_yonetim_girdiler.kacaktahakkuk_icraorani    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.kacaktahakkuk_icraorani IS 'Kaçak tahakkukların ne kadarının icraya verileceği';
          public          postgres    false    225            �           0    0 7   COLUMN genel_yonetim_girdiler.kacakicra_dosyabiriktirme    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.kacakicra_dosyabiriktirme IS 'Bir müşterinin icraya verilmeden önce kaç adet dosyasının toplanması gerektiği';
          public          postgres    false    225            �           0    0 @   COLUMN genel_yonetim_girdiler.hukuk_kacakicra_avukat_katipsayisi    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.hukuk_kacakicra_avukat_katipsayisi IS 'Kaç katip başına bir avuvat olacağı';
          public          postgres    false    225            �           0    0 ;   COLUMN genel_yonetim_girdiler.hukuk_sucduyurusu_katip_dosya    COMMENT     z   COMMENT ON COLUMN public.genel_yonetim_girdiler.hukuk_sucduyurusu_katip_dosya IS 'kaç dosya için bir katip gerektiği';
          public          postgres    false    225            �           0    0 .   COLUMN genel_yonetim_girdiler.isg_sef_kacuzman    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.isg_sef_kacuzman IS 'Kaç uzman başına bir şef (takim yöneticisi) gerekiyor';
          public          postgres    false    225            �           0    0 8   COLUMN genel_yonetim_girdiler.isg_maliyet_maviyakabasina    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.isg_maliyet_maviyakabasina IS 'Mavi yaka saha personeli başına İSG malzeme maliyeti';
          public          postgres    false    225            �           0    0 B   COLUMN genel_yonetim_girdiler.tahakkuk_kacak_borcyapilandirmaorani    COMMENT     �   COMMENT ON COLUMN public.genel_yonetim_girdiler.tahakkuk_kacak_borcyapilandirmaorani IS 'İcraya verilmeyen müşterilerin %10''u';
          public          postgres    false    225            �           0    0 *   COLUMN genel_yonetim_girdiler.anketbutcesi    COMMENT     X   COMMENT ON COLUMN public.genel_yonetim_girdiler.anketbutcesi IS 'Anket bütçesi (TL)';
          public          postgres    false    225            �            1259    16775    genel_yonetim_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genel_yonetim_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.genel_yonetim_girdiler_id_seq;
       public          postgres    false    225            �           0    0    genel_yonetim_girdiler_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.genel_yonetim_girdiler_id_seq OWNED BY public.genel_yonetim_girdiler.id;
          public          postgres    false    226            �            1259    16777    girdiler    TABLE       CREATE TABLE public.girdiler (
    id integer NOT NULL,
    sabit double precision NOT NULL,
    iki_sayac_arasi_mesafe double precision NOT NULL,
    dummy_egim_1 double precision NOT NULL,
    dummy_egim_2 double precision NOT NULL,
    dummy_egim_3 double precision NOT NULL,
    dummy_egim_4 double precision NOT NULL,
    musteri_hat double precision NOT NULL,
    hat_uzunlugu_merkez double precision NOT NULL,
    kume_1_min_saniye double precision NOT NULL,
    kume_1_max_saniye double precision NOT NULL,
    kume_1_ort_deger double precision NOT NULL,
    kume_1_daginik double precision NOT NULL,
    kume_1_toplu double precision NOT NULL,
    kume_2_min_saniye double precision NOT NULL,
    kume_2_max_saniye double precision NOT NULL,
    kume_2_ort_deger double precision NOT NULL,
    kume_2_daginik double precision NOT NULL,
    kume_2_toplu double precision NOT NULL,
    kume_3_min_saniye double precision NOT NULL,
    kume_3_max_saniye double precision NOT NULL,
    kume_3_ort_deger double precision NOT NULL,
    kume_3_daginik double precision NOT NULL,
    kume_3_toplu double precision NOT NULL,
    kesisim double precision NOT NULL,
    koy_sayisi double precision NOT NULL,
    egim double precision NOT NULL,
    en_buyuk_koye_sure double precision NOT NULL,
    ortalama_nufus double precision NOT NULL,
    ilce_siniri_uzaklik double precision NOT NULL,
    karli_gun_sayisi_etkisi double precision DEFAULT 0.15 NOT NULL,
    sicaklik_nem_etkisi_25_30_derece double precision DEFAULT 0.1 NOT NULL,
    sicaklik_nem_etkisi_30_35_derece double precision DEFAULT 0.2 NOT NULL,
    yagmurlu_gun_sayisi_etkisi double precision DEFAULT 0.065 NOT NULL,
    trafik_etkisi_yogunluk_buyuk_10 double precision NOT NULL,
    trafik_etkisi_yogunluk_buyuk_1000 double precision NOT NULL,
    uc_g_etkisi_iyi double precision DEFAULT 0.05 NOT NULL,
    uc_g_etkisi_orta double precision DEFAULT 0.15 NOT NULL,
    uc_g_etkisi_kotu double precision DEFAULT 0.25 NOT NULL,
    uc_g_etkisi_veri_yok double precision DEFAULT 0.25 NOT NULL,
    "AracHizi_kmh" double precision DEFAULT 40 NOT NULL,
    arac_indi_bindi_suresi double precision DEFAULT 3 NOT NULL,
    mean_sigma1_arasindaki_musteri_orani double precision DEFAULT 0.68 NOT NULL,
    sigma1_sigma2_arasindaki_musteri_orani double precision DEFAULT 0.27 NOT NULL,
    sigma2_sigma3_arasindaki_musteri_orani double precision DEFAULT 0.05 NOT NULL,
    tarimsal_sulama_sayac_ulasim_katsayisi double precision DEFAULT 7.5 NOT NULL,
    kus_ucusu_merkez_ulasim_kume_1_agirlik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_2_agirlik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_3_agirlik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_4_agirlik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_1_aritmetik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_2_aritmetik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_3_aritmetik_ort double precision NOT NULL,
    kus_ucusu_merkez_ulasim_kume_4_aritmetik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_1_agirlik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_2_agirlik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_3_agirlik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_1_aritmetik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_2_aritmetik_ort double precision NOT NULL,
    kus_ucusu_kirsal_ulasim_kume_3_aritmetik_ort double precision NOT NULL,
    osos_sahada_okunma_orani double precision DEFAULT 0.05 NOT NULL,
    dag_fir_id integer DEFAULT 0 NOT NULL,
    "akaryakit_Sarfiyat_Binek" double precision DEFAULT 0.1 NOT NULL,
    "akaryakit_Sarfiyat_Sepetli" double precision DEFAULT 0.20 NOT NULL,
    diregecikmainmesuresi double precision DEFAULT 3 NOT NULL,
    "Akaryakit_Fiyat" double precision DEFAULT 6 NOT NULL,
    "personel_Ucret_Mavi" double precision DEFAULT 70000 NOT NULL,
    "personel_Ucret_Beyaz" double precision DEFAULT 85000 NOT NULL,
    osos_direkustukayipesikorani double precision DEFAULT 0.3 NOT NULL,
    arac_birim_maliyet double precision DEFAULT 50000 NOT NULL,
    direklerarasimesafe_ag double precision DEFAULT 50 NOT NULL,
    direklerarasimesafe_og double precision DEFAULT 50 NOT NULL,
    arac_maliyeti_sepetli double precision DEFAULT 80000,
    saha_personeli_aktif_calisma_orani_merkez double precision DEFAULT 0.70 NOT NULL,
    saha_personeli_aktif_calisma_orani_kirsal double precision DEFAULT 0.65 NOT NULL,
    saha_personeli_aktif_calisma_orani_ofis double precision DEFAULT 0.70 NOT NULL,
    gunluk_mesai_sures_hafta_5 double precision DEFAULT 9 NOT NULL,
    aylik_mesai_sures_hafta_5 double precision DEFAULT 18.4 NOT NULL,
    gunluk_mesai_sures_hafta_6 double precision DEFAULT 7.5 NOT NULL,
    aylik_mesai_sures_hafta_6 double precision DEFAULT 22.2 NOT NULL,
    is_emri_alma_suresi_mth double precision DEFAULT 10 NOT NULL,
    is_emri_alma_suresi_aob double precision DEFAULT 20 NOT NULL,
    yonetici_kackoordinatoricin double precision DEFAULT 5.0 NOT NULL
);
    DROP TABLE public.girdiler;
       public         heap    postgres    false            �           0    0 !   COLUMN girdiler."Akaryakit_Fiyat"    COMMENT     @   COMMENT ON COLUMN public.girdiler."Akaryakit_Fiyat" IS 'TL/lt';
          public          postgres    false    227            �           0    0 %   COLUMN girdiler."personel_Ucret_Mavi"    COMMENT     R   COMMENT ON COLUMN public.girdiler."personel_Ucret_Mavi" IS 'TL. Yıllık ücret';
          public          postgres    false    227            �           0    0 &   COLUMN girdiler."personel_Ucret_Beyaz"    COMMENT     S   COMMENT ON COLUMN public.girdiler."personel_Ucret_Beyaz" IS 'TL. Yıllık ücret';
          public          postgres    false    227            �           0    0 ,   COLUMN girdiler.osos_direkustukayipesikorani    COMMENT     �   COMMENT ON COLUMN public.girdiler.osos_direkustukayipesikorani IS '%30 üzerinde kayip olan ilçelerde, OSOS''ların direk üzerinde olması';
          public          postgres    false    227            �           0    0 "   COLUMN girdiler.arac_birim_maliyet    COMMENT     m   COMMENT ON COLUMN public.girdiler.arac_birim_maliyet IS 'Araç başına yıllık gider (akaryakıt hariç)';
          public          postgres    false    227            �           0    0 &   COLUMN girdiler.direklerarasimesafe_ag    COMMENT     E   COMMENT ON COLUMN public.girdiler.direklerarasimesafe_ag IS 'metre';
          public          postgres    false    227                        0    0 &   COLUMN girdiler.direklerarasimesafe_og    COMMENT     E   COMMENT ON COLUMN public.girdiler.direklerarasimesafe_og IS 'metre';
          public          postgres    false    227            �            1259    16817    girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.girdiler_id_seq;
       public          postgres    false    227                       0    0    girdiler_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.girdiler_id_seq OWNED BY public.girdiler.id;
          public          postgres    false    228            �            1259    16819    girdiler_money    TABLE     �   CREATE TABLE public.girdiler_money (
    id integer NOT NULL,
    money_personel double precision,
    money_arac double precision
);
 "   DROP TABLE public.girdiler_money;
       public         heap    postgres    false            �            1259    16822    girdiler_money_id_seq    SEQUENCE     �   CREATE SEQUENCE public.girdiler_money_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.girdiler_money_id_seq;
       public          postgres    false    229                       0    0    girdiler_money_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.girdiler_money_id_seq OWNED BY public.girdiler_money.id;
          public          postgres    false    230            �            1259    16824    girdiler_sayac_islemleri    TABLE     �  CREATE TABLE public.girdiler_sayac_islemleri (
    id integer NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 9 NOT NULL,
    "aktifCalismaOrani_Mrk" double precision DEFAULT 0.7 NOT NULL,
    "aktifCalismaOrani_Kir" double precision DEFAULT 0.65 NOT NULL,
    "aylikMesaiGunu" double precision DEFAULT 18.875 NOT NULL,
    "sayacArizaOrani_Min" double precision DEFAULT 0.03 NOT NULL,
    "sayacDegisimOrani_Damga" double precision DEFAULT 0.1 NOT NULL,
    "sayacSokmeTakma_Monofaze" double precision DEFAULT 11 NOT NULL,
    "sayacSokmeTakma_Trifaze" double precision DEFAULT 13.0 NOT NULL,
    "sayacSokmeTakma_OSOS" double precision DEFAULT 30 NOT NULL,
    "ekTahakkukSuresi_TarimsalHaric" double precision DEFAULT 10 NOT NULL,
    "ekTahakkukSuresi_Tarimsal" double precision DEFAULT 75 NOT NULL,
    "sayacSokme" double precision DEFAULT 5 NOT NULL,
    "sayacTakma_Monofaze" double precision DEFAULT 6 NOT NULL,
    "sayacTakma_KombiX5" double precision DEFAULT 10 NOT NULL,
    "sayacTakma_OSOS" double precision DEFAULT 25 NOT NULL,
    "sayacTestSuresi_AG" double precision DEFAULT 8 NOT NULL,
    "sayacTestSuresi_OG" double precision DEFAULT 8 NOT NULL,
    "ekTahakkukOrani" double precision DEFAULT 0.5 NOT NULL,
    "ekTahakkuk_Sikayet_Orani" double precision DEFAULT 0.25 NOT NULL,
    "ekTahakkuk_Sikayet_Gunluk_Incelenebilecek_Sayi" double precision DEFAULT 25 NOT NULL,
    "yikimSokulenSayacOrani" double precision DEFAULT 0.01 NOT NULL,
    "BinaIcindeSayaclarArasiUlasim" double precision DEFAULT 0.0833 NOT NULL,
    "isEmriAlmaSuresi" double precision DEFAULT 20 NOT NULL,
    "sayacBedeli_Monofaze" double precision DEFAULT 48.38 NOT NULL,
    "sayacBedeli_Trifaze" double precision DEFAULT 107.93 NOT NULL,
    "sayacBedeli_Kombi" double precision DEFAULT 186.09 NOT NULL,
    sayacsokmetakma_kombix5 double precision DEFAULT 15.0 NOT NULL,
    kayiporani_minesikdeger double precision DEFAULT 0.08 NOT NULL,
    kayiporani_maxesikdeger double precision DEFAULT 0.4 NOT NULL,
    ekipyapisi_ariza double precision DEFAULT 2 NOT NULL,
    ekipyapisi_yenibaglanti double precision DEFAULT 1 NOT NULL,
    ekipyapisi_yikim double precision DEFAULT 1 NOT NULL,
    sayactakma_trifaze double precision DEFAULT 8 NOT NULL,
    ekipyapisi_damga double precision DEFAULT 2 NOT NULL,
    sayacarizaorani_max double precision DEFAULT 0.05 NOT NULL,
    koordinator_kacpersonelbasina double precision DEFAULT 10 NOT NULL,
    minziyaret_mrk double precision DEFAULT 0 NOT NULL,
    minziyaret_kir double precision DEFAULT 0 NOT NULL,
    dag_fir_id integer DEFAULT 0 NOT NULL,
    ektahakkuk_sikayetsuresi double precision DEFAULT 15.0 NOT NULL,
    ekipyapisi_tespit double precision DEFAULT 1.0 NOT NULL,
    kacaksuphesi_max double precision DEFAULT 0.01 NOT NULL,
    kacaksuphesi_min double precision DEFAULT 0.001 NOT NULL,
    saha_tespit_suresi double precision DEFAULT 10 NOT NULL,
    saha_tespit_orani double precision DEFAULT 0.0075 NOT NULL,
    ek_tahakkuku_orani double precision DEFAULT 0.60 NOT NULL
);
 ,   DROP TABLE public.girdiler_sayac_islemleri;
       public         heap    postgres    false                       0    0 5   COLUMN girdiler_sayac_islemleri."sayacArizaOrani_Min"    COMMENT     l   COMMENT ON COLUMN public.girdiler_sayac_islemleri."sayacArizaOrani_Min" IS 'Yıllık Sayaç Arıza Oranı';
          public          postgres    false    231                       0    0 9   COLUMN girdiler_sayac_islemleri."sayacDegisimOrani_Damga"    COMMENT     `   COMMENT ON COLUMN public.girdiler_sayac_islemleri."sayacDegisimOrani_Damga" IS 'Kullanilmiyor';
          public          postgres    false    231                       0    0 8   COLUMN girdiler_sayac_islemleri."yikimSokulenSayacOrani"    COMMENT     }   COMMENT ON COLUMN public.girdiler_sayac_islemleri."yikimSokulenSayacOrani" IS 'Yıllık yıkımdan sökülen sayaç oranı';
          public          postgres    false    231                       0    0 ?   COLUMN girdiler_sayac_islemleri."BinaIcindeSayaclarArasiUlasim"    COMMENT     �   COMMENT ON COLUMN public.girdiler_sayac_islemleri."BinaIcindeSayaclarArasiUlasim" IS 'dk. Yeni bağlantı ve yıkım sayaçları sökme için bina içinde sayaç-sayaç arası ulaşım';
          public          postgres    false    231                       0    0 7   COLUMN girdiler_sayac_islemleri.sayacsokmetakma_kombix5    COMMENT     a   COMMENT ON COLUMN public.girdiler_sayac_islemleri.sayacsokmetakma_kombix5 IS 'Dakika cinsinden';
          public          postgres    false    231                       0    0 7   COLUMN girdiler_sayac_islemleri.kayiporani_minesikdeger    COMMENT     �   COMMENT ON COLUMN public.girdiler_sayac_islemleri.kayiporani_minesikdeger IS 'Sayaç arıza oranı interpolasyonu için minimum kaçak orani';
          public          postgres    false    231            	           0    0 0   COLUMN girdiler_sayac_islemleri.ekipyapisi_ariza    COMMENT     �   COMMENT ON COLUMN public.girdiler_sayac_islemleri.ekipyapisi_ariza IS 'Arızalı sayaç değişimi ekibin kaç personelden oluştuğu';
          public          postgres    false    231            
           0    0 7   COLUMN girdiler_sayac_islemleri.ekipyapisi_yenibaglanti    COMMENT     �   COMMENT ON COLUMN public.girdiler_sayac_islemleri.ekipyapisi_yenibaglanti IS 'Yeni bağlantı sayaç değişimi ekibin kaç personelden oluştuğu';
          public          postgres    false    231                       0    0 0   COLUMN girdiler_sayac_islemleri.ekipyapisi_yikim    COMMENT     �   COMMENT ON COLUMN public.girdiler_sayac_islemleri.ekipyapisi_yikim IS 'Yıkımdan sayaç sökme ekibin kaç personelden oluştuğu';
          public          postgres    false    231                       0    0 2   COLUMN girdiler_sayac_islemleri.sayactakma_trifaze    COMMENT     q   COMMENT ON COLUMN public.girdiler_sayac_islemleri.sayactakma_trifaze IS 'Trifaze sayaç takma süresi (dakika)';
          public          postgres    false    231            �            1259    16873    girdiler_sayac_islemleri_id_seq    SEQUENCE     �   CREATE SEQUENCE public.girdiler_sayac_islemleri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.girdiler_sayac_islemleri_id_seq;
       public          postgres    false    231                       0    0    girdiler_sayac_islemleri_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.girdiler_sayac_islemleri_id_seq OWNED BY public.girdiler_sayac_islemleri.id;
          public          postgres    false    232            �            1259    16875    girdilertum    TABLE     �   CREATE TABLE public.girdilertum (
    id integer NOT NULL,
    surec integer,
    girdi character varying(255),
    deger character varying(255),
    degertipi character varying(50),
    dagitimfirmaid integer
);
    DROP TABLE public.girdilertum;
       public         heap    postgres    false            �            1259    16881    girdilertum_id_seq    SEQUENCE     �   CREATE SEQUENCE public.girdilertum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.girdilertum_id_seq;
       public          postgres    false    233                       0    0    girdilertum_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.girdilertum_id_seq OWNED BY public.girdilertum.id;
          public          postgres    false    234            �            1259    16883    gozlem_girdiler    TABLE     >
  CREATE TABLE public.gozlem_girdiler (
    id integer NOT NULL,
    gunlukmesaisuresi double precision DEFAULT 7.5 NOT NULL,
    aktifcalismaorani double precision DEFAULT 0.8 NOT NULL,
    aylikmesaigunu double precision DEFAULT 18.875 NOT NULL,
    "og_hat_yürümekatsayisi" double precision DEFAULT 1.5 NOT NULL,
    isemrialmasuresi double precision DEFAULT 20 NOT NULL,
    gozlemfrekans_ag_havai double precision DEFAULT 1 NOT NULL,
    gozlemfrekans_ayd double precision DEFAULT 1 NOT NULL,
    gozlemfrekans_bina double precision DEFAULT 1 NOT NULL,
    gozlemfrekans_dut double precision DEFAULT 1 NOT NULL,
    gozlemfrekans_og_havai double precision DEFAULT 1 NOT NULL,
    gozlemfrekans_sdk double precision DEFAULT 1 NOT NULL,
    gozlem_ekipyapisi_aghat double precision DEFAULT 2 NOT NULL,
    gozlem_ekipyapisi_ayd double precision DEFAULT 2 NOT NULL,
    gozlem_ekipyapisi_bina double precision DEFAULT 2 NOT NULL,
    gozlem_ekipyapisi_dut double precision DEFAULT 2 NOT NULL,
    gozlem_ekipyapisi_oghat double precision DEFAULT 2 NOT NULL,
    gozlem_ekipyapisi_sdk double precision DEFAULT 2 NOT NULL,
    dag_fir_id integer,
    gozlemsure_ag_agacdirek double precision DEFAULT 3.6 NOT NULL,
    gozlemsure_ag_demirdirek double precision DEFAULT 2.4 NOT NULL,
    gozlemsure_ag_betondirek double precision DEFAULT 3.5 NOT NULL,
    gozlemsure_ayd_armatur double precision DEFAULT 0.3 NOT NULL,
    gozlemsure_ayd_direk double precision DEFAULT 2.3 NOT NULL,
    gozlemsure_bina_aciksalt double precision DEFAULT 11.4 NOT NULL,
    gozlemsure_hucre_aciksalt double precision DEFAULT 3.5 NOT NULL,
    gozlemsure_trafo_aciksalt double precision DEFAULT 3.6 NOT NULL,
    gozlemsure_bina_moduler double precision DEFAULT 10.8 NOT NULL,
    gozlemsure_hucre_moduler double precision DEFAULT 1.4 NOT NULL,
    gozlemsure_trafo_moduler double precision DEFAULT 3.3 NOT NULL,
    gozlemsure_guctrafo double precision DEFAULT 2.1 NOT NULL,
    gozlemsure_dut double precision DEFAULT 6.9 NOT NULL,
    gozlemsure_og_agacdirek double precision DEFAULT 5.6 NOT NULL,
    gozlemsure_og_demirdirek double precision DEFAULT 4.4 NOT NULL,
    gozlemsure_og_betondirek double precision DEFAULT 5.5 NOT NULL,
    gozlemsure_sdk double precision DEFAULT 6.8 NOT NULL,
    koordinator_ekipbasina double precision DEFAULT 10 NOT NULL,
    karligun_utilizasyonkaybi double precision DEFAULT 1 NOT NULL,
    gozlemsure_ag_agacdirek_tek double precision DEFAULT 7.1 NOT NULL,
    gozlemsure_ag_demirdirek_tek double precision DEFAULT 4.7 NOT NULL,
    gozlemsure_ag_betondirek_tek double precision DEFAULT 7.0 NOT NULL
);
 #   DROP TABLE public.gozlem_girdiler;
       public         heap    postgres    false                       0    0 1   COLUMN gozlem_girdiler."og_hat_yürümekatsayisi"    COMMENT     �   COMMENT ON COLUMN public.gozlem_girdiler."og_hat_yürümekatsayisi" IS 'OG Hat yürümelerinin kırsal yürümeye göre ne kada az olacağı';
          public          postgres    false    235                       0    0 -   COLUMN gozlem_girdiler.gozlemfrekans_ag_havai    COMMENT     `   COMMENT ON COLUMN public.gozlem_girdiler.gozlemfrekans_ag_havai IS 'Yıllık gözlem sayısı';
          public          postgres    false    235            �            1259    16925    gozlem_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.gozlem_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.gozlem_girdiler_id_seq;
       public          postgres    false    235                       0    0    gozlem_girdiler_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.gozlem_girdiler_id_seq OWNED BY public.gozlem_girdiler.id;
          public          postgres    false    236            �            1259    16927    ilceler    TABLE     �  CREATE TABLE public.ilceler (
    id integer NOT NULL,
    ilce_id integer NOT NULL,
    sehir_id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    ilce character varying NOT NULL,
    yil integer NOT NULL,
    alan_toplam double precision DEFAULT 0 NOT NULL,
    "Alan_Mrk" double precision DEFAULT 0 NOT NULL,
    nufus_kirsal_2012 bigint DEFAULT 0 NOT NULL,
    nufus_belde_2012 bigint DEFAULT 0 NOT NULL,
    nufus_belde_1844_2012 bigint DEFAULT 0 NOT NULL,
    nufus_belde_4611_2012 bigint DEFAULT 0 NOT NULL,
    nufus_merkez_2012 bigint DEFAULT 0 NOT NULL,
    nufus_toplam_2016 bigint DEFAULT 0 NOT NULL,
    abone_sayisi_ag bigint DEFAULT 0 NOT NULL,
    abone_sayisi_og bigint DEFAULT 0 NOT NULL,
    abone_sayisi_mesken bigint DEFAULT 0 NOT NULL,
    abone_sayisi_ticarethane bigint DEFAULT 0 NOT NULL,
    abone_sayisi_sanayi bigint DEFAULT 0 NOT NULL,
    abone_sayisi_tarimsal_sulama bigint DEFAULT 0 NOT NULL,
    abone_sayisi_genel_aydinlatma bigint DEFAULT 0 NOT NULL,
    abone_sayisi_diger bigint DEFAULT 0 NOT NULL,
    osos_sayisi_tarimsal_sulama bigint DEFAULT 0 NOT NULL,
    osos_sayisi_genel_aydinlatma bigint DEFAULT 0 NOT NULL,
    osos_sayisi_diger bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_monofaze bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_trifaze bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_kombi_mesken bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_kombi_diger bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_ag_x5 bigint DEFAULT 0 NOT NULL,
    sayac_sayisi_og_x5 bigint DEFAULT 0 NOT NULL,
    ilce_merkezine_ulasim_suresi double precision DEFAULT 0 NOT NULL,
    ilce_sinirina_ulasim_suresi double precision DEFAULT 0 NOT NULL,
    ilce_merkezine_sinirina_uzaklik double precision DEFAULT 0 NOT NULL,
    ilce_sinirina_uzaklik double precision DEFAULT 0 NOT NULL,
    ilce_merkezine_kus_ucusu_uzaklik double precision DEFAULT 0 NOT NULL,
    merkez_cluster_egim double precision DEFAULT 0 NOT NULL,
    kirsal_cluster double precision DEFAULT 0 NOT NULL,
    merkez_alanlarin_ortalama_egim_degerleri double precision DEFAULT 0 NOT NULL,
    ilce_idari_sinirlari_genel_egimi_derece double precision DEFAULT 0 NOT NULL,
    yurume_hizi_merkez double precision DEFAULT 0 NOT NULL,
    yurume_hizi_kirsal double precision DEFAULT 0 NOT NULL,
    belde_sayisi_2012 bigint DEFAULT 0 NOT NULL,
    belde_sayisi_nufus_1844_2012 bigint DEFAULT 0 NOT NULL,
    belde_sayisi_nufus_4611_2012 bigint DEFAULT 0 NOT NULL,
    koy_ve_belde_sayisi bigint DEFAULT 0 NOT NULL,
    en_buyuk_koye_sure double precision DEFAULT 0 NOT NULL,
    kayip_kacak_orani double precision DEFAULT 0 NOT NULL,
    ilce_merkezi_siniri_kus_ucusu double precision DEFAULT 0 NOT NULL,
    agac_direk_sayisi_ag_musterek_haric bigint DEFAULT 0 NOT NULL,
    agac_direk_sayisi_musterek bigint DEFAULT 0 NOT NULL,
    agac_direk_sayisi_og_musterek_haric bigint DEFAULT 0 NOT NULL,
    beton_direk_sayisi_ag_musterek_haric bigint DEFAULT 0 NOT NULL,
    beton_direk_sayisi_musterek bigint DEFAULT 0 NOT NULL,
    beton_direk_sayisi_og_musterek_haric bigint DEFAULT 0 NOT NULL,
    demir_direk_sayisi_ag_musterek_haric bigint DEFAULT 0 NOT NULL,
    demir_direk_sayisi_musterek bigint DEFAULT 0 NOT NULL,
    demir_direk_sayisi_og_musterek_haric bigint DEFAULT 0 NOT NULL,
    aydinlatma_diregi_sadece_aydinlatma_munferit bigint DEFAULT 0 NOT NULL,
    aydinlatma_diregi_musterek bigint DEFAULT 0 NOT NULL,
    aydinlatma_diregi_armatur_sayisi bigint DEFAULT 0 NOT NULL,
    havai_hat_uzunlugu_ag_sirket double precision DEFAULT 0 NOT NULL,
    havai_hat_uzunlugu_ag_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    havai_hat_uzunlugu_og_sirket double precision DEFAULT 0 NOT NULL,
    havai_hat_uzunlugu_og_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    yeralti_hat_uzunlugu_ag_sirket double precision DEFAULT 0 NOT NULL,
    yeralti_hat_uzunlugu_ag_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    yeralti_hat_uzunlugu_og_sirket double precision DEFAULT 0 NOT NULL,
    yeralti_hat_uzunlugu_og_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    acik_salt_bina_sayisi bigint DEFAULT 0 NOT NULL,
    "acik_salt_hücre_sayisi" bigint DEFAULT 0 NOT NULL,
    moduler_bina_sayisi bigint DEFAULT 0 NOT NULL,
    "moduler_hücre_sayisi" bigint DEFAULT 0 NOT NULL,
    bina_ici_trafo_kuru_tip_trafo_sayisi bigint DEFAULT 0 NOT NULL,
    bina_ici_trafo_yagli_tip_trafo_sayisi bigint DEFAULT 0 NOT NULL,
    bina_ici_trafo_guc_trafo_sayisi bigint DEFAULT 0 NOT NULL,
    dut_kuru_tip_trafo_sayisi bigint DEFAULT 0 NOT NULL,
    dut_yagli_tip_trafo_sayisi bigint DEFAULT 0 NOT NULL,
    sdk_sayisi bigint DEFAULT 0 NOT NULL,
    havai_arti_yeralti_kablo_tedas_ag_sirket double precision DEFAULT 0 NOT NULL,
    havai_arti_yeralti_kablo_tedas_ag_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    havai_arti_yeralti_kablo_tedas_og_sirket double precision DEFAULT 0 NOT NULL,
    havai_arti_yeralti_kablo_tedas_og_ucuncu_sahis double precision DEFAULT 0 NOT NULL,
    yeni_abonelik_acma_sayisi bigint DEFAULT 0 NOT NULL,
    "yeniBaglanti_BasvuruProje_AG" bigint DEFAULT 0 NOT NULL,
    "yeniBaglanti_BasvuruProje_OG" bigint DEFAULT 0 NOT NULL,
    "yeniBaglantiSayac_AG" bigint DEFAULT 0 NOT NULL,
    "yeniBaglantiSayac_OG" bigint DEFAULT 0 NOT NULL,
    ilk_evrak_red_basvuru_sayisi_ag bigint DEFAULT 0 NOT NULL,
    ilk_evrak_red_basvuru_sayisi_og bigint DEFAULT 0 NOT NULL,
    enerji_musade_surecinde_red_basvuru_sayisi_ag bigint DEFAULT 0 NOT NULL,
    enerji_musade_surecinde_red_basvuru_sayisi_og bigint DEFAULT 0 NOT NULL,
    proje_onayinda_red_basvuru_sayisi_ag bigint DEFAULT 0 NOT NULL,
    proje_onayinda_red_basvuru_sayisi_og bigint DEFAULT 0 NOT NULL,
    tesisat_muayene_sirasinda_red_proje_sayisi_ag bigint DEFAULT 0 NOT NULL,
    tesisat_muayene_sirasinda_red_proje_sayisi_og bigint DEFAULT 0 NOT NULL,
    dagitima_giren_toplam_enerji double precision DEFAULT 0 NOT NULL,
    faturalanan_enerji_miktari double precision DEFAULT 0 NOT NULL,
    kayip_orani double precision DEFAULT 0 NOT NULL,
    uc_g_iyi_yesil smallint DEFAULT 0 NOT NULL,
    uc_g_orta smallint DEFAULT 0 NOT NULL,
    uc_g_kotu_kirmizi smallint DEFAULT 0 NOT NULL,
    uc_g_veri_yok smallint DEFAULT 0 NOT NULL,
    ilce_siniri_kus_ucusu double precision DEFAULT 0 NOT NULL,
    "Guc_DegisiklikBasvurusu_AG" double precision DEFAULT 0 NOT NULL,
    "Guc_DegisiklikBasvurusu_OG" double precision DEFAULT 0 NOT NULL,
    kesmesayisi_ag_mesken_borc bigint DEFAULT 0 NOT NULL,
    kesmesayisi_ag_diger_borc bigint DEFAULT 0 NOT NULL,
    kesmesayisi_ag_borcharici bigint DEFAULT 0 NOT NULL,
    acmasayisi_ag bigint DEFAULT 0 NOT NULL,
    kesmesayisi_og_borc bigint DEFAULT 0 NOT NULL,
    acmasayisi_og bigint DEFAULT 0 NOT NULL,
    trafikkatsayisi_mrk double precision DEFAULT 0 NOT NULL,
    sosyaletki_varyok boolean DEFAULT false NOT NULL,
    kofresayisi_mrk bigint DEFAULT 0 NOT NULL,
    kofresayisi_kir bigint DEFAULT 0 NOT NULL,
    sayacsayisi_damgayilindandegisecek bigint DEFAULT 0 NOT NULL,
    gunes_potansiyel double precision DEFAULT 0 NOT NULL,
    gunes_kuruluguc double precision DEFAULT 0 NOT NULL,
    dagitikuretim_santralsayisi double precision DEFAULT 0 NOT NULL,
    kesmesayisi_og_diger double precision DEFAULT 0 NOT NULL,
    musteri_mrk double precision DEFAULT 0 NOT NULL,
    musteri_kir double precision DEFAULT 0 NOT NULL,
    dagitikuretim_basvuru_mesken double precision DEFAULT 0 NOT NULL,
    dagitikuretim_basvuru_diger double precision DEFAULT 0 NOT NULL,
    trafo_sayisi_ucuncu_sahis double precision DEFAULT 0 NOT NULL
);
    DROP TABLE public.ilceler;
       public         heap    postgres    false                       0    0    COLUMN ilceler."Alan_Mrk"    COMMENT     Q   COMMENT ON COLUMN public.ilceler."Alan_Mrk" IS 'km2 olarak ilçe merkez alanı';
          public          postgres    false    237                       0    0 )   COLUMN ilceler.kesmesayisi_ag_mesken_borc    COMMENT     t   COMMENT ON COLUMN public.ilceler.kesmesayisi_ag_mesken_borc IS 'Mesken müşteri yıllık borçtan kesme sayısı';
          public          postgres    false    237                       0    0 (   COLUMN ilceler.kesmesayisi_ag_diger_borc    COMMENT     �   COMMENT ON COLUMN public.ilceler.kesmesayisi_ag_diger_borc IS 'Mesken harici AG müşterilerin yıllık borçtan kesme sayısı';
          public          postgres    false    237                       0    0 (   COLUMN ilceler.kesmesayisi_ag_borcharici    COMMENT     j   COMMENT ON COLUMN public.ilceler.kesmesayisi_ag_borcharici IS 'Borç harici AG müşteri kesme sayısı';
          public          postgres    false    237                       0    0    COLUMN ilceler.acmasayisi_ag    COMMENT     �   COMMENT ON COLUMN public.ilceler.acmasayisi_ag IS 'Yıllık toplam açma sayısı (borç ödemesi sonrası, yeni abonelik, vb.)';
          public          postgres    false    237                       0    0 "   COLUMN ilceler.kesmesayisi_og_borc    COMMENT     _   COMMENT ON COLUMN public.ilceler.kesmesayisi_og_borc IS 'Yıllık OG borçtan kesme sayısı';
          public          postgres    false    237                       0    0    COLUMN ilceler.acmasayisi_og    COMMENT     X   COMMENT ON COLUMN public.ilceler.acmasayisi_og IS 'Yıllık OG açma işlemi sayısı';
          public          postgres    false    237                       0    0 "   COLUMN ilceler.trafikkatsayisi_mrk    COMMENT     ]   COMMENT ON COLUMN public.ilceler.trafikkatsayisi_mrk IS 'İlçe merkezi trafik katsayısı';
          public          postgres    false    237                       0    0     COLUMN ilceler.sosyaletki_varyok    COMMENT     `   COMMENT ON COLUMN public.ilceler.sosyaletki_varyok IS 'Sosyal etki olup olmadığı anahtarı';
          public          postgres    false    237                       0    0 1   COLUMN ilceler.sayacsayisi_damgayilindandegisecek    COMMENT     �   COMMENT ON COLUMN public.ilceler.sayacsayisi_damgayilindandegisecek IS '10 yıllık kullanım süresi dolmuş ve yıl içinde değişecek sayaç sayısı';
          public          postgres    false    237                       0    0    COLUMN ilceler.gunes_potansiyel    COMMENT     e   COMMENT ON COLUMN public.ilceler.gunes_potansiyel IS 'kWh/m2 cinsinden, PVGIS''ten alınan veriler';
          public          postgres    false    237                       0    0    COLUMN ilceler.gunes_kuruluguc    COMMENT     X   COMMENT ON COLUMN public.ilceler.gunes_kuruluguc IS 'MW cinsinden mevcut kurulu güç';
          public          postgres    false    237                       0    0 #   COLUMN ilceler.kesmesayisi_og_diger    COMMENT     R   COMMENT ON COLUMN public.ilceler.kesmesayisi_og_diger IS 'OG borç harici kesme';
          public          postgres    false    237                       0    0 +   COLUMN ilceler.dagitikuretim_basvuru_mesken    COMMENT     p   COMMENT ON COLUMN public.ilceler.dagitikuretim_basvuru_mesken IS 'Mesken dağıtık üretim başvuru sayısı';
          public          postgres    false    237                        0    0 *   COLUMN ilceler.dagitikuretim_basvuru_diger    COMMENT     l   COMMENT ON COLUMN public.ilceler.dagitikuretim_basvuru_diger IS 'Mesken harici yıllık başvuru sayısı';
          public          postgres    false    237            �            1259    17053    ilceler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ilceler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.ilceler_id_seq;
       public          postgres    false    237            !           0    0    ilceler_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.ilceler_id_seq OWNED BY public.ilceler.id;
          public          postgres    false    238            �            1259    17055    it_girdiler    TABLE     4  CREATE TABLE public.it_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    dag_fir_id integer,
    altyapipersonel_kacbilgisayar integer DEFAULT 200 NOT NULL,
    cihazbakim_kacpersonel integer DEFAULT 1500 NOT NULL,
    vtyonetim_personel integer DEFAULT 3 NOT NULL,
    sunucuyonetim_personel integer DEFAULT 7 NOT NULL,
    haberlesmepersonel_kacilce integer DEFAULT 20 NOT NULL,
    envanterpersonel_kacbilgisayar integer DEFAULT 1000 NOT NULL,
    konfigyonetim_personel integer DEFAULT 13 NOT NULL,
    isgucupersonel_kacpersonel integer DEFAULT 1000 NOT NULL,
    sistemidame_personel integer DEFAULT 25 NOT NULL,
    sondestekpersonel_kacbilgisayar integer DEFAULT 200 NOT NULL,
    siberguvenlik_personel integer DEFAULT 6 NOT NULL,
    "isuygulamaları_personel" integer DEFAULT 6 NOT NULL,
    iszekasi_personel_min integer DEFAULT 2 NOT NULL,
    iszekasi_personel_max integer DEFAULT 10 NOT NULL,
    projeyonetim_personel integer DEFAULT 2 NOT NULL,
    guvenlikopmrk_personel integer DEFAULT 7 NOT NULL,
    sebekekopmrk_personel integer DEFAULT 7 NOT NULL,
    lisansbedeli double precision DEFAULT 0.22 NOT NULL,
    cloudbirimbedeli double precision DEFAULT 0.75 NOT NULL,
    haberlesmebirimbedeli double precision DEFAULT 0.75 NOT NULL,
    it_capex double precision DEFAULT 10000000 NOT NULL
);
    DROP TABLE public.it_girdiler;
       public         heap    postgres    false            �            1259    17079    it_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.it_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.it_girdiler_id_seq;
       public          postgres    false    239            "           0    0    it_girdiler_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.it_girdiler_id_seq OWNED BY public.it_girdiler.id;
          public          postgres    false    240            �            1259    17081    kacak_tarama_girdiler    TABLE     �  CREATE TABLE public.kacak_tarama_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    "KontrolSuresi_Monofaze" double precision DEFAULT 5 NOT NULL,
    "KontrolSuresi_X5_AG" double precision DEFAULT 25 NOT NULL,
    "KontrolSuresi_X5_OG" double precision DEFAULT 75 NOT NULL,
    "TutanakSuresi" double precision DEFAULT 15 NOT NULL,
    "KontrolSuresi_Ilave_Yuzde20Uzeri" double precision DEFAULT 1.5 NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 9 NOT NULL,
    "aktifCalismaOrani_Mrk" double precision DEFAULT 0.7 NOT NULL,
    "aktifCalismaOrani_Kir" double precision DEFAULT 0.65 NOT NULL,
    "aylikMesaiGunu" double precision DEFAULT 18.875 NOT NULL,
    "EsikDeger_KKOrani_Min" double precision DEFAULT 0.08 NOT NULL,
    "EsikDeger_KKOrani_Max" double precision DEFAULT 0.40 NOT NULL,
    "sosyalEtki_MaxUtilizasyonKaybi" double precision DEFAULT 0.20 NOT NULL,
    "KacakMusteriOrani_KayipOraninaGore" double precision DEFAULT 0.75 NOT NULL,
    "EkipYapisi_OGHatTarama" double precision DEFAULT 2 NOT NULL,
    "Tarama_OGHat_Gunluk_km" double precision DEFAULT 8 NOT NULL,
    "Tarama_OGHat_AySayisi" double precision DEFAULT 9 NOT NULL,
    "Frekans_Baz_Monofaze" double precision DEFAULT 0.1 NOT NULL,
    "Frekans_Max_Monofaze" double precision DEFAULT 1 NOT NULL,
    "Frekans_Baz_Trifaze" double precision DEFAULT 0.1 NOT NULL,
    "Frekans_Max_Trifaze" double precision DEFAULT 1 NOT NULL,
    "Frekans_Baz_Kombi_X5Harici" double precision DEFAULT 0.1 NOT NULL,
    "Frekans_Max_Kombi_X5Harici" double precision DEFAULT 1 NOT NULL,
    "Frekans_Baz_X5_AG" double precision DEFAULT 2 NOT NULL,
    "Frekans_Max_X5_AG" double precision DEFAULT 4 NOT NULL,
    "Frekans_Baz_X5_OG" double precision DEFAULT 2 NOT NULL,
    "Frekans_Max_X5_OG" double precision DEFAULT 4 NOT NULL,
    "isEmriAlmaSuresi" double precision DEFAULT 20 NOT NULL,
    "EkipYapisi_Baz" double precision DEFAULT 2 NOT NULL,
    "EkipYapisi_Max" double precision DEFAULT 3 NOT NULL,
    "KontrolSuresi_trifaze" double precision DEFAULT 5 NOT NULL,
    "Kontrolsuresi_Kombi_x5harici" double precision DEFAULT 5 NOT NULL,
    esikdeger_kk_ilavepersonel double precision DEFAULT 0.2 NOT NULL,
    koordinator_yonetilen_ekipsayisi double precision DEFAULT 10 NOT NULL,
    tahakkuksuresi_tarimsal double precision DEFAULT 30 NOT NULL,
    tahakkuksuresi_tarimsalharic double precision DEFAULT 20 NOT NULL,
    aktifcalismaorani_ofis double precision DEFAULT 0.8 NOT NULL,
    tahakkuk_kontrolsuresi double precision DEFAULT 2 NOT NULL,
    tahakkuk_dosyahazirlamasuresi double precision DEFAULT 30 NOT NULL,
    tahakkuk_itirazorani double precision DEFAULT 0.9 NOT NULL,
    tahakkuk_itirazcevaplamasuresi double precision DEFAULT 18 NOT NULL,
    mahsuplasma_suresi double precision DEFAULT 7.2 NOT NULL,
    dag_fir_id integer,
    tarama_oghat_saatlik_km double precision DEFAULT 3.5 NOT NULL,
    cks_personeli double precision DEFAULT 0 NOT NULL
);
 )   DROP TABLE public.kacak_tarama_girdiler;
       public         heap    postgres    false            #           0    0 7   COLUMN kacak_tarama_girdiler.esikdeger_kk_ilavepersonel    COMMENT     �   COMMENT ON COLUMN public.kacak_tarama_girdiler.esikdeger_kk_ilavepersonel IS '%20 üzerindeki kayıp oranlarında ekibe ilave 1 personel ekleniyor.';
          public          postgres    false    241            $           0    0 3   COLUMN kacak_tarama_girdiler.tahakkuk_kontrolsuresi    COMMENT     y   COMMENT ON COLUMN public.kacak_tarama_girdiler.tahakkuk_kontrolsuresi IS 'Kaçak tahakkuk faturaların kontrol süresi';
          public          postgres    false    241            %           0    0 1   COLUMN kacak_tarama_girdiler.tahakkuk_itirazorani    COMMENT     �   COMMENT ON COLUMN public.kacak_tarama_girdiler.tahakkuk_itirazorani IS 'Müşterilerin ne kadarının tahakkuklara itiraz edeceği';
          public          postgres    false    241            &           0    0 /   COLUMN kacak_tarama_girdiler.mahsuplasma_suresi    COMMENT     j   COMMENT ON COLUMN public.kacak_tarama_girdiler.mahsuplasma_suresi IS 'Diğer (mahsuplaşma, vb.) işler';
          public          postgres    false    241            �            1259    17127    kacak_tarama_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kacak_tarama_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.kacak_tarama_girdiler_id_seq;
       public          postgres    false    241            '           0    0    kacak_tarama_girdiler_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.kacak_tarama_girdiler_id_seq OWNED BY public.kacak_tarama_girdiler.id;
          public          postgres    false    242            �            1259    17129    yagisli_gun_sayisi_data    TABLE     �  CREATE TABLE public.yagisli_gun_sayisi_data (
    id integer NOT NULL,
    year integer NOT NULL,
    sehir_id integer NOT NULL,
    ocak double precision DEFAULT 0 NOT NULL,
    subat double precision DEFAULT 0 NOT NULL,
    mart double precision DEFAULT 0 NOT NULL,
    nisan double precision DEFAULT 0 NOT NULL,
    mayis double precision DEFAULT 0 NOT NULL,
    haziran double precision DEFAULT 0 NOT NULL,
    temmuz double precision DEFAULT 0 NOT NULL,
    agustos double precision DEFAULT 0 NOT NULL,
    eylul double precision DEFAULT 0 NOT NULL,
    ekim double precision DEFAULT 0 NOT NULL,
    kasim double precision DEFAULT 0 NOT NULL,
    aralik double precision DEFAULT 0 NOT NULL
);
 +   DROP TABLE public.yagisli_gun_sayisi_data;
       public         heap    postgres    false            �            1259    17144    kar_at_maks_yagis    VIEW     �  CREATE VIEW public.kar_at_maks_yagis AS
 SELECT foo.sehir_id,
    foo.maxcolname,
    foo.maxcolval,
    (f.column_name_outer / (31.0)::double precision) AS maks
   FROM ( SELECT yagisli_gun_sayisi_data.sehir_id,
            l.maxcolname,
            l.maxcolval
           FROM public.yagisli_gun_sayisi_data,
            LATERAL ( VALUES ('ocak'::text,COALESCE(yagisli_gun_sayisi_data.ocak, (0)::double precision)), ('subat'::text,COALESCE(yagisli_gun_sayisi_data.subat, (0)::double precision)), ('mart'::text,COALESCE(yagisli_gun_sayisi_data.mart, (0)::double precision)), ('nisan'::text,COALESCE(yagisli_gun_sayisi_data.nisan, (0)::double precision)), ('mayis'::text,COALESCE(yagisli_gun_sayisi_data.mayis, (0)::double precision)), ('haziran'::text,COALESCE(yagisli_gun_sayisi_data.haziran, (0)::double precision)), ('temmuz'::text,COALESCE(yagisli_gun_sayisi_data.temmuz, (0)::double precision)), ('agustos'::text,COALESCE(yagisli_gun_sayisi_data.agustos, (0)::double precision)), ('eylul'::text,COALESCE(yagisli_gun_sayisi_data.eylul, (0)::double precision)), ('ekim'::text,COALESCE(yagisli_gun_sayisi_data.ekim, (0)::double precision)), ('kasim'::text,COALESCE(yagisli_gun_sayisi_data.kasim, (0)::double precision)), ('aralik'::text,COALESCE(yagisli_gun_sayisi_data.aralik, (0)::double precision))
                  ORDER BY "*VALUES*".column2 DESC
                 LIMIT 1) l(maxcolname, maxcolval)) foo,
    LATERAL public.get_kar_at_max_yagis(foo.sehir_id, (foo.maxcolname)::character varying) f(id, column_name_outer);
 $   DROP VIEW public.kar_at_maks_yagis;
       public          postgres    false    243    243    243    243    243    243    243    243    243    333    243    243    243    243            �            1259    17149    kar_buz_ortulu_gun_sayisi_data    TABLE     �  CREATE TABLE public.kar_buz_ortulu_gun_sayisi_data (
    id integer NOT NULL,
    year integer NOT NULL,
    sehir_id integer NOT NULL,
    ocak double precision DEFAULT 0 NOT NULL,
    subat double precision DEFAULT 0 NOT NULL,
    mart double precision DEFAULT 0 NOT NULL,
    nisan double precision DEFAULT 0 NOT NULL,
    mayis double precision DEFAULT 0 NOT NULL,
    haziran double precision DEFAULT 0 NOT NULL,
    temmuz double precision DEFAULT 0 NOT NULL,
    agustos double precision DEFAULT 0 NOT NULL,
    eylul double precision DEFAULT 0 NOT NULL,
    ekim double precision DEFAULT 0 NOT NULL,
    kasim double precision DEFAULT 0 NOT NULL,
    aralik double precision DEFAULT 0 NOT NULL
);
 2   DROP TABLE public.kar_buz_ortulu_gun_sayisi_data;
       public         heap    postgres    false            �            1259    17164 %   kar_buz_ortulu_gun_sayisi_data_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kar_buz_ortulu_gun_sayisi_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.kar_buz_ortulu_gun_sayisi_data_id_seq;
       public          postgres    false    245            (           0    0 %   kar_buz_ortulu_gun_sayisi_data_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.kar_buz_ortulu_gun_sayisi_data_id_seq OWNED BY public.kar_buz_ortulu_gun_sayisi_data.id;
          public          postgres    false    246            �            1259    17166    kar_buz_ortulu_gun_sayisi_view    VIEW       CREATE VIEW public.kar_buz_ortulu_gun_sayisi_view AS
 SELECT kar_buz_ortulu_gun_sayisi_data.sehir_id,
    kar_buz_ortulu_gun_sayisi_data.ocak,
    kar_buz_ortulu_gun_sayisi_data.subat,
    kar_buz_ortulu_gun_sayisi_data.mart,
    kar_buz_ortulu_gun_sayisi_data.nisan,
    kar_buz_ortulu_gun_sayisi_data.mayis,
    kar_buz_ortulu_gun_sayisi_data.haziran,
    kar_buz_ortulu_gun_sayisi_data.temmuz,
    kar_buz_ortulu_gun_sayisi_data.agustos,
    kar_buz_ortulu_gun_sayisi_data.eylul,
    kar_buz_ortulu_gun_sayisi_data.ekim,
    kar_buz_ortulu_gun_sayisi_data.kasim,
    kar_buz_ortulu_gun_sayisi_data.aralik,
    (((((((((((COALESCE(kar_buz_ortulu_gun_sayisi_data.ocak, (0)::double precision) + COALESCE(kar_buz_ortulu_gun_sayisi_data.subat, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.mart, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.nisan, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.mayis, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.haziran, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.temmuz, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.agustos, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.eylul, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.ekim, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.kasim, (0)::double precision)) + COALESCE(kar_buz_ortulu_gun_sayisi_data.aralik, (0)::double precision)) AS sum_,
    (((((((((((((COALESCE(kar_buz_ortulu_gun_sayisi_data.ocak, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.subat, (0)::double precision) * ((1.0 / (28)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.mart, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.nisan, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.mayis, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.haziran, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.temmuz, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.agustos, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.eylul, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.ekim, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.kasim, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(kar_buz_ortulu_gun_sayisi_data.aralik, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) AS avg_,
    (GREATEST(kar_buz_ortulu_gun_sayisi_data.ocak, kar_buz_ortulu_gun_sayisi_data.subat, kar_buz_ortulu_gun_sayisi_data.mart, kar_buz_ortulu_gun_sayisi_data.nisan, kar_buz_ortulu_gun_sayisi_data.mayis, kar_buz_ortulu_gun_sayisi_data.haziran, kar_buz_ortulu_gun_sayisi_data.temmuz, kar_buz_ortulu_gun_sayisi_data.agustos, kar_buz_ortulu_gun_sayisi_data.eylul, kar_buz_ortulu_gun_sayisi_data.ekim, kar_buz_ortulu_gun_sayisi_data.kasim, kar_buz_ortulu_gun_sayisi_data.aralik) / (31.0)::double precision) AS max_
   FROM public.kar_buz_ortulu_gun_sayisi_data;
 1   DROP VIEW public.kar_buz_ortulu_gun_sayisi_view;
       public          postgres    false    245    245    245    245    245    245    245    245    245    245    245    245    245            �            1259    17171    kar_buz_yuku_etkeni_constant    TABLE       CREATE TABLE public.kar_buz_yuku_etkeni_constant (
    id integer NOT NULL,
    dag_fir_id integer DEFAULT 0 NOT NULL,
    ortulu_gun_sayisi double precision DEFAULT 0 NOT NULL,
    ortulu_gun_sayisina_gore double precision DEFAULT 0 NOT NULL,
    max_ortulu_gun_sayisi double precision DEFAULT 0 NOT NULL,
    etken_max_ortulu_gun_sayisina_gore double precision DEFAULT 0 NOT NULL,
    max_ortulu_gun_sayisina_gore double precision DEFAULT 0 NOT NULL,
    ortalama_ortulu_gun_sayisi double precision DEFAULT 0 NOT NULL
);
 0   DROP TABLE public.kar_buz_yuku_etkeni_constant;
       public         heap    postgres    false            �            1259    17181 #   kar_buz_yuku_etkeni_constant_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kar_buz_yuku_etkeni_constant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.kar_buz_yuku_etkeni_constant_id_seq;
       public          postgres    false    248            )           0    0 #   kar_buz_yuku_etkeni_constant_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.kar_buz_yuku_etkeni_constant_id_seq OWNED BY public.kar_buz_yuku_etkeni_constant.id;
          public          postgres    false    249            �            1259    17183    kesme_acma_girdiler    TABLE     �  CREATE TABLE public.kesme_acma_girdiler (
    id integer NOT NULL,
    "sayacOkumaSuresi" double precision DEFAULT 0.25 NOT NULL,
    "ISG_Suresi" double precision DEFAULT 1 NOT NULL,
    "AG_KesmeAcmaSuresi" double precision DEFAULT 3.8 NOT NULL,
    "OG_KesmeAcmaSuresi" double precision DEFAULT 8.0 NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 9.0 NOT NULL,
    "aktifCalismaOrani_Mrk" double precision DEFAULT 0.7 NOT NULL,
    "aktifCalismaOrani_Kir" double precision DEFAULT 0.65 NOT NULL,
    "aylikMesaiGunu" double precision DEFAULT 18.875 NOT NULL,
    "isEmriAlmaSuresi" double precision DEFAULT 20 NOT NULL,
    "ekipYapisi_AG" double precision DEFAULT 2 NOT NULL,
    "ekipYapisi_OG" double precision DEFAULT 2 NOT NULL,
    "uzaktan_KesmeAcmaOrani_AG" double precision DEFAULT 0 NOT NULL,
    "uzaktan_KesmeAcmaOrani_OG" double precision DEFAULT 0 NOT NULL,
    "sosyalEtki_MinKayipOraniEsikDegeri" double precision DEFAULT 0.08 NOT NULL,
    "sosyalEtki_MaxUtilizasyonKaybi" double precision DEFAULT 0.20 NOT NULL,
    "sosyaletki_Maxkayiporaniesikdegeri" double precision DEFAULT 0.40 NOT NULL,
    sosyaletkiminutilizasyonkaybi double precision DEFAULT 0.0 NOT NULL,
    sosyalmukavemetsuresi_mesken double precision DEFAULT 1 NOT NULL,
    sosyalmukavemetsuresi_ag_diger double precision DEFAULT 3 NOT NULL,
    sosyalmukavemetsuresi_og double precision DEFAULT 5.0 NOT NULL,
    koordinator_kacekipbasina double precision DEFAULT 10 NOT NULL,
    minziyaret_mrk double precision DEFAULT 30 NOT NULL,
    minziyaret_kir double precision DEFAULT 15 NOT NULL,
    dag_fir_id integer,
    fkb_katsayisi double precision DEFAULT 5 NOT NULL,
    fkb_min double precision DEFAULT 0.0 NOT NULL,
    fkb_max double precision DEFAULT 0.02 NOT NULL
);
 '   DROP TABLE public.kesme_acma_girdiler;
       public         heap    postgres    false            *           0    0 -   COLUMN kesme_acma_girdiler."sayacOkumaSuresi"    COMMENT     l   COMMENT ON COLUMN public.kesme_acma_girdiler."sayacOkumaSuresi" IS 'dakika olarak son endeks alma süresi';
          public          postgres    false    250            +           0    0 ?   COLUMN kesme_acma_girdiler."sosyaletki_Maxkayiporaniesikdegeri"    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler."sosyaletki_Maxkayiporaniesikdegeri" IS 'Sosyal Etkinin hangi kayip oranından sonra artmayacağı';
          public          postgres    false    250            ,           0    0 8   COLUMN kesme_acma_girdiler.sosyaletkiminutilizasyonkaybi    COMMENT     k   COMMENT ON COLUMN public.kesme_acma_girdiler.sosyaletkiminutilizasyonkaybi IS 'minimum sosyal etki orani';
          public          postgres    false    250            -           0    0 7   COLUMN kesme_acma_girdiler.sosyalmukavemetsuresi_mesken    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler.sosyalmukavemetsuresi_mesken IS 'Mesken müşterilerin borçtan kesme için ortalama mukavemet süresi';
          public          postgres    false    250            .           0    0 9   COLUMN kesme_acma_girdiler.sosyalmukavemetsuresi_ag_diger    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler.sosyalmukavemetsuresi_ag_diger IS 'AG Ticarethane ve sanayi müşterilerin ortalama bekletme/mukavemet süresi';
          public          postgres    false    250            /           0    0 3   COLUMN kesme_acma_girdiler.sosyalmukavemetsuresi_og    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler.sosyalmukavemetsuresi_og IS 'OG müşterilerin borçtan kesmeye mukavemet süresi';
          public          postgres    false    250            0           0    0 )   COLUMN kesme_acma_girdiler.minziyaret_mrk    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler.minziyaret_mrk IS 'Merkez müşteriler için ayda en az kaç ziyaret gerçekleştirileceği';
          public          postgres    false    250            1           0    0 )   COLUMN kesme_acma_girdiler.minziyaret_kir    COMMENT     �   COMMENT ON COLUMN public.kesme_acma_girdiler.minziyaret_kir IS 'Kırsal müşteriler için ayda en az kaç ziyaret gerçekleştirileceği';
          public          postgres    false    250            �            1259    17212    kesme_acma_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kesme_acma_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.kesme_acma_girdiler_id_seq;
       public          postgres    false    250            2           0    0    kesme_acma_girdiler_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.kesme_acma_girdiler_id_seq OWNED BY public.kesme_acma_girdiler.id;
          public          postgres    false    251            �            1259    17214    meteoroloji    TABLE     �   CREATE TABLE public.meteoroloji (
    id integer NOT NULL,
    sehir_id integer NOT NULL,
    sicaklik_nem_etkisi double precision DEFAULT 0 NOT NULL,
    kar_ortusu_yagis_etkisi double precision DEFAULT 0 NOT NULL
);
    DROP TABLE public.meteoroloji;
       public         heap    postgres    false            �            1259    17219    meteoroloji_id_seq    SEQUENCE     �   CREATE SEQUENCE public.meteoroloji_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.meteoroloji_id_seq;
       public          postgres    false    252            3           0    0    meteoroloji_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.meteoroloji_id_seq OWNED BY public.meteoroloji.id;
          public          postgres    false    253            �            1259    17221    onarim_gercek_yas_constant    TABLE     v   CREATE TABLE public.onarim_gercek_yas_constant (
    id integer NOT NULL,
    gercek_yas double precision NOT NULL
);
 .   DROP TABLE public.onarim_gercek_yas_constant;
       public         heap    postgres    false            �            1259    17224 !   onarim_gercek_yas_constant_id_seq    SEQUENCE     �   CREATE SEQUENCE public.onarim_gercek_yas_constant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.onarim_gercek_yas_constant_id_seq;
       public          postgres    false    254            4           0    0 !   onarim_gercek_yas_constant_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.onarim_gercek_yas_constant_id_seq OWNED BY public.onarim_gercek_yas_constant.id;
          public          postgres    false    255                        1259    17226    onarim_girdiler_constants    TABLE     �  CREATE TABLE public.onarim_girdiler_constants (
    id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    envanter_id integer NOT NULL,
    ekonomik_omur double precision NOT NULL,
    major_arizanin_hangi_yasa_kadar_kumulatif_oldugu double precision NOT NULL,
    major_otuz_yasa_kadar_ekipman_degisim_orani double precision NOT NULL,
    "minor_otuz_yasa_kadar_ekipman_onarim_ihtiyacı_orani" double precision NOT NULL,
    yeni_ekipman_ile_otuz_yas_ekipman_ariza_kati double precision NOT NULL,
    birim_bedel_major double precision DEFAULT 0 NOT NULL,
    birim_bedel_minor double precision DEFAULT 0 NOT NULL,
    birim double precision DEFAULT 0 NOT NULL,
    yas_0_5 double precision DEFAULT 0 NOT NULL,
    yas_6_10 double precision DEFAULT 0 NOT NULL,
    yas_11_15 double precision DEFAULT 0 NOT NULL,
    yas_16_20 double precision DEFAULT 0 NOT NULL,
    yas_21_25 double precision DEFAULT 0 NOT NULL,
    yas_26_30 double precision DEFAULT 0 NOT NULL,
    yas_31_35 double precision DEFAULT 0 NOT NULL,
    yas_36_40 double precision DEFAULT 0 NOT NULL,
    yas_gt_40 double precision DEFAULT 0 NOT NULL,
    c_constant double precision DEFAULT 0 NOT NULL
);
 -   DROP TABLE public.onarim_girdiler_constants;
       public         heap    postgres    false                       1259    17242     onarim_girdiler_constants_id_seq    SEQUENCE     �   CREATE SEQUENCE public.onarim_girdiler_constants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.onarim_girdiler_constants_id_seq;
       public          postgres    false    256            5           0    0     onarim_girdiler_constants_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.onarim_girdiler_constants_id_seq OWNED BY public.onarim_girdiler_constants.id;
          public          postgres    false    257                       1259    17244    onarim_girdiler_envanter    TABLE     �   CREATE TABLE public.onarim_girdiler_envanter (
    id integer NOT NULL,
    envanter_id integer NOT NULL,
    envanter_name character varying,
    hat_trafo_bilgisi character varying
);
 ,   DROP TABLE public.onarim_girdiler_envanter;
       public         heap    postgres    false                       1259    17250    onarim_girdiler_envanter_id_seq    SEQUENCE     �   CREATE SEQUENCE public.onarim_girdiler_envanter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.onarim_girdiler_envanter_id_seq;
       public          postgres    false    258            6           0    0    onarim_girdiler_envanter_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.onarim_girdiler_envanter_id_seq OWNED BY public.onarim_girdiler_envanter.id;
          public          postgres    false    259                       1259    17252     onarim_sirket_hat_trafo_percents    TABLE     �  CREATE TABLE public.onarim_sirket_hat_trafo_percents (
    id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    hat double precision NOT NULL,
    trafo double precision NOT NULL,
    minor_ariza_orani_max double precision DEFAULT 0 NOT NULL,
    major_ariza_orani_max double precision DEFAULT 0 NOT NULL,
    minor_onarim_bedeli_iscilik double precision DEFAULT 0 NOT NULL,
    minor_onarim_bedeli_malzeme double precision DEFAULT 0 NOT NULL,
    major_arizalarin_yuzde_kacina_minor_ariza_uygulanacagi double precision DEFAULT 0 NOT NULL,
    major_onarim_orani_opex_30_40 double precision DEFAULT 0 NOT NULL,
    major_onarim_orani_opex_gt_40 double precision DEFAULT 0 NOT NULL,
    maliyetorani_personel double precision DEFAULT 0.25 NOT NULL
);
 4   DROP TABLE public.onarim_sirket_hat_trafo_percents;
       public         heap    postgres    false                       1259    17263 '   onarim_sirket_hat_trafo_percents_id_seq    SEQUENCE     �   CREATE SEQUENCE public.onarim_sirket_hat_trafo_percents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.onarim_sirket_hat_trafo_percents_id_seq;
       public          postgres    false    260            7           0    0 '   onarim_sirket_hat_trafo_percents_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.onarim_sirket_hat_trafo_percents_id_seq OWNED BY public.onarim_sirket_hat_trafo_percents.id;
          public          postgres    false    261                       1259    17265    ot_girdiler    TABLE     �  CREATE TABLE public.ot_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    dag_fir_id integer,
    sebekeyonetimpersonel_sabit integer DEFAULT 8 NOT NULL,
    sebekeyonetimpersonel_ilbasina double precision DEFAULT 1 NOT NULL,
    scadaoperator_kactrafo integer DEFAULT 3000 NOT NULL,
    scadailetisim_personel integer DEFAULT 1 NOT NULL,
    enerjikaliteyonetim_min integer DEFAULT 2 NOT NULL,
    enerjikaliteyonetim_max integer DEFAULT 4 NOT NULL,
    sekondersaha_kacdm integer DEFAULT 750 NOT NULL,
    sekonderrole_min integer DEFAULT 2 NOT NULL,
    sekonderrole_max integer DEFAULT 4 NOT NULL,
    kesintiyonetim_sabit integer DEFAULT 4 NOT NULL,
    kesintiyonetim_kacmusteri integer DEFAULT 350000 NOT NULL,
    otplanlama_min integer DEFAULT 3 NOT NULL,
    otplanlama_max integer DEFAULT 6 NOT NULL,
    sondestek_personel integer DEFAULT 1 NOT NULL,
    ososyonetim_sabit integer DEFAULT 3 NOT NULL,
    ososyayginlastirma_min integer DEFAULT 2 NOT NULL,
    ososyayginlastirma_max integer DEFAULT 4 NOT NULL,
    ososbakim_kacosos integer DEFAULT 1000 NOT NULL,
    ososdestek_kacosos integer DEFAULT 1000 NOT NULL,
    osossistem_personel integer DEFAULT 2 NOT NULL
);
    DROP TABLE public.ot_girdiler;
       public         heap    postgres    false                       1259    17288    ot_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ot_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.ot_girdiler_id_seq;
       public          postgres    false    262            8           0    0    ot_girdiler_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.ot_girdiler_id_seq OWNED BY public.ot_girdiler.id;
          public          postgres    false    263                       1259    17290    sebeke_ariza_girdiler    TABLE     �  CREATE TABLE public.sebeke_ariza_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    dag_fir_id integer,
    arizasayisi_vardiya integer DEFAULT 2 NOT NULL,
    gunlukmesaisuresi double precision DEFAULT 7.5 NOT NULL,
    aktifcalismaorani double precision DEFAULT 0.3 NOT NULL,
    aylikmesaigunu double precision DEFAULT 22.2 NOT NULL,
    arizagidermesuresi double precision DEFAULT 30 NOT NULL,
    aracbasinaekipsayisi double precision DEFAULT 2.33 NOT NULL,
    koordinator_kacekipbasina double precision DEFAULT 10 NOT NULL,
    ekipyapisi double precision DEFAULT 2 NOT NULL,
    malzeme_maliyet_orani double precision DEFAULT 0.005 NOT NULL,
    soforsayisi_ekipbasina double precision DEFAULT 0 NOT NULL
);
 )   DROP TABLE public.sebeke_ariza_girdiler;
       public         heap    postgres    false            	           1259    17303    sebeke_ariza_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sebeke_ariza_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sebeke_ariza_girdiler_id_seq;
       public          postgres    false    264            9           0    0    sebeke_ariza_girdiler_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sebeke_ariza_girdiler_id_seq OWNED BY public.sebeke_ariza_girdiler.id;
          public          postgres    false    265            
           1259    17305    sebeke_isletme_girdiler    TABLE     �  CREATE TABLE public.sebeke_isletme_girdiler (
    id integer NOT NULL,
    year_ integer NOT NULL,
    dag_fir_id integer,
    varlikdevir_min integer DEFAULT 2 NOT NULL,
    varlikdevir_max integer DEFAULT 4 NOT NULL,
    denetim_min integer DEFAULT 5 NOT NULL,
    denetim_max integer DEFAULT 10 NOT NULL,
    aydinlatma_min integer DEFAULT 5 NOT NULL,
    aydinlatma_max integer DEFAULT 10 NOT NULL,
    varlikyonetim_min integer DEFAULT 2 NOT NULL,
    varlikyonetim_max integer DEFAULT 4 NOT NULL
);
 +   DROP TABLE public.sebeke_isletme_girdiler;
       public         heap    postgres    false                       1259    17316    sebeke_isletme_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sebeke_isletme_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.sebeke_isletme_girdiler_id_seq;
       public          postgres    false    266            :           0    0    sebeke_isletme_girdiler_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.sebeke_isletme_girdiler_id_seq OWNED BY public.sebeke_isletme_girdiler.id;
          public          postgres    false    267                       1259    17319    sehirler    TABLE     �   CREATE TABLE public.sehirler (
    id integer NOT NULL,
    sehir_id integer NOT NULL,
    dag_fir_id integer NOT NULL,
    sehir character varying NOT NULL,
    plaka integer
);
    DROP TABLE public.sehirler;
       public         heap    postgres    false                       1259    17325    sehirler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sehirler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sehirler_id_seq;
       public          postgres    false    268            ;           0    0    sehirler_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sehirler_id_seq OWNED BY public.sehirler.id;
          public          postgres    false    269                       1259    17327    trafik    TABLE     �   CREATE TABLE public.trafik (
    id integer NOT NULL,
    sehir_id integer NOT NULL,
    trafik double precision DEFAULT 1 NOT NULL
);
    DROP TABLE public.trafik;
       public         heap    postgres    false                       1259    17331    trafik_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trafik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.trafik_id_seq;
       public          postgres    false    270            <           0    0    trafik_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.trafik_id_seq OWNED BY public.trafik.id;
          public          postgres    false    271                       1259    17333    yagis_at_maks_kar    VIEW     Z  CREATE VIEW public.yagis_at_maks_kar AS
 SELECT foo.sehir_id,
    foo.maxcolname,
    foo.maxcolval,
    (f.column_name_outer / (31)::double precision) AS maks
   FROM ( SELECT kar_buz_ortulu_gun_sayisi_data.sehir_id,
            l.maxcolname,
            l.maxcolval
           FROM public.kar_buz_ortulu_gun_sayisi_data,
            LATERAL ( VALUES ('ocak'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.ocak, (0)::double precision)), ('subat'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.subat, (0)::double precision)), ('mart'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.mart, (0)::double precision)), ('nisan'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.nisan, (0)::double precision)), ('mayis'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.mayis, (0)::double precision)), ('haziran'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.haziran, (0)::double precision)), ('temmuz'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.temmuz, (0)::double precision)), ('agustos'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.agustos, (0)::double precision)), ('eylul'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.eylul, (0)::double precision)), ('ekim'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.ekim, (0)::double precision)), ('kasim'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.kasim, (0)::double precision)), ('aralik'::text,COALESCE(kar_buz_ortulu_gun_sayisi_data.aralik, (0)::double precision))
                  ORDER BY "*VALUES*".column2 DESC
                 LIMIT 1) l(maxcolname, maxcolval)) foo,
    LATERAL public.get_yagis_at_max_kar(foo.sehir_id, (foo.maxcolname)::character varying) f(id, column_name_outer);
 $   DROP VIEW public.yagis_at_maks_kar;
       public          postgres    false    245    245    245    245    245    245    245    337    245    245    245    245    245    245                       1259    17338    yagisli_gun_sayisi_view    VIEW     �  CREATE VIEW public.yagisli_gun_sayisi_view AS
 SELECT a.sehir_id,
    a.ocak,
    a.subat,
    a.mart,
    a.nisan,
    a.mayis,
    a.haziran,
    a.temmuz,
    a.agustos,
    a.eylul,
    a.ekim,
    a.kasim,
    a.aralik,
    (((((((((((COALESCE(a.ocak, (0)::double precision) + COALESCE(a.subat, (0)::double precision)) + COALESCE(a.mart, (0)::double precision)) + COALESCE(a.nisan, (0)::double precision)) + COALESCE(a.mayis, (0)::double precision)) + COALESCE(a.haziran, (0)::double precision)) + COALESCE(a.temmuz, (0)::double precision)) + COALESCE(a.agustos, (0)::double precision)) + COALESCE(a.eylul, (0)::double precision)) + COALESCE(a.ekim, (0)::double precision)) + COALESCE(a.kasim, (0)::double precision)) + COALESCE(a.aralik, (0)::double precision)) AS sum_,
    (((((((((((((COALESCE(a.ocak, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision) + ((COALESCE(a.subat, (0)::double precision) * ((1.0 / (28)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.mart, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.nisan, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.mayis, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.haziran, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.temmuz, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.agustos, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.eylul, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.ekim, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.kasim, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.aralik, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) AS ort_,
    (GREATEST(a.ocak, a.subat, a.mart, a.nisan, a.mayis, a.haziran, a.temmuz, a.agustos, a.eylul, a.ekim, a.kasim, a.aralik) / (31.0)::double precision) AS max_,
    ((((1)::double precision + ((((((((((((((COALESCE(a.ocak, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision) + ((COALESCE(a.subat, (0)::double precision) * ((1.0 / (28)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.mart, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.nisan, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.mayis, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.haziran, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.temmuz, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.agustos, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.eylul, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.ekim, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.kasim, (0)::double precision) * ((1.0 / (30)::numeric))::double precision) / (12.0)::double precision)) + ((COALESCE(a.aralik, (0)::double precision) * ((1.0 / (31)::numeric))::double precision) / (12.0)::double precision)) * ( SELECT girdiler.yagmurlu_gun_sayisi_etkisi
           FROM public.girdiler))) + ((1)::double precision + (b.avg_ * ( SELECT girdiler.karli_gun_sayisi_etkisi
           FROM public.girdiler)))) - (1)::double precision) AS kar_arti_yagis_faktoru,
    b.max_ AS maksimum_kar,
    c.maks AS kar_at_max_yagis,
    d.maks AS yagis_at_max_kar
   FROM (((public.yagisli_gun_sayisi_data a
     LEFT JOIN public.kar_buz_ortulu_gun_sayisi_view b ON ((a.sehir_id = b.sehir_id)))
     LEFT JOIN ( SELECT kar_at_maks_yagis.sehir_id,
            kar_at_maks_yagis.maxcolname,
            kar_at_maks_yagis.maxcolval,
            kar_at_maks_yagis.maks
           FROM public.kar_at_maks_yagis) c ON ((a.sehir_id = c.sehir_id)))
     LEFT JOIN ( SELECT yagis_at_maks_kar.sehir_id,
            yagis_at_maks_kar.maxcolname,
            yagis_at_maks_kar.maxcolval,
            yagis_at_maks_kar.maks
           FROM public.yagis_at_maks_kar) d ON ((a.sehir_id = d.sehir_id)))
  ORDER BY a.sehir_id;
 *   DROP VIEW public.yagisli_gun_sayisi_view;
       public          postgres    false    243    227    227    243    243    243    243    243    243    243    243    243    243    243    243    244    244    244    244    247    247    247    272    272    272    272                       1259    17344    yagisli_gun_sayisi_ara_cikti    VIEW     h  CREATE VIEW public.yagisli_gun_sayisi_ara_cikti AS
 SELECT a.sehir_id,
    ((1)::double precision + (b.avg_ * ( SELECT girdiler.karli_gun_sayisi_etkisi
           FROM public.girdiler))) AS ara_cikti_no_name
   FROM (public.yagisli_gun_sayisi_view a
     LEFT JOIN public.kar_buz_ortulu_gun_sayisi_view b ON ((a.sehir_id = b.sehir_id)))
  ORDER BY a.sehir_id;
 /   DROP VIEW public.yagisli_gun_sayisi_ara_cikti;
       public          postgres    false    227    247    247    273                       1259    17349 &   yagisli_gun_sayisi_converted_from_view    TABLE        CREATE TABLE public.yagisli_gun_sayisi_converted_from_view (
    sehir_id integer,
    ocak double precision DEFAULT 0 NOT NULL,
    subat double precision DEFAULT 0 NOT NULL,
    mart double precision DEFAULT 0 NOT NULL,
    nisan double precision DEFAULT 0 NOT NULL,
    mayis double precision DEFAULT 0 NOT NULL,
    haziran double precision DEFAULT 0 NOT NULL,
    temmuz double precision DEFAULT 0 NOT NULL,
    agustos double precision DEFAULT 0 NOT NULL,
    eylul double precision DEFAULT 0 NOT NULL,
    ekim double precision DEFAULT 0 NOT NULL,
    kasim double precision DEFAULT 0 NOT NULL,
    aralik double precision DEFAULT 0 NOT NULL,
    sum_ double precision DEFAULT 0 NOT NULL,
    ort_ double precision DEFAULT 0 NOT NULL,
    max_ double precision DEFAULT 0 NOT NULL,
    kar_arti_yagis_faktoru double precision DEFAULT 0 NOT NULL,
    maksimum_kar double precision DEFAULT 0 NOT NULL,
    kar_at_max_yagis double precision DEFAULT 0 NOT NULL,
    yagis_at_max_kar double precision DEFAULT 0 NOT NULL
);
 :   DROP TABLE public.yagisli_gun_sayisi_converted_from_view;
       public         heap    postgres    false                       1259    17371    yagisli_gun_sayisi_data_id_seq    SEQUENCE     �   CREATE SEQUENCE public.yagisli_gun_sayisi_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.yagisli_gun_sayisi_data_id_seq;
       public          postgres    false    243            =           0    0    yagisli_gun_sayisi_data_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.yagisli_gun_sayisi_data_id_seq OWNED BY public.yagisli_gun_sayisi_data.id;
          public          postgres    false    276                       1259    17373    yeni_baglanti_girdiler    TABLE        CREATE TABLE public.yeni_baglanti_girdiler (
    id integer NOT NULL,
    dag_fir_id integer,
    "aylikMesaiGunu" double precision DEFAULT 18.875 NOT NULL,
    "gunlukMesaiSuresi" double precision DEFAULT 9.0 NOT NULL,
    "aktifCalismaOrani" double precision DEFAULT 0.7 NOT NULL,
    "EkipYapisi_EnerjiMusadesi_Saha" double precision DEFAULT 2 NOT NULL,
    "EkipYapisi_TesisatMuayene_AG_Saha" double precision DEFAULT 2 NOT NULL,
    "EkipYapisi_TesisatMuayene_OG_Saha" double precision DEFAULT 2 NOT NULL,
    "EnerjiMusadesi_SahayaGitmemeOrani_AG" double precision DEFAULT 0.1 NOT NULL,
    "EnerjiMusadesi_SahayaGidilmediginde_Ofis_Ek_Sure" double precision DEFAULT 5 NOT NULL,
    "Basvuru_Kontrol_Suresi" double precision DEFAULT 10 NOT NULL,
    "Basvuru_RedOrani_AG" double precision DEFAULT 0.2 NOT NULL,
    "Basvuru_RedOrani_OG" double precision DEFAULT 0.2 NOT NULL,
    "Proje_OnaySuresi_AG" double precision DEFAULT 20 NOT NULL,
    "Proje_OnaySuresi_OG" double precision DEFAULT 30 NOT NULL,
    "Proje_RedOrani_AG" double precision DEFAULT 0.2 NOT NULL,
    "Proje_RedOrani_OG" double precision DEFAULT 0.2 NOT NULL,
    "EnerjiMusadesi_SahaSuresi_AG" double precision DEFAULT 30 NOT NULL,
    "EnerjiMusadesi_SahaSuresi_OG" double precision DEFAULT 30 NOT NULL,
    "EnerjiMusadesi_OfisSuresi_AG" double precision DEFAULT 15 NOT NULL,
    "EnerjiMusadesi_OfisSuresi_OG" double precision DEFAULT 30 NOT NULL,
    "EnerjiMusadesi_RedOrani_AG" double precision DEFAULT 0 NOT NULL,
    "EnerjiMusadesi_RedOrani_OG" double precision DEFAULT 0 NOT NULL,
    "BaglantiAnlasmasi_Sure_Sabit" double precision DEFAULT 0 NOT NULL,
    "BaglantiAnlasmasi_Sure_SayacBasina" double precision DEFAULT 10 NOT NULL,
    "TesisatMuayene_SahaSuresi_AG_Sabit" double precision DEFAULT 10 NOT NULL,
    "TesisatMuayene_SahaSuresi_AG_SayacBasina" double precision DEFAULT 5 NOT NULL,
    "TesisatMuayene_SahaSuresi_OG_Sabit" double precision DEFAULT 50 NOT NULL,
    "TesisatMuayene_OfisSuresi_AG" double precision DEFAULT 15 NOT NULL,
    "TesisatMuayene_OfisSuresi_OG" double precision DEFAULT 30 NOT NULL,
    "TesisatMuayene_RedOrani_AG" double precision DEFAULT 0.4 NOT NULL,
    "TesisatMuayene_RedOrani_OG" double precision DEFAULT 0.8 NOT NULL,
    "AnaVeri_GirisSuresi_Sabit" double precision DEFAULT 5 NOT NULL,
    "AnaVeri_GirisSuresi_SayacBasina" double precision DEFAULT 5 NOT NULL,
    enerjimusadesi_sahayagitmemeorani_og double precision DEFAULT 0.1 NOT NULL,
    tesisatmuayene_sahasuresi_og_sayacbasina double precision DEFAULT 10 NOT NULL,
    minziyaret_mrk double precision DEFAULT 0 NOT NULL,
    minziyaret_kir double precision DEFAULT 0 NOT NULL,
    enerji_musadesi_red_orani_ag double precision DEFAULT 0.2 NOT NULL,
    tesisat_muayene_red_orani_og double precision DEFAULT 0.5 NOT NULL
);
 *   DROP TABLE public.yeni_baglanti_girdiler;
       public         heap    postgres    false            >           0    0 P   COLUMN yeni_baglanti_girdiler."EnerjiMusadesi_SahayaGidilmediginde_Ofis_Ek_Sure"    COMMENT     l   COMMENT ON COLUMN public.yeni_baglanti_girdiler."EnerjiMusadesi_SahayaGidilmediginde_Ofis_Ek_Sure" IS 'dk';
          public          postgres    false    277            ?           0    0 B   COLUMN yeni_baglanti_girdiler.enerjimusadesi_sahayagitmemeorani_og    COMMENT     �   COMMENT ON COLUMN public.yeni_baglanti_girdiler.enerjimusadesi_sahayagitmemeorani_og IS 'Enerji müsadeleri için sahaya gitmeme oranı (CBS üzerinden karar oranı)';
          public          postgres    false    277                       1259    17414    yeni_baglanti_girdiler_id_seq    SEQUENCE     �   CREATE SEQUENCE public.yeni_baglanti_girdiler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.yeni_baglanti_girdiler_id_seq;
       public          postgres    false    277            @           0    0    yeni_baglanti_girdiler_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.yeni_baglanti_girdiler_id_seq OWNED BY public.yeni_baglanti_girdiler.id;
          public          postgres    false    278            �           2604    17416    bakim_girdiler id    DEFAULT     v   ALTER TABLE ONLY public.bakim_girdiler ALTER COLUMN id SET DEFAULT nextval('public.bakim_girdiler_id_seq'::regclass);
 @   ALTER TABLE public.bakim_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    203            �           2604    17417 '   bakim_modeli_islem_tablosu_constants id    DEFAULT     �   ALTER TABLE ONLY public.bakim_modeli_islem_tablosu_constants ALTER COLUMN id SET DEFAULT nextval('public.bakim_modeli_islem_tablosu_constants_id_seq'::regclass);
 V   ALTER TABLE public.bakim_modeli_islem_tablosu_constants ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    207            �           2604    17418    bakim_modeli_varlik_carpani id    DEFAULT     �   ALTER TABLE ONLY public.bakim_modeli_varlik_carpani ALTER COLUMN id SET DEFAULT nextval('public.bakim_modeli_varlik_carpani_id_seq'::regclass);
 M   ALTER TABLE public.bakim_modeli_varlik_carpani ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212            �           2604    17419    cbs_girdiler id    DEFAULT     r   ALTER TABLE ONLY public.cbs_girdiler ALTER COLUMN id SET DEFAULT nextval('public.cbs_girdiler_id_seq'::regclass);
 >   ALTER TABLE public.cbs_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    17420    dagitik_uretim_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.dagitik_uretim_girdiler ALTER COLUMN id SET DEFAULT nextval('public.dagitik_uretim_girdiler_id_seq'::regclass);
 I   ALTER TABLE public.dagitik_uretim_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    17421    dagitim_firmalari id    DEFAULT     |   ALTER TABLE ONLY public.dagitim_firmalari ALTER COLUMN id SET DEFAULT nextval('public.dagitim_firmalari_id_seq'::regclass);
 C   ALTER TABLE public.dagitim_firmalari ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219                       2604    17422    endex_okuma_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.endex_okuma_girdiler ALTER COLUMN id SET DEFAULT nextval('public.endex_okuma_girdiler_id_seq'::regclass);
 F   ALTER TABLE public.endex_okuma_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            -           2604    17423    genel_aydinlatma_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.genel_aydinlatma_girdiler ALTER COLUMN id SET DEFAULT nextval('public.genel_aydinlatma_girdiler_id_seq'::regclass);
 K   ALTER TABLE public.genel_aydinlatma_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    17424    genel_yonetim_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.genel_yonetim_girdiler ALTER COLUMN id SET DEFAULT nextval('public.genel_yonetim_girdiler_id_seq'::regclass);
 H   ALTER TABLE public.genel_yonetim_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            �           2604    17425    girdiler id    DEFAULT     j   ALTER TABLE ONLY public.girdiler ALTER COLUMN id SET DEFAULT nextval('public.girdiler_id_seq'::regclass);
 :   ALTER TABLE public.girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            �           2604    17426    girdiler_money id    DEFAULT     v   ALTER TABLE ONLY public.girdiler_money ALTER COLUMN id SET DEFAULT nextval('public.girdiler_money_id_seq'::regclass);
 @   ALTER TABLE public.girdiler_money ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            �           2604    17427    girdiler_sayac_islemleri id    DEFAULT     �   ALTER TABLE ONLY public.girdiler_sayac_islemleri ALTER COLUMN id SET DEFAULT nextval('public.girdiler_sayac_islemleri_id_seq'::regclass);
 J   ALTER TABLE public.girdiler_sayac_islemleri ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231            �           2604    17428    girdilertum id    DEFAULT     p   ALTER TABLE ONLY public.girdilertum ALTER COLUMN id SET DEFAULT nextval('public.girdilertum_id_seq'::regclass);
 =   ALTER TABLE public.girdilertum ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233            %           2604    17429    gozlem_girdiler id    DEFAULT     x   ALTER TABLE ONLY public.gozlem_girdiler ALTER COLUMN id SET DEFAULT nextval('public.gozlem_girdiler_id_seq'::regclass);
 A   ALTER TABLE public.gozlem_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235            �           2604    17430 
   ilceler id    DEFAULT     h   ALTER TABLE ONLY public.ilceler ALTER COLUMN id SET DEFAULT nextval('public.ilceler_id_seq'::regclass);
 9   ALTER TABLE public.ilceler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237            �           2604    17431    it_girdiler id    DEFAULT     p   ALTER TABLE ONLY public.it_girdiler ALTER COLUMN id SET DEFAULT nextval('public.it_girdiler_id_seq'::regclass);
 =   ALTER TABLE public.it_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239            �           2604    17432    kacak_tarama_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.kacak_tarama_girdiler ALTER COLUMN id SET DEFAULT nextval('public.kacak_tarama_girdiler_id_seq'::regclass);
 G   ALTER TABLE public.kacak_tarama_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    242    241            �           2604    17433 !   kar_buz_ortulu_gun_sayisi_data id    DEFAULT     �   ALTER TABLE ONLY public.kar_buz_ortulu_gun_sayisi_data ALTER COLUMN id SET DEFAULT nextval('public.kar_buz_ortulu_gun_sayisi_data_id_seq'::regclass);
 P   ALTER TABLE public.kar_buz_ortulu_gun_sayisi_data ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    246    245            �           2604    17434    kar_buz_yuku_etkeni_constant id    DEFAULT     �   ALTER TABLE ONLY public.kar_buz_yuku_etkeni_constant ALTER COLUMN id SET DEFAULT nextval('public.kar_buz_yuku_etkeni_constant_id_seq'::regclass);
 N   ALTER TABLE public.kar_buz_yuku_etkeni_constant ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    249    248                       2604    17435    kesme_acma_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.kesme_acma_girdiler ALTER COLUMN id SET DEFAULT nextval('public.kesme_acma_girdiler_id_seq'::regclass);
 E   ALTER TABLE public.kesme_acma_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    251    250                       2604    17436    meteoroloji id    DEFAULT     p   ALTER TABLE ONLY public.meteoroloji ALTER COLUMN id SET DEFAULT nextval('public.meteoroloji_id_seq'::regclass);
 =   ALTER TABLE public.meteoroloji ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    253    252            !           2604    17437    onarim_gercek_yas_constant id    DEFAULT     �   ALTER TABLE ONLY public.onarim_gercek_yas_constant ALTER COLUMN id SET DEFAULT nextval('public.onarim_gercek_yas_constant_id_seq'::regclass);
 L   ALTER TABLE public.onarim_gercek_yas_constant ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    255    254            /           2604    17438    onarim_girdiler_constants id    DEFAULT     �   ALTER TABLE ONLY public.onarim_girdiler_constants ALTER COLUMN id SET DEFAULT nextval('public.onarim_girdiler_constants_id_seq'::regclass);
 K   ALTER TABLE public.onarim_girdiler_constants ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    257    256            0           2604    17439    onarim_girdiler_envanter id    DEFAULT     �   ALTER TABLE ONLY public.onarim_girdiler_envanter ALTER COLUMN id SET DEFAULT nextval('public.onarim_girdiler_envanter_id_seq'::regclass);
 J   ALTER TABLE public.onarim_girdiler_envanter ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    259    258            1           2604    17440 #   onarim_sirket_hat_trafo_percents id    DEFAULT     �   ALTER TABLE ONLY public.onarim_sirket_hat_trafo_percents ALTER COLUMN id SET DEFAULT nextval('public.onarim_sirket_hat_trafo_percents_id_seq'::regclass);
 R   ALTER TABLE public.onarim_sirket_hat_trafo_percents ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    261    260            N           2604    17441    ot_girdiler id    DEFAULT     p   ALTER TABLE ONLY public.ot_girdiler ALTER COLUMN id SET DEFAULT nextval('public.ot_girdiler_id_seq'::regclass);
 =   ALTER TABLE public.ot_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    263    262            O           2604    17442    sebeke_ariza_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.sebeke_ariza_girdiler ALTER COLUMN id SET DEFAULT nextval('public.sebeke_ariza_girdiler_id_seq'::regclass);
 G   ALTER TABLE public.sebeke_ariza_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    265    264            Z           2604    17443    sebeke_isletme_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.sebeke_isletme_girdiler ALTER COLUMN id SET DEFAULT nextval('public.sebeke_isletme_girdiler_id_seq'::regclass);
 I   ALTER TABLE public.sebeke_isletme_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    267    266            c           2604    17444    sehirler id    DEFAULT     j   ALTER TABLE ONLY public.sehirler ALTER COLUMN id SET DEFAULT nextval('public.sehirler_id_seq'::regclass);
 :   ALTER TABLE public.sehirler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    269    268            d           2604    17445 	   trafik id    DEFAULT     f   ALTER TABLE ONLY public.trafik ALTER COLUMN id SET DEFAULT nextval('public.trafik_id_seq'::regclass);
 8   ALTER TABLE public.trafik ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    271    270            �           2604    17446    yagisli_gun_sayisi_data id    DEFAULT     �   ALTER TABLE ONLY public.yagisli_gun_sayisi_data ALTER COLUMN id SET DEFAULT nextval('public.yagisli_gun_sayisi_data_id_seq'::regclass);
 I   ALTER TABLE public.yagisli_gun_sayisi_data ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    276    243            �           2604    17447    yeni_baglanti_girdiler id    DEFAULT     �   ALTER TABLE ONLY public.yeni_baglanti_girdiler ALTER COLUMN id SET DEFAULT nextval('public.yeni_baglanti_girdiler_id_seq'::regclass);
 H   ALTER TABLE public.yeni_baglanti_girdiler ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    278    277            �          0    16443    bakim_girdiler 
   TABLE DATA           �  COPY public.bakim_girdiler (id, gunlukmesaisuresi, aktifcalismaorani, aylikmesaigunu, "og_hat_yürümekatsayisi", isemrialmasuresi, bakimfrekans_ag_havai, bakimfrekans_ayd, bakimfrekans_bina, bakimfrekans_dut, bakimfrekans_og_havai, bakimfrekans_sdk, bakim_ekipyapisi_aghat, bakim_ekipyapisi_ayd, bakim_ekipyapisi_bina, bakim_ekipyapisi_dut, bakim_ekipyapisi_oghat, bakim_ekipyapisi_sdk, dag_fir_id, bakimsure_ag_agacdirek, bakimsure_ag_demirdirek, bakimsure_ag_betondirek, bakimsure_ayd_armatur, bakimsure_ayd_direk, bakimsure_bina_aciksalt, bakimsure_hucre_aciksalt, bakimsure_trafo_yagli, bakimsure_bina_moduler, bakimsure_hucre_moduler, bakimsure_trafo_kuru, bakimsure_guctrafo, bakimsure_dut, bakimsure_og_agacdirek, bakimsure_og_demirdirek, bakimsure_og_betondirek, bakimsure_sdk, koordinator_ekipbasina, bakimoncesi_manevrasuresi, hatbakimioncesi_topraklama, hatbakimisonrasi_topraklamaalma, aydbakimi_panosuresi, ekipsefi_kacekipicin, karligun_utilizasyonkaybi) FROM stdin;
    public          postgres    false    203   �D      �          0    16489    bakim_modeli_girdiler 
   TABLE DATA           �	  COPY public.bakim_modeli_girdiler (id, senaryo, gunluk_mesai_suresi, personel_utilizasyon_orani, "aylik_mesai_günü", "yillik_calisma_günü", saatlik_ortalama_hiz, saatlik_ortalama_kisa_mesafe_hiz, "arac_akaryakit_tüketimi_gözlem", "arac_akaryakit_tüketimi_sepetli", "og_havai_hat_yürüyüs_indirgeme_katsayisi", "arac_indi_bindi_süresi", "is_emri_alma_süresi", bakim_oncesi_enerji_kesintisi_ve_manevra_icin_beklenilmesi, "hat_bakimi_oncesi_topraklama_yapilmasi_icin_gecen_süre", hat_bakimi_sonrasi_topraklama_kablosunun_alinmasi, personelin_sepetli_araci_sabitlemesi_ekipman_almasi_isg_onlemle, iki_direk_arasi_mesafe, ag_durdurucu_direk_orani, og_durdurucu_direk_orani, ayirici_sayisi, parafudr_sayisi, kar_ortulu_gun_etkisi_uygulanmasi, "planlı_bakim_ag_havai_hat", "planlı_bakim_aydinlatma", "planlı_bakim_bina", "planlı_bakim_direk_ustu_trafo", "planlı_bakim_og_havai_hat", "planlı_bakim_saha_dagitim_kutusu", gozlem_ag_havai_hat, gozlem_aydinlatma, gozlem_bina, gozlem_direk_ustu_trafo, gozlem_og_havai_hat, gozlem_saha_dagitim_kutusu, ag_agac_direkler_saglamlik_test_periyodu, ag_beton_direkler_saglamlik_test_periyodu, og_agac_direkler_saglamlik_test_periyodu, og_beton_direkler_saglamlik_test_periyodu, "planlı_bakim_ag_havai_hat_ekipteki_personel_sayisi", "planlı_bakim_aydinlatma_ekipteki_personel_sayisi", "planlı_bakim_bina_ekipteki_personel_sayisi", "planlı_bakim_direk_ustu_trafo_ekipteki_personel_sayisi", "planlı_bakim_og_havai_hat_ekipteki_personel_sayisi", "planlı_bakim_saha_dagitim_kutusu_ekipteki_personel_sayisi", gozlem_ag_havai_hat_ekipteki_personel_sayisi, gozlem_aydinlatma_ekipteki_personel_sayisi, gozlem_bina_ekipteki_personel_sayisi, gozlem_direk_ustu_trafo_ekipteki_personel_sayisi, gozlem_og_havai_hat_ekipteki_personel_sayisi, gozlem_saha_dagitim_kutusu_ekipteki_personel_sayisi, "planlı_bakim_ag_havai_hat_aktif_calisan_sayisi", "planlı_bakim_aydinlatma_aktif_calisan_sayisi", "planlı_bakim_bina_aktif_calisan_sayisi", "planlı_bakim_direk_ustu_trafo_aktif_calisan_sayisi", "planlı_bakim_og_havai_hat_aktif_calisan_sayisi", "planlı_bakim_saha_dagitim_kutusu_aktif_calisan_sayisi", gozlem_ag_havai_hat_aktif_calisan_sayisi, gozlem_aydinlatma_aktif_calisan_sayisi, gozlem_bina_aktif_calisan_sayisi, gozlem_direk_ustu_trafo_aktif_calisan_sayisi, gozlem_og_havai_hat_aktif_calisan_sayisi, gozlem_saha_dagitim_kutusu_aktif_calisan_sayisi, "direk_ustu_yagli_tip_dagitim_trafosu_oranı", dag_fir_id) FROM stdin;
    public          postgres    false    205   �E      �          0    16495 $   bakim_modeli_islem_tablosu_constants 
   TABLE DATA           @  COPY public.bakim_modeli_islem_tablosu_constants (id, "gozlem_bakımın_uygulanacagi_varlık_orani", "bakım_turu", ekipman, ekipman_alt_tipi, ekipman_alt_tipi_2, "bakım_isi", envanter, enerji_kesintisi_gerekiyor_mu, "birim_islem_süresi", "is_suresi_iki_kisiye_bolunebilir_mi_baska_isle_paralel_yapılab") FROM stdin;
    public          postgres    false    207   >F      �          0    16513    bakim_modeli_lut_eszamanlilik 
   TABLE DATA           I   COPY public.bakim_modeli_lut_eszamanlilik (id, eszamanlilik) FROM stdin;
    public          postgres    false    211   �g      �          0    16519    bakim_modeli_varlik_carpani 
   TABLE DATA           u   COPY public.bakim_modeli_varlik_carpani (id, surec, ilgili_varlik, varlik_carpani, varlik_carpani_label) FROM stdin;
    public          postgres    false    212   hh      �          0    16527    cbs_girdiler 
   TABLE DATA           �   COPY public.cbs_girdiler (id, year_, dag_fir_id, verioperator_capex, planlama_min, planlama_max, verikontrolofis_kacoperator, verikontrolsaha_capex, sondestek_kactrafo, baglantidegisim_kactrafo, diger_personel) FROM stdin;
    public          postgres    false    214   Uk      �          0    16540    dagitik_uretim_girdiler 
   TABLE DATA           (  COPY public.dagitik_uretim_girdiler (id, dag_fir_id, "gunlukMesaiSuresi", "aktifCalismaOrani_Mrk", "aktifCalismaOrani_Kir", "aylikMesaiGunu", onkabul_sure_mesken, gecicikabul_sure_mesken, onkabul_red_orani, ofis_kabul_sure_mesken, ofis_kabul_sure_diger, ofis_red_sure_mesken, ofis_red_sure_diger, ofis_mahsuplasma_suresi, basvuru_imdatgrubu_aylik, hedef_kuruluguc_mw, hedef_mesken_payi, hedef_diger_payi, gecicikabul_red_orani, paylasimorani_binasayisi, paylasimorani_guneslenme, paylasimorani_mevcutguc, "isEmriAlmaSuresi", onkabul_sure_diger, gecicikabul_sure_diger, basvuru_birimkuruluguc_mesken, basvuru_birimkuruluguc_diger, paylasimorani_sanayiticaret, paylasimorani_tarimsal, ekipyapisi_onkabul, ekipyapisi_gecicikabul, ofis_digerisler_sure, ofis_basvuru_red_orani, onkabul_ziyaret_orani) FROM stdin;
    public          postgres    false    216   �k      �          0    16577    dagitik_uretim_il_girdiler 
   TABLE DATA           �   COPY public.dagitik_uretim_il_girdiler (id, sehir_id, dag_fir_id, sehir, yearly_pv_energy_production, sege_2011, bin_kisi_endeksi, kurulu_guc_2016, pay_2016, kurulu_guc_2017, pay_2017, edas_toplam) FROM stdin;
    public          postgres    false    218   �l      �          0    16583    dagitim_firmalari 
   TABLE DATA             COPY public.dagitim_firmalari (id, dag_fir_id, dag_fir, explanation, opex_2019, capex_2019, depo_sayisi, kik_tabi, hissedarsayisi_gt100, kacakbolgesi, cagrimerkezi_personel, "güvenlikpersoneli", sebekearizapersoneli, yatirim_opex_maliyeti, capex) FROM stdin;
    public          postgres    false    219   �u      �          0    16602    endex_okuma_girdiler 
   TABLE DATA           4  COPY public.endex_okuma_girdiler (id, year_, "sayacOkumaSuresi", "veriAkisSuresi", "gunlukMesaiSuresi", "aktifCalismaOrani_Mrk", "aktifCalismaOrani_Kir", "aylikMesaiGunu", "sosyalEtki_MinKayipOraniEsikDegeri", "sosyalEtki_MaxUtilizasyonKaybi", "OSOS_sahadaOkumaOrani", "isEmriAlmaSuresi", "aracBasinaEkipSayisi", dagitim_firma_id, "sosyaletki_MaxKayipOraniEsikDegeri", osos_sahadaokumasuresi, "OSOS_SahadaOkumaOrani_Tarimsal_Max", "OSOS_SahadaOkumaOrani_tarimsal_Min", endekskontrolorani, koordinator_kacpersonelbasina, sosyaletki_minutilizasyonkaybi) FROM stdin;
    public          postgres    false    221   6x      �          0    16627    genel_aydinlatma_girdiler 
   TABLE DATA           �  COPY public.genel_aydinlatma_girdiler (id, year_, dag_fir_id, lamba_ariza_orani, direk_ariza_orani, aylikmesaigunu, gunlukmesaisuresi, aktifcalismaorani, ekipyapisi_lamba, aynipano_ariza_sayisi, pano_suresi, arizagidermesuresi_lamba, aracbasinaekipsayisi_lamba, arizagidermesuresi_kablo, ekipyapisi_kablo, kablo_vinckirasuresi, vinckirabedeli, malzeme_fiyati_lamba, isemrialmasuresi, koordinator_kacekipbasina, aracbasinaekipsayisi_kablo) FROM stdin;
    public          postgres    false    223   y      �          0    16652    genel_yonetim_girdiler 
   TABLE DATA             COPY public.genel_yonetim_girdiler (id, year_, dag_fir_id, satin_alma_sabit, satin_alma_butce_basina, mhm_kacmusteri, depo_sabit, depo_butcebasina, stok_sabit, stok_butcebasina, filo_kacarac, arac_kacbeyazyaka, arac_genelmuduryrd, arac_misafir, sofor_kacbeyazyakaaraci, sofor_genelmudur, sofor_misafir, satinalma_kik_ilave, finans_sabit, muhasebe_sabit, muhasebe_butcebasina, muhasebe_hissedar, regulasyon_sabit, insankaynaklari_sabit, insankaynaklari_0_100, insankaynaklari_100_249, insankaynaklari_250_499, insankaynaklari_500_999, insankaynaklari_1000_2500, insankaynaklari_2500_7499, hukuk_sabit, hukuk_kacpersonel, hukuk_kacmusteri, tahakkuk_aydinlatma_sabit, tahakkuk_aydinlatma_kactesisat, tahakkuk_skb_sabit, veri_raporlama_sabit, veri_raporlama_kacilce, veri_kacak_sistem, veri_kacak_raporlama_kacilce, veri_kacak_analizci_kackacakekibi, arsiv_sabit, arsiv_buyukisletme, muhaberat_sabit, muhaberat_kacmusteri, idari_diger_sabit, temizlik_sabit, temizlik_kacpersonel, guvenlik_genelmudurluk, guvenlik_genelmudurluk_kacak, guvenlik_kameraodasi, guvenlik_kameraodasi_kacak, guvenlik_scadamerkezi, guvenlik_buyukisletme, guvenlik_buyukisletme_kacak, guvenlik_kucukisletme_kacak20, guvenlik_kucukisletme_kacak40, guvenlik_anadepo, guvenlik_depo_buyukisletme, tesisyonetimi_kacpersonel, kalite_sabit, cevre_sabit, strateji_kurumsalperformans_sabit, strateji_isgelistirme_sabit, strateji_sureciyilestirme_sabit, strateji_surecharitalari_sabit, kurumsal_disiliskiler_sabit, kurumsal_basin_sabit, kurumsal_iletisim_sabit, musteriiliski_cagrimerkezi_kaccagripersoneli, musteriiliski_sosyal_minpersonel, musteriiliski_sosyal_cagrioperatorbasina, musteriiliski_dilekce_kacmusteri, musteriiliski_memnuniyet_sabit, musteriiliski_ticarikalite_sabit, piyasa_taleptedarik_sabit, piyasa_epias_sabit, piyasa_dengesizlik_sabit, piyasa_kayiphesap_sabit, st_aktarim_sabit, st_veriyukleme_sabit, st_lisanssiz_sabit, st_teminat_sabit, st_tarife_sabit, mth_sabit, mth_kacmusteri, icdenetim_sabit, icdenetim_kacpersonel, arge_sabit, ustyonetim_min, sivilsavunma_sabit, ustyonetim_max, isletme_buyuklugu_ort, insankaynaklari_gt7500, kacaktahakkuk_icraorani, kacakicra_dosyabiriktirme, hukuk_kacakicra_katip_dosya, hukuk_kacakicra_avukat_katipsayisi, hukuk_sucduyurusu_katip_dosya, hukuk_sucduyurusu_avukat_dosya, isg_uzman_kacpersonelicin, isg_hekim_kacpersonelicin, isg_sef_kacuzman, isg_maliyet_maviyakabasina, tahsilat_sabit, tahakkuk_kacak_borcyapilandirmaorani, anketbutcesi, gunlukmesaisuresi, aktifcalismaorani, aylikmesaigunu, tahsilat_borcyapilandirmasuresi, tahsilat_kacak_borcyapilandirmaorani, tahsilat_icraoncesidegerlendirmesuresi, tahsilat_eslestirmesuresi, tahsilat_bedeli, idari_ilbasina, idari_buyukilcebasina, akaryakit_aracbasinatuketim_lt, hukuk_sucduyurusu_avukat_katipsayisi, st_sabit, st_kacstbasina) FROM stdin;
    public          postgres    false    225   �y      �          0    16777    girdiler 
   TABLE DATA           �  COPY public.girdiler (id, sabit, iki_sayac_arasi_mesafe, dummy_egim_1, dummy_egim_2, dummy_egim_3, dummy_egim_4, musteri_hat, hat_uzunlugu_merkez, kume_1_min_saniye, kume_1_max_saniye, kume_1_ort_deger, kume_1_daginik, kume_1_toplu, kume_2_min_saniye, kume_2_max_saniye, kume_2_ort_deger, kume_2_daginik, kume_2_toplu, kume_3_min_saniye, kume_3_max_saniye, kume_3_ort_deger, kume_3_daginik, kume_3_toplu, kesisim, koy_sayisi, egim, en_buyuk_koye_sure, ortalama_nufus, ilce_siniri_uzaklik, karli_gun_sayisi_etkisi, sicaklik_nem_etkisi_25_30_derece, sicaklik_nem_etkisi_30_35_derece, yagmurlu_gun_sayisi_etkisi, trafik_etkisi_yogunluk_buyuk_10, trafik_etkisi_yogunluk_buyuk_1000, uc_g_etkisi_iyi, uc_g_etkisi_orta, uc_g_etkisi_kotu, uc_g_etkisi_veri_yok, "AracHizi_kmh", arac_indi_bindi_suresi, mean_sigma1_arasindaki_musteri_orani, sigma1_sigma2_arasindaki_musteri_orani, sigma2_sigma3_arasindaki_musteri_orani, tarimsal_sulama_sayac_ulasim_katsayisi, kus_ucusu_merkez_ulasim_kume_1_agirlik_ort, kus_ucusu_merkez_ulasim_kume_2_agirlik_ort, kus_ucusu_merkez_ulasim_kume_3_agirlik_ort, kus_ucusu_merkez_ulasim_kume_4_agirlik_ort, kus_ucusu_merkez_ulasim_kume_1_aritmetik_ort, kus_ucusu_merkez_ulasim_kume_2_aritmetik_ort, kus_ucusu_merkez_ulasim_kume_3_aritmetik_ort, kus_ucusu_merkez_ulasim_kume_4_aritmetik_ort, kus_ucusu_kirsal_ulasim_kume_1_agirlik_ort, kus_ucusu_kirsal_ulasim_kume_2_agirlik_ort, kus_ucusu_kirsal_ulasim_kume_3_agirlik_ort, kus_ucusu_kirsal_ulasim_kume_1_aritmetik_ort, kus_ucusu_kirsal_ulasim_kume_2_aritmetik_ort, kus_ucusu_kirsal_ulasim_kume_3_aritmetik_ort, osos_sahada_okunma_orani, dag_fir_id, "akaryakit_Sarfiyat_Binek", "akaryakit_Sarfiyat_Sepetli", diregecikmainmesuresi, "Akaryakit_Fiyat", "personel_Ucret_Mavi", "personel_Ucret_Beyaz", osos_direkustukayipesikorani, arac_birim_maliyet, direklerarasimesafe_ag, direklerarasimesafe_og, arac_maliyeti_sepetli, saha_personeli_aktif_calisma_orani_merkez, saha_personeli_aktif_calisma_orani_kirsal, saha_personeli_aktif_calisma_orani_ofis, gunluk_mesai_sures_hafta_5, aylik_mesai_sures_hafta_5, gunluk_mesai_sures_hafta_6, aylik_mesai_sures_hafta_6, is_emri_alma_suresi_mth, is_emri_alma_suresi_aob, yonetici_kackoordinatoricin) FROM stdin;
    public          postgres    false    227   5{      �          0    16819    girdiler_money 
   TABLE DATA           H   COPY public.girdiler_money (id, money_personel, money_arac) FROM stdin;
    public          postgres    false    229   A}      �          0    16824    girdiler_sayac_islemleri 
   TABLE DATA           W  COPY public.girdiler_sayac_islemleri (id, "gunlukMesaiSuresi", "aktifCalismaOrani_Mrk", "aktifCalismaOrani_Kir", "aylikMesaiGunu", "sayacArizaOrani_Min", "sayacDegisimOrani_Damga", "sayacSokmeTakma_Monofaze", "sayacSokmeTakma_Trifaze", "sayacSokmeTakma_OSOS", "ekTahakkukSuresi_TarimsalHaric", "ekTahakkukSuresi_Tarimsal", "sayacSokme", "sayacTakma_Monofaze", "sayacTakma_KombiX5", "sayacTakma_OSOS", "sayacTestSuresi_AG", "sayacTestSuresi_OG", "ekTahakkukOrani", "ekTahakkuk_Sikayet_Orani", "ekTahakkuk_Sikayet_Gunluk_Incelenebilecek_Sayi", "yikimSokulenSayacOrani", "BinaIcindeSayaclarArasiUlasim", "isEmriAlmaSuresi", "sayacBedeli_Monofaze", "sayacBedeli_Trifaze", "sayacBedeli_Kombi", sayacsokmetakma_kombix5, kayiporani_minesikdeger, kayiporani_maxesikdeger, ekipyapisi_ariza, ekipyapisi_yenibaglanti, ekipyapisi_yikim, sayactakma_trifaze, ekipyapisi_damga, sayacarizaorani_max, koordinator_kacpersonelbasina, minziyaret_mrk, minziyaret_kir, dag_fir_id, ektahakkuk_sikayetsuresi, ekipyapisi_tespit, kacaksuphesi_max, kacaksuphesi_min, saha_tespit_suresi, saha_tespit_orani, ek_tahakkuku_orani) FROM stdin;
    public          postgres    false    231   i}      �          0    16875    girdilertum 
   TABLE DATA           Y   COPY public.girdilertum (id, surec, girdi, deger, degertipi, dagitimfirmaid) FROM stdin;
    public          postgres    false    233   W~      �          0    16883    gozlem_girdiler 
   TABLE DATA           �  COPY public.gozlem_girdiler (id, gunlukmesaisuresi, aktifcalismaorani, aylikmesaigunu, "og_hat_yürümekatsayisi", isemrialmasuresi, gozlemfrekans_ag_havai, gozlemfrekans_ayd, gozlemfrekans_bina, gozlemfrekans_dut, gozlemfrekans_og_havai, gozlemfrekans_sdk, gozlem_ekipyapisi_aghat, gozlem_ekipyapisi_ayd, gozlem_ekipyapisi_bina, gozlem_ekipyapisi_dut, gozlem_ekipyapisi_oghat, gozlem_ekipyapisi_sdk, dag_fir_id, gozlemsure_ag_agacdirek, gozlemsure_ag_demirdirek, gozlemsure_ag_betondirek, gozlemsure_ayd_armatur, gozlemsure_ayd_direk, gozlemsure_bina_aciksalt, gozlemsure_hucre_aciksalt, gozlemsure_trafo_aciksalt, gozlemsure_bina_moduler, gozlemsure_hucre_moduler, gozlemsure_trafo_moduler, gozlemsure_guctrafo, gozlemsure_dut, gozlemsure_og_agacdirek, gozlemsure_og_demirdirek, gozlemsure_og_betondirek, gozlemsure_sdk, koordinator_ekipbasina, karligun_utilizasyonkaybi, gozlemsure_ag_agacdirek_tek, gozlemsure_ag_demirdirek_tek, gozlemsure_ag_betondirek_tek) FROM stdin;
    public          postgres    false    235   �~      �          0    16927    ilceler 
   TABLE DATA           -  COPY public.ilceler (id, ilce_id, sehir_id, dag_fir_id, ilce, yil, alan_toplam, "Alan_Mrk", nufus_kirsal_2012, nufus_belde_2012, nufus_belde_1844_2012, nufus_belde_4611_2012, nufus_merkez_2012, nufus_toplam_2016, abone_sayisi_ag, abone_sayisi_og, abone_sayisi_mesken, abone_sayisi_ticarethane, abone_sayisi_sanayi, abone_sayisi_tarimsal_sulama, abone_sayisi_genel_aydinlatma, abone_sayisi_diger, osos_sayisi_tarimsal_sulama, osos_sayisi_genel_aydinlatma, osos_sayisi_diger, sayac_sayisi_monofaze, sayac_sayisi_trifaze, sayac_sayisi_kombi_mesken, sayac_sayisi_kombi_diger, sayac_sayisi_ag_x5, sayac_sayisi_og_x5, ilce_merkezine_ulasim_suresi, ilce_sinirina_ulasim_suresi, ilce_merkezine_sinirina_uzaklik, ilce_sinirina_uzaklik, ilce_merkezine_kus_ucusu_uzaklik, merkez_cluster_egim, kirsal_cluster, merkez_alanlarin_ortalama_egim_degerleri, ilce_idari_sinirlari_genel_egimi_derece, yurume_hizi_merkez, yurume_hizi_kirsal, belde_sayisi_2012, belde_sayisi_nufus_1844_2012, belde_sayisi_nufus_4611_2012, koy_ve_belde_sayisi, en_buyuk_koye_sure, kayip_kacak_orani, ilce_merkezi_siniri_kus_ucusu, agac_direk_sayisi_ag_musterek_haric, agac_direk_sayisi_musterek, agac_direk_sayisi_og_musterek_haric, beton_direk_sayisi_ag_musterek_haric, beton_direk_sayisi_musterek, beton_direk_sayisi_og_musterek_haric, demir_direk_sayisi_ag_musterek_haric, demir_direk_sayisi_musterek, demir_direk_sayisi_og_musterek_haric, aydinlatma_diregi_sadece_aydinlatma_munferit, aydinlatma_diregi_musterek, aydinlatma_diregi_armatur_sayisi, havai_hat_uzunlugu_ag_sirket, havai_hat_uzunlugu_ag_ucuncu_sahis, havai_hat_uzunlugu_og_sirket, havai_hat_uzunlugu_og_ucuncu_sahis, yeralti_hat_uzunlugu_ag_sirket, yeralti_hat_uzunlugu_ag_ucuncu_sahis, yeralti_hat_uzunlugu_og_sirket, yeralti_hat_uzunlugu_og_ucuncu_sahis, acik_salt_bina_sayisi, "acik_salt_hücre_sayisi", moduler_bina_sayisi, "moduler_hücre_sayisi", bina_ici_trafo_kuru_tip_trafo_sayisi, bina_ici_trafo_yagli_tip_trafo_sayisi, bina_ici_trafo_guc_trafo_sayisi, dut_kuru_tip_trafo_sayisi, dut_yagli_tip_trafo_sayisi, sdk_sayisi, havai_arti_yeralti_kablo_tedas_ag_sirket, havai_arti_yeralti_kablo_tedas_ag_ucuncu_sahis, havai_arti_yeralti_kablo_tedas_og_sirket, havai_arti_yeralti_kablo_tedas_og_ucuncu_sahis, yeni_abonelik_acma_sayisi, "yeniBaglanti_BasvuruProje_AG", "yeniBaglanti_BasvuruProje_OG", "yeniBaglantiSayac_AG", "yeniBaglantiSayac_OG", ilk_evrak_red_basvuru_sayisi_ag, ilk_evrak_red_basvuru_sayisi_og, enerji_musade_surecinde_red_basvuru_sayisi_ag, enerji_musade_surecinde_red_basvuru_sayisi_og, proje_onayinda_red_basvuru_sayisi_ag, proje_onayinda_red_basvuru_sayisi_og, tesisat_muayene_sirasinda_red_proje_sayisi_ag, tesisat_muayene_sirasinda_red_proje_sayisi_og, dagitima_giren_toplam_enerji, faturalanan_enerji_miktari, kayip_orani, uc_g_iyi_yesil, uc_g_orta, uc_g_kotu_kirmizi, uc_g_veri_yok, ilce_siniri_kus_ucusu, "Guc_DegisiklikBasvurusu_AG", "Guc_DegisiklikBasvurusu_OG", kesmesayisi_ag_mesken_borc, kesmesayisi_ag_diger_borc, kesmesayisi_ag_borcharici, acmasayisi_ag, kesmesayisi_og_borc, acmasayisi_og, trafikkatsayisi_mrk, sosyaletki_varyok, kofresayisi_mrk, kofresayisi_kir, sayacsayisi_damgayilindandegisecek, gunes_potansiyel, gunes_kuruluguc, dagitikuretim_santralsayisi, kesmesayisi_og_diger, musteri_mrk, musteri_kir, dagitikuretim_basvuru_mesken, dagitikuretim_basvuru_diger, trafo_sayisi_ucuncu_sahis) FROM stdin;
    public          postgres    false    237   �      �          0    17055    it_girdiler 
   TABLE DATA           /  COPY public.it_girdiler (id, year_, dag_fir_id, altyapipersonel_kacbilgisayar, cihazbakim_kacpersonel, vtyonetim_personel, sunucuyonetim_personel, haberlesmepersonel_kacilce, envanterpersonel_kacbilgisayar, konfigyonetim_personel, isgucupersonel_kacpersonel, sistemidame_personel, sondestekpersonel_kacbilgisayar, siberguvenlik_personel, "isuygulamaları_personel", iszekasi_personel_min, iszekasi_personel_max, projeyonetim_personel, guvenlikopmrk_personel, sebekekopmrk_personel, lisansbedeli, cloudbirimbedeli, haberlesmebirimbedeli, it_capex) FROM stdin;
    public          postgres    false    239   B      �          0    17081    kacak_tarama_girdiler 
   TABLE DATA           x  COPY public.kacak_tarama_girdiler (id, year_, "KontrolSuresi_Monofaze", "KontrolSuresi_X5_AG", "KontrolSuresi_X5_OG", "TutanakSuresi", "KontrolSuresi_Ilave_Yuzde20Uzeri", "gunlukMesaiSuresi", "aktifCalismaOrani_Mrk", "aktifCalismaOrani_Kir", "aylikMesaiGunu", "EsikDeger_KKOrani_Min", "EsikDeger_KKOrani_Max", "sosyalEtki_MaxUtilizasyonKaybi", "KacakMusteriOrani_KayipOraninaGore", "EkipYapisi_OGHatTarama", "Tarama_OGHat_Gunluk_km", "Tarama_OGHat_AySayisi", "Frekans_Baz_Monofaze", "Frekans_Max_Monofaze", "Frekans_Baz_Trifaze", "Frekans_Max_Trifaze", "Frekans_Baz_Kombi_X5Harici", "Frekans_Max_Kombi_X5Harici", "Frekans_Baz_X5_AG", "Frekans_Max_X5_AG", "Frekans_Baz_X5_OG", "Frekans_Max_X5_OG", "isEmriAlmaSuresi", "EkipYapisi_Baz", "EkipYapisi_Max", "KontrolSuresi_trifaze", "Kontrolsuresi_Kombi_x5harici", esikdeger_kk_ilavepersonel, koordinator_yonetilen_ekipsayisi, tahakkuksuresi_tarimsal, tahakkuksuresi_tarimsalharic, aktifcalismaorani_ofis, tahakkuk_kontrolsuresi, tahakkuk_dosyahazirlamasuresi, tahakkuk_itirazorani, tahakkuk_itirazcevaplamasuresi, mahsuplasma_suresi, dag_fir_id, tarama_oghat_saatlik_km, cks_personeli) FROM stdin;
    public          postgres    false    241   �      �          0    17149    kar_buz_ortulu_gun_sayisi_data 
   TABLE DATA           �   COPY public.kar_buz_ortulu_gun_sayisi_data (id, year, sehir_id, ocak, subat, mart, nisan, mayis, haziran, temmuz, agustos, eylul, ekim, kasim, aralik) FROM stdin;
    public          postgres    false    245   �      �          0    17171    kar_buz_yuku_etkeni_constant 
   TABLE DATA           �   COPY public.kar_buz_yuku_etkeni_constant (id, dag_fir_id, ortulu_gun_sayisi, ortulu_gun_sayisina_gore, max_ortulu_gun_sayisi, etken_max_ortulu_gun_sayisina_gore, max_ortulu_gun_sayisina_gore, ortalama_ortulu_gun_sayisi) FROM stdin;
    public          postgres    false    248   �      �          0    17183    kesme_acma_girdiler 
   TABLE DATA           �  COPY public.kesme_acma_girdiler (id, "sayacOkumaSuresi", "ISG_Suresi", "AG_KesmeAcmaSuresi", "OG_KesmeAcmaSuresi", "gunlukMesaiSuresi", "aktifCalismaOrani_Mrk", "aktifCalismaOrani_Kir", "aylikMesaiGunu", "isEmriAlmaSuresi", "ekipYapisi_AG", "ekipYapisi_OG", "uzaktan_KesmeAcmaOrani_AG", "uzaktan_KesmeAcmaOrani_OG", "sosyalEtki_MinKayipOraniEsikDegeri", "sosyalEtki_MaxUtilizasyonKaybi", "sosyaletki_Maxkayiporaniesikdegeri", sosyaletkiminutilizasyonkaybi, sosyalmukavemetsuresi_mesken, sosyalmukavemetsuresi_ag_diger, sosyalmukavemetsuresi_og, koordinator_kacekipbasina, minziyaret_mrk, minziyaret_kir, dag_fir_id, fkb_katsayisi, fkb_min, fkb_max) FROM stdin;
    public          postgres    false    250   �      �          0    17214    meteoroloji 
   TABLE DATA           a   COPY public.meteoroloji (id, sehir_id, sicaklik_nem_etkisi, kar_ortusu_yagis_etkisi) FROM stdin;
    public          postgres    false    252   I      �          0    17221    onarim_gercek_yas_constant 
   TABLE DATA           D   COPY public.onarim_gercek_yas_constant (id, gercek_yas) FROM stdin;
    public          postgres    false    254   H       �          0    17226    onarim_girdiler_constants 
   TABLE DATA           �  COPY public.onarim_girdiler_constants (id, dag_fir_id, envanter_id, ekonomik_omur, major_arizanin_hangi_yasa_kadar_kumulatif_oldugu, major_otuz_yasa_kadar_ekipman_degisim_orani, "minor_otuz_yasa_kadar_ekipman_onarim_ihtiyacı_orani", yeni_ekipman_ile_otuz_yas_ekipman_ariza_kati, birim_bedel_major, birim_bedel_minor, birim, yas_0_5, yas_6_10, yas_11_15, yas_16_20, yas_21_25, yas_26_30, yas_31_35, yas_36_40, yas_gt_40, c_constant) FROM stdin;
    public          postgres    false    256   �       �          0    17244    onarim_girdiler_envanter 
   TABLE DATA           e   COPY public.onarim_girdiler_envanter (id, envanter_id, envanter_name, hat_trafo_bilgisi) FROM stdin;
    public          postgres    false    258   �^      �          0    17252     onarim_sirket_hat_trafo_percents 
   TABLE DATA           K  COPY public.onarim_sirket_hat_trafo_percents (id, dag_fir_id, hat, trafo, minor_ariza_orani_max, major_ariza_orani_max, minor_onarim_bedeli_iscilik, minor_onarim_bedeli_malzeme, major_arizalarin_yuzde_kacina_minor_ariza_uygulanacagi, major_onarim_orani_opex_30_40, major_onarim_orani_opex_gt_40, maliyetorani_personel) FROM stdin;
    public          postgres    false    260   s`      �          0    17265    ot_girdiler 
   TABLE DATA           �  COPY public.ot_girdiler (id, year_, dag_fir_id, sebekeyonetimpersonel_sabit, sebekeyonetimpersonel_ilbasina, scadaoperator_kactrafo, scadailetisim_personel, enerjikaliteyonetim_min, enerjikaliteyonetim_max, sekondersaha_kacdm, sekonderrole_min, sekonderrole_max, kesintiyonetim_sabit, kesintiyonetim_kacmusteri, otplanlama_min, otplanlama_max, sondestek_personel, ososyonetim_sabit, ososyayginlastirma_min, ososyayginlastirma_max, ososbakim_kacosos, ososdestek_kacosos, osossistem_personel) FROM stdin;
    public          postgres    false    262   Ia      �          0    17290    sebeke_ariza_girdiler 
   TABLE DATA             COPY public.sebeke_ariza_girdiler (id, year_, dag_fir_id, arizasayisi_vardiya, gunlukmesaisuresi, aktifcalismaorani, aylikmesaigunu, arizagidermesuresi, aracbasinaekipsayisi, koordinator_kacekipbasina, ekipyapisi, malzeme_maliyet_orani, soforsayisi_ekipbasina) FROM stdin;
    public          postgres    false    264   �a      �          0    17305    sebeke_isletme_girdiler 
   TABLE DATA           �   COPY public.sebeke_isletme_girdiler (id, year_, dag_fir_id, varlikdevir_min, varlikdevir_max, denetim_min, denetim_max, aydinlatma_min, aydinlatma_max, varlikyonetim_min, varlikyonetim_max) FROM stdin;
    public          postgres    false    266   �b      �          0    17319    sehirler 
   TABLE DATA           J   COPY public.sehirler (id, sehir_id, dag_fir_id, sehir, plaka) FROM stdin;
    public          postgres    false    268   *c      �          0    17327    trafik 
   TABLE DATA           6   COPY public.trafik (id, sehir_id, trafik) FROM stdin;
    public          postgres    false    270   3g      �          0    17349 &   yagisli_gun_sayisi_converted_from_view 
   TABLE DATA           �   COPY public.yagisli_gun_sayisi_converted_from_view (sehir_id, ocak, subat, mart, nisan, mayis, haziran, temmuz, agustos, eylul, ekim, kasim, aralik, sum_, ort_, max_, kar_arti_yagis_faktoru, maksimum_kar, kar_at_max_yagis, yagis_at_max_kar) FROM stdin;
    public          postgres    false    275   �h      �          0    17129    yagisli_gun_sayisi_data 
   TABLE DATA           �   COPY public.yagisli_gun_sayisi_data (id, year, sehir_id, ocak, subat, mart, nisan, mayis, haziran, temmuz, agustos, eylul, ekim, kasim, aralik) FROM stdin;
    public          postgres    false    243   �x      �          0    17373    yeni_baglanti_girdiler 
   TABLE DATA           �  COPY public.yeni_baglanti_girdiler (id, dag_fir_id, "aylikMesaiGunu", "gunlukMesaiSuresi", "aktifCalismaOrani", "EkipYapisi_EnerjiMusadesi_Saha", "EkipYapisi_TesisatMuayene_AG_Saha", "EkipYapisi_TesisatMuayene_OG_Saha", "EnerjiMusadesi_SahayaGitmemeOrani_AG", "EnerjiMusadesi_SahayaGidilmediginde_Ofis_Ek_Sure", "Basvuru_Kontrol_Suresi", "Basvuru_RedOrani_AG", "Basvuru_RedOrani_OG", "Proje_OnaySuresi_AG", "Proje_OnaySuresi_OG", "Proje_RedOrani_AG", "Proje_RedOrani_OG", "EnerjiMusadesi_SahaSuresi_AG", "EnerjiMusadesi_SahaSuresi_OG", "EnerjiMusadesi_OfisSuresi_AG", "EnerjiMusadesi_OfisSuresi_OG", "EnerjiMusadesi_RedOrani_AG", "EnerjiMusadesi_RedOrani_OG", "BaglantiAnlasmasi_Sure_Sabit", "BaglantiAnlasmasi_Sure_SayacBasina", "TesisatMuayene_SahaSuresi_AG_Sabit", "TesisatMuayene_SahaSuresi_AG_SayacBasina", "TesisatMuayene_SahaSuresi_OG_Sabit", "TesisatMuayene_OfisSuresi_AG", "TesisatMuayene_OfisSuresi_OG", "TesisatMuayene_RedOrani_AG", "TesisatMuayene_RedOrani_OG", "AnaVeri_GirisSuresi_Sabit", "AnaVeri_GirisSuresi_SayacBasina", enerjimusadesi_sahayagitmemeorani_og, tesisatmuayene_sahasuresi_og_sayacbasina, minziyaret_mrk, minziyaret_kir, enerji_musadesi_red_orani_ag, tesisat_muayene_red_orani_og) FROM stdin;
    public          postgres    false    277   �      A           0    0    bakim_girdiler_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.bakim_girdiler_id_seq', 21, true);
          public          postgres    false    204            B           0    0    bakim_modeli_girdiler_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.bakim_modeli_girdiler_id_seq', 1, true);
          public          postgres    false    206            C           0    0 +   bakim_modeli_islem_tablosu_constants_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.bakim_modeli_islem_tablosu_constants_id_seq', 1, false);
          public          postgres    false    208            D           0    0 "   bakim_modeli_varlik_carpani_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.bakim_modeli_varlik_carpani_id_seq', 1, false);
          public          postgres    false    213            E           0    0    cbs_girdiler_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cbs_girdiler_id_seq', 22, true);
          public          postgres    false    215            F           0    0    dagitik_uretim_girdiler_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.dagitik_uretim_girdiler_id_seq', 21, true);
          public          postgres    false    217            G           0    0    dagitim_firmalari_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.dagitim_firmalari_id_seq', 21, true);
          public          postgres    false    220            H           0    0    endex_okuma_girdiler_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.endex_okuma_girdiler_id_seq', 87, true);
          public          postgres    false    222            I           0    0     genel_aydinlatma_girdiler_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.genel_aydinlatma_girdiler_id_seq', 21, true);
          public          postgres    false    224            J           0    0    genel_yonetim_girdiler_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.genel_yonetim_girdiler_id_seq', 1, false);
          public          postgres    false    226            K           0    0    girdiler_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.girdiler_id_seq', 1, false);
          public          postgres    false    228            L           0    0    girdiler_money_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.girdiler_money_id_seq', 1, false);
          public          postgres    false    230            M           0    0    girdiler_sayac_islemleri_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.girdiler_sayac_islemleri_id_seq', 22, true);
          public          postgres    false    232            N           0    0    girdilertum_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.girdilertum_id_seq', 4, true);
          public          postgres    false    234            O           0    0    gozlem_girdiler_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.gozlem_girdiler_id_seq', 21, true);
          public          postgres    false    236            P           0    0    ilceler_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ilceler_id_seq', 1, false);
          public          postgres    false    238            Q           0    0    it_girdiler_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.it_girdiler_id_seq', 22, true);
          public          postgres    false    240            R           0    0    kacak_tarama_girdiler_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.kacak_tarama_girdiler_id_seq', 1, true);
          public          postgres    false    242            S           0    0 %   kar_buz_ortulu_gun_sayisi_data_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.kar_buz_ortulu_gun_sayisi_data_id_seq', 1, false);
          public          postgres    false    246            T           0    0 #   kar_buz_yuku_etkeni_constant_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.kar_buz_yuku_etkeni_constant_id_seq', 1, false);
          public          postgres    false    249            U           0    0    kesme_acma_girdiler_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.kesme_acma_girdiler_id_seq', 1, true);
          public          postgres    false    251            V           0    0    meteoroloji_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.meteoroloji_id_seq', 169, true);
          public          postgres    false    253            W           0    0 !   onarim_gercek_yas_constant_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.onarim_gercek_yas_constant_id_seq', 10, true);
          public          postgres    false    255            X           0    0     onarim_girdiler_constants_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.onarim_girdiler_constants_id_seq', 1220, true);
          public          postgres    false    257            Y           0    0    onarim_girdiler_envanter_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.onarim_girdiler_envanter_id_seq', 1, false);
          public          postgres    false    259            Z           0    0 '   onarim_sirket_hat_trafo_percents_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.onarim_sirket_hat_trafo_percents_id_seq', 1, false);
          public          postgres    false    261            [           0    0    ot_girdiler_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.ot_girdiler_id_seq', 22, true);
          public          postgres    false    263            \           0    0    sebeke_ariza_girdiler_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sebeke_ariza_girdiler_id_seq', 22, true);
          public          postgres    false    265            ]           0    0    sebeke_isletme_girdiler_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.sebeke_isletme_girdiler_id_seq', 22, true);
          public          postgres    false    267            ^           0    0    sehirler_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sehirler_id_seq', 83, true);
          public          postgres    false    269            _           0    0    trafik_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.trafik_id_seq', 83, true);
          public          postgres    false    271            `           0    0    yagisli_gun_sayisi_data_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.yagisli_gun_sayisi_data_id_seq', 1, false);
          public          postgres    false    276            a           0    0    yeni_baglanti_girdiler_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.yeni_baglanti_girdiler_id_seq', 21, true);
          public          postgres    false    278            �           2606    17449     bakim_girdiler bakim_girdiler_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.bakim_girdiler
    ADD CONSTRAINT bakim_girdiler_pk PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.bakim_girdiler DROP CONSTRAINT bakim_girdiler_pk;
       public            postgres    false    203            �           2606    17451    cbs_girdiler cbs_girdiler_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cbs_girdiler
    ADD CONSTRAINT cbs_girdiler_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cbs_girdiler DROP CONSTRAINT cbs_girdiler_pk;
       public            postgres    false    214            �           2606    17453    dagitim_firmalari dag_firs_pk 
   CONSTRAINT     c   ALTER TABLE ONLY public.dagitim_firmalari
    ADD CONSTRAINT dag_firs_pk PRIMARY KEY (dag_fir_id);
 G   ALTER TABLE ONLY public.dagitim_firmalari DROP CONSTRAINT dag_firs_pk;
       public            postgres    false    219            �           2606    17455 2   dagitik_uretim_girdiler dagitik_uretim_girdiler_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.dagitik_uretim_girdiler
    ADD CONSTRAINT dagitik_uretim_girdiler_pk PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.dagitik_uretim_girdiler DROP CONSTRAINT dagitik_uretim_girdiler_pk;
       public            postgres    false    216            �           2606    17457 ,   endex_okuma_girdiler endex_okuma_girdiler_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.endex_okuma_girdiler
    ADD CONSTRAINT endex_okuma_girdiler_pk PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.endex_okuma_girdiler DROP CONSTRAINT endex_okuma_girdiler_pk;
       public            postgres    false    221            �           2606    17459 6   genel_aydinlatma_girdiler genel_aydinlatma_girdiler_pk 
   CONSTRAINT     t   ALTER TABLE ONLY public.genel_aydinlatma_girdiler
    ADD CONSTRAINT genel_aydinlatma_girdiler_pk PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.genel_aydinlatma_girdiler DROP CONSTRAINT genel_aydinlatma_girdiler_pk;
       public            postgres    false    223            �           2606    17461 0   genel_yonetim_girdiler genel_yonetim_girdiler_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.genel_yonetim_girdiler
    ADD CONSTRAINT genel_yonetim_girdiler_pk PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.genel_yonetim_girdiler DROP CONSTRAINT genel_yonetim_girdiler_pk;
       public            postgres    false    225            �           2606    17463    girdiler girdiler_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.girdiler
    ADD CONSTRAINT girdiler_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.girdiler DROP CONSTRAINT girdiler_pk;
       public            postgres    false    227            �           2606    17465 4   girdiler_sayac_islemleri girdiler_sayac_islemleri_pk 
   CONSTRAINT     r   ALTER TABLE ONLY public.girdiler_sayac_islemleri
    ADD CONSTRAINT girdiler_sayac_islemleri_pk PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.girdiler_sayac_islemleri DROP CONSTRAINT girdiler_sayac_islemleri_pk;
       public            postgres    false    231            �           2606    17467    girdilertum girdilertum_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.girdilertum
    ADD CONSTRAINT girdilertum_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.girdilertum DROP CONSTRAINT girdilertum_pkey;
       public            postgres    false    233            �           2606    17469 "   gozlem_girdiler gozlem_girdiler_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.gozlem_girdiler
    ADD CONSTRAINT gozlem_girdiler_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.gozlem_girdiler DROP CONSTRAINT gozlem_girdiler_pk;
       public            postgres    false    235            �           2606    17471    ilceler ilceler_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.ilceler
    ADD CONSTRAINT ilceler_pk PRIMARY KEY (ilce_id);
 <   ALTER TABLE ONLY public.ilceler DROP CONSTRAINT ilceler_pk;
       public            postgres    false    237            �           2606    17473    it_girdiler it_girdiler_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.it_girdiler
    ADD CONSTRAINT it_girdiler_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.it_girdiler DROP CONSTRAINT it_girdiler_pk;
       public            postgres    false    239            �           2606    17475 .   kacak_tarama_girdiler kacak_tarama_girdiler_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.kacak_tarama_girdiler
    ADD CONSTRAINT kacak_tarama_girdiler_pk PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.kacak_tarama_girdiler DROP CONSTRAINT kacak_tarama_girdiler_pk;
       public            postgres    false    241            �           2606    17477 @   kar_buz_ortulu_gun_sayisi_data kar_buz_ortulu_gun_sayisi_data_pk 
   CONSTRAINT     ~   ALTER TABLE ONLY public.kar_buz_ortulu_gun_sayisi_data
    ADD CONSTRAINT kar_buz_ortulu_gun_sayisi_data_pk PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.kar_buz_ortulu_gun_sayisi_data DROP CONSTRAINT kar_buz_ortulu_gun_sayisi_data_pk;
       public            postgres    false    245            �           2606    17479 *   kesme_acma_girdiler kesme_acma_girdiler_pk 
   CONSTRAINT     h   ALTER TABLE ONLY public.kesme_acma_girdiler
    ADD CONSTRAINT kesme_acma_girdiler_pk PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.kesme_acma_girdiler DROP CONSTRAINT kesme_acma_girdiler_pk;
       public            postgres    false    250            �           2606    17481    meteoroloji meteoroloji_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.meteoroloji
    ADD CONSTRAINT meteoroloji_pk PRIMARY KEY (sehir_id);
 D   ALTER TABLE ONLY public.meteoroloji DROP CONSTRAINT meteoroloji_pk;
       public            postgres    false    252            �           2606    17483 D   onarim_sirket_hat_trafo_percents onarim_sirket_hat_trafo_percents_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.onarim_sirket_hat_trafo_percents
    ADD CONSTRAINT onarim_sirket_hat_trafo_percents_pk PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.onarim_sirket_hat_trafo_percents DROP CONSTRAINT onarim_sirket_hat_trafo_percents_pk;
       public            postgres    false    260            �           2606    17485    ot_girdiler ot_girdiler_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.ot_girdiler
    ADD CONSTRAINT ot_girdiler_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.ot_girdiler DROP CONSTRAINT ot_girdiler_pk;
       public            postgres    false    262            �           2606    17487 .   sebeke_ariza_girdiler sebeke_ariza_girdiler_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.sebeke_ariza_girdiler
    ADD CONSTRAINT sebeke_ariza_girdiler_pk PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sebeke_ariza_girdiler DROP CONSTRAINT sebeke_ariza_girdiler_pk;
       public            postgres    false    264            �           2606    17489 2   sebeke_isletme_girdiler sebeke_isletme_girdiler_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.sebeke_isletme_girdiler
    ADD CONSTRAINT sebeke_isletme_girdiler_pk PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.sebeke_isletme_girdiler DROP CONSTRAINT sebeke_isletme_girdiler_pk;
       public            postgres    false    266            �           2606    17491    sehirler sehirler_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.sehirler
    ADD CONSTRAINT sehirler_pk PRIMARY KEY (sehir);
 >   ALTER TABLE ONLY public.sehirler DROP CONSTRAINT sehirler_pk;
       public            postgres    false    268            �           2606    17493    sehirler sehirler_sehir_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sehirler
    ADD CONSTRAINT sehirler_sehir_id_key UNIQUE (sehir_id);
 H   ALTER TABLE ONLY public.sehirler DROP CONSTRAINT sehirler_sehir_id_key;
       public            postgres    false    268            �           2606    17495    trafik trafik_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.trafik
    ADD CONSTRAINT trafik_pk PRIMARY KEY (sehir_id);
 :   ALTER TABLE ONLY public.trafik DROP CONSTRAINT trafik_pk;
       public            postgres    false    270            �           2606    17497 2   yagisli_gun_sayisi_data yagisli_gun_sayisi_data_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.yagisli_gun_sayisi_data
    ADD CONSTRAINT yagisli_gun_sayisi_data_pk PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.yagisli_gun_sayisi_data DROP CONSTRAINT yagisli_gun_sayisi_data_pk;
       public            postgres    false    243            �           2606    17499 0   yeni_baglanti_girdiler yeni_baglanti_girdiler_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.yeni_baglanti_girdiler
    ADD CONSTRAINT yeni_baglanti_girdiler_pk PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.yeni_baglanti_girdiler DROP CONSTRAINT yeni_baglanti_girdiler_pk;
       public            postgres    false    277            �           1259    17500    bakim_girdiler_id_idx    INDEX     N   CREATE INDEX bakim_girdiler_id_idx ON public.bakim_girdiler USING btree (id);
 )   DROP INDEX public.bakim_girdiler_id_idx;
       public            postgres    false    203            �           1259    17501    bakim_modeli_girdiler_id_idx    INDEX     \   CREATE INDEX bakim_modeli_girdiler_id_idx ON public.bakim_modeli_girdiler USING btree (id);
 0   DROP INDEX public.bakim_modeli_girdiler_id_idx;
       public            postgres    false    205            �           1259    17502 +   bakim_modeli_islem_tablosu_constants_id_idx    INDEX     z   CREATE INDEX bakim_modeli_islem_tablosu_constants_id_idx ON public.bakim_modeli_islem_tablosu_constants USING btree (id);
 ?   DROP INDEX public.bakim_modeli_islem_tablosu_constants_id_idx;
       public            postgres    false    207            �           1259    17503 $   bakim_modeli_lut_eszamanlilik_id_idx    INDEX     l   CREATE INDEX bakim_modeli_lut_eszamanlilik_id_idx ON public.bakim_modeli_lut_eszamanlilik USING btree (id);
 8   DROP INDEX public.bakim_modeli_lut_eszamanlilik_id_idx;
       public            postgres    false    211            �           1259    17504 "   bakim_modeli_varlik_carpani_id_idx    INDEX     h   CREATE INDEX bakim_modeli_varlik_carpani_id_idx ON public.bakim_modeli_varlik_carpani USING btree (id);
 6   DROP INDEX public.bakim_modeli_varlik_carpani_id_idx;
       public            postgres    false    212            �           1259    17505    cbs_girdiler_id_idx    INDEX     J   CREATE INDEX cbs_girdiler_id_idx ON public.cbs_girdiler USING btree (id);
 '   DROP INDEX public.cbs_girdiler_id_idx;
       public            postgres    false    214            �           1259    17506    dagitik_uretim_girdiler_id_idx    INDEX     `   CREATE INDEX dagitik_uretim_girdiler_id_idx ON public.dagitik_uretim_girdiler USING btree (id);
 2   DROP INDEX public.dagitik_uretim_girdiler_id_idx;
       public            postgres    false    216            �           1259    17507 !   dagitik_uretim_il_girdiler_id_idx    INDEX     f   CREATE INDEX dagitik_uretim_il_girdiler_id_idx ON public.dagitik_uretim_il_girdiler USING btree (id);
 5   DROP INDEX public.dagitik_uretim_il_girdiler_id_idx;
       public            postgres    false    218            �           1259    17508    dagitim_firmalari_id_idx    INDEX     T   CREATE INDEX dagitim_firmalari_id_idx ON public.dagitim_firmalari USING btree (id);
 ,   DROP INDEX public.dagitim_firmalari_id_idx;
       public            postgres    false    219            �           1259    17509    endex_okuma_girdiler_id_idx    INDEX     Z   CREATE INDEX endex_okuma_girdiler_id_idx ON public.endex_okuma_girdiler USING btree (id);
 /   DROP INDEX public.endex_okuma_girdiler_id_idx;
       public            postgres    false    221            �           1259    17510     genel_aydinlatma_girdiler_id_idx    INDEX     d   CREATE INDEX genel_aydinlatma_girdiler_id_idx ON public.genel_aydinlatma_girdiler USING btree (id);
 4   DROP INDEX public.genel_aydinlatma_girdiler_id_idx;
       public            postgres    false    223            �           1259    17511    genel_yonetim_girdiler_id_idx    INDEX     ^   CREATE INDEX genel_yonetim_girdiler_id_idx ON public.genel_yonetim_girdiler USING btree (id);
 1   DROP INDEX public.genel_yonetim_girdiler_id_idx;
       public            postgres    false    225            �           1259    17512    girdiler_id_idx    INDEX     B   CREATE INDEX girdiler_id_idx ON public.girdiler USING btree (id);
 #   DROP INDEX public.girdiler_id_idx;
       public            postgres    false    227            �           1259    17513    girdiler_money_id_idx    INDEX     N   CREATE INDEX girdiler_money_id_idx ON public.girdiler_money USING btree (id);
 )   DROP INDEX public.girdiler_money_id_idx;
       public            postgres    false    229            �           1259    17514    girdiler_sayac_islemleri_id_idx    INDEX     b   CREATE INDEX girdiler_sayac_islemleri_id_idx ON public.girdiler_sayac_islemleri USING btree (id);
 3   DROP INDEX public.girdiler_sayac_islemleri_id_idx;
       public            postgres    false    231            �           1259    17515    girdilertum_id_idx    INDEX     H   CREATE INDEX girdilertum_id_idx ON public.girdilertum USING btree (id);
 &   DROP INDEX public.girdilertum_id_idx;
       public            postgres    false    233            �           1259    17516    gozlem_girdiler_id_idx    INDEX     P   CREATE INDEX gozlem_girdiler_id_idx ON public.gozlem_girdiler USING btree (id);
 *   DROP INDEX public.gozlem_girdiler_id_idx;
       public            postgres    false    235            �           1259    17517    ilceler_id_idx    INDEX     @   CREATE INDEX ilceler_id_idx ON public.ilceler USING btree (id);
 "   DROP INDEX public.ilceler_id_idx;
       public            postgres    false    237            �           1259    17518    it_girdiler_id_idx    INDEX     H   CREATE INDEX it_girdiler_id_idx ON public.it_girdiler USING btree (id);
 &   DROP INDEX public.it_girdiler_id_idx;
       public            postgres    false    239            �           1259    17519    kacak_tarama_girdiler_id_idx    INDEX     \   CREATE INDEX kacak_tarama_girdiler_id_idx ON public.kacak_tarama_girdiler USING btree (id);
 0   DROP INDEX public.kacak_tarama_girdiler_id_idx;
       public            postgres    false    241            �           1259    17520 %   kar_buz_ortulu_gun_sayisi_data_id_idx    INDEX     n   CREATE INDEX kar_buz_ortulu_gun_sayisi_data_id_idx ON public.kar_buz_ortulu_gun_sayisi_data USING btree (id);
 9   DROP INDEX public.kar_buz_ortulu_gun_sayisi_data_id_idx;
       public            postgres    false    245            �           1259    17521 #   kar_buz_yuku_etkeni_constant_id_idx    INDEX     j   CREATE INDEX kar_buz_yuku_etkeni_constant_id_idx ON public.kar_buz_yuku_etkeni_constant USING btree (id);
 7   DROP INDEX public.kar_buz_yuku_etkeni_constant_id_idx;
       public            postgres    false    248            �           1259    17522    kesme_acma_girdiler_id_idx    INDEX     X   CREATE INDEX kesme_acma_girdiler_id_idx ON public.kesme_acma_girdiler USING btree (id);
 .   DROP INDEX public.kesme_acma_girdiler_id_idx;
       public            postgres    false    250            �           1259    17523    meteoroloji_id_idx    INDEX     H   CREATE INDEX meteoroloji_id_idx ON public.meteoroloji USING btree (id);
 &   DROP INDEX public.meteoroloji_id_idx;
       public            postgres    false    252            �           1259    17524 !   onarim_gercek_yas_constant_id_idx    INDEX     f   CREATE INDEX onarim_gercek_yas_constant_id_idx ON public.onarim_gercek_yas_constant USING btree (id);
 5   DROP INDEX public.onarim_gercek_yas_constant_id_idx;
       public            postgres    false    254            �           1259    17525     onarim_girdiler_constants_id_idx    INDEX     d   CREATE INDEX onarim_girdiler_constants_id_idx ON public.onarim_girdiler_constants USING btree (id);
 4   DROP INDEX public.onarim_girdiler_constants_id_idx;
       public            postgres    false    256            �           1259    17526    onarim_girdiler_envanter_id_idx    INDEX     b   CREATE INDEX onarim_girdiler_envanter_id_idx ON public.onarim_girdiler_envanter USING btree (id);
 3   DROP INDEX public.onarim_girdiler_envanter_id_idx;
       public            postgres    false    258            �           1259    17527 '   onarim_sirket_hat_trafo_percents_id_idx    INDEX     r   CREATE INDEX onarim_sirket_hat_trafo_percents_id_idx ON public.onarim_sirket_hat_trafo_percents USING btree (id);
 ;   DROP INDEX public.onarim_sirket_hat_trafo_percents_id_idx;
       public            postgres    false    260            �           1259    17528    ot_girdiler_id_idx    INDEX     H   CREATE INDEX ot_girdiler_id_idx ON public.ot_girdiler USING btree (id);
 &   DROP INDEX public.ot_girdiler_id_idx;
       public            postgres    false    262            �           1259    17529    sebeke_ariza_girdiler_id_idx    INDEX     \   CREATE INDEX sebeke_ariza_girdiler_id_idx ON public.sebeke_ariza_girdiler USING btree (id);
 0   DROP INDEX public.sebeke_ariza_girdiler_id_idx;
       public            postgres    false    264            �           1259    17530    sebeke_isletme_girdiler_id_idx    INDEX     `   CREATE INDEX sebeke_isletme_girdiler_id_idx ON public.sebeke_isletme_girdiler USING btree (id);
 2   DROP INDEX public.sebeke_isletme_girdiler_id_idx;
       public            postgres    false    266            �           1259    17531    sehirler_id_idx    INDEX     B   CREATE INDEX sehirler_id_idx ON public.sehirler USING btree (id);
 #   DROP INDEX public.sehirler_id_idx;
       public            postgres    false    268            �           1259    17532    trafik_id_idx    INDEX     >   CREATE INDEX trafik_id_idx ON public.trafik USING btree (id);
 !   DROP INDEX public.trafik_id_idx;
       public            postgres    false    270            �           1259    17533    yagisli_gun_sayisi_data_id_idx    INDEX     `   CREATE INDEX yagisli_gun_sayisi_data_id_idx ON public.yagisli_gun_sayisi_data USING btree (id);
 2   DROP INDEX public.yagisli_gun_sayisi_data_id_idx;
       public            postgres    false    243            �           1259    17534    yeni_baglanti_girdiler_id_idx    INDEX     ^   CREATE INDEX yeni_baglanti_girdiler_id_idx ON public.yeni_baglanti_girdiler USING btree (id);
 1   DROP INDEX public.yeni_baglanti_girdiler_id_idx;
       public            postgres    false    277            �           2620    17535 3   endex_okuma_girdiler check_insert_to_endex_girdiler    TRIGGER     �   CREATE TRIGGER check_insert_to_endex_girdiler AFTER UPDATE ON public.endex_okuma_girdiler FOR EACH ROW EXECUTE FUNCTION public.upd_baz();

ALTER TABLE public.endex_okuma_girdiler DISABLE TRIGGER check_insert_to_endex_girdiler;
 L   DROP TRIGGER check_insert_to_endex_girdiler ON public.endex_okuma_girdiler;
       public          postgres    false    338    221            �           2606    17536    ilceler ilceler_dag_fir_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ilceler
    ADD CONSTRAINT ilceler_dag_fir_fk FOREIGN KEY (dag_fir_id) REFERENCES public.dagitim_firmalari(dag_fir_id);
 D   ALTER TABLE ONLY public.ilceler DROP CONSTRAINT ilceler_dag_fir_fk;
       public          postgres    false    219    237    3759            �           2606    17541    ilceler ilceler_sehir_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ilceler
    ADD CONSTRAINT ilceler_sehir_fk FOREIGN KEY (sehir_id) REFERENCES public.sehirler(sehir_id);
 B   ALTER TABLE ONLY public.ilceler DROP CONSTRAINT ilceler_sehir_fk;
       public          postgres    false    3824    268    237            �           2606    17546 #   meteoroloji meteoroloji_sehirler_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.meteoroloji
    ADD CONSTRAINT meteoroloji_sehirler_fk FOREIGN KEY (sehir_id) REFERENCES public.sehirler(sehir_id);
 M   ALTER TABLE ONLY public.meteoroloji DROP CONSTRAINT meteoroloji_sehirler_fk;
       public          postgres    false    3824    252    268            �           2606    17551    sehirler sehirler_dag_fir_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sehirler
    ADD CONSTRAINT sehirler_dag_fir_fk FOREIGN KEY (dag_fir_id) REFERENCES public.dagitim_firmalari(dag_fir_id);
 F   ALTER TABLE ONLY public.sehirler DROP CONSTRAINT sehirler_dag_fir_fk;
       public          postgres    false    268    3759    219            �           2606    17556    trafik trafik_sehirler_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.trafik
    ADD CONSTRAINT trafik_sehirler_fk FOREIGN KEY (sehir_id) REFERENCES public.sehirler(sehir_id);
 C   ALTER TABLE ONLY public.trafik DROP CONSTRAINT trafik_sehirler_fk;
       public          postgres    false    268    3824    270            �   �   x���Yj1D�ՇZ��%�?G�g�G�	)��6xy��S��N�M\�jrj�{|�Ӳ��7\WU�|��!�댶ju��.>tK���Cvj]��T��V�<7���8u�� �M�O��"�f�l0�&B6d![��5�b?�쏂�:�W'p!�dx�$Ñ�!~D��G��S��2�[ၐ��y^�fui���VMC-�|6_ �/�%���L�d&N�H'�|�u]��M�1      �   q   x���I0�sL��ٹ�?��(,𜞭��C�I���?�ـ��LV6`����8�l��e�l�'�a-���0�N���0�n���0�^���:V��:�|?��24      �      x��]KoI�>ۿ"O�@�ERϝ�d{��g#�0�bI����"������}m_|�i)����̪�zgUe�ݳ4ܲI�_DF�;��/�/�[��^���|�m�3z��,G�ӵ����w_�l�i��<�9?
��ɇ�؆/�?��?��x�.�����g�|��_x�[��6��Bۏ��f�,xݳ7��������D�O<t�?������w尙-�[ �������%z�g�.�Ys�����zO[�S]��h���r��e`om �Z��������>�s1�L�1�8I���܂�[�Ov �v�#�k�
V��_�s�%�c|�����Gtn'��.\����Lr1�6��������'����	-��&�=�3$7�g�B-��8
��z��Gp[�(�w��;p"E�L0�\��k;s����1��Y�%���'����z$UwB�!zg8+�4�~����[��F��fܿx��Q۳]�X�g��w�g�f?�#��x���@7�ޖ�;ֲ���᫛��� ��l�z~�`��g8K��rB���N�&���)�!�8��j>f`��#� �G��]s�޺6\<�.b k�v-I���eB�i�3>zq�ä�ƥD �ȱ|� �x(t��M@���w���������݀�����%�+������{v����jy���"_���mCB[e۞l���>�+{K*,�P�1�D<���x܍��d�G���m��U�M�P	|y�{��hm$O�f.*�k����_�b0&UN�x?}AG$�(һ��G���!��d��~�"q��� }�;�u9�[��_r歊�<�g�!D�=���=s���ۂc!�[��5��ܮ#8G�h�z~4��PL�,�c/v�� �!\"b�~Z���pN�n��vy�tי�[�Ol��&:�������Z�v	
�8�B}����v;���[n�������YK+ 8:�!���E��r����H��;PO t��ħ�߰r�&������>]�
HV�{
,m� ��`&/'������Z߮��	�{D���|�������_(|x@�^����c<�}�W�'�	NWJ|'��A��[K���'�( ���Ֆ�o��d�z�eG���3�]�[���&�mĜ�G0/^��2�s��8Ӈ}M_���x�1���N\�s}�x���{v����nw���9|�F3�,`(;��?Ab����
g=�"l��7>	4	�������H�x:nq?E(�J&�^��B����	�o+�E�#]�V_1|��5��S�m�*NH�I�\ X8����7r|��-�f��>��H��9`aZ?�r�_��T�跮�D��d@�ɂ�9 {��m���&g[P�x�8o`��A�}���6���Th�ɯJ�+ln���-�1��[kk�ج�0����
�J�6����5��P�T(ڊ�Cȗ��j��	� ���fn���B����+f��sb�p�\*%���@!�,��Ɵ�rLϴ z�ݓ0��v��a*������(Ȝ������ld�6�pB�>7�hP�h�z`�2�<:,k�z��kG����f6M��HM4a�%���d���Hi�ңF��@��?�c� ��~�O4�>p��嶧]M��r�ң|��1*��R\�{*�=�JV�$�+?�{��{(_�1�K���MN�=.�皑�AN4M�#�� G1R3��/.���@�`�����Y����7��7�GϿ�]��v5���K�݀X�7?>��o���茎nZ���r�����L8�P�8����} ��"�X6����� �]�j�-��-���i'���p��W�����MU_���1��Q�j�d��Cw�}�;w�,��!a;��vE��=���*���$���+���=9"�N��� z��SY*�����RC�ە�8ul��$���|V�nV�(�1_@�A0���ڪ�(�.D��Nė���ߢ�����ؼ���@O����Ƕ����f��9���Nh�4�kn��R÷EZc3�C�\:���� ����"���t�Y}����%��op�u�,6��O�:�����g5��`A=��jP�56��bgp�tֿ��߰( "VR�[ۿ�)��z�-��RRc�~�k�|��{+�������%�kG)�=�nK�1�:��zOh=,�7��焾���kq�Q��bl��?��˓��zC�X���O�$�?QZ%�?+��rv��YĖp��5�n�b|T�K$�@��]��Hd�n�)��iސV1���*с���l��.��U�?6�w�3�D�4of��h�az��?nJܟ�n����|,�l���%(2uyc\E���un�g{��pl��0=�uF�<˴�bĽ���*bn����о_�Z�Q���O�d�N�&�
��ݗ`�W����q���v���
�l�Q�I,�a.\+m̊*�R�����
:.W�����l�� ���u�G�"�,��;Jr'�Ӝ������o�@�; ;�N���jCy�X����TN�ڿ�>.� ?�[P��K�{2z(�_���I����m-�ox*}H��8˛�wO��e.w�h~k�
ʤ@�����$r��&�b+o�3��t���*^]�3 QZ��"�;��_����5-F���~����oe9���!J`������MID���)nv��o��F�����'yKW<�����	��:�M^�Y�<��][ŗAe{��[��W_�.~`&�����8��(l��k4z1��`�����YS/f��h��"D'oe��,���H�kBH2���i���okQ���r�Lɐ�<o񲼁߻�e���9ėA�s�k�ē��Sln�R�.|�����V����T�`3���M�ϨJ}^l-��#�b/�@�m2	`�T�T�����ߊ��y��@��#\�"|�����4����#~��Y��>%����ϋ����x����}��ܗ�5�Z�F�&����=�����Ռb}�%��#����J)Mg�FB�cCO�
e<n�𩭻���#a�ϟAB�&$w�ܳ���Ů��^r?�� z0%�oKk�؁�wG�s9���OQn�-�f�$U��.wO��8�*#,i��6�UPɪ�Ҟ�`ܿ���y��ݭȳ�}��ň�>��tܷL�Zk�U�G)�Sc!L��/.ߏ��G�b�?��DA<�)<��zWT�ߍ_,�?�.0�O��>)��Wk�V~N�漃����6�J�w��h1�_-��Y���Y���ukӯ�\�)z^U�_��a�o�J�Ź�F�@�6e{�D�-nd��m�)vÕo)�"�wr?i�g�	�<�6(��2��W�<}9�"m2>,����9�Uj�d�BN�U�L����b|X��ez-H� �t}�a��������hU)��-{X�+=>�p��t����=��È �w5�ꇺ�� *�����~����gԤ|��S�{�!<C�o,�*��'�]��I��k|X�(U��6������&U��T��(���O��%�?9c�5���Uv^� `�⒴A�IVW���z/y�`�7���{d	��2]��_�0���
1�b��
�W�o������?<�>�V�
��"����<8�'�=	�����M(�0�q��l.�����=(D�D(�q�ŬB>؈-�E�eny�Ր��k5����w(�³�(`Gl	��V�������d�r���m-&%m�\����F\�^�o�"�|��ǥ>8��sD�c���h�{�Ҏ�� ��`�%:��--b�N�U�zMAoi1!f
�Ad�xT�{2���k�q~i ։K8i6|*�k۵o����������\I�tw-M�M�
O��H~��Z���A�ጵdh�!,�A�VM�U՝M�l�~E��U��� ��=2R ,_�^'ݞ�QJDW�\A�^J(xۯ�B�&K�25�    U��U�I^�
�S��uѽ,j }j�{E]bZa�t���oY���6ICd�ްw�kve�(}�K�,�"L����ʋ�β�g��d
�j�F�{�#�B}��X*��{IK�ʚ�vO����4�&���"�W�&��r�PD��*���������@�G���^�n�_)��Tdص�ƥ�7���!ǚ�Q?%g �<�
˛=�7{��9u%��k�*�T� �����L%�_�;��'\���JEx�Ї�1�ET�Q!N)��
�m�(٪�H�
%[�jeti'�t�6� H�&6����XR�K46~8�F�4��,-�[��³�8�'
�5W��T��0��v���W:�@��̀��.��5�Fe7%	�������U1�mG:��/�S�P�ۈ4Si� �9���]�.��(z�� m.�PG:V�&˔�z��	V˚��,�=�7R���V�14�Įc��;1��(n��c�?��=E7�4]@�u܎������]6r��1X�[N�t?�X��!�1 ӧz=�{&�g9�����z;�3)F�N*�@,��0�/cԱy7Ƈ�bi;��#�6p��-r��FT�a�9���i����U7F������uRe����bҁY�/Y�T�(喥��� &#��*Q�È�f�׍{�R#�8���۾�²|��iyk���Hx��:�j呁����E�&N�SA��"NX��?��q������[��|U�oFl���P�VE���E֕�[.�v]����ֱ���u�`���s�F-�����_Y�>��8�¼斴wW���l�-|'�g���7ܭ�DԁQ]ҭ�}�F�Z���HNi�i��|���Z���4�N�}��C63�2��j�/�#oV��n��GZ�Tj�.	�����|���h�%�_���:'�R͞T�ߦCϔn�'p���(^�}�<p���_mSb�������2��{�NrlwnQ�_<]҇�*�}}
?��o�CN� �F�r��Y�t���W���<ڃ52�;��תc�����L���1��zԤ�Hq��f��:��0[&�F����������݊��0�̰�I�{h��I�uҥ&+;�D�:+"�[Km�����+���ɟI�q�:2�^p�V	��L�z5��GqV��(T�iz2��}��m��+��2��a�i�ߪFڰ�9a�I�z������j�|ҥ�,���/�Z/1��5�# i`v�r�+ᅓl��m�a�^[vDa�����n{��jN7=/[�0��]�E�T��j�F!�4��~ڮ]��d��>���]�ԟ߱���u�s#�e���.l��]�����[z0���e����3 C�hK�hnV���hT�
��m
�5�(g��~�uo�H����9�kڻ��_^����b�#=���]F5��N����6��*0�0���is�JY�Gձ�F/v7��)S8�]��	o�D@���J�?k�.TCÂ�z����PY�� ,9�rn�~#eu�ޖSC�
k2(Q�OB?1��Spkd
O*���#Dy�#짆�F,ObSTZ+�n�H�������*@�����3��*�w��/$k/ ���{{nJ$~�l���z��y�I����7���\)/|�f[�g��UT:L���<+vQ5&��VVDyi�]�r�@�ܼ��΢B�nE��Έ��ϸ}Jl �o��X���x�M���u���qF���ܜY�T��z��~	������>���鬀�BUaȓ�ϙ�_i�1e��G�BE�3��5'��Q6�1�1U����Bt�'f�D;ZN�%�[��5���F�����q��7B�p�Ώ;w�{
�tYY<k���=?逎f��,@7I�iJ�����g�5?���=ܭ���$-uV�:��;�l�q��.8s��|�JR��g@@�h/'�rSy3�`J��y�ֺ_3����cX��k=9��Pk�ѯ�L��b_K�O�P����*�e{��ǜ�/yP�(aOi� YpȨp���'�z��{�I�9V��r,�6�m���v�d+1�R��,(�=�5}��a�������`�%&%k�j�_=��9��z��i<��Uc#UŔA+��/�5yDńA�8�и�	¤�+&��o�}��G������?F̈ؑ�5)Y)�x�Gx� �\�V,)苞��sW�d;�~�!v�6uFѾ��w���4H��?�g�A���C�S�p��Έ�h�o��Π0�1�����_zg�	C�{�o�e��\���h�X[��4g�J֤u�6���i�(�NJ���"��"B�G��z��ĠW[���]��~���shg���:��لC ��dgZL�1f�YȈh��gm�������<�� ��oE�]��G��vD�K�i��;=����pD�{c��;#vW��%;�:�ݎ�mF�9����]MF��6�tK���*1s=ϦuFF�.���h�ȏ�v����2��"U��^cJf�WABw��]��
�'%[촯��`��T�9��Q9�~��T�q��e2��'�8⺖��ӎ ��_5T�%{��4�ѫW�F�L��Hhw�D|xho�%VWqi�D�Fl�����J3��3�M.�E��U(�.��L��T��JM{U�ڌH!퉟)}����|�m�3�����{+�ԯ[�pi+p���~����L��+�ht߼U��9J�І�D=|k=:zO��;���u��G�Gߖ?u�ӎu��s@�����n��ڨ�c����=o����ɕƻ4q��mh��* ��̩���{�A��>�w��q�#�%,����1S�K�UK��")d�aMH����������H��,���N|;�� �6�$���խ�Ϗ8��Fv��v|����<�-��P0����=r�a��[�i$j?�s��2�9���^3U��/���8���*y�c����D�Iu�c�ҕ̙�f�B,2��E��A,�b	
�e�2l``-�J(G�y�9�]��D�r�X��X"�OL1��Ҕ�4����bba�)F�Ѵ���j��hшp�m�"T�3����-|���lП`*�'�s"bg8S|�c�n�_�M		��Jw�����"�~�
�ٵ�u�N���A���������/do�ꆥ�=�*�5>�vi������y������N��L��k���W�~^yK���GQ��,?����&ghv v��т&8yA�7A�@�>�����A�Kfx������虁��W@8��;�>�M�{�Q�2v����BfC>�n���<����ϭ���N"QeR�x�����c'������^[�Q0��i���/f�q����Q�VA��2v:�;��T?.��%�jt+��s�~7�T�N���.���P3�p���O��Hh�n��t�r�n'���`ѕ�dI�H.�N+�㽵�]E�?�w��g�`�[k\�r�4L���Q;*���܊�J".B����{�E��mm�T��A\��}@���q|7�/y����0.���)V�`�>���i�$�2�y6���9�/�5�5�x��k��Ћ��(�a��Ǫ7���;ďo�xt,�C#f"��ńi��*<�,-��^���bi�Z�Q�	���:|��	��7���|�L-�h��Z��*˃�*���Y��V�^�+��x��R�iH8?��S�!����+��1�v��?�$'�}���+���(*������2�"ql�_x���8۹�P7�uZOg�%B��Y�)�����\�4
�@k\��N�r��%��i~5���'5A&����%�Qɾ�J�ߺ���A\��d�N����x�%M};88��ؾ��p��"+�Ǧ��Uݔ��}-,���>@zK�*������ƒ�c���\�6�e(���>)}�c}��Jv�-������]ȗ�-����d�F!DskmQZ,�~���,h1!v����KVk*�bS�h�8��vd{�U�
Wz����Պ����e`u5Y��W|��mm�h�mFh���~��$�M[u�F�ukY{l- `  ��: )u�Xk�͛���tG?�~��.�S�sԃ8���^�@C9��:~���tĈ������=Q)P���&h�� h����n�s��9	Rӑ���yO���8X���=���AW�u I�Н7X�Z�t���0[X�>F{��j�Q��=5*{�;wPخ�\��˴�,.
��b���ˮ���*iP���!�;��m�9�~���s��"!18v&��-��Q66�s�̕��3p0"�rLT"�)��o��M�y�GoZ���;���%�־K�oZ���w��MK֑����i�:�_pZ���w�NK���_��%���1�iɎ���O��,*�w�{u��/_�/F",�      �   �   x�m�=�0F��>A�9�����,�m���&c��lm�E(��f}~߳7Ŏ��4C�:�S{E��V���)ĺ"w�C��P-�����Ybͺ8�|�%f����y�ׅ�猪��H2j������"�����+�˳q��l��c��cr      �   �  x���ˎ�0���Sd�J�"��-!�Hu1l*U�	�"�K%� ]Ue�v��]2�U'!!9��f�±��c���Eno`ˈe�w�䰮l�OL��M�q����Q�F�K���'����:^+jV�K����k&q,5�Cj�=h�m1`�8a;��2�gbn���NG|'^M\�k��(H��J�#)`�yI5:�@U[kJa�������$+bQ|x�������@#����3<%���:nG!�X�Sx^;�MF2�]�jx64�eڪO����~3�]QF+�#�,^����H�%�3�^���������F�&��(����/��lP! ��w���vt#�O��1<S�Q��n�U�9������Ĝ���E(#vK�t�v�~��+*։GL�	��$�ҦA��+§٢�,z�������s$ina6}�^�~�x�\@]ռ��ե�n����"����.���	����h�eS�j�FD�B�[p��$(���m5S�\�RUԩ]|��1�J.`���6#	��Mz��n$AAӎ�
;��J\���9�|�w}�Ɗ�1Oî��Ox���/Cka󣪙�^W&�b�Ҥ
����~��`��Zu7#���>�����[F%\ۖ5+���<,�>ʨ�QE��9�<.��њ�I�M�͓Q���3Fb�!�z!�X��_�����P;Ƚ����E�,��fv�V4�L��TѤ
��My��F|�y�?@?&      �   �   x��һ1ј*��R�}z���p��q�( @`=)*+#ce�P�X���k�1;/���'�w��G��g�̯�O�ߝ_0Wv�^݋J�| z`[Q\YW�W���E�ecQdYY�Yv�.C�J���J���J�~̟��|G��      �   �   x�Ŕ�!D��b���r��q�n.W�D������뛑~��5x��|��cR^�2���8�鍺����2W�S���B4H�S��0�啠)�*ۃ.����}�E��T�t2����A�D�M3:B4͂�h�U&	8!j�Q[����[k_"��      �   �  x�uX�nI|N?0��_�͌���+���=���jTݍd�������}��m��ꪆ�"�.�O��s�DD�*�lV���)��QFǔ~��:���I��x�Y�}�U��_o��nP6V�~1�&�mb��:m]QVۤ�׹f<K�G����ϛ������u��!�;�i��9*u2ۆ��:���v�o	����ǯ�O�`����%���O�YT�	kl�� �(�����]վ$lWTN�>�^I�Ѫ��nw�Rykd�9��l
�	g�Q#<#�ʈ=�sb{쉷��ǠKv*jǒ�3�D\Q5>�݆;f�hu4�؜P���H
�R��Ɩ�UUf�����2�m�����A���K?�Z,cMH��� �`��  [$/Љ�8fg-��a;�6��Ge�WU����z���z)h�)wDEXݨ���c3]��o���E7�eo��hkNK7?��I��s��hM��C�Se�P3�O�E�5 ���a��Yv�5�PC 26�2�vL�%1�߬>�k����%OZv�q��KT��>=�w���2��b� ���o��4LZ��%��*�䩕����b�9`+�4��G��l37��o��S���0�I���ܽ��@�ץ��&d�?	��$��0�lW�l����*��Ӳkj� ��_���۬��5V9�q��"yOB^�	����6�h�x�c�2�hG-��������ڎ�k�5 �`�g9��;� '�]���,��>_���G�2,�:wL�`X�yB�U�y�mG�$"�yӍ:&�^����g�A�!��������ۏ���VYO�Ej���J� 4P�P����a�NM`<�%��A��������ݔ+!.0�6L�bSDT�R�*VP/��~�(��l�n�m�T�T K��M����y�*��т�`H+Qz�g���b��ݭ��������!�Ue�8
q�pH�������ݰ_}n���\fy��X� ���|�"0>(��~����0����B�?�<p�������ow {t��v�b��K
G��C4���K��>A/�,/��[��,�1�,�����@�0R��
�h���.�~�#��y��~�}�wǑ�.�#�1�d@�*^;ÙI��Db�s{�.��.�l��t��`�"����@s��k�!����㆔g$y���9��hikB7�^2v��M�P�j�R����!�f��q)�J���,0�T6��%�h&P,�A�b�n~S�"o�墔��N"K��}w�&`oC>�7?T�˲^7��m��R#�Y/�
�
vB�HO�'�C?<�[��r�U�ð�G/�5L[�|҂М�I�Da�2X:�"Uk[úa�w|�zӍ+Rs���
V�%�[H85'�Aԑ%�EHO�i{S�/f>��x�o �(^�"ө;f�ȴ�$}��x��`I�/����'�S�n�v�`�v�A�ۀ�����@?IfŶ^\�t�NP�ln�C"^V`���f^>��+�!��[�r��hZ����力y�m��M��B.�~V�E�`�`�yՠ6HxQ� B���0�ܼ�Rn��&g-M���/�`�J}Ս������:s�뚆QAx�DX�իոclkpǘ]*.#��]�T�h�B����x��Z�q�P��·��6�-?��`����_H>>I�ً���\i��`-Ό³ͯW_f|6���tͱr�aa$m�$i4h&�M~݃�i�����r�܉te��B���3Q��p�h�,F�@�g��g�u��c��oV��(}���	֊bH��5	��0����5���W?0�F�M�#]m��ܖ�4�h�\'8�L`a�7ݵ(��m�<�Sj����U��r�z���AD�̹].��h���(g��o�a�y�_|��1ӥ�L���v���n�=�0�����r��$�PN�(/0����^��㞮��;5���F6lNQoW�7Pz@^^hx���{-�Ǉv΄;7.�o��n?��o��.��w��� �[6A��{��{�IuΖ'�@������Q�t�q�:��4�����d�X�����a����x��={��EVTkQ0j�H(����'}��Ͳ圙�Mp�D�= ԀdU��?��IC��}^�Q�,$B�������A�k�?�_���UNn��=+!#^�%�¦�����l�t�5��'4��h<ݻ��'6r��N2y�/;�0N� w	]��ȧ�����鰹���?,>�]y)kOM)�V<m��]�R�:���3�m��W����볳��}*�      �   {  x�}�Kn�0���S� A�!���HI� �)� �QQ#�8�"�@n�U�,�u6���{ulKi��� }3��!z@�<�nb��q���.H^
�m�3�BD O�$o5Z��}ݾNc�؏*�ys!�XmI��
��H����_�������U��1B!��֋rپ�;����*@�]+�|r@�i�I�e��(��D'��x�dy<J��r�Z�������E��"IK1��#=q��FI�2^
�M�f/VL0F)�ZX�p�@+����6�}�Z��sZ���E�-���ry��	cjސ���S��K촯β�p�+��!%F{���[���=}OF���4IG�k1������}:�'æ7�%y_�: *�dn:i�<ogU�t�u\�{����|�\�{J:��C1=I��q2J��h�_Y��I������'��s<m�QP٪Wy�[sQ�φ��0�,����s�Nx_$�??�?�b:�_O��%��z�H�b�ez{l�C�Y�%Ŝfs@�<4|7�U�O}���t�g�^�×��>fXm�nu��0Y��`/���V�]\[O2�qd=�xzy�ߎy�F�肩<k�"������f�ry{�"�AW��t@���S!�_�RH�      �   �   x�����0���kg�c�%���HQ��r�2|�4�c�]t����>�"j���)נܚ����^��+h^���=z���`�������)���O1L׸�w����O�Xb��p����,��p�p�'����͟���2��U�`����u�������_��� �
L`���J�`��L�`0��ZJy�	P�      �   �   x����	1��gS�8��n/��:��v0��?}0�`�3'`�Ӯ�|]�F����3+����s��y+D94+4�ЪВC�B[�
9t+t��S�G�z�P^%2�:��F���p4q���ȡ+G3���t4u���ءkgk���������1��4�      �   f  x��K�� E�d1)@񳗷�u<�t�Vk����"IFZЀ_����;�Oиׂ���1Yl �HG"��<-'��s��O1�)��P9Vc"����������G����a�Fb��oR�&r��Lܔ�f#M���J��x$�ͺ%�d}�E�ӻ��-g��=�ֹ��Z7����#���m�Խ�w����&B��ZǴ*5���h�!de!���h�'���.BY���:��"ꁨ����PJ
(\�<(k�p=�\(�i�F!ʊh�Y��"Z�h���8�+p�WH-pD\�BV'�f?�%E�
PV@pW��P��mg�'����i����/x�/+ �3��ˊ��}��j��      �   �  x��K�� ���]������m'�i�3�pI	1?6|����`� `��J����];Mr_�=5t}���7���s+@D:/��T
���ԣ5Z�Ԅv�`��"ȆH�e�I�M�P��t'Ak٪�A��(%%�N��#��;%�Q �n͑;4�'��+e6�~�U;���?��1x��\��"d��]��Q�^���K �Z� w>�$��HbՅ�7�O��^	��z�+pCo�
Z*��HN�r��
WZ_A��m��%�No{�r�,�m0��Ϻ����$���j��P����}��_a�Go�w_<����c�qU�ң2� WWsE�����j��W2\]͕�J��������+���f���?��LWWcuh����j��U����C;A�n�����^�Z��j����a��T:���f��U1T�LU��*�����3T�.\��:]�W���:�n����աu��㫹���:61�MU������fOx5^xhS�k>�oqJ��      �      x�3�0500�\1z\\\ O�      �   �   x�͖�q�0c��{q�u����7!���"�Eo�c��m�Y� 0b�@��bŮ,W\>����/����N���er�����_��T����ż"kiU�Rk���b�F%�J�7|PS�N�!P����u	�ヺ��A=���^�ʙ�S��a�G���R��%-YJ[0���`�(�HPF�QO ������FRH%�4�BJ)�1P}�O����\%�      �   k   x�=�A�0���a"����2�V�$]��d���a0�i�D�¿�v+�0�^������`�����ۥjקh�꒭�f��ܮ3��M�}9w�ݳ0�{!���"�      �   �   x���K� D��0c������h7�,2B�d0z�D6a˪����`Q�s�^��4k~�MZ�\�>mo���_�S��R���ZOܖQ�o
<���7�At�#��(��O~��%����CR}�凤��I��y�i=�w�J � �?��Ɵ����C?�@�~@2��H�@�������o@!i@//�����      �      x���Ͳ�q�;.<LY�of)�u��#ٕ�@�k�l�4��nȬ�z�k���N8�����}Y�
�5���lTbWfz�������%]�����}󇯾�������r�q)�~\rK��?�s��.i���R���K��T�%��%�̏�5y�K��<_Ҽd/�\�/���������ƥ]�~���R�k��c^5�e���H��ӥ^읻�s~�~��
.N[��Rҥ��^�W�c�r)cK�|��ic>�1��9R�'�|���������w.�aS�t�]��<o ����2�w~X7����\�}�S�����Y����7�����>�����[��v~ϼ�T�}������2��|�ָ?��{~�{
�}��Ӈ����K�M���x�}�S�?�r��+�5�')��1��\v,6-���=�Ӽ���qi�|i��=->���]3Fɗv-k�i�k�Xk�/����ʽ���r��O�W2-8�������H�a�
oq���{�J�&��[0��O�f�\g��^�M���mR��/���#χ�����K*��i�����v���a�-�1�����峽�^5̧�|����S�o�ߑ�\�����-�6��8vV���O���9������s��;�;��a��y�;۹^��2�H>���*�i��>�v,7Bl���6_q�w⚪�׌:�g�犝��4�<�[�1_ÎQ�.�<;V�5c��]��S�1���a�i�zܛ�t�ĥ��e���Y-O�4^�|��gnr��1�=UO���]O���X�w���[J���i��0۫��x��7_��p1y�/3��χ�/�<�1]߾�53�X�w��;Z�_�ʊ����8�����Ϳ>�4��k�|�2�r�Ux�;�9_쵅�+����u��iC<�t��7�:���v�'�ɨ�g�`n�i^�|P|@ۚ*e�?8}gƳ��a�5���Ĕ�1}��e�6n�H�o��ƴ,�E3��ٌ۵7^�|ǘ�;o����@h[�td������ql��q�cN��Z:?N��V�N0���}����0g��hӜ�n�6_�\�8ֺ5�[��#�s�>}_e�e�X:2��]:���J=g�o�L��c^7�?8*Sw�b�䢫����]��i�z��'M��?ٟ�x^�;��V�rq;vvb���Ϫ�6�e�I-w~/�in�1��.�S���<W�|�i)7��?p ϻ�O�o��v���~弚A}p�C_0ϖy�/���q�g����i���%5ϳ���F�k��J$����m�n��.�z�?�<AJ��`�^q��WӢa�_�������y�6>}�|�	�>8c�����sy����Ʃӳ�ߔQ���ϝZ�?.m�s=������E\�w�-x�S��O�q����z7'<?߮�F�o���7>׏N8.&X���e���fԂC��}�ן��4��b��(Ӿv[�h�\�[��H��v�Y#��z��?ur�X�:h��Fo���]�B��x�&���8�zo��uI`�~6�,юF���L~x���xZ�ͼ��3f,��������ɧO�#���>��G{oq(W���I�܍�;�b��tgzb#���H�뿎e�F$2���x)���c~3�f�d���i*�>N4ϓi�|]e`�y����EL�7$VLFe�:�_/�'�n^�^>@�\7�����X���2}
���O1�2^��G;L��{�e������W�:�׸�_=}x��ӷ�r{f��E�J52�cbsO�a�q�=4с睦�m��:;x:��f���VS3��s?U,FX�Z���r�k���M�!�q�f)^=�?`�ϓ���!>)�J�{�b�=������ng�^8��o/E��$QYj����3�/Y���t��)��2�H��:\7��3N-D2�\����5q4c�y?c%���%p����nˬ�2�z:s�D�4����km$�W��|�D�0+�F���`#�c�NaDj�c�'^a��0�y�������dn�ٳ�=w�fG,�a���u������]���6�8s������_�D	�q�D�w��<QٲuY���0���g@pq=[��)���+&L�ͧ?>}x��V��%�{�8|���uy���)��\8ශG�{����-�|���-��|�o����:�S��Dpү�?&J)�t�!r�t��7�2��H��54�)\J�3�B5���,ټL�'��UrWN�7M�ﭒ=��s�/�W�$g������y{� w�Xl�;����J%f�Y�'석~����C�f����ޞg�ܢ��4c�3c>�����3�-0ó���W����"ʘw�qxZ�{��߼��2Ș1�
���\��~�{�c&���
�I�u�>x�6}��:d�����\ncm6�?X����0k:#�qޝ��%�0�%+�����]�H<�1�A�W��7�$�s6wLG�|�=��o9e_��`���髧o�ݕ�C��L�i�s�sf��<m�4ӕ�P�dO��Yϱ�jD9Lq��р7fzT���]n#^��O�����v-�S}�8��Հ��?���qqq/���n��:��`���g��*�xR��R��V���
A[1� �g�M'#xc�^�~g����;u���L��t3m���/�0_�����8���Uؗ�|�2י����1>�O	b'zK������ڊ���*��Ig7,�ׁ�1��|�ʙ��HC
P�<��2wF[y/N�%h6e�8_�B�L��[��	q`�-�#]����`fsGL0�xf�$�L"��/[ fi�҃[�j;~��m���_)�xA��Ȳ�i�i�X�wQc)F�<v{Ɇ�pYn�G�I��f��y������h3���:>X��j�������^���|�Ûw�ެ\}�]yH�Ⱦ͇�cnF���[!->�� Bq��}n�Ź��EY�{�����1���ݴa����
�n4�7��$�lKކ��f%xm��w�[����5[Tr��"3zP�Ƅs��71�R�
��l\����I�|aq gN��ƌ��R�M~Ҥn��\���i�q�0���!,9�.&��(L�1M�θ?f/��A��������t�
��\ ��M�Ҷ���MLl&ED�h#�uf ü=��H�}�o�ܬw�@	�k�-F�C�S�H�W���g�o�4�� vKs3�T��������We�$��Ιl*O����ZÈ���[��ǩ�uw�����4�PqzzѦ�$o��g�K (/���f�����lãOU�s$��0�A|��vW}�m!�(�ュ�i�´�}���wo�}Z8�R���T`>�\�O�Ə�����B�ӧ�L<H����O��dd6@��.^��<���d�Wb�c_�ww�fv,kO;�0�����	t���(e�	�ҁ��l�ܝEn�/9"EY���h\b-��!�OB��o8��xц�]���yE�q�=��υԚ)�ژ3c�+�{@��5?l}������_����?��Vy[��7ҽ�|L��9��u�ˡ�\	��<]�vxc����H� r���DT��O&G���̘�|�jz��� ��L�J�R8��^b|ɓq�ɴ<G)l���|F���̻�X�_
8g|J!�R��i�k�H� ��{��=�ù�*E��?���8���c�������O���i"�'��6׌ػ�'qB,ܲ��o:�]����3��O+oL����,rF`^���x��K�|XZ�t����m'��V
��J�>C�fDh�O�P��V�"N�r3v&r�x�oϩL<6��\ �ð�Z)�8��q��Y1�)���!�&p�0��Sŋ"ڗ�I���o����'S�f�x�ԩg`L�,aUl� ������X���#hӿ{��L>~��Z;�b�e�8����h(L�L�r�e�^*�7AK���I�H�����n�ޭ�� �_��x;cF<�������tt<"�'��pu�..	�����<��f�'���w�]�0�_8ð
������K�b�TI��{�D.s�܌��W�#+Y�͍��%޾;I�?D����%�_��.�ao�],�-�~��,\\�r     $�<������WD��	/qx /�@�'�ܲ��{ -�`��&�ie�i�2b���X6���%��݁t[�eaP��u5�;�	�{Fg���m=mP3���%zg�&~��$_`�Q�����h�W��$U�B:�ô���[����ؓ�^���>���J4ۀ��瘷�&��-�S�P�B�rl~Ƶ�zu4�2�B�Yo�]m�b[�l� �/̈́u�q[`$���~(���������vG�p�m#]
G�l;�@�Q��)�����閞>�q�����|}+�����7�~AN�rx*��� ��6�5:�0Ɨnh��r�i���lU?OOx�?��d [(�� *@2�,�+���/��*�����m9�����Lԃ_}y;���� �)���G��n?�g+�1��ĉ��U f�$0�e�o����E��H���C(E�T�4����2 ���󌡃�CY��W7(/�I��gG�T��̫6�@WO6C��.��)��+��x�y��5�$�����9����u�9���!���ȷ���nj�0Ic�F�;� #`$�e�Z�\�IQ�� Hp� ����i�*�q>���<0@8�U����qR� ��Ť�n8)�UI{�H]�,E.`=Pd�+�Z-�&�ޮ��j����	^��j3X	�2�C�����D�Z`a%��NŖJ�W[X�8!�ܭ���F��!%�Tց_���w�)����;lp�x!�R��h�њ�v��2����'4��O{	�7 j�O���n1���E��cTC�[��2�QG%�e��� { )��G�/���KEfď�H�|�SV�kP��̙�k #��_L�U�w����"�N��˕���J�����F�3>9<�x����5+���:z�� #��g��|&�}1/}<��&I9r.����9,/��P��>�}��f6��O��Aҕ���~}��������w=�~[%�T�b�P���j�(Nt}�&���]jJ���$��pҴE@��1��z��~��� �K²��x��������l�P�?��+?�-v9�7��Ǌ�v��$�n.����r��< @)*5��TN���(ֵ�<��'>#A�X�4Ї�N�x��KdiF�r
 �.jEi����r�-K��B!�����fq� 'vӉ�V@�yN���r�0�
}1���,�e��:"�A�A�Y�R �Q���C���n1�e ^�������i���)7q;���͛i�Q��D��0I�j|t���a��Ǉ7��y4%XHs]pJ5\H6X��=�n;��M���
%�#bW�"��a��<jfv��ө�k-Aw:���B�1� �$�+Wk�| ��l�m}nkЗ*�AR��(8�]2��9hj:3aB�|q���9T�b*T� lXPƽy�-h/[+_p��>;��I�|�FR��vb|A
.ϊ�X晕 ?�� ���0a�	���������# �ή�ԷE�j��7��~HN�u�!X�=F��q(�ψ��k\�{~o���פq�eP��W���$i�d^;��ɠ�_xZ���Y�bL� �Y�cFħ��۷sO��R�g� Bd�/z������l]��Br�w�,&�J�6=�Q�P��gqD���߼���HB"�)�������T�)�π��Ƴ�[?�ѫ���BH���d��v)����gx�EgT���$A֐ܛ�($a/�2`sB,O������D�x��yh�(�lky�Wx�����2����`^����{�y�rB�%�*c�@a��a�6��4q``�&p��G(�]�ï�ޭ:֨�?����ւ;H�f��W&2�.�M�^���?��a]�xW�~��Y��pk��8��#�|n#�q�@���L�x�T���c�T�;"1؀���s�ؔs���4$`�����ɟ�3�D�`�d���m�y�˙�M�����Տ�����gY���f�4R6�H������x����:�BK�vL1̻�AʄGo�U��[�h��(9<����o~֣�|1��ґ�s�rԀS8��s���E߰�vu���Ǧ�JR�V����oxl��jFǃ")��0� ˳�"ҢT�Y*��5UG��+0^�SdJ~�|����;ѺeY6���XpwvΞ/7 �
5��\�8��&�5���6q��;��p�w�r�y}.-��^�Z�_������m���N�[۶��L�_�n���y�� ���q�f���"U��T��s����%^��j��=ܻ+uᒗ��yP����EZid$ظ�S�2L-��fL�;{7Z���z�¬4�q*��7�B�L��t��;�\l�����l��sѼ��ƀ)�/!L�JBm2�dv.�6�	a�y����5�n|\�¶�ٴ��>}x����?�1c� ;�H=-v�A�
3_^4'���a]�I'������w�,�ubRj>��T���#�I�'EcL*H�'݀{�L! �ȓsy�=.�o)�zKtj)�֟��� �|S�q�K�d
T��B#:�o�3���	4�]��6�
;�"�^Z^�˅�^x�P�oT/�<�� x�̓��,{D;�A�6�頵�����Fv��ia�Tn?��x������Q�k [����nM�R�/[\\�:G	���c����ua�F���s@��T[]��z���j,�)W��R���!�r\S�s��:,�(yP߀��f�L�3#�]��}�@~s�G'8Yl��L���O߮�/�qD���`n�q�]� ZF<i$�s��fߩ�јgp!�J�����d�\��
�u��GΗ�<}�����7`8��5KY0��&�{��.�"�b���[Iv�;�Y/�Q��R�J����m�0 (���U�i�i��N�k�S��n��.���8��z��x�{}�+臱_Ə�ݴ�X�~�>|\%��!W~�u؈?{�R�n%d�}nzM�	��3X�&Fi��->c��]wFito5Z[�QpK+�"4Pڤ&B�@���/�=��?uA�a�����ml>������䵥�[��&I=W�W�"�����c���.M:V:�L��G��u���}A��Z��Ʒϗ�v#��$D85�Ժ�"�5��g���W��1���Ǥu�	���a�z���YM��(�o[9��\�H���F��h�Dˬ@zea\�O�!+����0)�L�-����ÝR+l��c�A���p�ſݥ��;I�f�Ѡ�I���F�w�?/�F�N���g�(/x�Z)V`Ƹ���K<��E>�qIm�e��l?�5).��>�Zfk`]}؛ktv3��a�Fغ0��$�/�}�鏫�J�8G��Vb�f��ج��"�$���/�0�.`c�R��b7�g�u��É�s� e��5���	�;��B>	��A�jlFH f�f�K Ғ�����*�~񬍦燎��.��^,���mV���[|�*��F�R�o��f���`p���xc�K|x����Ĵ��x����|f��c��}�
8�7P
�AŤoI�T�Q���#�4;�˾�����_ "�;��tM$�ٷ���ẵ�Ɲ�>�����'�e�C^�W��"�6���g�1PN��d����E3��S@ ��	z@A�V�v��`���@�2];�=l�L�����Kv��sɡo���{s��C���9GӠ.˺��	�t�;���8㉝��8A������W3�y���?}����BB��I'w�
�����>\��?�/�50Y�9cE�Ic_0���`�[4��:3�bI�[� ��ʶ54�����qn��!Yql�`��!!"��)��ݓ��H.�3���lc�=��:חsңG��˂�%��j�iKتCj��mZ2]�H 7�e�������?�Y`i�e�Y�p l��񃸎�Q=W+��3?o�
�����9�n�L.u�*�á����b���8�n���̱�!���>��A�X����r�����91�L��D˞l�����;�1��~K�_~    !Hz���|���h�E|R׶���\�w��ِ��C�2��@�����
7�������Oެ��1b f�{H���!���8y^C�[k�0Mj��9�^�+�i{t�����^sD?��:�]z�v�@�G���2����+e�%� 4��Cz2�3�A�E��0�{֏Z�lQH����(1��8�v%�����M[�_�|��)�p���ERW��n�Em�`���V!_��Z�,�)��|&+���Ǉ4@��JT`�����^�凳�<
�,(���d�Ѕ9o`Yޅ��g;�n�a��NfQ�G)�G��؆
�(��x"����8/�E~�;,g���@�"O
��u�6�R��>��|�|uC��G8���v1ж��4(�3ڿ�,+rhO��?Ϸ���Fh��n+oS!N�V����w��4��������֖e߼;1 �j���e��O�Pj�$QO��T��u�-���Wfm�?�Pgg�f����F8�>���ի,W$q,w��|�
�&�E�qR_�S��t���m/B��W�NI������g�Ŏ�\�$MT�n�舋j}� 	nU^�7/[��o�4ɺ��o��Z��S����γ��/݂��l,I�v��V�sL���:�Ǹ�f�#G@���~�t�����ĺ8�Y�7_ǡ�(wP	�Kā��VI��FG�6�jGD#sGK94�����K�!�HW�V�LD[U�"�ƕ���W� ����J�0�a9@�ec�����e��k tR��|�L�x�edo.���c
)}������r@��)[&<X0�lKٳA	��p�_���pa;�����޼}��)F��4(d��X�]|,���+6l׻Va��'�^Mh��t�սE{Gh��t��D�-ҝ��]4�[�Tvc�w�`:y^��2�6+8��qY]��Y�\ǑG�x5����BX-�EE�B�Bnh�j�P"��+j�?#	�ksq��$���|(�N,@� rw��bi}:\xӒR����zw"�vZ�Y�C� ���13���98pls�>�lqP]z�0��a���!��֢JQ�T3*��Rs���`�q� m�
�n3�"�7i��z�� ��N�cm�?O�l���e	�٣t(��y)�g� 4�����?�gA�����it��oR�� �2�w&����|��������黧{�KS6�Ճx>�;t�I�ӌ�l�5)������U�xs[���Kz����Yj�,E�w�w�:�O�TN#�*�J���*���BN@�z�jf�Y���O�v���HW�2���"A,�j�@��E�xP+���Dm  �[��#>;� 籤���j�|�4`Q���֓��w�$	�U>?^Y�+Z�#����o_�}sr����W�zD�2V^/������.�!t��:mrk�xx����� �,�kj�@��>��I,�N���� 3Y�@EY�:APy���@��Ŵ��B���5��ڡ�"�}�x���w[Ｄ���|�K�N��
?񿂓�:Yvٱ��C�>�a#����,�G�A����U��oYj�	U�1��}����\����3Ļ�-�+5�nu[�:B=0q}��ٞ�͋��ӸB8\W�orF�m�[[�e�K��썑$��EDh��p�� ���#�b���О2l	y_0������n1������>�3$����/H)����+�.�	��9�R,����&�'�."r�V�q)5�R����*��껧�ߟrl�k`���ʦ�! I��x�/�ӾB��'?E��XJջ2cx77S7KP��Y�)�㢦m�6^Gdj�m�#zW��^�Nb�ug(�;��X�������b�
eȤ�h#�!������=`A��I:d\A�Ey�[!�������#x���w�~^<3�7q)�&��.,s�m����X��� Ѵy>gtgzR�c��Ls�%�j����߿����6�q�uZb'P1�j����+��3��2|�i;=U�{`p�x�k?t�C�9<5���m�R�m�HC��e����%����XI쀺�ʓXB��خ�fe�����eQ��Z��F֒������ƽ�3��'J�h��tRP N��*��^r�f��Z��L�o5��i1$�f����S�jY�<I��y��!;��6��v%J0%��J�prnr1���{g��\����� IP�H��.1���/�~�1�$�h���nrE�	P�i�?� c�JS�2�t���V5pH/.�-��9#��<e��P����w�k]9!��cʹBWi�Ī�o��7���Pa�=��=��)DvD�ZU������?����&������0�F���0�|��95�L��KB�;'�H������!�.��k2�Hi����*��im�c�Q���YH�Yp*8P9�Z^`��8��h���m\ �!U kE��ͤÊV�I���ܩ���"JҠYr���7�iޯ�����N��'B���72PH� �<���a`��G�گ($F���x���)��k\U�0�����c�*��jz	����r��8з}���tRBbց�f�-50m��B�,���Ǫ��X�I�'\%��R�;���o�^)`��"6��@��2o1c�	�tG�&�~��З���1|����˒c�Q�d[9D�GH�ֱe]�v�ftKl�D�gJ����S�z�9Fs�/�����O���)U��u��m��d�ĎNym�ix �fH�Ho��VA�ǞϮf=�Mݲ6[3�ʜ�C�1N���l�丅��l�,�E��n3p�!'A�yLh��|������݈����P�O���
�dڂ˝{14_ |�[�q�Vp��*��k��e��3��l+�!#����#Dv_5�h�O���)_��)͡.5�Sz�ջ�$쮜�U$��A�bp�m��>�#DԥY�p�^4��Ĩ)�ʤ�Lp��s�JP���1"�t-���R!��6��3­7�+յ�jA��,������K�%���z���K�K�h�� {�$���%L`ʁ��h�龂Lh�G��Ɂ�2?��_x: vܩ�:�z�jSl�#�h�l��{?�e���y/㟅6��ј�0�vAL`��"���y���
4�����XT+9l�\EM�՘j����el��
��=:��}և�Cg�g#]��kBV�TI��|�*u� �m�M��x����:a�_=�v�}nT��%-P��K���,���wg�w�\���X�s}���8��g�T�솓i���yx\كU��(��HRE3M���lxKX��U��@�Y�ۚsyWgď4��N��Ɛ,��L��	5��x��kd��>��wz�1�����u�݉(��� ާ�
��^��&���&w��̆�u}��bQ�?-�\�����A�s�KiF��~N���:�@�&�DB鿄vyVk��<����H����흗�H7�"�!�vVT�*N��8]$�m��V�X�a���=�_Ez�bX�^��ҡz��z�M�rLe3���.�lc�����`�,�,�-�3˳&��+�ZsY��͔��<�Ea��`2�͗���R����_/����Ј#݄�jn�v��;�m}I1�Ս�P��;ӝ	ɽf=�P_0X��%=�8���QUj�nc�P���E�#�Z���̅ݚm�|IuH�L��<�fQ�bsI/��2?F��]=�X%��:�`.4w$�������(Q�T���
꟭(����@ų|�vr�n������`�6�d>����Ȗb�Bn���y���]6Oy�v�~+`'���ŕhsĊ��Τ�6�#�YI�ˍ.-�e�S殡^"�����i�jn�i�Cjd��R�l��H��x��.Q ǵ�3�	nk/���3��?�s;$&z���|`1[;�����ȑ2��ڙ�l/�����=��ۯ�T8�E��lg^��l������β��=�϶�hΎ)[@�jf��懷���\d�y%����[r~D���ú�Mΰ�fi���kl�ҵ/��r$F�x����� ��&    ͯ��|�.D�2��/2��˙������&�y�'�E8�F�d���0�c�f?�2V�ܔO�AZe�X�N��Ga�>J% L���\���+��>��d���a+�4�[ZXI��ay"�ρ�������tP�0�ǯ�}<��"`F,��X����p~򦝲���,q�s9��9 $\������z�30�C�HE(�y�%RĴ�㎟��5-#�W�U.�ě{��D�?�����N��r 6q��৘�tD���v+��t?F���H�Hx����F~������k��f-ur��)���o�V�,uW"w�%�eFM������W]-l�OO���?-�����C�s(�L�=���G�.qg��?�)%�,�n{7H��s��wo��ɺ����,-�1߁�]y4C��Y
�9��'�6��@A/�����b[�7�a���Xpk�� ! Ԙ14��������.!�Z��=ʒ*q���CP��:��AR�=���@�ni�7�$��#.r� ���s^6A��!�?�4��s}��ѝ������;�g�S��EW3\�����!<s
0�a���R�2����j���߯�E�X=x�<�;����Y���͋tU���c�pW�,0�fA����O���b;�����I�y`�U"A�y8�����s8lh��ʜ������ �\V_�g�^���� �'np�')�vr���nNE����^��蓻M���B�������V�9�J�?)n&	=7�G��3CkQauO\�q��lK�aa�揓�(� &a�t-�ᓖ�"X���*� ZS���K��+찇*�ܺD�����p�������GN=4m�Y�(T����u�ր�o�b�=;+�y����\.��7]�*f�2g�ۦ��y1euxg*E����##���XX�@k�a���x�����g�H�f�J#g>C�2�z;�I^���� 	)+���`�㭞u��I	ȯ"t���oM봽M
�b�K=J��
z���kp���f4eI�4m-�*E��7���'>Y���-�.~~�T5}�e���!WN���T�u��|�]<�*5��@�v���,d23�����eemD5��!'b�pLU_Q�>'���R��9zn�������fHH�Jմ\'np��r�(�Н8��B~x�;�ML��0�K�m���GI%E��$��3n��>���]����O[�t�GfI�E��S���LA(�Dn�॔��u5laMC[������,���r9@�3K��;��X/ 5�����K�}�ku����Y��0�j(UW�Z9ƻ�*-�8,��A�cC�ʯ�	�O펽�Iʤn��𛪤,$jM���1
K��œ_�邅�1O`���{����[(R����������@t�z�!�LQ��.�;3:�uO�c`UwU��',�᫏��P�9-�-0����#dK��]�K�M�+���uQR,�c	����=�T��7�Jũ:^-�z:�M��lT�y��T����~h��8x��F�8�IfN�o�\�N'�ʭ��QBHV���cַ�:I��D])GP��w�]�-� ^�V�:���,�i�P�P_��1��e�F^Ėy�{��������,a�O���_����=J�cXs���[����|X����xl���yϓ��@�cn͈�եñߏ[�U��S�j�k���Ռ(�j[WS�/Ѧ@���!�ˮ�}�^@�&�G�tSj� ����-�8��TJ_a���MG��S�e)��ډ�]��U"��.��lѰl�E���۰R��Vz��7o?��
����"��d�A��Ui����\����L"�qn�\^B͚�C�����M���U��m?[���Ƚ�Z����� N'�.)F��NK�9\1��L�%0}��+��ܤJ���Z�zG)���X�t,K���e�b@J(7�']4�Fk���m�<����wwz6�;�;g]V�u��M7[��hD��U)�D�2U�3��V����ğ������i�~�ӓ�N;5mR>�J�WM���ݞE��jL�px/EFX�h�����[�Ó��w�*wϷ|�����]�G5��d�~\Wm������V�Vqr��O����8��S�Y0�6�P˸Q����U��[`ۜ
������c\אVi�Y8>tՎ�ٗ`D�>�=)�?c6���#�����o$�h��T�SD$G4�Ū�1Z����%;"�g��S��G0�͑go�g�|ͨ�a��Oi��Td�2�<����=��������[&^���t���8�5������+:T`��T��.O�4곓�HQ����|Ih�V��5x�U
�՘(P�KK���H�?#\t���~?T�BfύR	��7�d��L��O�B��7b��m�>���o_�8�;�H��7ʾˬl �Li8r�Y7���$G����������l��&N0��[=��E�CV>/�И�P��o�x� ��a)&1��V�ob]��󩒷�/�m�f���O!�Izg+T�K�` �TI�[� ~�H3B�Y0���m��7�+n�{C0_�-����|�&v_��k����2P�� Ma��}��Z㣺8-0� ����Ûwϳ�Y�\�C�xM�r��R;�&=f�l2)�j���|9�@����q�PFHƞ��B�������Ug��^\Jt�o0�X-劘��4��H������?MX	Kv.�"�^��}����Fp�/��a�!��2C4m�S�ļ�����B!��.h�؏�2�\�T�]�--��,����4b����0��m1�l���-��"x�؄=(@�ݲ:1P+�T�ڏ�F�ԉ=etҭ����WҰ�pځ&� �1b�'�T~����*�'=���wr��ky9�������Vg�%��I���k��&9*h����zw ti�㻧_������Y<Z[��NCֹ@t� ����dz�zs"���
ߑ�l�'���n�VU��N��������:t�<o�GP/�FxȨ
!I�����1��9���G2t�y@�$Х���L��$�W0����2�7H�+Uo㴘c�� ���o>|���)���6O�?�rF	�G�/�pȎ�б��t/��C�ڼs�|�Vծ���zY������3QU
}�P��k��)	�A�K����͔̬�
�����a5!��M��3��vq��sw�-9��~?��{�B���J�ƻ �w�)�2g�,�� �����ڽ�s���'���a�~�|�������vU5ѽ��T��H�`�Ы�1B ���$j�	y#�|�5�V��Dj�����!�(4EǺ/��p�9�K�~�D1�(�p���*plS�E�ߓȘ�Չb��'a��`_H���/k��m��auRt�����_o1kol3�+����o�`�# O�񝡤��������e�O~��6���R���"��(L���cv�)Ǽ��,����O�'�@�ɵi!��
���`(W Zi"�̫Y�K��v�/)Z��H+��~A��6��>`7����X���wo���E!��b�U�}�{�OKVM�k��5 
�,�9%�bp|�G�v��`�j�����?}���rݝ4��q�J݌cC��(��`Ǻ1<��p�*x\ۦT�V�nh��,�e�o1q?tJ�zs��n\��u�@��ʙ��nɋ�!��Żj�1��8�B1���;K0�w|M�)��7��p�ÇV쾨��c�p���E�/�o8�z���Ma�B8��C
]��PğllK�\鼠��:��пz��o~�͇w��#��Cѱ��U��� ������9�/{ۈLhs�S���Bj]\0��������!����k�CԳ�=l�`*�"MșJ2e.�ӥUD�1��o`8�:�n3I6����5��d#n�o6�g��I�24p��i$�Q"2�����lX����D�.��_���o߼}��t?�0)de�a���C��$q(ތֆ��\V)6d7*��!��j%j����O    �W}J�  �.R�kL`#��橔3$��@�X� �Pfa����v���BCH!���E��.��a�Q��-�y��ܑ?�>ăFG��g.���l�t���m,�5�*ɱ����̷[��=��v���~������M߯p�Y���M�]h�POG��:G��@ɂo+��v�֥=��pN�k��̢���%�V�������Z�+#P���9I�J�Ii�<�m1 勹�� �b&Gn���C�%{g�#���(��Ʊ��)�b!J�elPe�Prh��<�{+,���}�鏟���	��~P���s�ۚ�����4�ǹ[����2��;�)1�|�a�b�ʂ0��C]�`��$2��[�9��c�L�Iy�e:;�GN�I#���>��8���txeDr\�p��e)��zp�����5��k��ֵ.�1�g�r�Tpb+1_��*�=[���|�*��T#�L���}�;�(�f��NܞU��IH$ ��9��WS��� �]�k,y6-�F%���و��)�<���	�ӄ3P?뜪�':����*g����$#�����M�1T��>�R��2��4ם�����!��-7;�
����?�� ԡ�nJ��%�궇X�@���%T$	�cD�\	�i�,��9�ɠ���d/!�Zb;��N�~�� U�D˱�{q�,{L���}	�~�~��bs�**ld{���z���ÛV:}�]�,������u�zk��v~)�B!�7�`tl�*�������,��#Hl�l�Y���_~x��맯^}c�;޻�e���"'&w奉҇j�3���rD��:���r�s����`���*�r�8����5��.�-(F_�^�+�rv��ϢRb��%�SR�����ҖF�O��gN�!�1���;����ݻ߂��'1Yk��B.�K��W?��{J�|{���uR�^z��Bq0�^b��#��Qv57D��4R�F������5u��M�g������h)Hu"�4Y�J�⠰��x1qf��&��S	/�0�r\����L'R�:��P�َ���4Y�X(3){M����L��x���2�mu\��}��D�+��Iu�Dz��"S�Rhp�
?9)`�\
az�$�y뭶W��h�{��Y�2���<�ή\DۤM��`��K�Ī�o#��{��HB�7�z�/3�4gvkZ0�A�⾿ڣg-�g{Cq�v��qY��K:��#´֬��`X�!��Xk
m�K44���{Q�J/W��e	�-z&{�=A�_�K���x�=r�.��j5 j0�	��B.wa�a�Y�I����tT��b	2�1�d�˛��;%��(�::�ш�ٶ�И��;�����Цhn��d��ל���2 �g�6�ZFsD1S�Y�@㦩w��U�ј�Tt�cBI;L�q�r�8�l[�/�q�B��{�'���*��Վ�C�c����9�+f�HgP����,֌dL��+���D�+t�
������ف#�G�(�fg�%��ѯ �uq�9<�h}�7-@\���+�]I��c򵼤�G��[������3[��kG���E�(1�1�L�ɑq��'���;U~����[(�RV�B�]2�����J�!�w��<�P�	X,�������"�|Z��*���*�����O���0��p���H��B�vPū����T�bo��e�Q��7� �e+��2�����V�(�W� 9��%����@N���@N���݇g�}m�z��|�cY��41��-	h�M1���γ�A ��o	������̈́j?Yh0c����Ȣ*%�]��{8��H�'�n���ϥ(b�#t��WO�����'y�YeV�*<2 5n�>o,�b�kp�! _���!�Tƙ��%���jtYg%~I��������¾��Iy-��ǭ���Y�/L���N��D��֢3f�_�wS�h��pHf�b�k׺���*íG�񴲋���}�O��Վ�j0,�<�\���9��rݣ}����ptC��\0���_������sX�q���<J�!��i\�*	&�;�妖�B12���c�����׺b�%A��q�
��%�"�|e�n�9����ST#J�v�X��N+�\��;a����n�x���։��+\�}ʐ�6roauC3������i�,q�0�o�����m��|;��U�j�����bkH�w'U��<pÿ8~�-h��[!׬�t=be�G�+�ǯyEY����L�̱In1�*%�gW�:|W1��X�`�N��N�b����%t^Tw��9���>Z8���;����g�Ǎ���,��8��|(��en`���>����İ����=8F�3"J�����8χJ(s�x�Y��P�!ՙc%	���tz��uI;��`����W��WmK�+;�7ʝ{����춳7�6	Y���$��gv�/3/k1���\������a����8tO}Q��l�P���3ZK6|�����������������LE*���f�:Z��"���<�������By&"e�$�_�"z8J4�v\�̒�R���o����i�����Mc, {`�B�ݡ:N�v�z�ڐ&��0�,ŉ���YIN��e����/��C��P���I�s�ʊ�a�RaC
�('�ڋ����g�e�C��s#�)l��9�o+�|�i���O�񏆑(�X�Y?� �D��]��j7��Ɋ���ZV!�� X]�[��?;�a�7�1v���V^!���m1̱�J1��a��0�6�2����A-+	߲�Tn̲��#�R�ke�;�I�������~�����K�1�v���[�5����`6����r`-��4ڧ�|�[�����y���r�Ց5Neڛ����Jsqn��bF�A�m���o�L?�fA�gS�TM?Z|�����ڋN`JG��<��
r&�)���]ƛ�jd��r*8k�@��`�+��B
�+���G�}�����~��F��z��Y��J�|��Q)�EG!z|�a��-e�y����ۧ��|�f��M�G����(���c������q��eo4��`Bq�@B���J�j'�3�#1=	S樑��U��\���?���!ڱ&�qm�m�>(6E5
K��|8
T�[�fc[��;��O*�D�'e&�-��Ǳ�Wo5��g�G��9C^����o�Ӗ(PD�IK��+�{VnEQ��f<�J�[V2�ʉq�8Gּ������o���>��B,Z:��n�Ӛ�#Ex�H�)_�5rJѶ�y��}'u��Ñd�����P�5��1c�ss5zm��Z��iW�4Z��ͮ�(�L1L�7Њ��H�T�6ۺ���}hx���c[<+6y�>��up����1���X8C�Ȭ���w��,ü���o�;a�Ln
�(�?�`���ݎd�h���.�!��>P�:�qʊ��ܶ�y@��a�fC	��x��3#�Y��/'��9���a��S*m{��ZN7�YK���F�,���o�����u)b8�
��BAR��%��<X���ӌx� ����KY��;����]r���`���<���D�������]b*W���i�x�������&���ĨP�L� $z�:�|#�%�s��f8B�l�G�/$_�q�z���vU�
,l��MP�kM5@S���>��pA��=;b'����R��B��[��U�8Ƕ�l����Ȣ%=��Z M�8��(���LYb��ŉ��7��~ [[
&�o��#�
v��I��?�I�Bl7�~����������̻:b(3U��B�����BL��a|D��r���tӴ�Q"�#ú��Y�T�թpH�/��ł�԰�'��~N7:8����6-o�����A�+Z��ڿ������WF�i�[B���쩋��C?ˡ�|C!(0���=͸�=�����o����_ߔ�o�7�^rQǻ�v��L��G��ia��msl� s������HD����\t]��xF�I97�Y�T.E�ډ�z��iV���GZZ�� �Ѐ���e���WW�e&����    ���O���K^P`G��R�6��c#��\>T��4uR��]��y3�s�!��q�:�t"XIu���%{6!��I�"鉘;�s����>���?��Z���5�j)m���uPm�Mys@0w�ЅԬ�"�u�Q���6ٹ�<%�@�g�MH a ��͎(�R�Rd$�c���q^k1<d�Ao�vf�t��%�c��%KG4Ln& ���˙�pH�������'��w^2�jW�-3F�6��9�YQ_٬{y���M+j���}��o�
��l˲u,��ꏟI�t���{f�J��}`-��K� Y���'b�#�LW6)
��B�SÌ9d��K,�?��^J��[�a�e��,V��b[�G��t"�Ν���P@�V}/6�x
� ���0j����0�����_۰@|9��У�'r[�񌹭��R|�J����94���bq���>���G�wiao�������s�0�V�9�����[�a� L_c{l��5�������O�s�,�޶3��$T�j���#�TpLGKo\U����3y��{��sj���;�$|��2���\�M���o��i#ּ=wZ�M�9�Ȑ�y(6�B��.7��ԗ���L K����g�D�����붿r5���߿�~��gD*��{��%)o�Wcx����d��T�W!����ph����pE�i.��X:�JR�������M[���r}�e�k�������w����ݣ���\c��h��j
�Yϯ�<���=wxw�;/ڕ��b:X��( �%�3T˻����h�L7[�B�>ZP;��"M8[c����ka��0g����~���d�7Ej/���mLdt$hJҌ��dͣ��X@�pX_Ư�����|JU(�l�3�&� �`�C���<�e��y]�m����kM`b����eYe����$y�yb�K���ŀإpj�ɭG��#=�� s����f��o[�UE�-+&��١��5n��
��fKPR&c�φL&!lT?$YҖݠ[�û����ߝ;N%`�s����)����k�XǪ���v�'�R{9ċ\�-��f�����~�S�E�Y���.��:3Id�Z��ְ�`����0:�ƀ�C��R��,nv���h�ٗ����Ra��6	�1�����_zy�pP���v�۝���������������< �Ie�c�IN2p��k�4$UꦰG���r�G��������h�<���C�'5m�2���s=�o]��^Z�I�x.�;TQ���z�N��/ʐ�!��������+�!�N!&P��a���"1���� ���Q7,Q?�d��9��~�(Y���J�͇���������ax|�9��I��ର"1��=���K�;���ZU�!"U1{�v�h<&�9� �Q�NU�|�y�8��Ј��@����,�
�.���dѓx�	��r��.���w��6Ǻ�^���#&�|�*���^������uCֿ~�pm��<�$T[��$�E�}�D�,Ȝ�kE�c���~��5R[g���q��1�=��w?������ �Ø0Rn�M6�9m8����?^�
m0dx�Z&[0=g���)�����d�����.6�Ds֖ѷ�"	����x�ȫ���Oꭞ�á8�Ƣ��$C!~�����v��.�����T�M�z�R���X�(��N��(�j����-����v��Dož�c����;z��t��9�)�0����ЎK�"=zXئ�u��F��ȹP+l�8�b\ؑ����~.��YX��\u�I i�L�Z	�{��ؓK�f�z<�Y%���ܝ=�]�_e�nhɏi�v��F�j��v���?`�k���z�Ň��~�9?8���n�cۍ��ؑv�z�ȝ�A�#ҷZ?��}PE��i�
G�9��~&W��s�ٝ���.ۺR�̖I�Εc�X�.R�z��$���I�l����=(�5���˲�����Z��6�q�4����F��r+b�[��4�ݳ�c+j��ձ\�ﶺ�/1G��6uf�a����x����?�{V�t(������QD~�2�]V<��T������qּrK�,�����B��%�֤��{����/��(�ٱw<�O�s�"I'B���k]�K#��T���Ֆ�樺sr��П/����asF+�;Sl���.b��[�R>�dT
�|��W���?}���(TDe��M����V�tV���-����Z��Q��#&򖦯�/>A��%}|�-��$BI�[�tDǓ�%5L�vGh���^��Y�h��˃�1l�~�����|��J��s�^Q<�6b,�v��qB<nw��z��#��z��ta,fg�vqf[�\�{����8��\�O���M��ͭ)(I�^�uՇM1�:�mKǿ_������KT|��8.�6�Y�5$fB��P�>6{�e�E���.#3j9Tp�}]N��EN<3����%��/�.�6M���<���htoG��>�7U�q#|��R��T�����KkR7�0fj0`���1�.zd;	z8��BZ4L�p��N����x�gq�t��L�����h/�F+	�pڢSfr�=�!�6�׵_�%��"�y��jh��L�)wQ��gB%=�sQ�-��^ĝ倛���ʻ~$��B�3��7�~��SV�\D�ڸ�"��}�5�EP:\=-k���AxN����:9����b���S-��[��&���J(�X@�	"�sxIM�HV�*f����`M���ĳ���i��5�F�#4�Z�Ow�Ŏ�J̧2�g@��dQ�w������#q��������_|?���߽����ʳ��f��ޜf&���Z���!]�e�~�1%���@c���IG��TAy{�PzL~6z~./���8�r*�'�"�Yg�l��m���Y�#֡<c�J�ty�}�G���=U�3�v]2VG�i��M_�4e'+	�ݙ���*��~P�%|�2�0��=}���{��C�s�� Z���h�N�O5}' l��[p�Ĭ�PT$&w��h(�����Ri7�ױH�jŨI����s}��r&U��Q�q��!Ib W8�(BFo%3�85���=�j�5^���G����#�;�#0ڴu��C��:7�.Y~�P$�:xV���P�W�� �2|ˢҗ��Ypy0�X]��h��~�ᎇ֜� �d߾&c���M�.�FOGs��\
Yt��`G��-K����e5�{�н#�C�����[\�C2�k�NY�<���9R,�5��5�x�lrP�ǘzu}�8ܟC���6"�^�oU^�<VBs��Ҭ�i�4 n�4�͆c}�0ꠈH��<}?���4�v���[�e#P>1g�Z`
HL�Й���Xº��$�-E/cQ�&��0P�����ʸ�[�Ҍ<*9[M�K���3�L�9Ww��� �AK�+tB��v�'k�f��MM/3S�iߎ�K���o�U�x�!��焣r]s6�r�Cd�}%;4�?|�Û���hQd�v�&3p@btt�^��s�l8��HH=�a�]˳[�͙78�ݱ�ܐ[���:O.x<��,�)$�n�G�)2%�Eu)�;U�Ĭ|��sO�y[��"����-� �'�\㗓����H	��:�Y�ǡχ�����3������6��yS��C�ӥ-����S�A̪�y7SCn����.bh�r��������M����q;��6W؎0H'heL�*V���R�*�A�}1�>�!���qRB�؅|�V]as�!ݩ)�5����'�N�X�4�R�
GI��80��gl]it:+��q��-`�GQ-���[0��7<�-X�1f31?ڄ�������6�v�b���R��_����w�.�]p�zW?s��
f�;E4啻��b�nd���ę��
.�&�Øj?�)=��8����`�5�  ��my�(�퐖4?��YV�BL���)�C�!�8{�_�<|��T���H�@g4��!���>a�rL�QM�$�X�f�wo��!���Y    ��s��E����*��w���԰�I�#r�^�O˱MB�)h��#�XA-��*�>�-.�m�'����{y��nW������T�?Va�r&D�����}+M�~��EJ���.9g�
�q$��P�o-n�>�����$��ݻ�o}����ޮK�uY����S'W�<��j�s�=���S˫Ĵ��&�%�q�>ׯe?�7oK5&�lq-d�a�~J�����EI!GPfNi��xB|��	I��wBT:��,�H9�����q�\lZs��Sb� V��޻ ����~�ۧ�=o�I�X�nS+�����<���Ԯ\�*���(�i,�I]�<r�zש��tm���(`e�[��X)m,	�yu�G�c��l�x��b�:!nb4ۮ�[��#�@�D�~�9��r����A/�q|ar�H�u}۔aCi[1�3�w�-Y
��gGH�Ҁ��XF��5ҿ��𛳫#�4�YOP{?05��;W�9E�aT��^O	�X��yt��/���!M}lZ�H_�N��6���v�[�dǫ�tZ�·y��2���a���ɺR�1�N��Ŝ�|51)T�M�7�C�[�Y���^0T���,�N<FsdQǅ2P{+FE�g����G��MG������3���sF�"����Q��#�'>���!����U���/�Ci�!6���j}>�G�8cli�6Iq^��ࡢ$R������!�R��(4��Q�9lDc-'ރ��!W��W��98+Ԕ�yi!��/�������&��.�Bf�C��0[�y�=>R����A�/���ۧ[m���(���Ȩd65Cs	\��.-T/Ҫ�����p&g�Q�{��Єfai���b��P��s�Չ�|��t�C��J����3?�dY,�����ܷ5�� UA�v	J�:���x������~�ʝ�ܱ@gřҌ,�f<���`�Ax{�JU�K<�u�|���2�-s����O����A��si:A��o3����FGcB����*#t��S@���pK�qy�:�7X��,&ȋ��b���vZԱ�)/��cRe���t���Uy��� ��z��IL
^��EY6R���7���F��;�:�0u.���f���e�L�l�?;w��v(����1d��C�}�ϳ�&U���K�K���;�V]��n�嬭���{�?����pDtK�%�W�����Q��0f����:��
!Dk�mu�lrbJ����.rȝE3�eT�OJ�**i13b��Hl�|p�!����4SU���/\B$I}
zg9��Po�.Oe�o��B�%>����k���O��Ӎ8q���];Yq��6����4o�eI���2V��f����6J�l�3B��T��CdX����h(�Ҷ}>�e��[(�����Vx	�W@�9�+4<��s�,�צ��N���?m���KE�KЩ����ʅ��&�X8��@`o�zI�2P��a�o><}{��hNi�����@)�n����1"���tXu��I5�l�0�"%F����9���$�Tm�ܘF�1���X5�h7ȁ�WE��wG=娚���.�ݨ�(:GجR�B�j��Gt�����]���֪3.� �J�I 3�(�i{�QC�ΏP��F5$$q�oN�� xr�n��Ѻ�r����>nm=�>�LKc���醨m9�'���V.��<�w9U�TIj
<')=�z�1��G��c�c��(.�h�,�PIʋ���'y��T�(6 -�-�!���v7l�3���.���6ܔ�#�r\W_Fa��A�Uy�K��Ʉ������Qm�R�a)�T~��7�>7��szUP����2Q]�3�%�+��8s��By�~�m�*����0Ip�9��q��4S�=-�bn�K��S�XAx��сBB#�>�Yv��+r����j�7`��gap�%����G 4	��|]}��k�=t�%u�U#gH���%zן��^���/�RͳQ�K9[��6	�t'<�R;@����a��Ϧ�~��I�h/2�L�ֻ5G�»���������Ѣ�U6/mh��t��5�o��s&���cT��v:.�"gZ��D�VG`�x�s��L�^zNϭ'g<�Y�Wq�+o�˷A�Q���0�W�eK|�0���������?/��.�#ٷ�
�/��e�"���B2Ma��x<���G�C�(0���:P��@5Ar�a{�`��Lk˔!����S�s���rA��Q�@QhL��#��m��tY��+t���1~���z�<����6v��Bf\�$�1��!2�.|r�W=��z��O�>ݘnE��#4��Y��w;GmQ�̞���%vE�Jj�V��,wטyH]욢�'¶��mH�w3���o�5"?[����L "yO�@�)������q����Ee�EAaq�v�z,����%��e�P6z6��)��@�%�B�Bo��."�~�,yc�j��}���ȹ��rS棑}Wj��J�%L�@A^"�t$�#�1�����|�d���.^V,@�ש�(泾�/��K�BI����Y�VU%�5�˱�Y�Ɇ��6��I��J2]�`��1؍�/����r�w30#�yIa#1�������*s|x�ή�N�z�l�h��f�<{���ɲ@j]$������(_�8EE�	e[-��L���D�0Ϧ����@g'�,��r4A���'U!F�z�w��� 	�ё�C-i��X{�K���Hwe��ݗU�m>��pfCY1c.����X-��	��ӻ��_}���sX.d7�Mb��x�_?��N�|j(Z��695qo�@��Iǭw���Ep���Z�Q|H;A��q���;����� ���?�u�D7`3O[}��F���.�5��M��0��֬��� �k�ۓ��Nsv�C�ɦ����O�m��I{�];�3Mw�t1�C�T��atw�� �ٶE�)ʠD��&ְ���G�������F�Z�Ž�BC %1�{��_F�����q_�0��z��-��qC�;�b(��l5xD�ӲO�\���Ű��o_���1[�Â�������A�]T���Jt�u`�ɱ�;l���aH��m2��ɍh4 ���T%Շy2����O�9&"Z#������-�$;!�@�M��.]�fߛX'�'-��'�<�|����(���P�;Q=��k���F��i��SK�K�f��x���C;C6T���*������zP��ٯ���i�+'�`��L��K�@��p=�Q�a�=��͑U��h�jHx��D�s�`e_��9f�piX�k3��&��C��k�ߟF����&������P�-�\N����'�.���Q��;�����ͫ��9�9�B�U���3��}� �GV��r&=�fӤ���� �.G������M�d_�1q#�!ߜ���"�!ݝY ���;e�0z1`���$&C�;3��L&^ 5r�4�i@K�P�ߟZ.����6�:�#�pɡf� �H1����G��K�p
QaPM���ū#��(��!�^o��1���X��0��	z������{֙�T�������&e �B�Xx�,1H�W�4F�_"��(J�W��=�S�C�h*7ui�w�A���שh����#��=gp+��8����Jk���9,���ʪI.�͂���w�^��~P�����u��0���%� #���`�s�Gϗl�B�.���$�mi���Ve���\:u��.����L��ȷ��ͣ����N�E�a� �d|6�PkNe�6�CdU��>����:G�P�����
g�0k9q��*:t�}y�1쥞77\�L?�3�F��1���߽����9�c~#.[�̀��6ɿW�B�������̛�lP��O���a�|�KW	�p9����v{���z(�m�b��	Ҙ�Tg��6��"Z��*?��}�ŉ�N����茭��)	� e��dX��]�`{ͼ�{Ϡ��q0t�D0������ώ��^����L]��ʍ��S�i�C��8��/B6B"@$�w��v#ȆB?�* �    JE�M�]���E�������M"͞�-��� "�g	eA�w�Q�]�ܻU
��|1��B��46ؒ����1�)��^��~�KɎ��ߟ����	����r�l +~oc���yF� �=�6 %W�f�⊭?�_�}x}h�u�	x���VM!���j���T�6e�`��H���64!	m�Kf�W��8��&Y���IX�k�U�k8ԢIf:�&�RGZoH�h#�W�%�OQl�]:��ݻ�a.�Kͻ	F�|[����K���1��u�{����� �̃]��Ŗ�78��;�v�d|�%���hu�������~D�W���&*�A*�ߛ��}ű�f�T���	�('�9� Z�ɘ�J�8ؤ��,D��7�Oo�W�8�e��I��b$�ٱ���1ƽ�n��D�n��R��
�D���|��h&����aV�1�6��X�;�wG"mg��F���������Y�TB)�f*�ҝh�m+��1��`�-���R�s��7P~�X3�W߼���qU�L]�(5[~��]E&Z�c�zI1p��������	,*��WJ���%�"k��RH3�eb��7Jbqx+�@�x��`4kA�FYNݍ.t��'��8�j���#;���҂�he�'xJx\��z��Jo���
R�����q�yC_��Db����w߿~����f��ܠ�����7P9���`�߉Ӂ>ia�&A9p��`]���"i�s��d���w	���0~	�f�Z613f�֣-Ed���9R�g����y��T�Nio�:�>Ħo�0���C��4s�lU��/�b�b���ͥXfP��z�ի��fL2>L��ߨa���m�'e*��?o̕.M��M�^O�Bc����z&�Uu�ڵ>��`�w"5"�С�J�Ū�=y*��2ɴ�.�zgK���N�/���+Oh����9�!�gjy�NR�SM�nD�:
����iו�4��9
o��p�S
��G$ڨC�[�
	UĀ$�l��'��v��+ż��( j!JM�ι��8�l$y8��swyʭE�����s<FZ�cu���JRĈ�R؎�0�Mާ��z�; ���dC(��8=�I*��F��OH͂��e�r�G@�Ɨ�t�]�6����?~������3����p�����^���H�)��6i��qjz��ݥ"ȬC�s�Z"Xv�kq�c�8׳V�]3YՆE��6Qϡ��i�' ��۟D32K\�j�'4�R�:�Z��ڶ��^,�~����i�����ރN[
��� �E)Έx�FD~���?~�i+�P���N��*�RŽ�b�V���sPv��Kn~xrA�2��J�ւ������J5Na�����$�skզ�h ��e��j��F�m����B�a`��B/'G�<�JK����"e@��O)����;Ru��j'/�� �����%UQ]sv���1mE���gb��ǯ`_�Ǳ۬b*�ߡ�JiL��N�^1e��)Ҡ�[ ��+(��.�8=�X_*��S���SIt�U����t���X�h7߹I2�G��%��b�֔�U��ll\U:|9��� �u�]��'�(w	A�����c��[s���( ��w3�4�Ց5҂�EöR�Rr�����\�`g�n�lE��o�����?���
��4��B�hh�m<�,�z�V�<���"��a2 s��Rq�2���U��.7q4C�:RZR�%'�3�mb04Ty8Ę���4Y�$)f�O@.�׷Nu���d)D7��Sv�ߟ8�yԑUR�/�
g�,�9	ܿ3�mtb�he&����69�#��_~�4ˢaTqڳ�$o�'��9����8�if���H�p���FB��E���eC{fX�)kx۝ԩ�u=:�S��;� ��3������ �@f�rX"�x�Cxp9�A����s$�j��'�C`J�-	��ir�Y��g	��tN�n���m>W�w߾�~a�p)�-�s��2�����ķz,�x���M+֤���"
�Ys����1@�r�3X�{6�Q��4x�Ȍ�i��|��h=s�V<1�[�5�̻ ���,��#��p-(���}<s9=vШt@��ú2sk<1��˯�|x��r�6���[�՜�C&���R2��J�_���"K�� _̱y3i ��J
ӶsWD�!{�}��[O��y1!e��&�+B�2��V]fe�S���d��gė	������o*u6J��9���+�9������G�$��p~!E� 8D1���^�i���.��vk,�=+�v�w��S� ��lW�-��"D��XC��|ff$��<h�R-�4�T�I�տ�86.@k�B�����qs�\2���")݈m���WRY�.�VT �Δ�?p�s*1�YV���Zz2R�$[]�ֵ��D�t�eMΨ�0��_�81
�v4sKK+��<�W�~����o�?��@�q�Y5�,xQ��	�XM��<��>!��gՀ.�q�E�t.2d r�N���VR Wt�%�:0Sob&2o����&��[O&2ؒP��܊�
�.��K�6O�7��4PAgz�+�� ��;������Pe��)��1��� Z/9�����ս�IyB�3����&]�M�H���__����:,=*e��Ϙc���^�ؼ��,�J��-�S&�~���#� a��+���>�� �1p>E���RUxr�����֝��"�sUXj�2D+"�	�?�x�5py'@&@�䥟��}�c&�UNu��)��aąF�iM�m�*Z��ś:]�Hfi5�l��Ŵ�,d�D�߾xs�_�?|۝hA���F��gt��)aXV@��m�tDXM�-Rm�f^�R�;Y���Hi*:��P5\_�f���ɍkg86+a���YȜ�Ze��H��X��m�W��V��EAr�i/�����A���
��6y�D�^dHv{X�wC��"xÎ�F!�̈́�7_���m�1��&Р�fi�{�_`��U�)�Q��6� 7�mA6S�n��zX�8��Q��Y��w��zD)|�p;��N1�a�knq��QM0���m��@��H��`��&�[[��H�"��/���̲
>B79�E!H�Qꍲ�X�X���j�QS���e�%�fI&��mE��wKN8���	M�E�H�#P|��k�	�]�"�GF���W��wT^���};B,Q��Z��=�f'�`�i����5��h	��\�<����b�8xj�}�Y^E�N��D�����N}�hS{y�7�ӊ�������h��%GV��o�΢��y);�c��;7�[���c8''/�6��^n��6x"���w�%�ZF]�x\��,tDA��J�`�&Lt5�a��S�x�q ��{eO���R���]�H���9n��x�����z��	CfE�vh��c�����Uӄ�Y�d�=�U��w��&�P��~*�����nP�d�]%QIy9��ݰ�X�vE��j�De�V���Le�m�V��g�g���/�|�r��m��-m2G�4dS՜�Tז6$I���mk"�|���i����	t��Ma���h*)��	9S��e�.������9c��"Es�7!
��ya�	��Y��=P�ϔ@!-̜sFuqZ���P?�f4�89#==��A&ٝ�y�
u3ʦ5�
��%e�TZO��Q&di^�􂌈�4.�}x�W7a]��5 _���RS���M��"�*�X�������1�YP�}�4$T�O���./V�^���?��c?f��~�l&�gs����@��$:�5z���]�=�(�� �5s�l�G��r<��c0	" 3؞�n�?OAChv��ܱJ�X�4�$;���{0�M�;�K�MJ7ۼ�����>V��������Nr��mG1W)-��an�r��ꠛs-=���t����>(��Ո�����2$�d�#��ʭ��0RG}���(Q#{ �E0{s��*P� 5H`1	���z��=�C���E���\�n�z��eC��b���f�F�����,��z\��g�W�j�u    �:�}6X��x����v�>���i;h�9�{���Wd��(']���>t��jZT>
�8(�Լ?�%���r�6[��6�X��YxL}�p�b��6�pa!��E�ZXɎƀ �$h�73�'�n��Ŀ6�����2���i+�s&
�
<E0���7g�A�~�r�ڷc�z��4O���mls����|��_�}xs�A�N�«b꘤�o��3�h� �B�X� D!}J��=\��h�P�Q��$Ѹ]	&�>���V�����ܸT�6,�����I�hNɞA6Mo����a-�S�ʿ��
����e,�Y�g���6�>u�[��l����%���LC�n��Q�t�o휍&y�Z\� �/�����}��_m�D�������TQ�B
/oJ�e��[sq�\�����ȴ��پ����%����B�ѓ�)�J���ܒ�7��LE�����Tuph��s�?�w	�d���lr��ʉo*�+A�n}���@�h��ܠ��d�����G��^1�q��A�`��r�+��SKe/�͊�`��b₺J�������i*��P���! �٥C��LeP���F��i*6����G˞n�O��e{���<,Z��}K�����㠧�βu�������� ����@)A�jL�7�Mj���W���S?5V�g˃�D%P�<J�_�z�n�kv�z����6z�4�X!�'�&ܮUف'.��^�X��É��C��,�?��T=�v"��?�.�D$͉	3�Z�ޏh�x�����VM�jl���t0/��aQ�s#��+�:}Q�А9�W$��3��2%��a��b������:+C#D�7�^:��D��/��K6���=�"�Y����}��͗X`-�t���u#0EOD�wT�,�'zo���6:���N4�zI/��"�&n�vNn���n:���E
:R��%l�[33]��E�F _��dK��S�T;�IDv�g��u�`����QK 1�ȁZVD��`����h�h��=ϕ\�5����U6�z�yY@H�Q8��u�eۢM`0���rX6�:��`=*xVc����(�?�}��1P5��V@�^ac���S��9xo~:�̔5W]��A�� �T�l��WR)�CURe0�d�Z��)_`�\j�h�+�H�k̟��G������t
ax�huu���O�;�Н��^0t �K�d��.��ho��:N�ew�l��Μ��L�S�rY��0��ً���P�aH�n����l@�����B�� (<���7C�[󏺑0�
ԟ�@�nn���g��� w8��ި#p�:ܖ��^f��;������Qz@�h���.]�wt��(Fپ���e�d��sD�� >P0�S��Z�UD
M�X,~�֚��Hʍ�˕�ߪ�EY�����lzt}õ>��;����r�u������ׇ�_����ãAh�qs�4E�pn��\�
�u���+g�D>��m��,�(����bt��5�ap�Ȝ�+o�\�w�,�1�(e�x��+��W�)�{R_C�M@�K���T=��.�\1�8�/5�����<��a2$�\����[���{&8w�=�|���&�c�����	�-�(��!��f�m���l�WI�4�[�ک�h��b�*U�ZJ��-��1�b��*Ԝꂰ�q:�d���F�k�b(���7��0j����4ݪZ ��8��'3�Xc	0R�6����k1��.�	D�l'DD�V ֛Q��s֟�'���qf%빉��V�'}��Bb#�����Bn�����H�Q~��w�p� ToR��*Ē�d�UF��ϵk�m��u4gw�����l�J���s�*#�_�f��;�u,rK�j�K�^<�[@��hXQ���o�ӣ�j�L�����:���y��cf��섊��BԟZ/��ڸ��t�V�,T�Q�s��|Lli�f��\۴��V�	L��3ڪ6�2�"Ip!QVh� ����@��~���-We秥�� g�ӯ��B�:ќk0��{ېŐVCᩑ"�{g�I%�j�xUN�/�%�w�M���a�r���mQ7��f��C-LƑ���H��QR��˴�V]b�u%!��,����x�k����w�b��i��,�}����^�1!3�H�)�:}�*>�4�C���K��n4�o�
��/�d�O�Ƽ�־��N��b��D�~�^װZ��\�0]��c\��%���'eWM_F�,���C�<���t4�g�&�%\nV+���#�O����㿽gz��i%?�O��~ҹX�O���{�s0�£�s���~���'U���cϏ�o_tnR�x,G���ܿm��# LIP��x��W��r��� �^4��:�mk����s-�k;�q/�q�c�N�f�����
OP�MS�J���ȡ2� ��/V���a=j��X [e[�uF{GE��n�>?��a{�Ҟ\Qe���E����n���,�j���A��ω��d�4Q��.c�C7s�����_?���K��{ez �a������T9�vP�C�t�:�M�� &�Ajkӟ9#��W���ޟ��K_]L$��k��ˍ5oHA���3M�a�my��%�8���"��2�X��\6���#�Z��ԟs��P���`f���ǜ��j"��W�����(��S%5�u����8��'U�0Ś�P�{�lɦ�F1�^�XG/�X�8ȴX��Z!ң����Kڑbj����hV�L��� %���pķN�5�g%,� ����J_ƢJ���s��-��]0tmϧ�G摮�V�NAMM������zP@��}��!d_4�Ua�t���A#l����G�9#����JN�J<ɠ�2qnP,��X	C�J��v5��S�M�0�QO6Ĵ��:G��h=�t=^e[Rllnh�L!l!�2�o1:�s"��Ş�T� נ��BS,}���F1`���*�i֪sR�.a<�?�Q��fE�F⥳�yR����5xsK("zj�(]�Kԭ��}����o^|�ϗ�~�!���p��G�,������~4Md�l�ۙ�[aN��Z��voY��d Z�{`6�[Ψ�N��XjU�>t���X�<�P��o��Kc���;�M��N��=ł�FԢ#+��^�����N� 8���2�c;m����(Ľ.�_�$�HLI�tD�61�݂���9�$T	�7Y���,ۃPH���Q�(��*�����|���?=|���ꫨt�߃����f�8v{�>Q9��dE��su���y.dU�D:�-Le��mI3�����t�J41�2� Qtʔ���bsna�P�ӗD�O뗩���Յ�+@ ^�,eElR��n[�FszpB�CKV���uF���؞�ݕ�M!+t]�,/]E��;�i�*�A!�P������/d��_
���c7O@��[�kr�k��'1���7�(�?5R� ^P�U���vIM�=7T�ccd
s?�^T�:�4�V)sA&�6���\|�dJMt��B�B����Vz&t�v�çrq�j�pO�1����Qi�$�u�t���y����j|�����S���CRa�D�A,ġ��#�������x�D F�rf�a_h��/�>�~���?V"q�dt��ڼ�o�� ��1�RNnU�a����"�Y,r�+(�K<q���)QR;ٴV~ܫ}�f,���A�r�(W�,'�)mR_T��Gë0�Pk�긌6g�(;D,O�$,��k�3���v�LI��ω�l�
�4i�Ս��Jw2Gh!�x�&����c���&�#���������
��Y�q4���=p��Ңؑgu*�H�Q�SE�:�ci�ܪU�6��і���9���T�IVT:1'��Ѓ1��+��LC6��$������$W�O@��b���x����D��4�f;��A{	����Vq�:�z��	�T�V���Y�l��e���%�'�U��r~��J(͗���K�m���,xc��-jt���ĩ�ݘ����틯^�|�͇����o�����)L    �ޖ����	i]��#����$s\U��Cf5@M�����	O���Ky�I���-��*�����
&5L�Y���l��ƈE��8��E�2b�f��t��
S'Q�nPh�4��g��glc���[����}ڒ�^��Z��l��=����u7���!W�i�����1~冱�qd��[<�Ŝ|I{"H�v��c�9�D������ϣn���PF���,�a���ևVx�x�Z�����r*�Z�5%�;��]�j 57I�9}Q �L@�L�k�0��ʹc�j]��%	"#V�aE@D|�1�R6%oe"��7��:�T����NB���D����Ѭ��YOB$�ǎ��cMfzC��k�mT}r���"��7@�A��o����ށ߽x���=~}3f�ިw�K�kAh~���=����ޘ_4e��j�ω�[,�AF��:.�j@P�ئ����YA��
��,�B�m��'�7��r~�:BД�\[�u�n��;�:�^E�#�3�Z�1���X����0�-���h6����Ӷ��+6'T+�rT��78&�XsG��j��|(���5)�E~f�#�D`^Q	qc0#��W_?|�v:��]�n�����%"��v�N�JӉTP\PR�ٿ�`nn�F@�`o
\�˳Hm�6����;a姿νЕ"�-|t���
*z`�D�B(�.=��j���L?� ��t�.S?A8x�]>�Ի��*�O$�4��� �F����/���`e�)*��� s�Я�
Eu����-Z�>%�ߊ���w��� �iq���U.�wiˊ3QA�WR��[]�od�Rɘ�&�F�0�&�J1
�xj\$�Շ��m�t�Ǣ�0�4c���SC�d��rQƥ�}OF��ۘ��c Џ�����e)�읖-(�~��Q���CV�7�+��;Y��c�T�n_��mV�Q��S���]�s�4/\�Z���ͻ�������"@��X���0Ӯd��,��>�9˃�F�*�\�fK}��ŷ����ʣP�m�ا��g���Z�j����DT���q�(�X���f�b'v�g9>���I���Y=Z-���\�"��%�]�udޗ#"�$�*�W�PlSL����ﾽDTu4�}P��in�[pG��J��xX�D�bp��F����"Q�e�
@��(6�+����f(�M�F�56�,Mc����I�UB�Q�
�\t�$s���e���Q�=���k�y'P�j+䁞w9/&&5�FU�A+V���W�pV2��}��m^�vq���b�}��w��>��&�"�6qSƤV��MG�`I�	�QmK��l�ш^g AH�a�9/G\������!4 F�<�Zy�<a���U8m�&��:lX�^�뗕l��נH(���	^�������2��#�,���&��ϖ"��i��V��&u]X	;L?!�N%:g0��n��z�����xP��]��w$L�4���)������0MBl��<C�E���n�-ed��t4e{l����:H^J7�ͻAJ2Ҕ���D���ͧ�����,0�q���ҝ����� ��3|sd���&z��_ǐ�Oi>�D�����o?�x��XcҴ�h	˭�e0s��䆮�M@���7��Lj���3�8��8|�Z�e*����=r���T�ͥ*Y�o���I]�NW5 �����nh7t�u,�*�Ͼ?��!a���g���ۈJn"�gܧ�ĩ��x2Q��cƘR��>���vu}:@��LP�U��Tn޶v�?�1w��ݔd ������![U<E�!5�T���/�zB�mc�/ɪ�e�I��T������7�����X/�є���x���5�VWf5Ľ1'kБ�ږ1;Fq�PD�����TkW{��#sk-�؈�m�p�Y�y31���}�6�?j�$a����E�H�tZ"x��>,������F�)���_�.��Dኴ��a�{��ͬI��o�DwC�}��blJ-A��<=2��j��B�b¨3M��ͨsm90�:L��BthJ@f���4u���c�0�ݬP�#��n� s܇d0��'�tD�ۮV���������d���yWLF����V�����pHYqzhK�ŪM%����F�S��!>�d�x>W/H`�匆���'x_H�C74p�n���;{�o�û���P�	�%��[�d(��C��

v)�i�}*��ᝁe�ܵ��r_��
�۞Q�9�|�h��W㥉�����y�4�q)#��*~���u?����M+���R1�ljd	�МQ�5��e�
u�]��oi�l[q�"Mq�D]"ذ��>,4�nU������`<��$�m?R�zN����.�2q.��X�g��f��8~!$k�����?x�("�&T�����i�|絵p���囷|wH.�<%��1c��nOU�P&ƨC���"/��T�ƾܳ�@5[ei��D���V[��ToYV�����_�M@�!�������4�:T��1��WH�0��pq�I���oz{�hZ������������p�4��`���(�nV�(�tzX�av~���g���ѮA/�2;քӆ+}}��D�뀲�V�ϱJ��( 1)�'�Q���?���O���%�"v�1�P�� ڥY�l�0��^8����>F�D��b�	�߽ka��D���zoZH��
��7o�����s�	��$������z�Kjr*Bx o���z��ñ[��Dmh�h�t�ŔhU
�=2��&����[ҝT���c�=�u�w�4­PTm��Ӟ~뜅�?7�3a���k�~(z	6t�d�4���t�H���/�'tq�h����	�L1J/]~!,s���M}��5�� *7���d�z^7QCs.�n^�=�������7�����Qn�8i�9����s����M�I4�����N{�f�� �s�K;�
NĒ�OMs��o2TE�Xen�"�L;��<.��f�=.0���J�tI�j�"a�ˆ�����k��T5ق�=9w����Tb���q{Kt~T[x�(8I�R���˺.��#��l����o^� �mR�WWQ�e\+
}�-z�@�ԩw�zSt��zՍl+���t���Z%sl���L!���4��q�>�'|�i�i�t���'�8RΤ���ó�oA�v�0V����qҸu�/wv$�������g] ֛�P�c�n��L���%��,�/Y��?�����9�W���+�{Њ�z�1��.�%�J��Y�pUG�f�SD�XAЬ��5K02g�J����rc��^6�ǳtïݜ�"�6��;Zi	�ls��DKR_Vⅵ�}eb�柈A���M/��Ÿޒb_��W	���es���+���KVD�3߾z	g�Ч�Ρc:��-z�!�aHS�e$rOu���d>LώF�_�;��h��m��b_j�Bg�8��,�[N��Ƶ8�����J� bp`�f؂�@NT�WK�zk��M5'\��~��F4��B��3��"��W��:5�X��p�FC��|	/I�!5�F�b����W���.�2�!|�oH���@�(��*�2�К�����������?���%�蜱�E�V����9�j*����%�{)q�c4����ѩ�0Ѧ��T�i}Gy����f�-
�\�wюӧ�H�9�f��G��Z�%>���?���͕�j2a�wq�E�8���~����w�	�
)V������m#��7o�C�Zq1�P	���.�6���&��=դ:�A�ҥ|��B�6݌l�k�M�9��}kͲ?����K�C�j
Zl~�qz�l���a3�۹9M%_�3�Ӻ�M��D$���eR0��J7�~�Ss�W���ڬ��5z���Û�>�$�Џ�+� ٖ�^�4@�p�aK]S�Ј'&v{O@�Jib�nq��0��W��޳P�y�d{68�;ܛU����R��]^�xq���6(wI����L�� A�%3��s�hC<Q�Jj�/O���5d�����K�wH    �&�]wl�P�[�U��l�����(����Z���2
�ԫH�n�<��7ئX��Yr��\7�ީ�V�O�F)J ,{��J��������Ya܎���#t�.ގ��t	5���""x�ZKKJf����ʳ�T�a�"�y�%�[�V��̈́ rm�i�u�5�^K���ӥ5Ҿ�ے���A�C��J{~�(��4l�]gZ�Ln�f��m-:�.��������t/�6vJ$��>񦋍@�e�Ͳ�E�Hb�j]zK��W���vb�5>�Y��jj룬���?nKW<G�-�LK�l��N�y�͜P����xB�r5˜̈�F�S���_}���M��FY��{���8J=���+� ��t�P[C+#��@�2E �P��T'�2̓���,P�u8���L�6 `���;y���Bv���&�hkNjx������_|���ќ��f`�[i��9�==� ^/k��E�� �G����.�[t-в��+��czɺ ���݃�f���.��QI*UQ�S![���?�7��j:����'.�Z����N^��{5Wq�η���RQ�YK�^҄w�h���a�́��I8U.>@4����G�PZo���|*6�T	h��F��
˘�5�R������k꓆�\ ��9����9|0�G"�|P����{�(n�~����e^�h���$��2�����k����>L�`Sѩ�Z�y��Ž�����h�M����&�
OϦNI;��b��$سB�*��b	�I9�j���˶� 8�`��W����=K��Y�5�=���0���"F )9"����W�_�b�tz��Y!��eS����Ea|\W��oE<Mc�j��"$�扐�#�^���y>l�:_�x���J�V����K���=ھ=I8q�$<�]����P��ł@���
�:�џ�ˍ-�kcZ����\)������ee $hcٓ�KN�A��ׇ�^���w/�Ά`��5fK�֫�K�x��x+��6��0j9U�!���U�^���ę�m��Q6{D�an>�02����=����Y��)m��f�􄧓�� ��h���2�ھ�	(	7���t�9��Nj&��fT��е0f��K�KG\
�����y��J��,@�._)c��C�b���9�Do|���:������EzR��)����o'J�rŬͬ&maGs�+�rkF�k��S�`� 0Q�?��JUa��V���gri��MDuא��h�?K�A��'q �!�?1:raP�PE��X�mu�J�3���bn�;Ѽ6$��O_�L����^��E��r�Ӛ@�Uy��<f�T5�ʚt�8�{��>�����Ek<��ab:m�7ߍi��RUǃc��e��g��֚��HP��+Ɉ=��u�Խ+�]B+�k>�|��)@�-I-�4�d:ճ��9=�D�G?�.�g ^���WG���n`��T�i��j��0%�������6jE�6kD��j�'}��h�J��Y�
���<3�Lڏ��4�{����9�Ч��b�x�f����]���a9OSE8��p���筒5��;H�mv�a���ãM,�ǥi	�~h�3&�|����M{�U�xX���J�"�V��R^�t��f�̾m�&Z쬽raB�)�
u`�J�-�������f��/1���E�8��҅�MÆ#aj�؄������s���H�=��:��ܘb����)��5���;�\�۬Sg��;o>��͚Zbo�*{8��f���xs���������U��M,�w8@0�s	 Z�]�/�V6��F�}�6M���U�J�m�4�רC��Lk了�1�8�ڃ �\�\�u�'\��=me�( ̤�d�̽Ѕ��:"����U�l�X ����?��?}�����]I���8Pli��hՈ�`��!S���FKX�K�ǻ�#�eD�뚜�bK)�'��l���fݚV�K*%|�E�{���q�q��MC��ƴ���q��5S��Q�tP�M�ng�J1���#
�!"#E�s�>�KO}G! 0����]gx�O[`$>��HJ��Do
��0�4����k4i��j�}��."�^����
�L��zخ/p7[> �Ҕ=��g�y}�A:LU�(:���n�m�4���@}�S�N�HK�>j�On���I��qxG}��� 9�}���4����E�l)�o�{���7�N��Y�B��Qӎ
�RJ�h�b�R�D  -�!U���.@��8�h�N��I�B{H��(媩ʜ쇍��̴�ù>KmnFLر$�u������;�Ʌ5tR���-0]V�SK60m�$�7�y�B�L��b������OSC���G@�g��@:!�W2�$&�������r$=@�>�O�E�&�{��sUwy�������1�/��&r�:e�X�X�񔳛���ޠ���T�v����Z޴�f�/��p���RFdH4�$�$�a�?���Z���C��4s��w9�[��!`�r���=yw߷��:1j�N[����<�~SW2O׷s#�$Ӈ\�f���|���^|새G)P��F~a��C5_)/�����~�4�u���Ћѷ�0i���V�A�m����Մ����������$<O46�=�;����:���n�t-k�첅�#E�L8������" HO����GP�Z���O{���!�v5C������5�aI2!���6�8En����y
"7
�*�7�* =O���U���&Ӛ� XUQ�(�#6".+�fR�
v���w\�
�j����f��[21}^,��PSO��^2V#M��m�z���r�XէR/�������X{!e�~�!� ����1��D�*�'A58Y��#�|7�Ǒ�/;0H���%�5S����[�k��&=���rG�twJ��oF�M�Qp	��47B&^Q�rw��_���Z�i	O� m.�����R@���B�R�xb�����H�>���oW�";�H��q��%�"υ�&W&@s�b��D9:�̘�c;@:��	��
����,���U�^���9H�G�?Ð���y�E%׀Qq���v����AT.����`����1�˔!����Ұ�Y��M�pȋLU�I���h�z'��DWb�v��߂�xXM."F��Ak��o�X�`O���Wr�4"Hhp�b��
Go(�+P�u0�*�,>,pm�1����[�KcV��k����U�<�ں͊�U����o̤�F]�3ys�=6��p_x
�CH�6�V"u3���C%��Sj��~���q�h�}f�uoSmQ���8��4�Wa� ��SBa�yu���@ŵ��4^�q��m�$�	g>@��]���
�H.�
8�o6��\�O��s��J�/L/�X���/�>[3Uu�tﰓ��b��LR
	�q�j���l���G��9�,��/���&&cħ�r# ���6��Ux� z? �모A�a��ͪ�����e[y��ǟ~x��O�S�~iP*�Ù��7Uй.��uP�`��4�ҍ0��:5�t������`����-=�i���9�V�(ܰ q��}����6]g��F�U�H�*{��BW{-�2	�q<H:۞k�俋I�;�)�E%.����'�q$,p�0��>*��u,`�<a�:KpT>�����_�f�o:�馭���Q�ª�K>�=�J���
���^W:9�)�C��s��f1!WԻʄR
�d ��J:F��<�A@��"s���3ޢ�֚��̖{�%E�Ƃ���~�ф��Zw�:;� ��`)n���������ʸ*�eҶC�6*��	D��������$����i�9H�E��%�V�V5���r�j��l��X�^᫚�]g�Po/�rp*�V�%J�8_n�~[� /^����|��z&���s��BA�Lˁ!�
)����7�R��"q��_I�x S�7=5��"%iwwOȈ.,�=F�S9\��+N�/�c� %�t�h�9N������/    r���i��'��%/=5݇`�%݀������i����i�gK�G$�5��ӜOuĆ>����s-�P =�L����ŷ��ȾA$bC{tl���%�܀4ހ+�/�j�G��}il��W�4�	���5�J��@���6��Q��wV#�����h��V�C�C�BB�� ��a������7'�a�OՈl�����+��W����btUEz;���4�ތ�l
��0�#�ұ,
�C�zƫW�_<��P��*d.|��=/ݞ�E����P��t���Ly0���RL�7詠ַęa��	<P�D{儿y`z�R�k �w�8{Wz ֟�ݱ�_Z�~0���z�ؒ�ņN�������%T�M�i�)��:�N�6�p���7�ʠ��k�&|�>m�v�6"�Y#Ɣk�(��^��»W��*qk!��g��HZmJ\���߾{�p�.���lX�f�rmnh"]�����2�"I�zYec���i�l�-�J1�F��4x���Y�$�ZeS�4��H{�/p7���x�^����ƻXQΨ�ٳ�1�mTE���v�=#(��L|�ۆj}�%J}s�6S4T�uN-۴c[T�K}�>�;*�C�9�c�A
��'�V`=_,�}����g�/6%,�xK�>���Е�26�C� ���m��0y�6�x�Z�R΂�I�i+6�:	�H�V�f�Y�l�ڟ����"L˓TwE�@���L+���D�Te�fb�r5q]�_�#j���"s����K��.�8w�N����z����Y��$JKĀ9"���.��H�ٵe�l�����I�)��L^ N���\�������GoԈ.{�@�.��Z�K�#z(�\��:4��vc@�?6�i��]�Yz- ��������6�A���-�v7��������m��նN���B��֡ڭ���#�_͓t�v8d�����^=���o��R��{AE.W��6!�s"�n��l�1�f�R���M_Ւ�b��.�.���Z��!���hF�����$��R*ۼ���.$�4P���"�" ����>\FN�<�^Ba�a�0� dQ���lW��8��Jl��k��R�D)h��1��I��+{�����y���]��g�����߂�գv���Yڊ.T7� *��q\@�Q�I�A���B�&e{9��uUˁxez!9;����%3�A�� ���%� �@v���ͼ6����e|��� �i����;DFg�6>v�L8hH�c�љ9��o�:���\�����!_��(#��G�	,�&=C�?������J(�mx�ҋΞbt�r��EI�y�y=i���?�}��U�ᑮ�v0��f���V �R��WyO3�R%8��H[v�b�]ؚ�� Ǳy5�y�T��%�� <���>�E/E�[��̀]gc1�|������(�L�P'����!�}��\�V���B�z�M���^i��3���Ţ�[�*w������W���yF��Y쟽�k$�6!t�G�Lj�l�+��?zd�Wi{��f*�o4�B�����?_����U��շG�g �5�0���Ȳ�~4���j��B8��g,H�EVra4�i���HgD����jђ&z�
�ln*�����<u�C�����6Ǌ2l�Zc��fw/8'�g���yn�	X"��\�T� v�l�Rc�����R"��Wd��9��⼘f����C�~���˯ע�1�M@�øb$��a�d�{B��١����Y��� ��@���ܹ����;(����o[��}�
r�o8������h/C��A2{F�.���' ��&�	��͸@����x�J}��x�
_VR�*o�,�If*;�[z��Z��&�[L��g���~A���0�����B��Ji�S��%i؆f�p������t�f3��������'�XK�+���HV��	P:$�����-@j�����t{�1��:�<i���ƻ9�Ϸ��0r��Q�p��՜g�
)��o�����/΢	��}/DX����"w�Gy�k<�͆���D�B�D7�?��܋�g�e�w�v�2�V#�aq`/^�d�q�Y��AL���3�,�.����-`�wD/9IiYsDcYMu-�X-앏A�fa�TE�$VYY�3���d��8pQJ��^��Z�y�ɰ���K�^�m���(Y��`�u���HT����㏇���[�&I�
��RG�J��ܔ۶!�VJ����̯e�T�&��$��V��ڦ�!j���Ҍ�K��a�9K`�ּӸ�L͊5��dȄ����D�(��4Q��!b�tz��^�g+��h7��('^r6�q��R.y<�
-���J�~��e��H�V�z8:6���f��S��}���,�5nx@��c�DDm��$(����߯��:;>�\����RrN���<t���(�x��d��<S��Gg�8�B�K��_g�����4V���ڒ~Zn�^��C���:�����4'^*R����l�8�qP���L�:Ǯ�0�:j����ZEq��IN�N#FKšQǰ��p#+�<�>��O_U��Z��S�����~����m�[p�T?4%�(.��4�ɕ6,-��1�(&�uJ���^�Ρ�� !�q�_��8G��?�l��Ǎs����Ra0H#a�iQ�|�R�>2S�̘�b�-�-G����KJ�I<�ӡ#[v��5������9���8�{����@pţf�q�T��b�g2���9G8UJ��Yb;"�� ������?���9���3�.=�}��YÃT;�r�VGy�=��O�]U�3c*����l�]��<��S�z�O���8s��¤�Xo��$�!Xr� �mR2��R�,P����hqִ���0�4m�(Jvj<�"i����v~Ы{������Q���~�s �Y-�#z~��ؒ��QZ�kȟ�j�p7����`XPJ��e%F�]��ǳ/I\�{jN|9j��Q	)~����r�����K.jŕ�Dj�Q�1d>�r�gl�P\e��B�7�*eM�8V�<�����6,
��fn�J��+ԓ���DW83TN�D_���"�fέ�8=�}v��Y�W|8����T�-F�ݲ��t5r,C����{8�v�R��,k���G��;���ٷy�%�y�*mtqKu���Q-�@i�מl��#��=͌VM���頶	���egkL0G*F2�-ᣥ�	��
�ř͐�
Tf�z36�� Ѭ͔����"J��QF	E3Yᠳ캄N�o�Ɇ��������J ��y+N�!��y���7�~�����,�j���y#�"ڢ�����V�c�nK��Y�;;��D�
:��S�r��C��,$��(�4�(>��|�������i/��`١4��U�f@�F�X�����쀺��@b_�ي b0� ��T&9��0wFF��6Q;�_�zy̱�E�+]@�$�8mw�:������+�Q��^���������^�̸��4#��o�x�Q����u����MnZ�!�YkY�#rl�?�œ�{���.��oe�h1䉔������q�B�He�o���@uͤ��D�о���7t�[���ҴJ*����]p\�t�ufnֶ���7U�-��ҟ���,|�B�Q�OGo�jd��S�Y3����okm-t�	ZG�~���߿{{���Z���L�1�F[�ѣq�ғ���Z�rlb�C��pY��X(���u	�|��A�ь���03�۩J��|�.�1k�S{�wg�ayL��lF*"ZĻ�]�b�W�a��v;E�CC,�� �Z�낵�]V��-����t<��ҡ��!5d1��Y�Q���'t����qʈ���9=7�&����S�v���ۏ?�_4u���D��Ǔ,�d���m��чϨ��	N�]��&�,Ȃ\�tx��,x�ى�jf�! �N�MS��,�z��d�*|�i�#�F��:p�S�؉�>��]�H��������    ݍ!N`��w��Cs�K�j0�t%?�P��p����IG7/JU���p �ڱ��ۣ�H�&��̮91w8_|�p���Ւ�ȼm��9�3��T����t��^�"��2q=��̗	T�jOз
lS��Z��#RY����ۆ��m��d��������D�80��"�/j6�S�u6y}�M�3ZH�V�l�R���o5���!O�ڮ�iVIH=�N���=���;&���>���4I�pt<y��<�@��F�o�����q�^q~���_ޮ��T���bAn���oskj알�.�<W��W�E�~��5UR��.\]\���HXk[(JR�i�Z����p	��p�p�y�#Ad-��IU�p�j�65o	^X��'A��"���i4�5lGMzB8�nk����?П	O�F{��_;]ops�)��e�db��)��
2~��Z� �/�,������wq�]���c���rbP;>�Q��~�P�yj(Mܬ�Mz��y��!dN�tebjiJ�߳��6��O�R�U#�84�3 $W�	l���8��b�ЉM�-�q9ך���B�.:y[mG�c){�6�X)S�����3�ʖ��R����/��x-����_��C�h��ҏh$.�����k�Q͎&4��������裀��N��=���7K��9�C�ah�?]�}:��,쐲�b�e*U����.�G5��b���'��������x4ɡ�p�0,]� ;��� ��y'�P�FD������o�CSz~�M.��΅��N+�f$Q�ua4Z��.�Mb�y�'Kz�s Os�1�Oc2��
�K���dk.=�w���Ez$yE�
VC�&�����4=�f���f����ہͲ��s ���7x~6��=6,���@�MY�n�t"􄣜��}����Ky��9�0��`�^��]-n}omu�X���(�d<�U@]�P�k+�U�&MT��N '���{ڲ�%�3^�S�!�������@Y���b�K��rQm�bwV��RK��:�g/��r��Q@n2���9MA�j��7-��;&:��I�)^��ˋ�_0�ʰs_�G�$I��DY�>Z2�!d���,Pg>�A�z�v��H���GB;�EeL<5��+3z{Hҝ^�ۼ�~����~YR~��@9h��y
0Tf�t�
 *P{�b��%�*,e��?��z�0�����̔�U�*&�%��l:|{8GI¨.�����@}���o��d�0��=��P�@��p[֧�\Os��}�{�l
 O�N`�-�ơ�-�b(a@��v�TL�fh���$8��-nM"�4����-OxX":Ռ���I��c��hǈ��k� ����A��+�F@�Q���	���
t�X/vÚa����xsw��`��bbp���݃��RA ��ـ��X�T��0="�!�H��WkEJ� �+aa�!,X�\�C�j*���� {b���S�\dl��%U�1�D(�5$K���G��<4{����t��������~=w�7��j��������]�4�ކ/!��@�`J����W/�7�E�m����j��F{`� R1 �l���Q�4m&Ф�	�<E�M��z�L��j(��հ���l+���[T42�����83i�SR�ϭ�8J�(�(�B=�g(�/i���V���:����y`h]勱]$K+.�C�j� v�}o�|i�{i�ޙ����|���͍w��9@ƽ�]k;i�nZ�=Z.�e�����n�o�X���7S�wtl����~0�u��+��>N6���������X�{	�	�0n�3��ᴉ�i
$g����v���I�):H��_H�E' �����.�.�B���[�͗�6��)Ax~#���kʙ�>�PHn k ���M+�_V2a����{X�N3�����hF�0#���5��	x�t���Z���@��~t�U�jMX����7���,�%Ó��p1�G����]�˅�/�s7��nCb)��4��S�3�:{j+Z3�:҂xIW�v�-PHf_Z����7�߽���oW��Qs��V<D�s 7@�$N��M��Ko��:kj����P@:#�o�+b��ba)��vK�a���
Y6o��;�2��\(�v�˖97�S��I�������N/�Y�ӊ���������A}�;�
Nِ��"���+��� �u���޾���j�i����>�c��dE��2����Q�T�h���\��m{u�1#y9L��X^��Z2_S��"����f���QiY`�t���n���(З���1��#(���e¿YT�E��/�D[���5J��3֓�(��ZF��e�NDӟ�)EZ�������ЭL�?������_�=�^�����H�����L.�'�0�"��u	�����,� Є��Ԃ�:��C����Q��"�����j0�@{�l�#��W���0�� g4��Ův�M{�,:{���D�!�nʺ6FU܎ݣA�D��2aq*D� �fBk�<���j���)+4�dH�.�V��nE��$'a��s ����}C2m�5���!~��/��z�jȣ@ߏ6���n��|��a�nb)�����ܭ�jҴ��c�*E?N�XW�(�+��zJ2�e�́jV)*��MvX���Q^W�5E�C�_Æm�հn�6Q�����&�[��l�$�=�:��� Ԑ��cw��B����F�f�?��~�a��s����vj���!�B{9�����e�T<�|�f] M�X.nL��ΪW]>���|#j�3ѥ,�WB=S׃V)SqT��dKB>F�H�9;���KϞ��YF����1ڜP??,�՚�y #�2�:��}9����K+$�'!���_����_,zM,lӴsܒ.���ojӨ�)�CJ����X������3�bz�O���'W+Tbr�!bgx�޷���ǥ��W��6��\t��$D1T}��*��U�`̭Ն�r7"z�#ު�����VQ���=c~��>�zoz����($�LE����W��p��y��_`�=f��?ޮ4D�4��0�>}���F�t���� �$,"4�o��<��?(x�atKP��EC�̭���莮A #y�~K�e�p�/"�H���f)f�TI�f�����B�W�ɶ�R���:B��)�� x�����x#l1FE���8Nu��i�O{�a������_�Ҡ���_��v�y:�P��0����Pr�Er���$s��I/$MS�V���)T-��Y���as���S5g��{l.3̚`�|��0-��W�����I��*Y��@�7"��<��J��εr�;�^-me+��cR�G��T�@��Pd aIq�5�o�|�5��
!㧧����e][�� x��wGKf�f�$M��A5��R܎�����e���?�7�=�L�+����Rud����Ŋ��yX�`�ّ	��4_�1��"@�2���k�� ���y)����eja�!�ԑY� -���\0�&õOPys�S./�6E[G�|\��Y��ҌEcC,~��	���W߽^m?Z"�`��HR�8M���!-��tO���Z����&*
:���J�F�Mc���F�͑���_���^)��=V���=H#�"]�Zt���؉Xo|=-/������$��8�:�&�)Kz�D������vI^.� h��~����%�dO�T 9�Jz�QI����e���kL�
@yٙ����K^m�F�Mts�am`�g��2��7׼���1~U\
(�2�u%H[g��Ѩ�aQծz���ʜp�9���vD@-]O`+ P� �������/�`V餲��Igڞ�&�/�=�1H�2
����"���SѧEy^ź*̫ej� ���|���P���Y���#��gX�2�[�{	O;[��V��0��b9P��bz�0�ޝ�՘tʼaXZ.Δ�6 u�1-.��3d#��1҃�<v������u:��+�5�k<H]6pb��j�3d��(Xv�o��-R:�|���    ?��T�Օw^)�X��/���d�6w�
��0���m_���_��_�d�{�փ�d�U*��l#��\Ґ�����1A�Sg�1�I|7qz-�j}����z`�h���hYK�[Wŗ��{J��[ݶ4��*y/�����|681�3X���ǀ�g��sk@	�[/�+��hx��IT.M�l�L������?��������v/�HR���O�~s��(B��b��AWҩ�5����Ӳ�f�A��@��Z�)5���!���h��bk,}1�f��
�ze���XL�)n�.�mv~8�K��<%��87X����*�R�� ���'��ȩ�P��D,��J�(²�����ryH��vtp��ߢ��M��"�
�%b�o߽~�o��l洴g��M�fGq)�t\d:�De.�4�{)�� �ͨpz��h���=�	b�[��6u�j�ۅ��ӯ�����,H�
0 �H�q�,�F,�
�{�c��@+?�š$��`on���DaCz�ڱlae�G����o^=|wj�2�e4��Ec���Ӝ�Z[:hl�^�Oݐ"S�Ij'v��0
Jݗ��z��u��D�5㳬Q�%���a��i��l����)�f�&���n��x��>L��Ј��|��k�u�rf�S���u ���D\r�G�ħlj<d�y����I���v�Q�S�l	8z9M�qw������fX+軷ZSF�>���h�Ŧ�g�&���&�D��aԡ�>� �Q���_�QY��	�)s�4��3Bk�q�օbUv�X(ֺ��7E߬�/��E�I�kuX!�'lh�k�i
�f�O!�Ч�&��AҾ�ho�͍����)S/ῒct��L8��j:y3E���x]��������m�Um'�E�~�B��7N���U�,��z��ٳ&_��6�I{�;`�q�ֲ�9���8Sz �1��+β�R��&�������2o�U&լ#sE�w�6cJ�/�	�u���.*��4�?�-,ڞh}ʶ��Rmmx˒���Ey��R��"vu���|��M�'�[��7�+����U�!��~�FN���Dz<�Q�JȔ�DmDS?�ay����D%�K�&���>ة�i"��2q��,[��%�s�a%M�'�%#�>��;�@�̹���ǽ=��O�:HTr��5Y������kJ��P�Y��L1��~8� E�������~��ŲOE���>�d����:��Uf85zX"-"Ϝ��g0�S��%׵��P-��0��� J������6��#5D�	�[o���f�'z�RllO�f�\��宏^�;wK�y�`.P�Y��ŗbeSBeDfA/2lG��5�ѪȫA[���y���v�����/ͼx��2�(��e�3��J��.�4�XE�dA��^!jT�(��8�!Z�=���D�\b�;�Htqʑy�]�)�f�+����hT/d9��"�	Ă�M��r������j�c3Q�����i�}|$߳�BpLUY�V:�Y�Θ
�����B��� ��EX~-<���?�x�C!a�C�������X�1���C��M3���d����Z��?��[�?tV+��ւknװ�ɼց>�L�;�tΔ�昗�)���(�X�,.<rmu�ݰ�`���O���?���SD�=��E~~����}�*�2υ�܄��!��$1@�iv1�z���nԀK�"� 
(6��_��k�R)���̀U�aO�r��i{G1������NPQ:ڋ��q��L��kZ�D�j���ZIJ����4еr�vx�aP(��i��IA�k�Q~�<���"��5[�Y~Q�R�	&*DD��n�@�+�$1�G ��qxx���I~�c�����'o(:ř���*�'�K�S�*��#��Dߢ��@�'}��fc���sx�\�?��P���w2O*ҺqA�Y.B�i(��&{�S���Xu�5�fp���y���L���K&cje� e 7ZSRTSs���2�R^�3@/^��RĒ�̆���s�y�����)Nn0��ԯ��aԔ���w�+{HVRly�Pt���������X���%���IG��A�Q%/U��A�ɴQA|�iwb��,�������4���x
b�"��|i�)�ոb�}�P�d��g�t�'G�7_�*u �r��JJ��LNa~?��H-�$�f�$q�cϔ���Sn����[K�^��^���	�fL���W�@B���~d�Bbc'�;��"keui(%+f����#��1 �H��4�%�?Spz62����c�J�,���8�ޅE�^�jaP�%S�ߪ���śYĪ
�C8��h& d.،"(YH�0�$DT�Vp�Kܕ$��Bس$�b >�3ڵ�i��_�l�[�-��;a ��M�cI��/���q�������H�$-$����4���< da�����,�+̒ƍ�> �(�ե���'_����ò3�iH=��'�>d[2i��K�=KT�6�<g�R=�*aǨ�ک�{��5�:{I��<$ښ�X�ɱA5@����G��������h�D�u�~�ZF堨����Y��A{�=�Q��@u}/%�t�*P��6a�
�`�-Zz77�����.�9����o/�zx���W��&�S��g�E���7q�d���ɰs��I��AgeP:0�
����k�� �R��MT  E�a7�n�� �H��FG�X�=�Z�0��8����-�e�(�x� �eϲ&`eN�C߇	h0��	S�W�G'_��U�%�[[����Ϫ#P�?e�$�q�鎃����>,u�)��Tw�Q�6�0%A,A@�2#_���KCM[�q�N�߿|G��&c
�Ȍ�k����AZz\
��B.�}���ov%4�b�+dH�n4h3�P;sLm2K�����h1�n�;��A�B��b۲L�����'�jtᕧ��V$������_-��c��Q�01��Vp�`�yt��V��MI���G#�L�� �z�)ʴ��4�Bh���m��[Ӂ�R�]�1� }P��YO_9��ݶF�2��8L��diD���Wo_�Ib�'q��A{r$%\v� R��1^�]/ዊ��ӓ-r��P���b��� �e�>��f���8��	Dit��fl�;tt܋=u���n��3����Լ�����D�e�U�&�ixHӻ D�C|���.TD}��XZ�T!Br'��L�ql)�G�ׯ�c8Q��SGV��:"�0�0n���Z	Ao��f�/%�	^p;�3��o(�m�XX�J���t����7�J�U)�4�YF}�����:ww���O��� V�L�EZ�O�����sr:Bb�M�f��>F�F.��p�VM�߽����8U'm���N�Y�$o�q(K�~��¸HY��-�F܍��M#��x��؛��x���5����y�'�B��%�9d�\)h�#���)~�x�8tk7nn��pmcj%K��bςdk�D��OGL��_���-���r�?��cC��178^����^	P$J`��o���j?�H&SdU����?>����ߢ%!ҘJ���l��2�uX�\���f�g
�v7\����`_)��[%�x���Ǥ^c�'�'໮����ra��X@9��iB�k�4E{F�y����0����1}$�Q.� n/�-�4�����M���h����b]X	1q�ɓ�:��d<�*XC��d�"����]ݺ�ѳuc%5�4`�|<�d�w��EsB2v�ÊT�Ns��ٛ�V!yX�+	I(e~eGov�sX}<��sq��vH=F����|Z*���e���X��%�fД�����	�����<�T,�3!:�Z�`A�D�:;���X���|Пv�@b� �+�}Vh��������G֘2���1V>S�&��R�@�O�m#�Ź��|x�,lt�i�ZF�'k�5�4��RK(O�~H.]F���x-2^��r$3��d�z����E�ʰ��ZA��84ņ�t`�n�.*;X��,�    �Y_M<D��'��+�Q�¯�1��E��#L;M�Q�IJe�3�����8"x�2�
ޯ޽��/�>��g�}9]������(�U���X4��#
�#f�yl���X�V�F1_�� g��'�>̳OG���/P��z��f^ pT���w�+�j�mfya�C��3���j��[dx)��B��G� �Eo"��� h���F\'�c�I��j��V;Aj{l\?���yw0���j�-G<hYZ:J�l�J.&j#N�S��0�0��8;�|t��BI��k�Cu������i��(ް_�33�Y,^5ػ��ӼBMZn�<��P}��z�^���Mk�=���5M�k��Քa��ށdjb#[1-���l%Br����m�JRB��߼���͝@��|�W;c2l �b��$Q"�n��
��k�i�?%O,
�O�P�Q����茇��䥒Ž�.ڬ���q3�2�B�/e+ x���3��~T@)���ò��󾟎�-���lܙ��a��c�Gb?���+�O=V�M�����o�����X9���ʙ�Z��ᾨM�2�x�N$�a~]��(��g�<_Ҩ�bе3��m,^2X�'���c�';@15��Μ��tX4��d�8�{H� 's�8=��|���`��d���4��Kan����"��Vΐ+�턱 �GNA���%���>��$�=��'��,0?Jߑ��T w�ϐ����Ml���&8;^OB�qԶ|����2X"��t��>��J�s��6�J	��-i�����Pl^�8�T�#�Ft���B֫��y�$������
Lџ?�l�IS�a���;l;��m��-�U�P�q�^�=�a�x�n_�����?�(� .��N��8��/2�(��ƆT��4Fŧ��8��!�p��^AX'��5��E�$LP�pkJ�ݕ'c���?y���r�k\��q��ڱ(1B� �!���e�
��c9/�P�-2�z�VV�<Pl������V7��]O�L�fD7��gA*�ȵ�t���J�F�����ӛo���$GiV����L�j���e��`%V�cN ���,կ��tZ��ʤ� �;!Q�F�/��w��e��N/�� ��Õ�1�Fè���*�t&��h��!�ؘN�={)1�|T��V+/G�e�Y��#\T��/��|H�1vS3d@���*Q.��L���CH~�͛�x��s%�Yˀ��w�U�:�׽c Y�f�>��t^P�b�`(�Ýx]��n0񍩇�ٓ�%ע�y8a��$uv�΁q��D�\��S�AE����{�F�1���ZPJ&�]�3>�fV�������r���4�u��?_�n���6N~�(PɅ45Y����x}T3�y�H9Վ����B�:
�����7�|qO��,D}���Q��F6j2��8R��1��t��� �C�{�U�.Ӧ�v�Ay��j�gp�~�:P���M����^����j_������Is�	�TD�5��Vo�����0\?Q�!kk����!��V�?+��)�(���.H{��3o����SڭBYˌ�Y<0�D�&�,�~:�ҹ��O���.���w ��\�hkgʠ�q"Fɹ��vΠ�f��o*R��B�&c�������8ai��J��3=�qm�S�T�z�-��
�ј���S�ƪ�I��}3Š�W�~��L	fETM�9���)�6٧f�i��m�H�
SN��W	-/�S�.s�o�:C�
"S7�z��$Ay�+(VJ�z@��a����`#�"(4tW��zS�I1�ŵD���� ��!���J��^Rq��*��X@+Y��)k��F��s;w �pII�䡰������z��Γ�yeE��T��;l޳%� ��� �3��"��^���!�������M�m���k���$6�H̹K64������0#�p�u�Z��҆u��_�ٚ'�]� �m�hY��rE�H�/�ە��\�ŧ�������'7�<l��_�/,u:�O/[$��&<����OG&�w�cBG�{
R�/����
r���s�Ӵa�L�6�U��ơ���5�S���V�ĥJ���T�/f5�dI9X�c�p�ܚk&P��KB����z��/ ��X!��MsA�=��R�!�N��f�]��C+,c*̀g�}���W��_ �D�
 \O\។�J�d��az�݃�9MF:��H�@�W{%�	!���0&���/֭���=aP������jZ�xl�����Ff��N
t��g j��������r�1��zj��n!y�+�H��bЩsH��%{�}�K�\�߿��ǁ��x��j*����B���Ķ4�s.�<��a�T���jcH1�ޥۏ��7�|�ll)�0*��i��{E�Jm��u��҂�( !��jMW���ac3����l��d���,��+ݎwV3o�A���ۢP�P���(z�\I�&}�v���R�R�V!H�(j��[Pu�`\�G���W�U�j�Y� �X�(g����O��E� �D* ��կ��%u7�jҧ�lT�i���6�㵜�U�#눎����il�V7zj-�~^{�GԄm��&k�k��6�Hl�+frmb���y�J%?U�Dԅi���4�Sv/��?�J���^�?��I�W0�KL���Ք6Ɩ���;cu���/Ā5�A�a�|��)����#����q,)�m�f�Kv��h���(M���n���Qy���ȓ���>�ɖvt�ݍ��(;;�f���� �M�#�q?g�v_������Gy١4�h��1ϲ���Є�>�I=.��(���C��d�i����Zg@v�~v�L��#��Q�P���6��
����
V��?|pk
� �x�C��Z��=(�!!�z���,����q�CUI\J))���ߝQ�s0PF| ����ڟ݈Ͽ�Y��j(C���0~/�,��$��!JCZM\��DQ�a?y�ҿ�~�����Pɯ���9v�c6�<��	�^�&�c��,��#�ǎ��𬹺(ҳ����d���Ԍ�b�P|��ж�E�m����ɖ��уױ�`���q��Ѽn��k�%�6x,d=��¦A�d�H#}�����G�xH&Ԅ�E�\��W�������w���y�̚��'��M�NW
��	����d���B�T��d$\�	������zB]Y
�U �|�"��'�]�`����*��,�.XUZ���%t�uR7t�H����[��n����\��D�$��q=����=�f^Ϙ�e%|,��Μ�d�a���j��h4��k���w�;����<�Ie�Z� �	~�C<�H�R0?P��M��������]y^#L���u��WZ@�?��^����HB�:��X~��f��:���ׇ��Ҽ�?ѯ���[�>6`����p�p.�l�^p��pC��B���J�Q�Z���}��%�K�~'�����W�w�����a4h�|t��S݄�7ö`c��mm
�-k"��a�OB��B�u�l�a�G��Y�.����`��BZRLB��JUI��JJ�l�����1��V�ͻa=s�T��py��/n̟mI�^ʆ�3��~si��M�aQ*@L�>��*�I��{���P�k>�������x~���%U��fIV����e
��w�2 CǃD8^�啙 ڝA��#�k��SL��h�Ĝ6Ó$V�Ď=R7@Oj�f�S���������
͕ΑTE6C�`"á��  �͡��m�zܤ�T%0u�.a��c0��
JP*�t��M6�F�1mTj�g�ޜ�Nq\W�4�H��\�Sd�!IL@��7��|�z��hcZ1�ґ��DQ�M��v�r�i5'D��wJ>�/f6���8��	���&F�O8�Q��T-:^X��b�)��6�cH����ھ�0���T��%���|H􁆓71U��Pw�.
N�Y^>�>��[���jh��g�79Y    �>N�5]�s�5�.�[%j�������*8�U�2�z���/V��:���0	h,���7�rҒ�8:x�0zFl:��/P���tZ���%zw���₯4��d�a,�ƕ���������?�~�9P,6�{�v s*��z:����bt�QI=#�(5�J���G$-�1]���j�����>}�Vr�=����4�"�C^��t��9�=��4m%�V���k����2�:����;�-71���J�i�o2�������N�>%��R5�| ���&RM�{�XM�r�7;��
rz���b�z!2?^1�WCԶvN�I�'�3*�m��B�1��8����_˪=�b[ss�`i;˃6�rA��`~��bPH�~e��iI=t*��owJ^+8�[�l�:�س?���j�3�5��n-��w8_`�-%�:u��bI�}�+y����hi���� �����IV�bp�u�@M����WH4A/���gXq�޼�i7�?e���o�X�'�Aս��_7~d�%�b����`�&K־�x�˟D�n�$����]"��x��0PLi�$�v��2cc���{YZ����������͒2��WC�&q:�=f���!�:(��>��i��:�?^<v"�!��~�<�M��h��RTpa�O$*�������}���s��HV:��)�/(�~�CSS���셫��<>-� �)ӂ'P:�^~L�/j���5�ƞL���O��m��@��
 ��. e+�(��@�&P茣	wx|;��4�6h��H�ub�3<�ʷ��덖��b�����wF�+e��i�;�2D��Ӛ�P�Z<��/���
y Q��ZF�ǫ/������>����8� E-���L�ޛ�nB��DpX&&2S	�!%�(٧Pev;=,�
yjg�7C��z
B��Y,k�L>	J2�R���M�p�=Om� �xnq���r#���O�9��B9*[u���[8���s��G��];ߞ��> A*�э���fatuI�-m��%��0m(�(�/T�J�O���BW�ygz�V�=8�ԤՐ�I��#� <�_PA�eE��RP3j#AS֞V$��L#F>�b��#2%v���G����W��},jw��)ջ5T�ǝ��p[�7��k)@֑X�׌Q�2���[�@[���Sv�V��4�7dv�g�$��NF�/�C���2v���?bۄW��¾�Y��'�t5,�Hu�m;���"��f@���g!�;꧞ &Y�f�t$���(;�Vi��������vyP��������Ҟ��I����(�1�X���������b�|�p�z�Zw���.��/n��)V�z����Xd>=�](� ���UK�FR��Tw��d#�٩f�j��E �Nk׍����§��#xr�������W�I�А��w��y��P��2n�����4�S�/��?:x���*,����ßN��H�"c��3D������Q�J�6���>�����B�J[�a��{W�9�ؕ$ꔦTg?f`n��h������j2�q��J鏶]jwu㻱�8-�v�K�H6zo�"�1����!�+I}5��z�V�v�n��>K�r����?Ѱ��g� ���K�Z�6����ү�E�θTm�\�����L��˯� �߇Xyc�Fj�1�@F	��~ޢK6j��5�K�F�1m��w�*b�{t!J���[f��8���}Q�VB��l���l�L��z�s�Ą��n�N�ݽ-�?�E�"th�ߕ�p}6���ȗM�r��o�����ݚ��q�Hs��uT��k��f��/��a�����`�Ketl,�u�k�PS	ց:�)yF$�W�
��7B�I�3@Wݲ�����
6�|��"w�����#���_�h��Z�)dTFj���ϣ��A�uH:<��o_�"��S��s�C�ԍ�2�U����%8����7���Q���ܸNPA6Ŷ�+��Z�4�g*�tP��F�4b0�"Qg���k��]#Tz�,ǩp���������M���w����c��*cpb�7
MA'�a٭��F#H�'G�7�o�x~{��UA
;=�ݣ�ti�48d���mI�^�Ŧ�2h��!ԶB?p�n[�ڟ`��Jr��Z�N��ؖ'N��~$�:��VkE�,<d
��:�VӴ@�{],�
��ȊPy_E|�щτ�_�D��Ĕ1&��@�sƭ���c=��<��u)o�Q����
)�M*A���ZSW�i�j�\�3Z�*�U5�I�/<��X�+���>/B=M*��W���bO���k3:�Tr��)�M3�U��VA��w����&��f�2e��c���qm��L���=̣��3u�҆����]�~Wɧaφ��DܶJ����~@��0�Q��?��{�e��R���刯�usT���s]����W�v�Y�H����,�/�C9ڏjH���Ya#�GBE�]�,�7Pm�������kA�6�Z4�5���C��rl�7z�B.^S]��j�B�� ��ep-���N�#�^ �����DB�=\���I�?e�du��*��>�+8xM��uaH��Xw�)��۾8G�Xj�m��O_|�����7յ ̼�C�B�`�C=�냭���4��ֲZ,gKw�hL�'J���nu[,���C�s�ש���j��R��+�4{�fH2�\l���^����y�!^����d	��{L��;��hj�1�z0?�w#���������_B&�a� ����{>�F�n���e�x��cR�2�?�u�д����ssm����
p�爾����O7�~v�6t�*�zt�e�4������īz1F��������U�YI���@!�>�P��Lsװݪ�j�!�^ܓi[N��g���OUX�6�Q����Ƚ�� �BJ�@��ӍN�E���g\��<p�mJ��K�g­P]�q�
ʏ�+;�5��d0o���[\k��'�}xj���/��<P��b8ÂRtؕ�h`�H�9�\.�,+ ���ɁC`�]��EJI��n�1;�ue-Ӕ��H�#�~�C.A!Ky`A�lF\c`�s���iVy�/��;Xu��ݩ��z]�2�K܊������h��Rh#4g��JMA�ȴqR�%�C�&.\ڍ�n9`��+Y�|������M1�����؞�NC�)���n����u�t�z��G�$�H5SR���M�0ۋU��e��]V�<+�څ�EN�R��o��b����T1@�0�D�c�#�Z��;T�~s������2\��L�ODʉ��|N�1�jq?�M�.���*���K9�!�6�!������W�	�2����110�m�*8J�狃*d��u�J�eA�h��>�Zt{
dط�� ŕ���>�xq�&.���r����]a����r���o�l⟫��~���2����������P����<����*UoQ���'_8�2�ͷ_�N�m_�QJĞ,�;}�]:��[+�]0�;3&/r�#�L+�NO<�����g$9lp��H'��	������-��@�����(��E4;l�l��f��#5�������8�5����5�7��G5�f��q��������\s��Jt�u���W�߾��a&�n�M�}�u��S�����
s�
>�s�����i�O%�W�g��k@�M��ϼk�@�����ǔ�cS��z�����%�[��"p\��1q36��+>�/�����Ic����<�����_�DaH������W�"�b�&r}
�)@u����JY�{]�f�s%Z|Vt��t�y�,~ �B5n���	K65@���?}��jp�u��*=F��\H`Z�`7úIǮ���d��,t�`�]��5��q|b�������g7i�����؁w����)W6@U��St����w�$T𡬩�?n��ft�5��������`',<h��*���)�yAi�8ϓn3:Ļ�T��䘱6/�]�\,"ͫ��FkDz�R�
�    ����b*gC�/���8+�7�p�yw���|�|��E^r�7���mj(���P�R���y���o>��?�����Y/��pyHB�~� D�yD�a"9P�.Q�C�*N��_�d9_��Zp��x�@�oOe�k!ɰع4Z���.�y$\��i��-�>\�3�Z���@�XO$��œ�lů�悍�����*v��5��x������9�!�?.���:B�W���@����B�O�@������X��Q(�A��kN�V��ܦ���5S�м%�ʻ��k�n�Q��h��g������pt;��d�A�48E��.�4u�@�b�R �����92�l6q|�]r���bP���O`>ʒM?_�U��e�a��z���3T-��Z�Ʌ̈�����דu<�jI���/����Z�1�D_Y"=E����<�C�\��-�������N
�G���S�v���;���AiͲ��X�9����+T�8i���$eY�g�~P�2Xuu}�����Vf&x���6�'�k?
[L;,To+WO�].�$,�K�}�G6�3��j��p���z��=+����%X�����A'dDB`ӑ���"4��8���u{Nc�-�F0j����"^�Ds�3�:�v�X�K�B��ձ�v�C��9j��/��>j9�@�� 4��T�aؙkP����x=A�w���?�Q��t?gy�I�F3_�� rL�Xr��c�5\�p��C���~g2kh��o��w�IF�+�88�n�l���)#��O�r���B��2�F�1ܽfw�S���`�a_���S<�M�15����%�B��f��㶨D�Y���E�
�	s�.V,B-~��3�b,3����`�	��&�Q��q��ݿ�D�[;�'�Vm�Fc���|�V1E�N5QQ�ͅ3�s��������|�v�ս{��� <c�
6���'�浨s�J��� �p�tgC����n��@�<��q�~�0Q�n�W�P�,05�%ن-ǔ�d�?��a��U��^pl�X���r�������5���5����K��~�^���}�~{:���p]K�Q|iw�$�4����߽=]��9@5�7�`Y1l=&�m��Lg�
�s`�r u���tM�w?u7�F���BR�T��$�����ե�-�U���?6}B'�kfӥQ��K�rs�(���D�?;Mk��o�(�����gU���,jOzhg��[�G�;.llւ�R��_�釿�������l�'5(#:c�
�}��+0v�q�]fG@Ų��4�������b&B�`,!��lцy3b"q��.'��E���%Z��B�vSN�Z���^��a�p��me!m�a�PBT"�NjT{��E?h~�.�Х�]��U�}�a��Z��\���Q�F�����M�߽�rw�`�!32e����}�5M��z��6��(K�c83��L�1���V���gKtH�T"��{�;-zQK��O:�����OV�P���/Ax��T, (���{�7��^��8/m��
	��/�Qa�;>R����'�<��]%��U��
���ک���	*[��\�z��k%��J��Ź��_=���(�'��J9�*�QV��s�h^P7$�X�N���k��iML��Tj3c�*!u��œ�Cō\9�68���	ẘ�w��(����!8�e9E�B,��vKBb����_KJ~�ާ��-TY�����@_����	��p.�.�K6!p�*�[��*��a�:A�F5p��ߧ�h�ޟ��J5@�.T�T���7��>� �k��tJ00_�X��}#>ː"!nQ��g���Yv�5��n��7T<��B�m����QH
=.i7�3�����R�U��|d��E��J��%��*�QA1ͮLe�V�]�']��<��X��ǫ٬�u%ԨAP�c����çD<���� �.��{�S%�w��=�iJO��B,;Ё���}��$���b��a�ğK�}`<�����;�JZ���k��__�����ݩ����Qqt?T���-Qz���P�>]�-B���b8Rͪ��@V�E�~�
p�8�	��z�L*!��d7�zk��ŝы�~���l�W3����)'V�t�7+8zj *-�~0��ޏ:� l�X�=
ɟ�WO�x��@�����&����	4f~Xk��s����е�E�~����+���Z08=I@@�za���7��i6��d�P�!(PJe0q�)����6A���a�m�K�E*���S����+��7���+T�tx�e��k�z>�Oޥ[��;� ���8 �����@Ai�X�2&��p^�u��!��:2�[4��[��P��л�߼��T?Nz;z��:���6<l���t��=�+V�"�JB-2��tA�z��1�<b͗�C��	W��~���U��d7�T>�.YJ��S�%�d�*@՜YL�K�cL?�T6ESSs`����'eBe�ܲ-��?�2��9ҋƜܚs	M�;�É�D�m��R��B6�9�a��s)i���Z�����>�.0������ʭ��N,)6N��H�Vv$$B�	�}<f������8�q����0��6$ej,ڠ��7�Fqӫ;#7=�����y����E�R0!R�����X���k\�^�骱FP��=KZ�/�k��ќ�ӔZ=�e��ҷ"�4j� ����.���|暠!������J�9�)�آ&��F'-H9��U:6����	C<�r]cc-���u����/=������ɋ���Z�0֟t�kk�h-�S	נ[C�i�iR�˯nJt@,���!қ������@��占���jn��ޑz�Y���QZ�6:m�v�A���s���4_l��z�@��{h3�J��|]�J�S*�%2n shr�dȈ�)rM"�&_f�E��Oe��W_n��d��'���N�+caR���i�:��� HA�M�=�qYy�7uz���f��KYt�=�f?�[}D��t����@/��<6�M���to$e0��f��10��]��Sώ��H�����6?
�ⴥ���ܲ��r>̺���%�V*��h��2�]���g��Ȉ�EBG��s���]p��d�\��B�]�pt?��W�|�%��x�������A�n�>�D\ȳ$o��O�������DE��� YR�
[���*ԋ�<NO�z�eH��@Goi9(��ȸ�*mS���2����d�j�
�\U��f�#�b�24i|�Ħw ^�;&�8Ҡ�S��(������>�.x�b�B()QI�!x�.��]Wsϕ�p����'eb��U���nT l?\�:'y�GE��۸DA���U�Wb�pH:Z~x��7nFB;}�X}��=��w��V��ʁ�:&�{%���8{�g��F��,0��\Y3N)���+.IFWu�zhiZ���"���R~d�Iq`�R�Y�����2K������@���#�|u���o?��t@%\A9��%�!MDy��F0nU��2���,��i��S���+[)�;d�*����&} ��Wj9wO2�;�jUv���*��U3�|�.�2S�|�q���w$]>U'=�r<C~
�~�[�m|�M��������ɉw��i�mR��]%�ϯ��%�e��WI�~()���J���d�ؠ��\�Hf�|I�>"�
 ��%k�pl_=�O6@xJ>��x+�R=5;����#I�7�A�f�IxÚ���QE���o4;1�M[R� �s���n|�HAbc�����T0bx�k��RkM���֙9�'��qI;7�^MD�_~���;�J:'�uj�6Lʳ �=
�EW˫ጋ��aE��*�\y�F+�2,��l�x��b+�����)��x��y��i���dz����c6� �:,�X[M�e�}u�?Bg�$h/�>�/���s@��Z���#�<r����;�>.p�V\�+�і��������MR`�!R�bhܲ��卤��.>��ׂ@+�ҡS�+;�S1��Lu�6p�59��dSݬX�Fc1�}��(�a�{~�     �Z7p��tj.��Ȕ\B��(fӊo����5k�b爅@���n�j��U��[��Z�<�6�?Y	Ћ�ᵯ�Ej���D`��#l����dŏNΣ�tw01��ު�k!F�UzD��g,��!�q��B��J�lN�w%��TWf�$��h�2A�Ȣ�����%�`I� �L��>��"�	]~�j��X���n�EN5�&vY�ł|������]��<�t1$a3�x,f�S�ȱ~7h<*n���6V�/��ɍP3�s�O#LG'2�(���0I�����x�ciY�H�j�F�C���w��V����3M��L5�N��'�]X�\\5s���s�/��8,��ۉC�QV�^N����`U���cZ�4�K���0О(�/��t7IWy*��?��lW�׽9O>z�%z�`':,�h?�u�3��<L�i�p`��&��- ��q)�����	��o��|���t�:DV;Q~ׅo����z�hb������kc@�d�Z��b�Y�sNs��5�GL{(��d@�,��ɑ�;��.��xB���
�-�﵉q�,O�X-.)�(�HAIv�4Ӗ��x�e,�y�g�'%?��f�[���m�D��ݲ��Oo�[!���2{�� d�34��Խ�ʘ�w���Z:E�&Z\Fr��.��wx���i��g?�M�}��H2{���|��+�,(�7�a�eg��N|4��>�1h�1�����J	]{^:��^��A��h��*�,�=Ʌ �#��n�|  �������Ť�a�#�^LA�������ь�KZ��c����}�gs�AX�y��|t�p���N�V�鸀4�+zج,��[5n /����'��хm��w�<�M��A;XtZ�\��:�Q�Y+J>=J��CIގ��U{�(ʘ�M2�bYhg���={ŌR�ǱX�0x�/VW0��R����. aޕ͎L�sC�PW�ib)��d'N0�"N���m�"��R��ө��0M�S�����#4����MO2��-%��œ�B�W��|��&��"�*$	/	Xu�X��s,^;dYZ����I��z�X�E�[b��p�ڠ��^�.~���4؝ m_�*����JB'��vO6�d�k�7���%����Tz,��´���o���j���`���_��j���g�~hĜ�2J���D��K�ur�U�<�fap��A�thQu���V��U0�p�z^:��'�Z,V��'�����!:�ƃ����GJ�υcr���*2��B���2"�~M/�m2q�m�l�
t�0���%��D���C�!�b��g���b.p�"��{�6�o����E���S:��h�J�9��HDH�\��@�]j���"k�h�_Jje��Y���U��F�*���u��{�s2�Z��V�"t�%4*y�իQw��k1Z�)+F���\�EF9yȗ�1턭�NG�=]R�����*ڼ�h맳��C�q���κ�<M���>�V��M�{F�����Ms��#P���c��Wo_�㯯�c$%��D����+N�`�4sA���؟�]��AC�&��iR�������{�+�Wf���B�Z�BiI0�E\�,�̥:�gݳ��xiQ[��k��Dɸ�Bm�~(���1,��д1#"!�u9�K7�Ii6#��� c]�o��Hc�·?�Uj<�!���$t}�8����3*���0MS��&;WYH�����j���_��v�w0�0r?P�v����WĤ���}��
��kGWZG�k Қu�eEʚ9�������Wn�Q�F�1�u#�²z�꼉yM���-$���ym�\t6�u5�'[�S����M��I�ĢS�gK���	���d��̃���(�� �{�V./��?��P��[@e������Ɉ��N�yh?9X�-�֫��x��2�����??���Շ�m� ��k�R��p�V�d��qYx�%�O�?5�(52K%DsZ�F��x��'�o�Z�*_��ֆ@�n窊R�c����D�c�,�|�-&�u6��A�a̨��|lm�>6�н�2u"[������EW4�Ҏ�͇7P��	���>V:1PC�r+qR�h�8�z���I�y&��杒�F\�*-��Ņy�h,��i��[�������{!)��t��lj8��#,�E���}��r'��,z�P�g�n2���3'�o�u�&,1��.t2=;a6Z�,�8�r�B���x���^)M����ѵ���Ȅc���9N�@�5���_��q���:�H].TC/f��7?�������Wޤ�\�w�y��!�j�ܛhd�I^�#)�2�lU�rd ����JY�k��O��V;����=u�4��Ί �wA�ʌ!D{�7��s�<H�������-x�l��-��[�>��}�3�)B�I�.�W�9H��.f���.�䔲v/b;�g
��BU_,V�><
�#М׻�;Vy�jS\�R�M�3cU�y�φ>��F���J�u��&�_���{����?���� �2����R$ռ4���ph���v[Af�͍��AJ8�W�¨����o�rtj��e0da���V4�K1�g�,�M�����(���mtW� ���atQ6�W� =�&��JS�������Ky)|݂��||r5ow	<I�s߰��R��G��`����K`d���[�ءz��o�JB�-k 7r�8�[.ẟ32�4Ћ�;������w��*�+PL�LF�l�VR�pQEu���Z}u$xn��	�o��b�����,���* �"��-����Y��(�
���׶��N8q4$i��<ʶ�?���`Ȗ�@Գ0��X���}J˥��-�4����#fH֠@c~t��8������?Sy������W�����-;�KD�Z�K�t�H�zt��nH=�GB}�m�lZ�b���f�V���nf�{o�i�1���:}pE\4�2�њ��Q���KʣI���Z�����r �L�6}�S�"a.FMe�Um��5NK���#D�&yI�i��i��K6Er"1��h2�B�dvV�ǡ�w��ֱƹXW�3#��x~���|���� g��x9�bz��]�Z[���85	��a��D�]}<��L������=�&����w�<o�Pk�7,������,+���Mp\�ox�h{�6��4z_hF߮X�)�D���>8{$!S~��R?�|gږ�3C?ɱ��Z�ɼ_o�����Z�G�����������BGX�sZ�kd��Z� 'y�:����<�a[[��3�� G��� �ik������Vl���-6����c{ʗy	/r<�-��V��d@�+=)�e�j
��H�)diZ�)�WچI��"����H\��KR4���H��v���k3�f�q����H�3�<c��(�N��7{A5��h�K�V{P�T���U9�ڃ�i���k�Ǚ`$��4bE�b�BeZzպ�O��Y!��v&�iY�#�$���ڣ�˗�Aj�u?��[��
� ���}bq��|qN��x ���C��s���.��P�WR���Ԟ�)G'u�/�ߜ�ځ�h��8���c���AלU�QE�G�_PGB��h�M�vא��B�'�hK���>�R`�Ga`�6MĨ�x9��U��@R�	���N��H�R"7�"��1Z 4�`�l����>
v�c�b1�݇"]�a{|�p_"��ZM�4�-��lY[���Ra&l���@?>1��A[�z��g�����^�����'����y�^�C�Y�{A����w�Ξlr��
��[U�tM��y��91�C�"}]a��v�v�tR��r���~��0��IpH�Zh�f=��!K<[��,S���j�~@^�E
��Z*գ��Q�>�E�g���m[��M����%���t8;��k�iz��pf�H�� �����|�ݻ�l��a��jk��bw���&��!���м49���_D6I����w�%��I�i��S��FfF1p�X0�
+fۢ4r    ������Cf��%`u�3]ݡ*��������+~�oU�*|DO�� ���[¼��0���NO�v�3�������O>��?�H=��b�SBN��y����h��P�no^�l��)��YT �v �^��tZ[�q��쌒�?2�6k��d�� * r��n6��)�.����A�-O��L!R��m�8NP��.c*T�+X���G�Eiƶ|����S�-���7:�y�[MW��a-?�8XO�₠:��x*�ۂr�!�Z���~�Y��"���������o��>��I)U8J�~H�k��X�grRw�'����9�q�_r�#�ο�.�D}f@�Տ>@��*hK����B�(A"�g^��g��hc��^l+_T{����
dV���t�l*�ք8�@+�{Z\_�i�Y����5�ƶb�qw�b{�q�~/��<˽.���ŀ12ϛz0פ^>@�A� =��,��zfW��z�cAJ��Xß���~���O���LUz`�;' ��L�)�d��
��O�K:�n����'���k$Q������� ���`�`dx������/�n_��nU��A�sԎ�WP��(�ڰf�h�w�t9H;o�.���a��=��#�<�ǲ��TxdAձ<��S&5�4U(�ڹ���*����l��3t�ߜ��;�P�!%����,�$~ ��k��#��q��E�B�Pp�I'f������š$ti�(�?�v�<.A'W%�����~��W[5��(+�Ox��O��� }g�K���Ě~�Pr-^�N�~���zo�X�����s�r�pf*�c^� �&�Ufn~������D'ބ?��QLQ��kѧz��3-�:�c.���^@�`��|%����2-��$��u�)=�V�J`�O�立�]@�f;�e�������g�Az(*��!ԤY�r��d{����i,s�L���:�M���Bn�:�x!k�ZU95��k瀜#�^7/���N<�e3�)NTh����� ޱ�z!�u>��A+fun������ؗ�e=�+�w��D�������[ �E��W	���iu&I9w�w%�Q'�z&ez�5�P��]Y����f]i�*9]!�I(�LNh��7Q�`�9��퍿W�#yi@����%�\�K�.����r��b���G$[���ք˖)Bi��K�H��K5�+rE�E�Dȿ�{
�x��5ai�M\N����]�&�݅NHAŸ��,����R#r�y~/X�d��C�<t_A4Ʀ���uv�����RંpPT��2�������x1�Sp���~R���	���(�w2;�ps��,�fwHy��n�$�4
�����U��U�{��\:-�T�l:������?������������bY�;����%v[�Zdaׂ��
"Q.�n�wy	3̺��r��/Pny�Ոo��~��/�޿�NCA�@:�UWoj���2)щs-&����Nu���͸����T��]���E�h�⑚�'i^���p�iD8C��� ��L�[1���Jp簴��a��x�w�at�i]�1U�OӴI�8��b�Dh�(�c&T��+�x�hC�G�+�G�����Ιu[���w��[&��*��;�h=_��~�����L�t��V�;p��7��𷠄2$�yXN������~c^��LpC�4�6��ק6��&^��2�'1��3L���eM���$1���gl��`L������WF��B�*�fy���IY���`���P �Ϛ�dp��ch	<l��,��R@k�)���ݽ�A�σ�#%����	ԇD�Ǎ�d.� {�F@#�?^_ӣ{ eя�o��.�Eԥ���zW��, [�ʉ�������.�de	�e�(�Tl�gͶ�΄i
sڨI��mݷ|A ���� �h������4�@.(�&��9�&��ޠ��ͅ-�%t��3񏦄py�����n�O���S�m��/�nk�z�;%�! ��T��2���G]��������Ԝȯ ���GY�Q4�~�3(eؙIڹڧf|�
Q�G�42%e��?�0���ia>��>��H)�:JFVȋy�Y�� ˅��ǐ�b�� G4q&�QԷ���KB�Do���{ˎФ��:��Y�P���Ė�e��pw�lӃ�j��c�`�Gt�1j��҅�u���=�Ԝ\�Y��/���=ѩ���qV,ӈ	�;�f2��Z�Ʋ������HQ�ہQh�J���$Jm3%$ê��܄E�¦M��"ҙ�y��_��3�ƀI�q�Uˌ��Z�/�o ���o���'��r=n}!��9nU�$`������ ���̹����dLA*G�7߼����^C�UV]�vA�|�/�*a E�
�N-
:��C_5	���� ��^/9m�= $}��/@�j#�e�&:��B�-Ma�a/�dĆ�Y�"��:,D���;�o�@�-�%��l�z�1C��,xd:O��g_h��>� l� Q9�3��@�9�kmw�ؽD��?YvV_,v��H)�������9cV1�wt&]��Ć@�(rI��Տ2�̔W�WN�V�݁�����.6�X5L�;�}�2���j��K�S��&l��zV�h@[��,#,JLQh��zjbi<o{[�Ƨ��C�I]~	��aW����~�rxx1ᐰ6C���>��D0�3�XV������_?j�ڦ�����_t��y@�Y�Mɫp�܋�B���Tji�����i���0va<�r�n
�uj�X���S�O�h��P@�ZT�/`�����  ^e)XqD��
�� n3-@dàYӂ����6A �s>�{4P
T6��2;Ǖ�-�Z͋��&�X	�K��^O���	_�c4=4�b�J�%����|���ۨ�d��C�J
� ,z�#U�'+$4l@���f��b7�ĤNj��5d��U�5������>a���-�$n����lS���JR\tvU^'�4њn���I��F��������4�'$ʙ<�}+���O�v�;*�X%��+L�X\�=V�M&����͛w'�_�E�����v���-�-�^�K�6�,{������e'9�'y^L�����)Ѯ�_���h���l6^�H(��:���bI�L�lO��l��;M��X+d��*Ͽ��Zşt�H�*%k�~Ы�E�Z�7^v�V����Q!+��ג���Y�ބl��xW/SM  /��MD��Y�ПF	V���
���*�77�"� c"ӓ��fA�U%O��� FkF���	8q5 ���= ��f����^�
�2a5�5 ���\��ח�Y�S('s�v$��2[<S��1��Q�v�mG0�o1�S�;H���w�_m	%��u�����dU�rݩ���;��͘E]A�*S8$�A�)�`�mu��oJ9Ћ�Vs+#/�q�����I��瞗�n�����G��q,�3�T\CJcf��^@�"��-C��/_.�/i����$!����kj�|�x�8d-�������Ōe�sX�#W u@���i�߫?�U���������_�{�=H<�dP:aV��h���.3V��W-���J@�)�V	��(�z�R�Md�)�PTKL����ZD�a��2\���#^���џv�X��v(@Zb��$.!��c���桑�|�H)8��R���1�����S� �������``p���B���﬎�OD����S5YD�><%�j&���ޢ"��$y�8��kf���j��+E�N�ْL����&fnx4��Q.�\�����	��yD�[!�r}�˗��:�I��ɛ(nw�7Av��u=P閙i�Ō��˼����YO��܇����M�p_�o�/A��i<�}�aKlR��5�W�߼��C��'��r��d�_U�éS1�6#`��4�J��I��3����QP��J��H@`�$KX6�I	��N\*{���N��i�c��,�]D���6�jp�Vސ�C����M�fiFkr7!-�    aу�F�=��7 }j��iއY3CͰ!@�WϷs�J�ﻚv&�<���W,A���p��G�������_�Ƈ+ts0Uÿ�T w�:�͕P��c.f� �i���* N ��	R�ִ��k�n��a`ܓp�TS),٫C����ljF��)�%dQ�O$��e���P�ԭt��~i�ݼx�Z�t��"�4�<�6�Q�,a� ��xQW�����Ve���v'�>��ݰ!+��-	֎��_����#�"��s����7|��������䤧ˋ�N����#�'��Мk�/S��u-�#��فghˇU�4d���t!2�xa֋Z:7�!�f�٥֔vB�M���6t����R6d.�����n�Sѷ��ʁG��t"�-$`T�D�9r�G���P�8�v��ݺ�m݅*Y�������r����oNڥ��O@6��_�$O%�U[�Y����L�ۀ3W�5^�%J/�o�m�Jh`q��F�"�Ϛ:{���*y�,X �&�������)��E��t���U�w?]�=���5(������Ū�>�B�{23���Tq����z2��j=i������o?���<n�r�$�hT��*��՚�jh�у�v�V�Z��0�ӟ<S��Y��688,�W�
�Im�6���⎀Rvf����.���*;��,�I�|h �̮�hK'�K�KH?�t��`����yK��ԋ[����Yt8�g8��e�&=�˥c�QMgٮ![�}�u�����H[����&<���E<_����݈�z�Gԉ��%5!�`@�������޼-Вݦj�7�Y]'\ɰ��.�t��fi]�/�p$τ剷���Oe;i�]��h�ru�f�y�=�&����H�,�T��/�#K����2:�rd(i�d':�� Y|���;�,�)6,p�`�DY,j%N����d�X��[�$k�5�������o��_7��A�����6N߸.d�5}S�2ߜ8���<ϣYm�iׇ�ޝA�I(tY���mx¤Op�Vw�ChK�к�h���T�<��4Gp)���< *f6"Ww�R��i� ��S��l�gt��VQ������ ���YA��1�M:�\�����J�ȼ��T�H��[[B%�9��]8��Ɲ(��
���
�X�������q�qwpu�'e�ZV	�;S=��`�E�/�Ydǐ��VѠͯ�]3�M�ܱ�c+�ڣ�%�x���S��VZOqP���4rę%�@C��w�ѾBL4jh�U#n�o߽���Q"**Y���jȟ�L^�����G	8� �aB����vTF��b4��V���h��֣�rԫؼ&qĴQ�I��#1R ���
�=)o��킠ї�U^�4�4�f7C�7ݚꚶ��}�|�����q�0n�Y��V}������5�[�����I�	§+��I}�@����7Ϸ��i���籙!�W��:�LC�C��¡���vzKWKA+������d��/�4������R�v�i��ķa�"�O/����M9�B�÷��;�xIV��^p�r�n��ɡ�������86vj�й���ꏯ�
�0��]D��=R�m���.�j˨)v_>"�h���Tx^�Y�<�/,�u����p��r�Ҵ(�{�����0��L6�X�����ܴ,�|������������y3%)���*v�asP(ww\��z��"KŌ΂؏2
/��S7���{�G_r����JB�gLF���Z���̉0R���A
ќ'T�n�}!R�K;�@7���0Sd@�����bm�g��[b��ۍ�o��[����;#��zs��1!���.��#�g��8<���br�������/��Q7n4ڌ����9�0#��1Q���ׄzz�WR�͎�ʥ��2|������;$JuO���7YX�4�_��1i�6�  n/�<3-u�n&&���{Mvp�������C �`�,h�m?$�����~6���Y�ky���Þ2�xy��o����=9XF@>�֧7z��T��	��Mіg�(��[���.�4䆈�nZ�y1���Mn�c;�ȸă��v����q�l�Ѹ����N��_�&S[�-��8i�����)PAm?����;t: �z��s�P0���b@r^��j� ��_@t��X5����ʸ�h!&5!����f|D���0d�4O�R/v6�[�'����D֐��K�88��	Ll���+�ld1q�I�(G.oVH� ��"��
�*}�x��V0BIQ�K��x�?�!�j���֞��|O!��7���}�,pr��M�$wԼ+>��:Dį��F�q��\�/�%y3r�_K~`O�J�@���,M�.�Y�?F�����!����ZgF���o��i4Ʌg��}����d����
�������Jy3�%%{�n������&��A(���a#�y��cy�O��ֺ�$ܕ|q�$�C�y�4:���r�!�<�d���`t� `Ox�)9^"�b�@e���w�v+h�a|�k��	h�j�{�5oވBL��р;����Tr��%5��@A�07��u۴l)�>g3usF��<�����+��|���f� 4��8J��0_zG�-�Ä
)A���8#���Q�y]/���]J'`���W�v��=G��G�w2n�2np����������O4�oZS�s�Ww@!�4a�'��Rq��_x�R��uX�	���7`�	L~\��Ʈϙ��^q�h��=�ȁj�C �_n`I���R|�8�<��L���q����nZ9���s��I���G!gx8Q�0m~�2�Y�F |�Ļ�<���?=eEY]��G5l.�}d��状���;�T9:�� �>�mO�$8g�g�E�4Dg��Ո�
�w�a]g^ڲÑ*�)���6n֢ �d�q�'`�%0�iøJ���N��r)��6�+����p��B�j��fh�4���r�"��Bh��"��]� ���f�)�;����?�:A�hI^tm�D��2�aY�D޾½(��8�Tr�2�V�Ƅ���;b�<`��B��ԦQ��>��^*�'�/oz�p��k�-�;-�ϐ���.���#�E{D!c�h����R�/XQ�ٜ�1��Щ��Q�7�a�2>^N��/-G*��d�����*�j���~U���;���UPr�VG� ��-D7�T,M�'0���{��u����Q�)fU$J�C�KB��u!	�������9?�L�Y�[v���BKp2�OAo����z���d�(l��5T)KW��Lf����'�I��bV��(���k������yZ�(���޺�ʟ��q��WO���q��Ă� >����	:�f��ϣ���P�Y�X64�*�|:��fn�_ۙ|Ѓ�r'tT}D�]�6�l��dk`�����i&�����i��C M���ϟ�F �q���Qw@��5W?:����E�T�ʉ5Y5N��'E�:Nh���@���V�� S4BC����a����-[7E��8Al6���8]���zp%��5[�L�YkU�'O��D��p������LR����C�n���K��(�_���
���K<)���+����������uVua�����jI�E� ����PG���9����= ����?�ٟk�"l��)[�7xH�h"��E�����4�Pd	uL�	�
M�`S��M;�ED�}k�+���Ӻ:	��kjv�k�"���M��:b�g����M��X���G�ƽ�˃�[/�ƽ$��Qh�����~���
%�@ ��瘰�%_j>?Ѳ�S�|��M�BKS]оNQ�,(�h�1ՀQ(O�pWiW>���M�k$<�K'����oEΒu˹y�3Y!=7��j%3���`�ij,:#IH�[;�o1q��!I�Խ�d�jf?�.�K��߄��6�"��1�y�]�?q�(�<2���x�E���0�$���W�_������)]��#g_�=A����K�� mw�8��c��&yjv�_(mf�    G��;��SJ2e���BK��,g������U�ҹ��T���z�(�Pa�b���z8�"0�D� �._bS+'��� �S]?��$���l�����U�V��N~��z6�8t��'�=�V�qt�#���S5�Lt�5�>��0׆\��[�}LFڣ����߿z�ǭ%q���&-`�BG�T}Ig�zbW�@�t{57r<uv��{��C�c�_��T�5����B.󩦐�E�/!D�v��$���6y�Ц&6�@��I͈����YʎTs��*"��bC�������c^~�q����]8ʋ�?u�mS.)4cZ�]٬��#�|�u$\�Ή�u��ܻ��(ep��H��!��\nG|=(��f0`��8v`���)h�Զ��F�NۺP�H��+@PF��X�U��4&^{=t�K��x�8[a���&���Ⱥ���LW,x�5��;x3�tx��7<1&����d.< -(��2�k�4������@s��ܰA�V@��.�Ǎ���c�s�E�!�߾�M���\�Hq���VmЪwU��� �y� ����]{İ_��"���UM�F��=�mn;�8��)�$v�J�^B�J�({!H�A�Z������amF��)�h\v�o~ ����2(1%f���߷ �ˈ�"%�T%'��\2|A� ��_�����7؉2sZ��~X�<�rtX��� �~]��)U��^ծ�N+�&�K�)���I5�E�K�L�D��	��X�r<��Ó9[�5�l
`s�LU��TU�I�@�H��ՍEx��?����Fh�@|��g���%=��s�п���LE�UL7�[B��c�����٢��?����J�4������#Ѡ./��+(�@�,�N�(Uڔ�1�T3R�~E�õ��X�^�nĉ�L��.{�c���L�`CƠ\?�`�؆�̺�#RJ
Ë$,��g�X=vYԟ����L=���:���9�~�:��`1�J*�Ʊ��͛oޞCbI�&FCa�G�岫������c#��PY����]�&&zR��c�ۃ�t�ϩ���8��-<?!�:ĉ�AyS-�A�M�BI#��2ӆ?�w�������@����Zq#�_�B׷��]`���Д�P��74R��T�M���}���������n��Ԣ-��͊�"�KPFһ�b\�,E	yЃ%By����7ZMo{�"t�����!���z�������ͪ+Es���[���@�IK|���,%��Д����g�����p6����	��*N\V4�4��V����
�Y�	�m=�cw~���y�HL���,��*��(�R�]D�n��o��ܼ �j��5��P�s�|�D���؟�ߙ�˪:o��1�������f��:G�/���zQ�� �)��W@Ug �`��y����⌜�\3���v�?y�f��LL�h4d��?AS�"��´־R��`e7$����7�ÐJΤK�fVV�x�<��z�T+�Do�����	��fQ`�L*�k�\mB�s(��`���vgh�bL��� ��<�%�W|/d~�o��e,�^2AoR!�1��Q�m�z�� +�0sgt%�P5u%�������`�e�P�������.�%��&�c�DX\���K�Q�@W���`��=�&^u� 
9�(A+AJ���՗�����_}��G�+4O}��T�fuAi��g�����>�8U�s�#���Q��w�����'�FM(���	U�l���ct�jK�⟠i��Ȋ�ܤ�{�N#�:����53�"/��N�JE��THv�}�:B�CД�T��]�*�c�,�.�l`1=�!����\g--���&�!Mg�d�X�euJ��U:����H͔ɞP��1T��3��ӧ{h��f ���������A� ����G�ǃ�(��9�1o�C�#��0�D]��>`�]�VIw���_�\�*~�&��c��>�w?���B�ZK>\�R�q�a��P\�R�}F��o�_�7DC�]�� �a�����'hX���d�p҇1�K���(<#u����1�VD��nⲇ�􏀃8E��N�r�1>��s�.*�[�V�:���M|
��>}	��B�:"$�U�×7������vE��@D^�e�j�_}rR��Q�8�s"݆vV)�_:i)���!���!l��x-VrP�^����½z��u��d�R�6��SZD���э� �8>�*n1p�Gpx}�}�� �<�
�P�R�`�9v��_����߷'0#��T(Z,=YL[MH_9�k?^�E�{Vw�a��v�����`���Pɡ>��J���K!4T��/��Y	�Y�z���)���rvC����cUّ�K�J�B�� �+�H��%�4��f,������.m�q&Ǌ����_�N�iKՖN��q`y`u{@���"e�B�#&�]�㭜rvZ��R�/4��}W�XϞ��ڷ�Ǝ�k���њ�o1��n�!��������Kܱ������]�'��Y�x��@�zDm�DH�[a,���ӛ�E+��N����iQ��.(\���H��|��͇￼�{iЍQ��XȶкaN���3Ǚ���I���O��,�u\Y���S��{Pa����VVf�,��L�A�H(	� Rf��԰9�49�H3P��g}k{ĉK]m� %E�~�}��x��06d�@2|�1 ���"cq>I�����T�+��4�l1W�'��T"�1����eX&�.l�z�]�7�몏�����耗��n.� vZS]g�dJ�?�#��h�5�#�4�X��~���Wo_?꽙6Z�}+���T�c��$ ;Gz��������P sP��/�(�[H(HM���k�q�מ��-I��L�	��TǪ|j$�e�Q�JdL�q��� ��L�1%�hM%���B��ڡ�(���#�b�]Ψ������ǚ+S��/���d%� ��ϡ��x�I��m�M��3�P���8��_�}���K�Q�o"��y5���р�$�@�ҫ��[Q�b�s��V,:���Df���vr�`�iڰ]�����b�mig��%B�3�iC���t"�N���wܕjy�=;Kj�i���8�Lx���P�������7�&/&o�ћ�U�5���_��u����xxd?q��AV�~��+��~K���������j�3)-��r��黟~|��O?�_�۴/Hڱ��aEz�k7�ޏ�BF�ͨRj��B�<"�����2���y��ƜhuO��x=��͋�垓T��ҹ`2�{S�o>���ʇl���T�Ѱ�U��`�2��r���jм��'��������m�뽰��#Z [�uZ��(9���X�F�Q9�L�-�$�ī���<4�k_�����nb}�cjm�ĉ�1���;�a��7$x+��M���e�2����V�B�Ӱ&�ֻ���A?�"}�����0�>�+� ��lO��54���F%�k��H|��3L�yIW#? c����"�L�)�8X�����^c����2D�?�Npޥ��Z\\U��m����&��mZ`6��+�#���m��KQ���x�^ӯX��N�>Ap�n����)#2i�*:�N
r{�(�P�el�)�lQc6<�%����뱌\P<�������<��{KL�r�~�Ӿ�ӵiz���Ʉ?���m�Doc���!�y=�U���ڲ�s��ՍR���!���Q_,�#.eU@��m�P��~ɶ�Z�N�����w7���eƄ9E��`Ve[�0/����`K���(�zM `b��~-vȹhS�8$��r�vuD�Q� �$b� ��X"���� g�(X��Z��p��H��D�F�%����R�0y��4
�h��s;��9xC;�5b� .�$�ap<?��'_�5c����Z�C*7Cǽ@ w5���/љ)����HTܘq��pY"D�(��z�B/���k���|��H��pS��Z��u���\�r��BXK���HE����E{nW{]NM���5Oѽ�P���E:�q�����R[?�J����{c��2X(���V%�    q�h�t�W}#�<W�
�<�{�5܏D�lH���3������Ӳ)P/�~]��:-�ԥbD�v�oʡ{tE�t��E���Ć:rv���X�8Zo�~�|-�c7������~�j��	��Go�u���[V��]w]���|.��5��	Wz���4�KV^,I�AO2�s�'�)����h��UU��c���i�����&Sμ�z���n�=iXa%�,3�@Ӄ�i�NgQ�Ю���J�V� ��@�Ŋv?�����>Q�L�pz���#x��o�r���\Ij����}K�b1_���-����G�����H��'j��)}���2���ש�P����������Bޗt�>�ږK��*�zM��Y�-�L�L�J�丆�z�����d�%�Ŗ�d�S��M���w�-.�-T�I���6�˒T���s�S&Ɲ[ídcʨB<c2�\<j���U_u�����~V5	ٷX�_�~�z�X��]�	d	-=�v�� ���(-ԉ�����t�XhTQr�3:}e��#�^����(C6&�޵y1A��]���;���jc�m��#f� ;�5�4@wSHųx��������5�}��$zhv�K���l��<�JUw�B(��&|H9R���@ȱǇ�X����������iԇSU,.2�yy�}��oO���]��8R5�!8*݊�<v2�����y�Y�U!I��0�w��oӿF����B�q�q5�۸�Mk�hɝI�Q�ߎ��Q��Bw6[ZN0�,(�17�=�ꝟR�n�ߺ�J.^��^@�E]�.6�P��xa#��W�ZCO�±�iz9�����M<7U�>�E�ad���}
�����v����ׯ�Z�]���z/Ɣ�����reN5��<��|\(�g�<�%�WZ���@�2 *VĸH���.i�k,��`��w���C�7�1%Bx(���5ZM�;'ǬA�����؍0�TgL3�=}k� �v�n�V?"�o�&Q�t���	j����p��GG 	9/�1ӱQ׊ɤa�7���߿z���/?�yi�$����T�v�ݶb�8)U`*�7,4""]�Ի�5w,/�����s�D�+�(u��j͂&P�� #	=�1E�����P4U;�sB6����R	bo܄c�~�2*!h;ﱌ �cV���ʢ������Ԧp�Ht�U�P����I����/��V��0�J�k�wGS���$0!>Ao�0�X��x�dJZ7�����%r���뛭�A!o�Z;���.1/+�Z� �k#�^���,���'���`����".�� �nrTe�]�\��{\5P�:E�e���ףX^3�<�Y�VO���C׊��9����X�u/��@���U�Q*���k�
-=��1+�c��W���߮Ծ���*I����ݙP�Iv*�H7=���z_��ⵋ5��ls/��c͞;�N��I�`8�qL���07�4j�;l���"~�F��I/$U����P@~�RQ���˥=����V�~�cR��ːL�N��
Ĉ6G�B O5�Ȃ��0#�}c����	>��/ޯ����m����O?~��&j��i_��gO��� ��h2�ۖ�����-���z����4����W:���%z.���Z���xZ;[�-×���LLh��2�ٴ�A7�=�l*��0G��w��0s�z�5)Tb��䊻������CMnߪ� �&\�W����+uvN�";�����π�UJm���s%V��WOo����5{b������(�X{�M��F���>d��fe���F@h��9���l���r$�{B4�Q�]K?-d3�B�;<�,7 P��ܾ�|�jZc$|i���3E����9`���h��I��9�ү��n�4��\����YF�/m������J��O�]&�����9w�g��k}<[�"xy"�Ԫ
�Z̯��ݍ�".+��� ��[B�t\��	��M�rܜ���
���;:�$X9+I�Dl�0q�87L�ҖQ�!�$�ؾ�sQO��=}#ǟ��Ϡɋ��&)Nm�~q���:��gU9�4��<w_�ꣵm/�[>�2y�D�l�OM|�)^�Z��S�`�ܞu�b�Q�,�h����S�P�|K�7��Tlfe~�(jCQ�	=)��Š��yީ�Iz̅L�!�qO���|�݉ѩ�
Ԯ���{}��Dۻ����Ҁ�l`]7S��J`��:�$py��2�e���7 �3�9�S~����y`I�I#��#z���KAc�;e�$$ʞ��Թ!*��c�@+^^?�7�ma-��G1	`��;�w��g�2bk֢��Y�j(.n���u�lE�AR�yl?ɡ� �)�B��4�U���A�&��X��|V�ޞxJ��Cl��8r���.F� ����vq�t�Q�5�gww��8��bߣ��i?_��d�����B�X�H�q{��"+��I@�:6n���-Z�5���ڲ"y~&�<�y��_��~�ꏫ�Ӿ����B��ϭ������p�'禪/&:V����y���̩��8Ru�6gZl��@�O
Q�T��k �IvF�Y��L�c&�[�[r�h"t��2|e\�� IhU
|A�q2����H�3�Ej3L�������� �|*Ӹ�GLs<@���%tK'\o9�j�&�;5���	���=T��J�s���B𵺯�Z�T:W;@VN'k׆�QZ��:$���љR���p�	:'�N �q�l`γQ3M���S�dn^�y�"$�e����6�̛�������/��Ob2EK��~_��˲íȵ�1� �T�b�/wG��@�%xHR�R�l��x?���n�^���-�t����QbQ+�(���0V����Ww��1D�:�od(�M���1�� :�Ŕ�$0JI�G�����"��R�e[a����1���~ka�x�I��D�~��b�wqG�1��)���߂1s#^��!�.�.L���R9�v��� h�C��]��$U5���H��F����Y�f�A�J�5c�$��x�#�X��ݶ${���/��,Ib��n��}g����༕W��&�Mţa���c�u�s�=ikͤ��\¸@��R=q�lmva�t��
�9���y�j���U�C�Z�7��ք�â�N���� g!26`M<)�[�@�K�XBE%ţ�lC?,a�H���P����we	���������8�|�b�k�w�ۨ8`��T�4�3\'^f��;��y�����޿����aaߥ�&u2��g��sHH�4��G8�W� ��E���R)n�G�v�5h"�F�Ӷ�5��������}���ޙê�B�{�.My��F��u���lpD�z)x(-�q{F�a&b�W�!g�Ƹ��s�s��׶��Jם��u��r�j/BN��8�Օ!�^l�>���_k�~����[u���R����(R����'����
��3,7S�QLj
GR�oU\X��D� <��aZ&w#���!�@U�5-�Z�I� ���

d`�1�S�~!yjV����L��p<܀��E���i��h�Ci�:RA�L��%O>���ը�V��V�-y��~v�3� ;�x��P�M�x��u��&X�߾~s�v-8�=� �5�,B���Q:yh�L~���u�U?s;���0X�����xN��+�/A�)��.�(���v�e	z���ې+�x:�:V�J����/�e�Q�X���jLu�?i"G�ե�'t���!9v�yqG�{ޑ�Tjd}��٫|0z���/	�c��c��k�������eUa���~��wO�t=ݓ�v�]����G��~��SU�(�~[�>n#�I_$+�QM
	5C>��3x�7[u3���e�vc&:%�,('c�?��?jBr<x+�F�т�
S}K��J�#�I2R=�H�ѹ���LK6��oOK'*��	�_{�����@n��z��g;�&B�����a��Cy<ޚ�ʫz��;^����m@�������o�"G�|W�ΥO�l؁hP���t��
Q��� =}��G�ͥGF�	    M���u�R�x�ϵy#Br�֛�LBxAX:�����������18���P2�x�6ô~��u����^��C�9�R&��sج��w����F���@�{�F"�6=lU2�4Z�U���Di��$���W�,��X�G��] �qz���8�����a�c�'ݱ)���g���;�a�K��5���;��N�I%��b�f,����dN$���%�t�p7��
G��B�ˈ���h���0Q���P�)r�����X�m��y&+�N괩��"�5��e�^�=�?9�����Pre�kQ�*%�JoN���µ4�5_J��blq��;�H<z3i^*bf�tg��\�G�IlBZc�W.�=٦]�T�ū}[��ߔJ$zT�}�!��@P%��n#\�	U�-��AZ��=h<:����A����P:0S�d���,!�"�ASoA
�,��7C����bW鄆2���h��J6��o����A��Q*bp�Av[㦯��eF�|_f���E���		K�}�y��>�=�"���`&��Eoej;!�lI��q�a*���d?S�(]�+պ�J��ɝ;ޅ/����H܎*�A4�F�X�k`��G��"�]^����!.�tW��w�>d��eՀڑW%�`�"�c��P�[�妓�$��p�G-�.q��.FB����~�@�Y/�Mm���馄jV�b^�K��{��F�}���n��z`��s!?�k�+ѫ>��TŽUr�t���#�	֮8�(�&��]���g�� 5w*��SP�}��m춹�4��>TT���D���ú+^u��x�{+�-ޚ�x�|?��6�3��	;�4ߚF�q���V�:�SX���Č�^(_=�AzlD~��1��?����:7�m5i"�K��Wj��`2�:���2�"�ϰ���\�����������/!ۄ��7�&h:�����wq������PU���H����{9<3��7;V�7UŎEi����l�9�慱QŨ���A2j�\���I
����d@�i�@j���1>�ʈNv���|!�=�
��C: �ۭ�0�UEMvJ=J��c�5�T*�}����$��&J���8���T=ǒ�C�'��i�;ht�\f�
f�����ܣ^�}��%��P����5�'$Bu1�Ki!�u:�2O��'�S%�&W��A׽���hI�f�����as��x�8�x=��u��j�@d;�r����*d�A����q!
g�Z�F}({���ʋ��|�#�f�޿��x�F��Je�ԍ�R䐈�{|7�ʰ���n�p�7�ZUx�q�QM���0|:�s��g^c,鍧Y��ѫȎE��&���.���8pɝ@���z!�h�����.�<�څ�/�>晪awA�Ok�#����Fc�ŷ�K��׭�y��e�*�tUP���d	�W�왣���+X�J�r��{�N[���~�������v�+��]��"r#d��`��*Pu�wۨ8c����H510�5����[Uj982F=��e� �)��|+5Dgj���!�:t>�E���d��֙�[X��rzF�(�Pn���Շ9���ݝ_X5�㜮8=@¿���v�S����Y���
����	����6�\�����wZ>�<�yR'^�e�P+��9Xze���ɸ�����WuQm��̰`*������V��sWi9@��a���cm^�q�+�n��1�(�CFm�O���/N4����!jV
�j1�v���>�>����+S���
�%�Դ'�f����?��@��W��m��=B@��{��>�;Z�G�D)���߈���Q�l��b pmàM�ٲA�����X�� Ed�ǽ��4�NB_C�Yz����Ԙ(OdT~ë���Ykx���a�6��t�m�+)�i��ё!��a����㪙�dDtK�k��G8-��:���vގp\v�=�K|���s4��
���/��'-�k�+���v�/K̪:���1��Nͽ���<�}��]��j���)S�Rx�7�Y ����k#�F�u��(�W�J���@LTJ��;�z���U�^w���~1�*y� \�=TU��vV��{�G/l���!�U��SQ��:�>Sȥ��hFe���.<F��%�:�2G>q�t:��B�d&Z�ł��g�`:��2a����Έ<�ǈ��4\�tv�Tȍ`��Ni+�JN�u~�ӏ�q�"q��]1k�}`E`I�O��Ez��N��EA�Eŝ�?� �2��+��Rޢ{Ӿ�+����n�u��+���ˏw�p�$E;"ᡤ�\_.���>� ȥ5�) ԵMrL�=0���PP[�sYTlU\�}q!MU[��$'e8�|��nZ�L�ܭ���S,U������}	���A)�����O�n3�!�����{���]�4!N��kTyoպ.͗0-u��,�{�	/}}sGe�"?�ڱ����G/��H�?�c��(����g�Ÿp��u�l�6U�A�c�ň�Q��������7�r��ln5��y?��aVcҀ�|��Z弘.ĸh	<�x��iM�b��@4�Q�[r�R�L��Y.��1�~���k2��U�ָ������$�����j�x��-����w��%ԩ�l�Еd͒�M�Se�ECW}i�j��vA]��hT9�u!m��CTtX�!/`�\��8�n��kyt�x����ػ/tְW[K2��h/�>z=_����.�7��!�]\�D'��L��N�"Wc^b��:U@�X���=����l���8}c�l�B�*���M}���j�3���~�]��kG{ݠ4�	慟fGupf�|L��F�����S���ѯP1
�[��P��"��;ڄje�\_e��73Ҳ��/����@-c�d���9Y�Έ)	A����Xr��;1y����3�}�mjWAռ���CeʳM�_/
�E����o��Ƿ߬�H!���	�v�V��pT	��[��w�$���X5�K-\��AC=���}�^U^����7w�b��`.C��f"�'�d!"p��X��[�9���؜Y���6���y��&�U��2}��7A���`���.�z�q���&�4R_'��n����x�g�����Ϡd��B�[�cϷ��y��qi�=�t2-ju%��7�U���͛�~��oos(��#)��+�yj #8e�1mۋ�Jr�$�
3z��4Y�&ǎƧ%ۇ��|i��O2�e;���`��������p^瞧v���-�s����bw�Ҵ.���#P���{ggX�W���<�|
��%��bZ���Q窴�4�+˫:�Զ��X�ٍX�_~���n4����W�:���>��&$p����4��O#E.�EIBg���^k�u�k�*eK�XXh���R��>�jdz��Q�e$��"A�._u���B�d'|U%|�gFs
��s�	�(4�
��q�A�z����Y�q������E،n�=�Ե���h���z[���o \��<c�~��O�nM!f��I`��II-|���U�p����`1!m ~��(Aۥ���_�Ј\e��!��]d�ĥ=�N��2����po�fy���R0��j_%q,�W��ǔ�� SWS�S-F=������AL����8�~�����X�[��pO(m���q�f��i��(����Y˦�x����O_޼�eΔi�&��}نJu ~�[��]Z��|5 ���xAS^0�j���:���c��;�5j�W�N�@q���i���<�[tF�M6q�����+���:`>b�jf��',Pr��C�|g�L𼇑���dT*��A���������4�l�2��t~OL�4��Q�z�����zj:�����sΙ������ք�⺵]��� |Dա5��
T4�b3޴��6�i�Uh!�&ȍ��@!eBQ|�P&�WẐ�-��o�'�8���O�X���m#ë0Pp����~�U*N�*��p�=/R�W��Y7��
�e�~��w���cԊT�W��Xk�q̪;���5����B�{��Ɂ� ~�P    O1P��J�N��1`�Y/H��3��zo|�s���̠W�ħ�K��D�t�2]��TA��a��_�k_2.BV�$�������%���?��9@=G�Zm���U��y��K�e��m�L/����ϟ���ݭ�Px���l'����o�b������{3��ǺQ�࿞Fd�%�/��eM�p'aA�f*G��'�wCUj)�Uj4��Q&Jm�+:��"@%LU�����h��� ;z�!>�1z�I�Q��b;[䕃TWY :�ꢓ�������I�&*V���6�.6%�V��	�o��?����@�S~\����J��~��tv����Ъ��Q���G�����أݿ!ґю����F�-h��>I��u-��eT� �a��E��1�(�Xq�u7K]��Bs}_>��;w��N�L>m�Ց�W��ujP�/�5
�4D������rW�� �����Y�]t,�nl$��N+ܨ����X��~�rc�r4â�t�r%����ޛF��]6�?�N!s(1�WM������z�f�r�`���)�#Geq�.(�^�VG.�5�V�RD������2��u��!�9�����r�F�S8�-����ᩲ;B���Y�5T����,N����C0��]�\���戕[��8D|�5\6�B�Fi�.o�1���<���_E��J4�����=�?O�a�6KǕ����.~c�仪��Y}}���@��*\@�bN���߹�G��iL�貄�jEC��-��M���H��0���d��-e�[I@?E�RV��0!�W[�D�g���:�B��ǈ��jUPz!M,׆G�z<e[�0��g�k>�j��_�)��k���0�Z�R+�ϣr������Q_ ���>�*đ����F-�~T"jv1k�2݌�i�!��84����]��W���1	���)t�� ITK»4i��G	�ES{��P@A�&$�%���XU&��~�$���C�=���GV����Z�X�����S�s��Ó(��Z����um�A��i�n��]��H7-��(� �!n���;���5gjJA�$ $�ݽ�}˴]ɾ�M���~mB�+��mj�{�Xᡦ�ϒ�f#��H{� ��I�4c��h�h���e�A�� 4$���]N,:���2�!l9<�9e�"~�|~ � �U ������J~�����6�W2���=:DN��z�L�0,(PAE;���%6V�����x��캥H�ݙ��&{q�dHs�R�R���w����j�0U��(�k�+�M1�����{�F�Zś����dw��2(���'��:T����b@���'b'��+�w����b&��~��ť�;��믞��<�Ź��G��.P���������q�H��!�� 6�����T�iFdKTX;oW���f�)u)@�����	�dzʻJ�,�}i����D��T���
Zq��̈́����}����8�x�o�|��IВu�V.�x��H�������{S��_��:HU�~y��������@͆�I�C�烸�&�����͗	} [�G�'\����6��P[�3 9�MC�;�����z	κ.M:���c|���CC�&'���4��6��q��T#�΃Œ�V��<6���Pf���?z]�!.N�Y"+"8QN� �g��y����=�&v
/��c����8l�$@s� ��n<�	��A� UU�rR��j��fB8��me�*�{�&�뮿Fޢ�#2
�^�e�S`��&;Z�u>,Z^e��c��=���60'�5²����O(vϘH�%���i�M�@ ��q��Ō(*@�}M��=l(�([�mk�2�k��sT?�����?��OO��� �u��"K�q���O.��OZ�,:d����q�`~�R/O�mL�8K1uޥ�ͰV��9�l������$3��⤒��6(��a��/�pam�^/����5��wP"�%g�F*"��� 	�Q�$�/D
�������ͱS��{�^�m�,`�����:�:��k.��ʜ.z�߬Ʀ��t��YDe���LJN�	�3��,,E��G�{������	���F�8.$d�v-��I>���̛<k?7F�����&f�pΪ�B�GK�����JV�?d�������
�`�w�L㾔Eb��
s��[.W7��~u*�g���B�!�f�ӈ2�Q��߹��r"]�|����+ޣ��/������wO_h@)���v4�E����Tc4H�2fX���ڑ�qt'����X�v�YA\O^���N��H����O��Β��V���H�Q�T���~���I:f�fb�n���?+@طq���:x7��<5�P(g0��AّV�r�K"<Ge��/���lNS�/�{����Utd�e����΅�rׅ`f<�3;�D���@�3&k�n3k-�}yb4�Jv{M��D	R3䬛����b�y�R��t�^HbYd2I$��� �>ZNh�.$�O?>���u�����/�Fn�k��݆ɚ�drCw#9Fi: 4��f0�dɟ�Z��{'�e��f�lc~O��nF�����K�S�pjð�TpsR�4�'1�qGT�M:M�A�~�\徠]lq��g-Ȧ	�0s�|g�q����X�&-��ɚRC#�:�$���* 	"9���D�`�\��}���ͨ����r~�v�&���d	�C,��b����'��V
���N��`�W�ʬf����?���ջsK޻}Rvm�����Zb�6�0�8pѷА��{�8���c����S	��̱/�Y�gC��X4�A�U�Bc3p�!���M0N{��U�d;�S��B�#��&�%���C$���a-ʖ�H:��"�Y�͋R����e�<����{�����(��볩�.HD�ǍD	�zy�X>�k�m��gY�H`�'�b��ĸ6̕��w�������_�r˘�y�n1����9Q)�a�z#79C�������<�ƖP�p�yU�����ik �4�R�޾�uL�H|�#���b<O����E�p''�"fyR2l�'/�8��Ar�h �}>H�/� 9V�o�R���7Oo>�廻�
���w(�o��"h�Y��G�<�ey5�-��'C������X'ytM��+
5K:�#�c��6޹���s�a;�pqp@;�!�t���T�gv���#پ�����4��H3� ͐Ǫ���1%�y�!7��	Q	�]�>	&{T�<�����К�hW�3C��Z���O�ủ���@*���-�oς�.�ɶ*X\S�]x���.n<��L��H>%�>G�áe�u=�qՃ93���7�ᾊV�$�%V����4����\v�PT$B\,k58��$�D+�sb�{<��W��ߜ�%�k���
\췷�V��ƈW,;ub�7)Ȗ�-Rm�F�ш>���uģfR�X�)���>c�w�6#��I��i�/���Z�eY����)�u'ZJw���95q` ����"׋�c,��9d��ƣ�E/�?�L�2�Du�&���m�(E��K��b�ů��O�:�7`ظ�W�f9�\߂�*,1D��_pcZ2� U|�0��'X_��������L�i���(�٭��8�APR9�ᒧ%`x	qWۤ�n������'�
n�l�͘���.^K/,ʒH��7��/�`��rB�3	�yc����SI�뗠hMv(^����ß_�Q��j��<Մ���vz�k=,�e4�ܛoS�3�Ͻ��⇒ F!-��?�"�]�Ä�G4�j�<�Uj�:��To��\C��զz��%9^�]��$���������n�k�E1�tw�I�ɕ'�.��ˠ���#C��2��8O)~c���j�0i�8��BI$ ]/�%g��9�_?}u'bkK�j"��$X��Ar"���:�a������j���ĒU����٬H�#O���e�͏d��@ֻ����j|'�82�Lj������V�y*!�ܥ�)d'���d?A\ؔA��ۚA<gKEe@��U	�)���2�弽��v���<�    D�r�V7�O&��E$���| �8m���ӯ����ǯ�(U�՛��DUt��r�Q�M�����^�	Y����.��Zjo�ۇ)B���9��\ˌ���P�I�*����/+�dF�X�ع������Xg��� ��Tk^|6��:iϫ0���f~�r� `2�_B
#h�n�(-�}Dl�;��[{���߮�~z���7K|�Q޺C	�w�M����<a�'#-�V�DjJ��έ����X��{��@�T�=����-�/G��{�e���/%=~�ˣ���e��7㼑O��T�����v2U���c��b�O��`�����y�l�#���1k �k�˯�����;,��y�<
Qh!��.�f��D�r�t�t��!�vޱi/�4i��Ǝ���L��1�U\��N��]t;�' @�b��К��f��'_4��ޫ/���X����K��s�$�xs+^ا���"\�98�j)(�[�/����Ɇ8��aԉ�-7��! ����1L��.�6ᠾ��F�=���~�DrJ�5���R̠`&��ܸe��z���;�fAs0V��Ʉi��G݆��� �o�0@LT�eQ����ԮD��@B��9�䦆�����&�Kx;�&,�,A�˚�qڛ�����d��cȦ�E�E� %w�;����v�
F8�N�����C�L6}_+����
?��UM����5���lX����M���!�z:Jʴj$Q�*�s(��j��T��h^�18�\h��)�m̅�Z��9�c�,]��IN��<G������Y�^�_,W���R�ӠKg���H���ă�gK����H� e@w�-Tg8[b#�� �\�U�	=[Ɗ�W��:�3)��X�_���?�����r>�oB|o�]�P�\M�͆O�L �NP�\cw�1x�C��������:���t�����V2���6���B( �ֆK�
�
	V������=,Q?o��I��p��z)��ׄ[;�v���>�y�p�p��Px��?�P��Lo���gg������?v��f&uZW���~�7P���c�ϵ�_����H�A��T�z�9}v��'5ҙ����!��V���)*�}N*��ZF�-���$��'���&̨evda]TD�n�h�m�]+\Z�D�����N�ڠ�2q=C��7�@x-c��À��3/���71��>}_&n�\/sgבQH#yO�O�N�lR����6m���|Ŵ����<�.�f�]����Ս��c�7=�炡99=bq*������DV���a�]��#��-�%�sCЄmΊ�t�x��oF:��1����B2����p�y~�G2X8n��q���VO��P�XU�G�V&x�(ws��d0dl�6ժy�b�>��/�����o��p"iy��$V��SLl�h�(0J�bj��܊֠��'�"��وP�R&[���87��s�N�q�T�[��*���@�l	�6���D {�=�e*A�fqtρǼ���*M-z�>	Ua�/��O�r�+��2},H��.�������A��J�-�E'�h�
*��>_gߍ&(����^e�Hډ��ÔWC<�MR�����-�2ᐄM8X�$A�d��k8SX�'�\	�.�@,�@ �P)+���P���fL65%oC���&o��'�*3�tw�y�w���_�{���eN������VCI+��2vN���m�bk-~�����}��J�D�J���{,9�p@�rN.�7�-���N��ĩ.ԏ�}V��dA��&�󌋇���K52^qTL+��^Nl�M�~��O�� ݎ�3
��Y;��1���atz8��
�G�ߟ�
ϭ�gY��I�@P�i���K/κ�C���Z~��O?<�;�2�L�[%�~CX��æ�p��-غ��ko�،ʮj)����ߏ&��/.� �9�ޟ[f]<kB�݋K�P'5v�������T���:m^�d����`L��%=���m(+���67��=�~��.Ju�l��\�a2 ��������=����Z�������Q��
���-�ⶩ�=�ݖq�� �!��!���73��˱y���i�"���(R�I�-�]�Q,��o��3�t�;����B�jg)�jň��c�A�;H.�k
|�����'_�I�����kn���E"�E	������8/ͩ�B�:M��L�m���޿��{�"[ޅ�z�����d�DBWQ�!���{�KW�S\��~s�(o�\�Aڻr�n�f�7�t����iW��N&<_u�4�7��5���S���\��V��&^�P�v�sc�݌M�?o+i�����M:�o�k��F1r�uȏ����I�XТ;���_A��)m:&�c���h����Z����Y'��w���ވ��Z�߯�|z��W߭�.d�	��gRO���ܷ��nE������x�E�ά2���i�a�v��]�[���iRy���L���!	��ˠ���&��gp��!�ww�"�q� �r$hg�ޝ�R���X�dC&A�I�D'�4}���s@����缞�v�,��}���x/W��A޴���5Uc�\I�ڥ��`�ᐍ���9D�wF댡]�������П�'�U^)��fP�Ĥ��}#k�M�@�3��[L�p2�\�B�(����h��PR5�G렡�����P(XoZ��������C��o.�e5Ê�gY�_�Q\6�;e�F��	)d�9P\o
�-]ejK�3�v���3s�gRN��+�����3��"S_��j�l ��S���q�8l�4�c^�����4�o�9�gu�IwҴ=<iT��(H�L����D���ϛiLMը6��u��mk��ڀR�? J������[��
�B��%����D;�}2/ �O�D�8�����M��9�OIv+��P�I�*wj��UL�m���qbH2���ʳ�0\�_��m��������~\X2x1�)����l��ǃ!_����\�¯D����؅*����Qvh_l��9[��!�L{��b�<���&@���Y���R���h��cuhccW��`�|ݒ��	��B�} ��_(^
�|?F��,���<~�//N��۫
��M��Wl(L{�	���*�7���E,xX;eK��H��؝ks���c!���.�Sn1��,�[vk0����S���&��C˒� ��Z�^��FFMJ���&|��>:|��5D�$� �:�H��ˇ�����4��<�4���*���-��rcjD�{����T��g�
�'���p<���P���G�UΫ�}�'�fB�mO�|g΂���tYPܝ�U��]�k^߭��Lg:�bU�?�iW�#�$?�1��7?�����E��XRU���aQ/N�1����hK� �
3c��X��N=~�99�i?�D��3��j���鳭
on�5��}'FVrjd���>���9t��Q�����9�	�V���L����c�4�+\`v���I6���$+{3��àib��?�g��3%��~�Z܊V����<}��%T�{#�c��POp'&��jԎ1j��l��<�!6G�݊ls�y�UJ�a�l�.�팝��pM0�r�XV�-�SHa��`zw��қ�ֵ�05 Y6y#�#��e-z=o������	So�z*><!�o/?QZM��� '>�
���R��!���mtA�S�dk��x� ��ʄ��}O*������)3#�e8����l�����_���0k6XR0�iV�ld���&����3=�s	)�4Ʉ=�+���!��N����MFMԾ,u�x�ۑi軻6�40�wW��h!;Ú�vc �e]B���M�Ǆ�:٣CH��R���Y�v����<���ͬ�j�;���ri�)o�>/d�(�N��VU���$��z���D���qO�X/emV��D�l.n��XD� �*Լ���L��h�d�м@�X��+c
��Ӱ��M��`������uG�P�D��dn��j�~�����\M�k�    D�ׅ�gw����{M���k<� /\$�/�[isa����}���U�x�]9�,;Ȟғ��]\��+,&�}Ņ.(0��پ6)vgr�,9�'��(��-Z֔=���{���R��mf	����	ŝ3�c�/�lDb`���E��h�'L�1��T��"�c������<ۢeO%䃷W����`p䐼��h7v��V�}��w��nyA�M�d#�.�hJS�.Y�/�a���7�	�a���AQ�@����i��$-�7g��M�d�:��b�'����($f�ےNW��� k A�WsU�=(;6U/`�f	����9�o�?����z�#M��7�v�E�S�A�c��o^����o�,o����B9��{Tjb��[hu�S��:$((�.bĎ-�h3$�H;�J�nV%,y\�����gs�"p��T��|sەB�Ĵ�4#d�WGf^��-�����<�"���S���_l�Q%�d`	��N�"�CGäͅT��Q�Pq���2\����zF�""�'��� �_�ހ�.2��]�����o�ػ�K2â��r�$����d� �	�\�����~��xb汭��ݮ��R�k�QdĦ6�d���}{��q�(�rb<�jL,mb�[M3��#Zu��z�;�aO���7G���<�� l�S�ǥ��f^�����.�|��\H�V{Ղ�������w�E}��ݔ\�@G���.�{y^l�| "v�a�$�z�j��]�;_��7�XW<�n�FgÛv��I�su�!�c��)h�E3@��=ϔl3)&L�ڿ��"-��F�Ve1��M��R�?d&�!
�uF������9�_IP�Ƿە`|zY���?���gG"�z!V#�5�(w�����O�&���W0�E�NI�_�jۡ�&Q%ib#�H�G%���٪bP0mn�k���c>l ���Mu��B���5�qx�贋/t/�K`*�{� C=�@�s�v��c
"S�>tF��� XE�i74�^͗����쉨 NbW��Q=�,m�䷨��r�Mt����V�է;j&�x�[�FkY��p�G���rP��[~�h�P�����9�|�˻]�h�nib�'�#䕊�ߦ>]Ǻ����J�^��?����-�!A��cӔ�aXI&��5·���L��L�T�HE"9�ڴ�tM*�G]rpi�,�89$�'6��c���>�G�������Z�+@!߰7E�	,�vk�+��p�P�:��������A�FJB��~+j�����f��;�ĮM���[Z�a��dp��A�fQw3lY��	_���������DS���YDd��}�P���.a:GU���V&x�E��5#⇀F��?�j�2Y���Ѷ�[n>�&=8���1�4z&�Em�/��Iۃv&��$�Í)β��3o'p�R���� �mߐ��K ��>�q��3����+$ьx�mU�5=�'��Aޠ��&�M��:{��&���~�6��od'�o�+dJd=P=e�A	?��Mԉ%/�[����7)�S��X��G�y�E����X?M�j�vv,ҧe	�
�uڴ`�A_$����	~��{a��=]!��'��y���]7���j�L���x_�VB��2`�n��߰����ٞ�@��?���Wo�9:¨;e�Ւw�R�e|zp^�jfl�0X�D�e8��a�*66}cD; I��
3�qB㮌�W�>��)�����X�9i~8�m�N8�2�p�?�]u;w�-��!��Ik�=�_&	�iqx %H,��֟-�M�үa�šL�ݷ���>���&�����&��@w^��)Sw�b���՟������IƱ���]��F�g�qTzp䩦|�MC˰ح���Aӎ�b�U�"֦�-��I�_n����<ݽz���}p����J^'������S`�D��t����NV�.K?ݬ������^��
�B'z�*���y{��=C�R�hT?i�7����QX8JS͂�٪ǥ��7OIa�x^j���Q޼��2x����믿zs
�̰��������68_rK���j�^�r6����:x3CD�� u[i&F��Ƃ�rv�e�EF�A4䝺3���4/'Î�L#�颬ˤ�,����<�U�|����z�m��F�5p�'.�n���f�J\c�IW|�
B�p�\:��Hūs.d�A	�R��OO����KfG�7�$��x��J�p���h���J䓀md��U���KDn��'����n���
�p([5"�E����b9Qڗ��7����!"� �M\e����j$���L	y�g�}��c3q�<�~����a��0Ly)�>ek����SqL��W��#n�e:L�!�b+I%	���-����{,�^���ͷ�"�]�&2�$�f���m�Ėh�q������a9�/���x�����gM��щ[��m���Fҗ)��7B����葍�PnGF ���W�R�}�%��>l���@�|���∙2`�LQ�%�%�s؉�V0�jh�::N���at�"�	��O���@�T^�#���#e�V��!��%:�7���6�M�?�q�hƦ�:Ȋ!@fKh$���W�伾��m���(ę,����l�R�D���=�I���؛�&O5ud��!�ʞ�A1�;g?6��r��i�.��lΓ�����HCy��xv�	t�X�����:�梆B�F݊#�ǥ���>�<�+�L9U�������;�:@��i��	���,ˌ����Iq��n���R=A�=�
 Y�~j��abp]Մ��h%��������f#��v���r8��]`܅�# ���ЛSƨVZ�M�y���-��Fnu�Q&�S"Ǐ�26r�$��;Q�MG
��c�ڠ��0�I��5����
o)*���C���^Ԡ[�T�J�ꌣ��Z��eڐjs������ ��l��}֒�t~����k��m&:d4�"K��ʨ��x#&��ĔRӤ#�7Gx��ї�2���hښ�^,Vr�X7DP9x��`#"�w� �=WT'q��X�J���eH�0�Yq�t=t�}៯�� x�^���^�u�<���L0 1�6�[��E��M�C_}��(���j���b����og�xl9RC��jsG6���f����&�����$�����&��tu�2��I�"�2��u!��G�\���u!vkg,<o�J�� A���񀗴(٣4!a�v� �'�*bKV�i0(@��TP�"���	�8ժĶ���@�G֐1��s�H1!l��W�(��Q���M���Ut��Z-��9�J��6F�#z��_je�ȗB�������+~�B!34#R��t����;V#�~�[�A���O��l�Evh���#GU����F�k1/t'ӌؼ.�:r�1�vKO��(2��4�K���"�A���}�T$S�|�{��	Te���%�M@'d�"�CV-�@y��&F��6E�j9�����������U�Ro���WO￸�Q��.E+E4�����:����eL�nq��16ϱ�}�ґ��G�IT�9*ޞ拰�A���L�O7���1YN1�"td�ő(]<
�������TlWAq�C-�ɺ`�l:����V���,�}�#�"��5��
�R �i�K�'�U�q�T��ԋ{p����/V��^�������Ď��q��WP�| ���#$��H�~�r�RAK�J��3�͂N6M�i��Q��h�6,:�V���LjQ�e�{�W�J���@s.�|'������]G!�0+����O�p6��"�Y\<��'�#3�%����c�F������5���s��_SD��ڕ`P06h�SX�Dke�GuIx��=��%���h&p`J�i5r;>��g�o���,K�Ȟ�$Li�)  y�3�9���͎ȅ�)zX�-�E�<.����"�Xg�����Ĩ"��,�vW7�*X �f@0���0�o�C�	��'H�<|�������    Z��;/�6���O\9.�샐9����^S���;�:D�:�9nB��>E��_=���相^ş�M�9�,�JZ2L���Q��O;p�{<"��2���T]^��i���#����G�բب[o�1$��@�/2Ġ���_C���db�5�u��zn>�T����M�I���Ҝ�
&�����Di�U�JH7��V=V�w:���Ai֨b:��继EiK��2ob�Z��1vBE�i����w~c�p눋��	�8(a�2<���@_��p�G�G���Q;i���!�?Q�i?=d(�[ĉ����i�t����n��ˋ'۬��#�kT�B��E_.������1�%����/¤`	cF/��o����r����M� EH�T�02����ת�����X�0i�	��`PLx�S0��T0T%&��
�p̈́2A���Zv<�]��֬�sjm��$���&}n��!dRhq�{Y���\�n�F�Y��Ez#j��� ϖ,�M!�D��94�t(��kz��&�����a�j	��"�ʂ��_}��X�ع̒�����NB�c��
��^f�E�$%�Ӭ����P0p8�Z2��"��(W &��o@o0d�01��x���<�.�%7�^���f����\l�Ge���)G����32�s����:�$��/6���;
�["h��L���ݮ�^����F;�ǳ�?m�z}L��w��e��׿{z�vU�0TrS0�`�o��fg���(h>����[����%g,��A�y�r!
3�C�� S���e�S37�
�wj�AAC��LS[�U��W�V S�	�]�S�˃B���2>�b����H�kp������$*>����sZ4@L�����I�B����	G�U7hhQ��vR�{@�u�·c�?�] ����o�r[��v:�"}>�r��ņ#�����P��i���)���H-{pp�j"�t�Bnx8�`L�)�D��z�2����Ul�GԷ�}$D�P����]gDV�E��3��l�Z��:b��^�F�oj�;(����ɜ���\ ��D�(��U�����s4-+9E0<�Ѧ��ڦ�N�x6���W���-쯔Jl����m"�ڒ]Нϴ�A?Pր��I�m���-U��*߬���L�����?�ʚ��>Yv����#�W��u|�xc�VT�3R2D��d"��F6�y	�͓~W��$��{e##��J+����
� Η�vǎxC掹�����-Ճ�ʺ���%�3���Z�P��aۂ!bò��v󉐸�"�Y�h�+�B�7֡�ǫйiv5��6�ViaTN�w�l[��Bvm�a���4#30a��� Z���/�ű��*�U���C�G��l�V�l��8��?n���{^�xԔ&$���������U�nɿ	�U�:�*��5=O�����~qj����-�'����.��߮�{�U������̳�P�n�C�q�N�oa~� �!�pf��3�х�e�Wº�<^��Ǜ��Z����r�zYȲ�h��5~���k�A�z��ן?�J�S¦Ȧ��o����@Y��u���m�2���?!^h6m@Gr'O�P�e7f���=VX�bJ�rxc�NKm��&Z�:�����:-��_�3�R�Ro�NUE\w�Fi�MT��N;�9��	��-�>yq��I��S@?�ח|z���p��W�{� ��a��[d�'U��U����s�̄!��`"`�
��6l�����o����)�(܇�N̎� ��(X�k�>�Rwo�t]*���}+1�J���3�t��[p"U7���&g�4���:�B�|�=�\P&1�jPÆo�gk�DA1�"E��.c���z�Ӡi�jI���ʯ�Nżm�a=�n���v�
�n��� m(��p*%��z,�	�x�����$W/~gɎх)�xR�U��/�h���O�O������hFY8�<����@��O�.�:7��$̌PCt��bR&د�_�y�TC���ď5S��Ư�
~{2��4�J����xNR��~����r,��|�*f�9��
:�v�����e;Uol8Ik�Y�Ah�@�h��(<�/��R5ieU�.��:�.�����s]���u�"�'ޮ.�{���B	��^�[������o��}�ӏw$^�	`��㹚d�5hM��Rv�D�΍��<f�9���wZƂb(V�dM�\�7�2I{�;�˨;��B�`�)���lD\"
��
U5#����Y��}�P߂:��,gv�[�u^w��z���	^�$3�>i'��\ސ:��r͂���%6���Nu`m�c�Ղ*�!����ֻ?<�퇠��|�C�y�;��]��QBϖ�{��3��jH(g�n�ڍ�e�P��$�Gٰ��k������Sf?������1�v�3���LM��H*�u�A�2���`�2�:�)�.�T�Za0����[�l��r�3�p�x��e6�Mvz��U:0���ܹ՚AO�u�4Y����i������on'Jn�"�+���?���}�y���B��AzPp�Y��7(9o8"N��+���FTu)�P�
��7� ��K�Z�:����6�ҶD̊f��Ɂk64�k,�k�Ե�y�ҭ&�ψW(VJ}4xq��0�4I�ܭj2���,�@Hz��</��͍�^o�����t� ;~���o���X�ێG,U1����5d��*u����'���ƴ����jǽ�%�9$6���F���p�F������R��q�������ު��cy�+�Q<.�;�f� ��m%h�ґ	譔̶����5��S�-�Ƽ �O�˼��c����'INĹ� *⺺L���0^�)b��j��_��ܭT���h�?��+�����	Gl7 ���A)7�!rfM{�i���l��q ߗ���S�����&�����a�|{�ḄTr��6�=3��n�(���`��>,�&	,�E���E�f��e�*_&��u�w��@�E�#��g9_��R�e�.�]hU���D�٧�}Ln7�ނ��ȧ�6<���ɥ�U/��ߟ%�H_t����Ll>9 e�&G�Vͨ-M�ޏ�`!!�~qo�" �8S�'\E�be(%_����l!��(�8���������S�wW��d��i����Cu�b/AS�� [�b�&�{P����QZ��N���,#w�����NOm}v�7-5J,b�鎒��1��n���Nl?c���_��������5�������k��������"���{�F?�+���i|���R���OْC�Zt�R��(_�tM�{10.f���e��Ͷ�,�T��i��e�B}u�8MMP���Bƺ�o��؊��:��Xw�N�>�8��k�%��oF�:��k���t�oֵ3���*?��3���*=�rw�aO��{��GL`�`YOA��
�mf��{1��	&�(�jr����p����NBj��	�ľ����
 Ø޷�l�cΠ��I�Kn��vߞ_ƭ�ˑ@ٸ�X��3Q�S���bu[
�)�XBZ�I�,����WO�^-�
vl�{��h�?��Uv����\��%S9��	�b��������Vm�)�g0Y)a���މ�0��̻�7���W��Jݗ��� �72-�A!1�t�� ,H�|��vP�ϝY�gv�//и'��#���\,�8�]�%�p���+Фs�~�(�4�v��:Ͼ{�~�}��'o�77�F ��)4�]G,nY����*|uvB%Pbl��u�p��_]5J�+���m=�)��*�F3���_&A�9�?ys5lf��*�<�c=Ч��;${�� j�p�h�pC����05��{�<�U9H�
��D�N8����3���ˋ�����KƄ]�WS _�+ھLH�M�F��(x�ۆ�6��[]��Ų}�}-��YO��tn��\1.��?_��-&n[�[����rN�L����C��Ivjk\��K��c�"p[Bm���5    I��IQ��7O�b���'Aވm�����R��؟�+��0>L�D�"���J���w�)���'�.���s��t�e!\����Z1��܏�ʸ��܌� l�ְ��h��E��Ŷ�Ƃ3,w����v��<h���,@}E����\:*'1���3��O����M�0g�!2؞�q�����̕YQ��O�.�x��e�&��,2��)�F@a�����P8)(�bS
�h���:ɺ��j���B5�Ȣ�� ���ϲ<��HZ�<t�)��Oj&� �q:�2�l�a�s�f��%ww�k_��Uڽ&q~�Tw$^援D}�T�ݥ]�J\�� ������vH�A��O�^+>X�������jX�V�T�ě����H��N���E=Ę���,��LL���]��J�?e�QV(�u�y��q���J�Ӡ�ܠ��F<�*f σ~v��9�����yh����+���_>ļ6*x=�L%�K�����7Iw��zX�M�(���BJ'���$��m/A¤��7�Ǳp���|�W�y�s�xg�7���U\�s�l5U�;�|��4���C�͡%�W��nk�����;`��)]�֍�A�A��F�㎥�t �N���*��`2����#���e���B�	,�!��i�Q��"󫠌��x�,����z�{��˽��8���������~�g�l �i��Ś�$.iza];M�,����r�Yp�dcN@�8	�Ѕ�y;���L�S��	3y�oy��Ș���=%���V_����\�{v/��f+��KQ���j͗����	���6*ł'�຿b���ʢsU#�E��J�^�ym)Y��X�y�)"���9.i4�@
J'�`d_����4����.��A
��Aו�Z� ��s��{���z�@���3����6B7�,�uW=�<G�.����_7�~p���`M�;��/��׾���Km��l'��_�O���d*�.]�r]*R�A�D�J��n�vs�j�Ud��X���E��kJY�2o���N���ւ;�JE��ɬK�C�+����Yy�y�N�̲u0>���z��G�ϟ�����]5�,a��tw���	�y^��F�P���u�ק/����w�A3#imVDa��b�����9�:��U��.@5�D�[jg��������D��V�8����`��	%����v�T[BMvpn���g�X���U�lɩ�̀/۪��/��
QZ��H/� �.�xj5o�ڈGD��C�Z("�U'���J�,�b=*���W,��/���s��o8(ehn�Ӕ�z�3c��	pć��=�5m#�)�H��^��S�4�=��bv�s�A#�*��߉�C�;Ϭ�#H_�I�1���KH�-�Ap���m�<�DA����&�|l���XU�ځT!��[��^�d�y�,�"^�K)Z�;��O?~��ho�/� -�s}BF<=�<Cl��F�Z��'N���:�#s^�I΄n��F�O�55F>�@�J�Ds��b��"�f���I�p�ed�q_�5��uJW3غ=\�R���`\�Umu+��1 P�쟲Xk�s�'Ot�
���*�hj���a��MHpΫ��%/gU��;�����l �y��e��n{%� ^O5��Ą6����5���}�\�5��x*�KT�#��2|�9x	cEUM*��d��NW984*��v]Ԑ%���YS=s�1��aU"!��� ��}��GC)"�3g,������c�}�8��<I�O�FY�����׋'���8�,fg�&������Dv��^�Y�i���ٞ�H]*�k�����+s<F�b����7O�E�*$�yb\'�ط�;��%��w�n0���j��eD�j��&n�
<GQha�}�,��N+ՍW�=jj������;����;@=�Bh��ǐu���dk��%�?w?��-��l¼]���}j�����E�j.�%��y���)y��u�5�;cq^}�������j�s㽠�Ϻ���QY/rݜ�Q���@��kW�B��1��`�i	��/H���_P^�U�ld1Q�	e��-��v5�,5�E�oi6�=�����E�S3�N�k{*�����l?��\�$F�&)^&N�˵<�Qz����j
����І߼�������udy���}��M�:�L`�Eub�Q��D���	���E?%v�:6V��p#���qW�gk-CͿ$�S�:��(wDiM�̤#����Uހ���-"�Ж���*^��c.�a)B��`؁���?�zk�����iF�9Q�
�ҜBĳ���A7��öKjX���8y�Ze`��e���?�����n��D���N�]����M�
e��r�B�3� ��m~N��%r��Xz�땼���H�l�d�ѮI`��>c]倡����
U���~w�n�s2���}���%�ާ���r���xW��2W��'�C� wW���@�O^]����A%+砏����։#O��+�ΰYpK��8�Cɠ���v�R���q=�h��u�����㻻���PW,9m���3�g���o�o?&��՛nx�[���_�s�)�A��wԩS��E�l76hs���7g5�zEb'L�lщ��5�ag4�7��{<o��_H��cx��%_��~��({�e9�3Kw�|�4�_���Z2S��#�1���`@@Ȍ|�z��P��D#�@�׉�-��LPB�(
�Ό?����K|(!����l�)��g�ʂ��W��"	I�]:^��PB	-%�+��Y/)�(�	Ѵ��C���ӛ�?��z�.��X�*ivƦa҆���<�p�	s�@�8�P����*hʠ����)�D�"��Ց���u㠮vY]j�P�h2Ж@"�n|�\y�O����Ҷmw�"3׹�=�F{M��j��[0��7_�;�PX�e���>��˧��yb=�A*vڒ��LNu9v�aN��N��Qw1����G�9
�$lz��H�ٲ,Bߩ�d�?�z�♣���l\M*=��"�cţ�G��Hm��?!^q�6�<wfJ	놩Y�@��a�������t��@lqE��߼~z���_�T�4N,L
��+E��^ 5u�*�xG����-&�JW�V��Ubg�y��n��a�C�Nc�}g|�{f����> U�YlP�/h�j�Q�%�rEX����,�^)��sE�?g����C��Y(*`Z�	#����'�l�ҹsՄp�
��ׯ�?دj3��Of�t�\e� 5s8x]�:����n������?���& �������V�(^Ӯ%��L�-\�Z�Ur��~S��-īh�<�\��GG�P�jZ���S�&�E�I�nzkYd��������L��҄7n��H&"�Q�G�I�-���^p<�uu�ß4�)E�S�M&���5")/9���*���"KFj�ٖ����٬4ZD��i#�u�7���n\���L�[����>?(���|�CΏ����1l�Loa]�J��UY���/_n�\�qd�sh�:�)��tq�� �G�^�j�Y��l0��ͦ��2ؠ=:8��Iz�sՓ�l��\��%G/o&�@�vQ ��c���QЧ��]��YB(���^�,#�m���=���U����	���@����j� ��nx�R�!���UW�}�T|6�L���%a�X?8l�ґ���y���@�,\��^d֑4*n]���7����
�)sd�G?a*pt�ϒA1-��l�V����D�Y��L`��c)�՟u��v�f}3�bH�{{\��V#{0��.�G�`��=.5�81=�<��n��ӎ�_J`F�D�BLM%��������{zT`�ȇ]\K���9�?T,C P��KD3OI{��Iu�FQN�z$Ώ7HF�\r����nd>����[�z0`[��&��W����TlQ��A�j�QY3.6,����rZ�;%�zD��&�R��R��<L����>�{'�f��6bz �L��笼RwŪ::�!S�D�'.�u�Z��Y���ٕPn�K��)��uC!��[����7�$�KE(eS�?�    �W����M\�+�ȗf�T��^HB��36I�c���a�f���/~_�D������˳���~������"p~���xf����/�
3&�{�u��t��G�
.��
zw�������?<�y��N5U���w�z��GM�ŖI�ض�aH��&o� DͧhU��j���ʈ����"L,{��5`�
^��iA0�]�`�pN�Q�`+� fԄ	��]�9��03n�Y �J6T%sF[����c���1B��ҙKLZS��o^�~���G�
4�(PP������vQ~Q2?4��uu�s���-���Q�Ȝ�q������р�L������d
|�1��>�r�Lc��F%cb�+��jUj�(DQN�å6N���҈3�TG:���A7k��1K��[X������!�?h�HVB ���Jx��~�M5,� ���cm޾<�,�JͶ[	�}�������F�d�z�ǂ�a�4gU�6�9!��r��@�t�N^��\�V���w�������bs��Qm��M��f�q�%m3���X����&�@��b�)��L�s^�0�*��o�,������73�����vþ&MB����٥Ňωe���	����j�E3{�H�C�MQ�Ǒ��Ǿ�Q5�=�չ��ͣ���Ϟ�<�y�D5�T�j��g=��2��8Z�y<����]6�M'ܑ�����*F�#sSZoF��ڂ"�����Mw�#�F^����Q�8���-*&�&���fk�P,�A�7M�'!vwY���Hq(Ըy`��<~�Ϗ�aOm�kE� �T��>�J
����Yd"�)�б1����#=T{[Z�������řQ4�H�\�5o��vH�mp̪Żdѡ9$MO 3��jP�7�p�,8
�AY��gVݽ�bܲc���_S��:"ȚZE$��Z)�ÍJl*����	�^R�&f����{jEk\�����ur;��8[~"v�IP�w�����i�L�[B�����	���0�g�ѓ���u�~-W�.�M� X�ļp�O�1��AL�Oի`,o��>0BV������f�2�B�i�_� ��P9��d�uoK��v�$���~-"�n���/�����h}g��,��A)�d}2P�ڧ�T'+3ҟ�aGFU]��%���{_� .���?�;#TV�p$��Ȫ�9�5vV��@�eT�H���É�����T��c&�V�X-�g��n��)���y�F�f0+y�ht�f�X�Ɔvcq��.:e�s�r�����F� �[��������B>s��
Vfr!�����p�`IWb�b?��&�\Ԥ��v]��?����Ŗf���X�1�W
�m�(3ga���;�S�t�:��M����R�_}��{�t|��5�y�!�ꩾz�ۦ�nѝ%c���^Gh��`Sc�eז�eF��L�~����%>_��b2}2H?I#�ژ$�.�+�K���[c�F����|Mڎё8>JI���+��6��%Mw`F�C�x��8��b3�QM�ڌ�4hpis�1y�"덛`�ܺ�����fzUO�*���/'Nm^OT�o _�3�Gz��!�ԈS��v�X�aE�PJ�D��r$/wlƠi��M	��v��e������v(ėx�щ�g����j2A5>
;?������,�����ƓuT�L���ŋ�C����Ͼy���x;���Q멉!�<������	��Ǩ?#�?4L��0/����"��4�ў`��[W~��Q�ٞԲ�� �Ʌ��k�psS�^�PaTI'�nB�aƤi���l!���B�����?�� p�u�k��0���6��j|6�)�뜶l[JT*���J�r7���W,v���H�������u��_'x�_h��@���_�~��q^.�	==%���I��n�W:NPF�Y�GU}°�tq#��8l�9C$���$L�CYuS��F��z���ȸߙ��k�wc�p�bpd���։�<Hr�5�3���Uߌ�M�8��Ĕ�>D�l����\҉���^H0A���>*J(ȑ�I/N.e�7W4~���/wi�� ��(�9��!�{�zk���roЪcfZ�Ē���Z\E�̙ר�7���������p	�|��)�j��p�s7"�c�������x6�����줷�a�����RN�TN��\L;�B;j�T^$�aP��*��֔��wѢ5,a*]̘}��1+'\��ݛS�'J�$]�!�� P��$Mc�kѪ7���җIÎ�\5�jb���0av�n #�>��+���Xt��>	;6����R*�P�Kux�:�&6�^��w/�}T�dQ��[��]�N�?�4c
(�g�{bqnI�����հ��WB�I�������ݹd��/d��_�������û�4M-��
)�DU��"����B�p��/�P�sS_s	����Hy�R�WpS�E��ϕn�������1���h�TK�x0��V-H��}|���,�u�[%@���q�Tw3"a���zO�i�ix<m�,ZW��u������7���P#E��gqA.��`jHS��n��u:c���쯦l��=�*���$���{C4sVY��N�rBe��P/Vt���c_��-pCWK�Z�Cmc�5e����2d�`t��>�H�Ȼ�l�8ܲ��pI��ەz�Ŏ����Dy�/P�i���t=&R����c��N��[��nW�d�w�����-� ~XeR=�Z�JE&df2e�r��y�Hk
��גQ[dʵ=ɒ�zWٓB�`�)�y]��
�b+���l��U	6������Mcw�.���p��},R�a�kY�+�[����1��
�qU�s<rI�^�O����þ����W'�R�vc5�y�n��G�#�r\'�Ώ������K�7^ߜ�~��,��΋`�:>1*R?�,@t�X��=�۪9C�ɤ.f̚N ��-"�Q��v&�iz�Ƚ	t@��@ʆ	NFcÊQt���.�Z�kֹb����N���O�>:f�5��I����,u�Qe5q 3���M?�K;y������D\>���ǭR+�~B8��:tU�"q�n�Ց:USz��|���ܧ�K��bA܉j\��v[a״i��tR�I�o�d�"4-^b��B��/w%�Fb��x�D�5��"� P��R���'���Ω�2�p�?���K�jlD����nG����sE�������������I���!�z�&ܑ���-�i����tt�t��Rx��P�dPC:A1+�mxxJ�|�dK��Z̈́L��s�v�]��;�D0͙h�:alX*R��hٓ�{�O���M�~�[�w#>d ��<�v��k�~�iC��2[<���E ���clDKz]�;W0`����/_�|��߆	��8����z?�L�O���0ӈ�!�iA�(k�0�B�ziU��{Wc�߷�9L~չ3��}�K�e��WP�psj�A-ҷh
<�;�<C�/V܏�$��X�i4N�;$X)(��j�Do���
4�t��6k��?޿~�	��}���N{��`8k��S���G:IR��xU�X#�-�������A�΅�ݕ,��d�يɆ�Ϊԭ%�̨s�h��(.[�ƕy�q��c">O�d�h���>�ٟ�
��=IU��&�͈��J:�gX�J��K�a3�[qX~��o����	��I�|O&?8�ND�6=D
�K��;x@�@�+CYC*q��Y�'G��jDI"��Ȱsyar1qh��u�����Ss
J%��\�kfyB��`�-+`= "�Su�������JRX� qՕ�A��F��A\$b��2<,\�g.������:���tmE85�dr��*�֞ >	W%kz��a�V���wO_?m �Z�����I&�����`�#^��@�~���F�-(������Qק�U9A�$m�M�d�h��|�G`��`�9ɞT�oE3��l� f�iQQ�IZ��ey'�\q��E��>��6�h'h0��E}�X�B,Phќ����K�x!�hg�3<{��    o��E�?R=50U�R�&�k�i :곃�-yrP���N	T��VU|COm�+B�_�=�z3<E�)�d(_x��=���P�
%_D���%K��?�,䓜//a� �����"K�y�N �a��� ��zSD�;�rg�`P84��U���O߽y����A0��1�bv3s�k�5ujJZ�t�6{�_����g�hq�f�'�/�z)�j�^�G���a_�)��=;�*|oV�S7�u"x�2ڭ5���������l7�c��3��V��PW��y��#Zɽw#L7DP��
S�A0��~SQ_�K�
B�~����A��v�����W�#f%u��J��/�2��#/!p�+��39�fC����zU�RP�\:�<a�u^���B�&ʽzT�'Vm���:��E�a�w	����Iq���`Z^n~�}ɨ�����y��%4i�2Q����Nǻ������v�0ݗ,!�8Z�1�Bdb����/^m����2�9�:^In}JS���q�h+SQZ�̗%�'o༭ϛ�������ܰ��؇Pg�u���^��s��q�g,����V�+Jz�E̫z�NuQ�6�h#�γ�6PoyP�h�hE���p�{��U"�GN-/0'�3ٕ�RK� ����paK�jqi� x)�WPO������@J[�>�[^��4TZ=���Jl}b��lY�q]}����~��N=-,ò��X�=�J4iV�7�$羼�fFԌ�C��>Dc�k��Ep[��m�dh&4��q$��#_����ɧco���	5�,|��5�8{wc"-��ƿ��(���_�g����(��R0g�R��>���4#�����S��|ͧ���沩���t�W��]ce�|�\�����bSb�D�)�o�.tRH��Q9���ӑႄ\���qz"F5���}�o�e�q����YC�8�k���r͎�"�[�l��bv��q��0[�gLP4��;(G����{ L��������\���c_�B�4q@J�D�&�k�u�[�(�O����8 >�2(vgt7<t^xh�e��n�8����F`��:��h��<{J����U	�������`�����)��yAJ�+�'i�22`x�x��|��bҠL��n{�J��F�X�'|��z&J�^�:v�w7�7!5�kg;ZZm��䔌?v�"�4�l��OD8˓~='[�`[)�
�_�s�#���6��_?y�u�xC.P�G=/}��.���mF;��z��%T�X�jN@�ѽ '�#�i���ɟ
�Y��:�SS�9�V�����I
�ӆ:��'�33l�ԞN�;��/_�����
U���)|�q���8�
[Z��®H��Fn�9��ַ�a��{���Y�Ŏx�E��.�Z�����ΈͲ�N>Z\D�cm��� å�P�$Z��\�;4�F�tk�OK�Q�s�ь0���᱖��%��LY���.`?�
��|2��A$
9�?�Q�t�F�-��Fʓ&}e_Oy�&��;�����'�A!B��ݦ=�C�T������:ZKDe�H)w.�q��))�zw������M�u���Y-|I�戸���j=Y�66S�mX�3�g;��3��4��.��P2��������Ư��t*5ŕ���?����nc�3�M<m �$qJ����o��,����xv�"��ݏ���뗋�>��Yʙ���g�U)���������iA0��?�8Î|۽J�EM �DW|���V��e!Y�pB�v*c���[i����l򞎒��/ѧ��Ȍ�[b��G�~N��'L"�����M�	o|����!��j�$��m+����(%'����t}�A4#��?�)�*4>}C.��Cc��_�t�v�b��Il�i�\��!j0:���k/��HzBm)�V�θ���oO�H�j@�#��2q<�v�X�ʹdI�x���Ez��'�q�vE�y�Y��>��*%F����h8��0ƨ��Ψ�_����D5�������BF�� �.`���6�\Wp'`���3`o�^���w/^����j��!�1iT��r�/��?%vE&4l;�U��7X�r�'5����Y��R7���z�$�գ� jl�i5���SMV���S\2&��/�j�w�~��K7�/�f����\Z8������.^ a�e��-����-�>J']S��v�]����1V�Y� ͝+�4���ط/������z|#��+Ӯ�GΡ�r��+=�*�Y�Iߡ3�.�0�ˣ*Hb�#`AT�(�1�:��g/[���&� l��z;�Bf���;�s=e6oa�E��Z��߆��T����n��,�Y	q���^{Tk���d��h�W囕�_,G��2!��R�Y���Z*
S��y�UL"V?���W{H�g6�ݨ�g�(�9��@��%J�%�$��$��3��3&SK��-pը ��_�
�r��}�j0r�����۱�����)ꐕ�XX ��G�e��;��<��I.�Aj��`1#�M._��d�:$�5V���ggֈ��`���Ҵ{�h�_A�JF���.|��5T�
S���������Ӄ0����^fHk�:S��I6u@-�3�!����6o�4�2Qn,��;�@��G\e���3g	��`; sX��D��j��RW�<\�q���Åc4������$��+35�9z���N�\�ZB�r��`r�a��l'yĻF�܊{�W�L��%� Jk
����k�GՑs<r-amW�&Jԛ6�uy	�<����=}aj�r�X{*	6�_�$�˱k���w2��	�����w�yv�E�;�7�g�}X�?@i=ޛW�  ��a*7�9a�aZ¯�ʷ�lk�V�^���R�T��Z��=�P�����a��Ap.��\���mD�tM�N�门o[�g���i.F@���"�%!� �D��=��GQI2\�;��)�b���W�5,�h�gM�SEĽ�6l��F��HQc\��� +�F�Ӑ��{��ΜBq �������`����T����ʳ�j�y��m ���d�&��[t�&)���h6�\��5a�C{!�[S{}ޣ�oΔ�Y=�Uz�P���i�t�T<P$ܱ¤Q�\a���oNG&v�=���q���c��Kш�����D����H����,ՙ³��|r���Z%B�?f$������g�.�8l�^���M�x��ÊP�{���(Q$.`���y�D= �� o��ݛ���w;�ZR­�"��d�_�\V�4� x�r�%���,y��N��狷/���7=^g|�7�Y�5�3�>�:�N1�;����HY�;J�yUs�j���w���E�v�o����K)y96��R�j���Z֩�a��x�YD&�Z���>+8��{=���� ���Q�KD L Їgu���R_��e����*�aHz�MӸ����i���e�*w�"��~92����H�$���T��}E	'm��b
�'��Bi3K�Av"�������ԉF1�}�4M^�e�^�y��]2����9��y�]�.����xXWJ��.a)?k�-�~e��,���R��PӸV;��َX�>v�@}<���l�j�kY�}*����ś/_��%�L���CuͮR�Ph#�{ud8ˬ7'���[�l֎�v/�� �I��><��V̔Ulk+�gڔd��Zs�G��1�[�1��k��Jz����\�^�s]g\}To�I d* s��y!��J�o�u�ϺO7ؖ��/bX�C�xϩ���61� �� o� j����Uo�_HJX�:�j������~�ˋ�r�8�\�O�@�$Hx.̷U��36P��XՕ�!'���G�,�V��Sm�=|/��)s�}=��ᎉo��T~'(�,��Je@�G�hrbDU⧴e�N���^��.σC~���U+*R>SQ8 .����p(屷9mxY�-����N\+*�L<n^�}� �k;�جRq��)�$Š��(h���:� �Щ�E��K�.���f�'5 �u���~@i#a+q�6��.�    +T�'����&m��[2o�+ _G1>�!_,�<��g�P21b�ؾ{�}D܇,��R��\.v�%���
]�Cvo���x���������Z����wo�ޞ���		��A��8B
�_ٸ ��k��4��է�R8~�Zwz���Ї�ȉ����zm�O�w!CV�����x
�k�\DT�$5�UH���x�/@o"��u��P�O���|�G�"�#q8�ߒc�B����;BSY�
0���Ij�p)����{�ǯ�����N��$��Vh�u�F��8�A���8�����EƕG�ꡄz��{�[W�KI�*�QҤ��	E��2�uj���ή���@St}T��,J�q+�~�T��0�iY���Ԣa���aX��3L����2�(���p��Y�g�>N�n񖬫�|M}�����oO���,��?���Ι����<up�{��/��e`i��К��.��� i����2v9޿�5�(�Au�-�N���%�&�m3͢���$��׬�O�b@n`K��V��Jh0�ry
�=���Q*�����?�i�SK�B:�������(�S��=�F� �mi �v�~��ǧ7{��|E5)�i�3��! �d�EM`�٪�m(��d�0*rhv?j �#}Ѩ%S���Q~j�2�k?_�����8�zd	��X.x�d��z��+&�L�i��(p;U0�#6v�ͪ��� /ͷF��'�l.��Ю*�$�T��}�uqm2@<ۢ�����u1��NB�M�o�tH"�z�F�T�ق:CB���ER�ߚ�J�
iІD�v�?�8Q�UI;Q�vC���E�juA����v�>{�[͟;��!�؝*-قPL�b�au�L}�iSC��kF��6������}&!�����	[�&G&Y�dXލ��m��ݾR�X�_�Aŀֻ�������A`)��w��_��}�j[�B�>��Ol�4*j�6�$�WS����v[uh�ղ���뛩72@(�\��~v��I�u��s]L���(�Q'�&&�f�"i��H�hD����e�Vsq��Ẹ�kCQw���L�jy5sU�zm�Y�J*���H�ʋ�]�p��`��Hɿ��&w+��� v�F��������⭠{=�`������H��Q@N����Z�(���)�1�x`�EC�<-"F���!^�Z/���IE>�z��1ɗ����'hz?]&5֋�im��R{�5�2��)ڽx���S7�;�y���ӏ�s�"�� ��։�Jo��SdhY �E{�;v�X�ɼ9��x\��z�H�A+B$y�(;U˥qt���\�����+��xR��.�j-��Yh��Q���ɺN]ӤX.�ᰟ���� ��>y��4{�d�6ع��e��5f����2��b�|NfŢ�W�*�P$ד�/���>u��(2W
�©6sb�uqpz����#_]�o=Z%��fC�HR2��b�J��`�r^��uk�ӓ2ƍ�9 �ˢ������&(M2�H�v�k Y��K!�dP+�Ʌ��A�k]�U{��g��\��rV��V���I`RFxm�I`�1��+�2�}<+GsT�bS��H!
�>ÌY�Ԁ�ף�w�?������X�����l���Ȗ���+����� jF�a�viy�	)C4�s�Z߶c��O�D��44){�xTa�N�N��y��ʭR��/Xa��L�gȠ�ӈT��aT��	.�^A���T���N�b�Ȳ�5j���W�f�Am���κ��vf��Y���X5�ՄT%�ŨW�+�f�����9��袽��3]/m���Ap�狯7G�����<�|�]��8���օ$,�V<�a�$Yn�5�[��1���û,�}��ˤ��)OQ�.+�#ٳh�Q�-,Z#'e��J"[�VP.���}'�����m�m�:�:Х~n���
ȗ������i�V+��)�������%o����5ͱ��_?����?���
�+'S��� �l���N4�:!�T,�!ը��N���;	�� FfZ�_�£bّ�'��&9�D�֎��r�^�G����DIʃ��4���=7F�p2�/su�R�t�zE;��m���$�������<L�@صDb��۞Y���zw����hπ�N��廧�����2N�c��ed#� ^,RPl-	J�!:Ŕ=��;u#8SH%	��f�6��L.O�q��p��bf�Wk�K��@���h��Я��q��Ȇu��#���m�>̎=┘D��1�(H�?�C���U/�㙭a��!^�[����}:|ё}�x�٪N�S: @(����� T�����ު�3s��>����*�h��R���.���:6JE84�Z�D�۱�Q��V�d� �#
�F�*n	̍ԥ�:2�
BYD���^�2�z��[�_r����R�����?	[�Hj�8������
F�
ʸ`k{�Q��x�U�h�bBN�&#R���w�����u���6'JS �#�����S��!f�2)+籙��T|��D�u�Z�bnB܌6��d��I�V#|���Sƽ��mM}���!s���TiKR)s��	��?���Ӆ�
_)��L���g$����yU��yl�7�	��'�3��ZL/����0�XV��ɸZM� ��e'qEҵBDp)��D�;�#����~�wQ�s�.����>\����sfmz�,X%H�uW�Z���ķ�nV΢uKk���O����a����?D|���9���2|Pm�f��b��C%��I�����|k��].J��fq`@�����+��zP��ٲ�xh�?�;Ҷ�B
7�������r%��m�}�4S#��@�ֆ*E�dn��7O/_���w{�O+���ͣ���W�<��|9@�dvy��T����KXЗH�t�5�ǖNN��|�y5��n	�zts�C��GϾْ<����עC��dX��yhA,���μ�V���Ohk��QW �ɣZzD�P���ND��Q���P/ŗ�ɫ���J8,o���_�^
�X'�LV	��[0tʀie��[
A�1$3[-&Pl�yT�er�K)���uB%O�<̛0VӒ����hS�u1"0�c*�d.����JP��ҀM5��*Ʌ���M�c[2V4��}��P",���.ns��V:'��q���!��5śZ������.����u��hj}���o��/���z�+�V��'@�#Y�L̤�s������xLrD������8MP��
��5a��s�t���6X�� >Vl��+M��*nLS�M�.5�G��Z�Ơ�ӌ�����SR
3�OOk�^S�@F��xF��C��8�B
^���睭V�#'u�s�h��mŀ?�NZQmYp��I��b䥯���!֠����ۓ)�_���Ձ�������m��E4�d�����:r��.��mA��F~nY�?�}�Y�L�߹��C���R��\{�@���j#�*�LɽT�z*5A�v����>��\��d��v��.��+T����U��SֹM���E���-��Nʏ���e��msi�M��%6������ߪ��
��!i>%9���d��|�������E�z�1gqǾs�������C#���Ws�re�ײK�Tt��/F��0��w�%l"���x\�����#�����aa�ayb��!YZV5pN�H㹁���y�j"�@�,���fTp,s�� ��p:/��v/�Ƙ�YŪY��X}���?���tᠽ
rN^���*~��Z�Y@s&��o-D^�"�4�����Z�X����	�Ǯ'�Ú�J����]�Np�OKxut�ޢ�W�� �V�/���zP�#�_X��w�*�b�3�r�	���D�;����}��n���X�^QCU����53��e>�>�����fr�%��&n�_܇���-�X��|�6���pS���y���s0��>�$�M(mŠ� ,jb�4�'s���2l�K;�g5ٓ��9Z0�h=j�A��q    (��s��_]4_�TD���o�|�<J�����y%P\�����	^��(�+�ĭF���D$*��?C#swA�Q=�O�0�G�q�~�g\���.��/��ڴO�R~������^=��Ǩ�4���`��4�2>Cn�+�kr��k��7@�Ю^�
���q� \T̻��>���t%/�wQ_!��M[�q^��[�M�����-y����6td��8�s��& -*�#�fi�Tcq���	�$��=��+�W�I����3�v?�edi5>�YB����ϭ~��t{`ѷ@�ab��Q�����\����ۯ�^���n�%�gኮ�ي��6;�{̰�����R�j8����������\�Ƒ����Qkʵ���2N�{�%�[;>�4a�m�HJR�a�����H�h� ۂOY\	E�Z0���]��f{,?({���!#�bB�ec뼋O2q�K$���sX��^~��{������T1���5�\�*��W4�SE�>��LB�7	�gu�v}��3��1cQ7Ɠ[P(u����09/32��ߜ��Q�zw;T�]4�;M65% �Ah�����IP�l�:nʂ����]$m�n��珽���W	#a?��Q���	�k�۶2�k����[s�ǹP���5��p\߿z⤈�p�S��C�$���ؑ�L��|�����2�����<V�i�el1A9v{�9�{�ŋZռ�zkjw�7�>xFmՠ}%LƯp����� Qm�����B �a��"7`jb�2�@h�F�S#�Ng F��R�B��F:�|w�>�����'|j2T� ��~!Y�,ɇSw��HP�g��m�o�V���~������G�j��GGB�$ e�����1�>�b��	T�����k6��펇ǡ&<�A$O�{�����e�����D^}kN�Y�7(Llm��T#���)�d⨛*�ZX.6˖�� 2ma�g���P��D���XH�SQ�e1V�R*\��Gb2��1(SZuǂ`�¿=8(��Eek��Z�/����:��77�NA��k�ξFG95F�-����*��ݪ�)ꙺl���m7��B�Wx*��l*;rh��O���t*v��hM�������~4�����"���"��}�OAb���3��'@MA�"ɻ@�RR
���X�fEb�
9Y,6��i�ѱ��/>3�*��T�H�J��c���qU�4�:�����UZ��T,���˽#��/�=ҝ������,:Us;O
m�� G�QF�M�����QыY,Uu�/�ȟ���E��S����[C��mN'F>̽��0�6�F|J��1�5/8�Ye{G6C�2)�ʃ��]5S^����c���c�C���_����;� ��|m�E��eI�}F�Ԋ5ƫ^Yβ�߈u$�@��+�8�,��|X�6�$s�,4A[RԵ������6��f��>I��W:�j%�$%'����9���4�
0F�)��C�딕�/�ڕ�8���T(�M�-/��*��
ӷтM�um�r�G^�'%s�������a���k����e*ImC�(?/X@����>�Z�7��ԳT���-6(8�uQq�r��VD��?�����7�Zh�ԮF�Hu�cj�sڥ�r�]&��.e��ZDg���&�$t���z^e:̸��z|�Cm[��b�)��Vʈ�z�1�4��tY������znZPF�h"�L)�4|��=A�v�{��uJ�ɞ,�������HsGk
�P�M� ��	{�D5��,՜���0�3�I=R�#
^g*����ۧ��[�CI$�<F`rvq�����&�U?v>]c\�N�̲�#n��W�r��qk_Ɍ�Re$��F6'T��P�ZR������
 7۪ݼ�WXS n�q)��1�yJ�'��1�<�6fp)m�4P��Vŧg��n�u�fH�g��T�٬fL��R��uT3�~@�=oT܀a%�H1!���M>��1�C)pk@I��3�Ԉ�b4�j�4�[�>���w���6� Q�Ym�#��y��1>)��!�� "�j��|���NKE�X�A\�?����Tm�y
e����m�|�֝��������.Y��iձ��u?R�;6j�ulR�1TWf��r'�fl{҉$�`{B�
�~w�IM�#�7��j@r��M�2�>�u�I�v��g4��§KX��ծQ�P���g/^m�=��X��y~���E�>Q"��B[#Ȉ���D� ]���V�I�WP�
D-`дV�<D-���������a�\� �A�xⲍl�����������M�Y߂���At��3�ܯCqy���<����
$c�h8g℈��j-��^���q��5í��cRP)aE��/�z���aL_��)�������"Wf������ݶ'XBW�P���V��)E{3$Us`�c(����.:/�q����&B�ν��F���;�H
̦�-X	��Cϋp$�(h	(PsR����Q a7�P��;�sAp�l�ӷ��Zst��~�SӲY�I�Xk�����˕�NΒ�媍�L����lɿ�f�d�1!7��Ó,U�9��X�88��o&W�/"C1�2ԅ�/|�)zPQ�p�>lE���]u��3k��V.�`��e��έE���tN.�������)	rvAb��,�*�>���F0]*�3��zY�_Z6����`L�%�t�՗�*��Puĝ�i�0VT;�g���\�>,P�{���2L �	������߿�L�b���Y_���%9��ԛ��J�Uò�����fG ����vv�+8J�]��Ѽ�;u�2�C�ީ��i\���Y(mNq"}=�hz��SW��.e��	�֏`�=��w���5k����h�+��N���K��1R:!�n�|��6zU�\T3� e6q�WO��m>;�4P��ª`�D�۟H�K�`�EG+�94Hg�\�(�n�^_zA�٧�����j]�Z���5	eu� ��e�;͵벚U�F�A��ʴJ[EG}j!/;���d��`D7bУ����􃺽��#{sink�)�sB�µ���}Xĥa���5Ga�q�&u� 9
�.�
@Б�[�ǯ�v�����{*|W�\*[#�f�i�^Qfo�j�v���1t%��4���w��C�c\{&�k�)H�-��&� s2(�����D� !��-#�|g�5�j ��̛;�cӰ����~O��zN(crB9�* !�v.E0f�ܠWr<��j�֔J���K4�� �Z��E��6q��p����0���!�z�t�2p@��J�m����?���O]�@c^�~Qs'�(S��Ԏ�ɭ{zadP�<U�Icrz)�� S|�,t+�(��i���6�cŴ�v(�ʖ��V@�]^uT�_�@�(dsJ�P����t]J��v� ǆ	KA-l:�gQ�"�!0�\Xmf
1~f	9�O��.W51��"��s�
|
��	tH}��
XY�iT�WP߿�\)�0��ɜ[�e��$�0(A�e.W�"V��k�@i	r�a��O��i�F����{����x(\�n�{��_ԖJE2�)���l�dB��ނfbf~aԜS��y����-ƪ��&O�N��:�~��2l�"��z֎PG+,������]c����{�����U�P5��W�~m@� <��ڃ��"'��,�x�$�L�t2�6��s�?5n4�Hi��Xu6wM��&���d˜n6�e/?��_��J�6C�/�" �e��!
�p����ukv
'�)M�Yfs�5NFJ���ـ��b�D�W����;A`u���������O
tn��S������~��*.��U���j�*��O���҇Q�QIG�`����%"�����Ы}�*��NٝTm�N�;�ƙ;�%U���������<�F��g����$D�E��7�Gr��+�����8���?�C��BJ3��Z�- 3Y�aH�H�4�����OCLQ�k[mTY��݃����77)��S�Ȃ���S߿�jeZ^""    _ f\p፪P
��\���1����`z=�˴#.�z��-yjaT��\%=C��n������F46��k8��x<m�T!�Nmi�c�VfFe� '1,���u�fs���@�_:�������v�^�a���?�}M!hi\W�]���v����ƩLB������E��a��"�3. =:��Vs�)�Ų�H?۲��@�Ռ@��=���S��S�o�_g&�l��H
O'< 2�na6������"�e����H���4�0�.^b��A���������顅��K-��Ԇ��q��Ꮇ��iEJ�1������=:_3L��x��i�����z6��Kf�
��j:�!�r��o��`ܶ�Hh�h�ۆ����ݽEn��HQ�\�+&�֛�j  Z0l��X�D� �G� �¨�Mf~���l��Z �3mpv}u)E�5��B��w1ŕ��a=|��i=�_�|��݃�;_��L�Q9|T�/CSJ�0*��R �S$8�q�4�
�k�g�fα�SIܓ�X:��d�{1���i�6M5���Omex�~ ي��7�(i�����ؙ��gWI2<$7M�=4��ɂp�:�LGԂ$M���I�I^q��V��{j��<V�b��i��Ҍ�}C6TM��祂{HR�@ �0P����`���Q�����ձ6���J��I�c 4�!�=Og��prCѠ�-?���YΫط=��s����N4���քm�a^�D�J��N&N9ŭG�OWa��V�Fl���-�Źw��?2[�U^{�0���r1>���p_�ůH��恨-�VV���^;b������ӷ'�e�+��)3�NKQ��q��-'�ҭ���V׼7��ӛ��Ayh�Rp�<��g����2x�X�;.���򼐴� H�̎��<�#�l�8 z�����3��۳?�d�Բ7�m£�<ú�ӿ���/�O��/����/޼��;Z͂U֛\��#>ݱ)�ij�-%����8��j����`b�(���BFI���U������G��t]V�x�U�$d%~=������
�o�#u
4��J�!�K�#ƥB]'/K����A1	�a���-�G�,��jXƁ������硝��w�T�0�T^�!jD�����	�"pxR�}��y ,tH�`@r�bܰG]1~�����"�x��ە�4���E9���S�B�%"$U�B�ŋ�ܮ��C��Ě�Q/��R]h�HYL�CY�У>�b�_���B_#pAi�E�X7�:�"�nm�?C/�|��y�y��K#1�ڗ��R��A�ZM��%w�˧#��g����<z*�_���}m�U�W����S`�V�$����b�v�@yw\�������d��L���~��'zѐV�ejG�Ռ��� .w� ��@�?d�P�%���n��*ܔ�� ���b����R��U �2I����Vu����� ^���y�T�>;�5R�5<OLyX�u�9΀�����A������Ǣ�@�,"EQ�%"�o��sO����M�I�S�/L��@U:�iqhuߴ�-AQ����2�f_�8Mݒt]� �zk�}������x�Y�B9�U�t��Y��e�c	&F�6�J�έd�~F�0Ȱ������
0�4�k��ǡ}�?d�ϓ��	�*{��s��0:t����x=Ot̹�O�@�o����}�ϧׯ~��;�ū�a$^3~Kc*��aU�3υiI�d�ú���Z��H83�|��E�*��=�Q��!���%E{��C!�Ev�Q��V� 鹺��^�������Ԧ!�w%����k����87KVL �|.Wy�-|yA#((G\�@��XƸO�:_��_}��c��gna��o�|��d-��щ0�N���CWq"L�:��$G)a�T�7� x�I�0l���&l=��b�&U.���(z��� � P�rr9���~)�-9��z���#&R}�ݥ(P�&,B�h��\���W6�)umQ��-�%
���ܦ�?v����&�*�C�G��μ���A����	f�cx5���%���l�$��b����$�cU|k��S�7�a;�R�5+޿��Wo�V#.L��k/�(��+�A�Uʃ9�]+�ղ
��\���K�lɿ��T���g�z��	�a��ݭb�c񥜜����͛A6��̚�+X�2V�O�[��P�q֙�B�s�m�5%b�'�Y�U䑅��������Y��'���ji*|��؄���t;�@�/��¨潾�gYT#�:�῾���g��IwEx�I�TJ�) �PU6�0��|����f^��`�m�3�:^A5��n����@�e셦��t] f� 5H[6���#�-w�7� ����'!�@����o��p%�k�c��,S�!�ɼQ��:��)2ZS㱋2+J�l�����2e��,|(�=�8�K��5U�`��ѩIg���:�2�|����o7ѳp~�����:��T�@)fR��0��h��O��l�d�ȫĎP+Yl�:Z�8����h%�%��3LS�3��u^g(�2A��cM��(�Ҹ:3��pP2wH���`�FI"�5&r}�&?�<��~�F��a��x�k��A���TJQ�ەl��v0�F�s2��>�������ƺ�Y�E:��y���W[������	��Ƅ��a�p�]��zZ�v����7��(�ɐ�W�~��2���Eiָ��d:�yH%�6������S$��d�����[2K����fA�ԙ��Vl�ƾ�%�өf �?������Ƣ��ۓv$�jq��&�	�!$�����D#)��*!a�Ih� e�	�9tZ�����P����-_t���ۧ��޿;����}�O��`��$w8�<R��B��E�/Q��WK�]cuX��t&%�`������y�����/�������w�o�soF�p�����6�>��W�nOX~$ >��v��ݵ!ҭD���3�@Y��:u�6��a� 7�D�0�l���&�!�@�O �;\��|V�3�Yf��Z�h�56����v�`��2W�I�n�vq��~�ݡ�~���w�vf%,)��dhL�X#�����Li�$3�������3�Цa�M�W��N�r����P���;<˭Wf4�)�$����b�Ѿ7
a�����-��^N�J8٧��%�6А����G���Y��;Ҿj�6�=��[��I�`����4�$���/���"~(��{vW��㹬���?1��Ŏ��䭄��M�{kw���ś���?le"p�"��S�������o�^���)�_�`e��Gz��K��t�|'�Ns/�yö��XtKg|��Z��O�w��>����K<̧��D���.���4D����I�И���*}ab�Jm�N�@y�"��ؘ���Ê�v/J��;}��d��)PYEY3Y6��J�	-��˄A�=n��]Q��[���>�e3,dC-�r��W�$�y$Yw���	%����>���$��K�l�6�'��}��z0wO�E�������5�����&S.A��u.x~~����t{e��i�;��1ޅ����|���B��$	�\�:k	�����1�1͗�Bט���`�Q����}���_V��.��JEW���+��B�h �+���d�6�[NǚFʸ���z�]Y���ѕ�h'U�4�Ȟ���,{8oڊ��,���;j�a�f���gT[#�Į6G�>{�������hGJ�>,����vX���;�xn��Q� +Ś"Ii	���x��sIl�1S�:J�
��J=�`���݃bbs'J�ѓ��,��"�F��L�k��k�cK ��}�U��,�+/�]?m �u��L�vt6��\�&�r�TZ��l�N���6ы���̏�����}^4�g�>��@���W�^�����-�r��"h�t������|��� �G2�q9������D�a	��u��>z�B�ಪ��u	���0"�h�vH�    [� �>�{�0a�����b�+1���I�u�'L�0��.�dNp�7tM@��*@J�Ȁ���t*,ied�1�kdw�y��Nh���?	�-MQ�N�m2Zo$P�q�[�-����I"NqT���Hq~��<�C��߽~z����[q�D��A(�M�զa�F8�@������0LthP�H�0�|B��.F�Zyӛ^�NE7�eB[Lf(�+����?�#���d �<�Q��.���w��!e�G�(��h��倌1娖.�;,$ڪ'Ph�J�e.ۃ�R_��	��S��B�~���hw��{m|��Kg3l��サ�NcJDw�ÈPk��W�����6P[�
�#A�4����]���KeK]X��d �F����U����r�b��� ҽ�[:���i�
�*Ew�
5h��C�_N h`�1��s���L�5�bǙ�#��N�hK�?�I�>Wd��
�3W#K\�O�{�����j�h+�~�ZX�	r�e��������_?�Z)d�ئm��:�|�������~�r��.�3s�U�Oֈ��ӫg��4�9`�vv�#������vm�!��k!<T�n^�2�e�,/�#d���c8d���҂I��*+X�H�S�����.<���
rg�nX�WӢ1*�kR�GF�Mv�30K�_gݛ��Q|mx��4���Mڣhgl�g�W�`Q�]I����<=Ϧ�X�S�
�ӒY��Ⱦ4v��2%!�sCf
�9\�cE���%X#A��,�;�������,*�b�R�!꺧]�e�_L�&t����� �W��๜"�?b [��}�F�X��tE�p��c��~��6D���L��;q�ks���W�����LѝrX��h��vF�g�M4֖el�8��%��R��f���ٗ�:l' ��=>�!��˚>�[iLL"�!���Ċ�;��(����jc�TjHֹ��bO�=p)�dx4�Fu����5}��w��%��f�GA� 2�x� df��`�:IE3��}�'��׶���� ���O�z[��s^v�ƈ�ik�먎nMt�D�/v�N$�HNֱhn���D�b�⪵5ח��ܞ=�qa�)��`���0��>01>�)�AmTx��6n����"��|�P����V���D�(;�p�U���բ=e��3#@�iw��ݍ�k�_#F�@+F?���=m�F���yB��Җ��/�<���w�,�dW���%�b�$,S
�i>Ԯ:C!|��|�f-4��ضA#xG-3�B"���i�Oe�	h�վ��'�M��7H�F��Ōμ �̲�-/	8���B�����q!r�)�_ 7�U�VT�Q����E�-(��쏷�	�I�U����V!$x�~��?�h�X]]��+�X��T{A����p�l���kK�v^�$ڜ��d��MGr�,��Q"�,����SeԖ��w����%�fw���]sވ`�ԧ�y�TO�aJ����0��QF�zK8�2��ƛ�D��+.
U�K��-�(��4<�m	/���6�O�V<�;*f��X��
���/7ƃGD�n��#���X�|:��7}��٬�w }�hB&���D�;b��0�:8Iu5�z\�eu�j�nL�T\g$���~�1�S?m29w�u4���(SB�DE�o*oi��^h,����~�c;}���ܲ!Oϛ�~t��xqj�|K5��	�N�-ƪ��lt,��W ���凿�(�s���թ���] H���%�%��֦%Q�>��_E�SX])U؎'�S�na:z�װ���t:,�E����[�F^ �e�v�֘��=�z��� �Ř6i|�ԅ�Z�Ci��F�<����y�]�AM� ����Ztlt�A� ��JO�/�*8	?3�7����}S��D#6� ע�)CS�;2@�N�A�YG%��i��ڹ)���e6��Z&��l�d��5Z{���P��FnTAv�Qz ��X3��At��GI����I�OBa�����jN�60�8`�=%J��I��lv�T2E���������ۭ�I��@Y��O��x� XD�C�J��'(.�h�ؐOj�x��El׊��Ug����T�V�=�ע	u5*����[�Ȋ�h�S��ge_�IB ��0�L���K(=��/@}p�D�1ߠ�Z�.ps!��f�?^*WlI �U�5�@[7t�ah3��}t�
M�˵�TB3cɇ\~������Myd�v��X��H����XW���#���h)�V�3	\�"I��2�NgG�:��RX�t �H,��D�8�sЏskX{���⹽:�x��L��Vޠ�j�$i��*����h��F>�\���*%�Gk"��������X��*��jobcj��7C�W%q" AX\G��C���J!z��V�~���˷�Jܒ�&�l�;��E�!��
w� ���Nz�A�@�q鐨��.�s-Ə+S�0꼽�~�Vh�ݓ���0|,��%�nM�U�t�<_�[�}��(q2H&�����I$;R[�}*L���#S&*
⫗q&w��I�bԎ���h�v�s�%�n+8�������^~ąE	�*���ٰ�k���������Rc����>d�Iqf��D�]yu���'�w t5�&H{�TپV�"��b©� s�9i��	�X���!����ڊ��e�{��9ӄ�Q�J'
K�$So���\��~�DS��+>/M���2��7�Y�n�_)1'@w���4
J
�.�g4�8���q
N�wt����_����9���p�+Tf�r��)�K�f]�^�}��6e�	i���i�6㐄7�W�gS�j���6*�d�Gd�V�ۖ -f�$����C�̽W%�3Xp�Y^y��O�����}׳g�cb��v<����J����z���H�^�����؏#wat ԉ���n(?�	2E��H�@C���RͨLP��R ��ʣf�XdA��*yaofGDOz�,�wu/����Cꀓ��3ZY�J�t"l�<w��	ה��z��&�W��g�5�5Պt��k:�h���/F���{}����SLU�����T"���jG�U�~XO��l�v`=]�f�{��{�W/����v��M�O��*����
9�`XR@�!���o��z��1u��zM���"���v���~�+K-Y�xF�T8{%�f��:`1��N�e����-��{,�\;�g]i9U�c�A��6.H&/�}��`�k���K-�v ~�����?�|�����)wR�@We{� � ���kň��p��SGs�kǷ#'V���X�v��TU4�lP�KT��6��#ʴ���� ����[z�*5�#%xaP�m�R�d��� E��%��=������~�S"T�Xt5��r�g�"	���3Uk�>\w\���U�Sr\���^~�����>>�<�5�J�O&U�⻪wM���Ɇ �/��	�#���tmK�� �x���e\�qƫF��Z���$��Eۍ߬����(#�\M}�H��âK��I5������[OV��h���bz�x$��P�J���u7�Bє���@����\��ӿ���.}]�ݽ�	ց��|�O����]1ڻA�*��_����1AԎ'�tO��� L@�(\��aI�p�
���0v�5f��&�k;��3< �:�fKv�	�� J}��!#��L*_	�ĸM�i����� �9�G�G�4����x�Ps���P�����F��s�B"�Pi���d�Ǉ�
[Bu9t
��D��V��e�4�L(3���o��vT�{_�6��&g�@���(�������I�a\G������цaj�j"�4�0�i��V��Ɂ}bUߴz�Bg~���5��c0qԎ]A��ލ~ȟF�ф�$i�FV�nIu�7`P�%���$C�UNL�7�y��G�U�H�|}j� �B!��N�ޒ&��	Q�;�i�X��������_B�����b�������B��_$��.(e����f��hQ�Tԑ�,��_����M�IO|Hbx���}�(�    vW?Gd�r��I���J1x���]_^شLWO���n5���F'5r��8N��4���6�ֳI|I�&��|�"E�Lɓ^���Rv;xc�a���C趷=��5���_=}���w��iU�+`+��Z_���E�(�Px��\G���5�
,�B�m��4�E�!�^�]ga+b�/��R�r��Jd�h�L���1�����^�KU
u�b�=' d2�BM����Y�W����|Iwq�~�-i�9�K�
�̇�+M��]0>���t��]��\HÚ��A�i�K�~��ǧ�O�Kױ����g� �ݯ�x��{�WKJJ��j@�=��-f�\B);����@"u� 
����_�V��\dnLִK�7�!� �ݔ�.�\c
`���I��2����� ��"Ƞ�{��y��I����:p�,l*b�юJ�۱B�˸@��������٬�$�D���=�����cF��%UKp���⎍WPĔ���0E�W=�T��nz=��AG�faI:���[E�(>��{w:�3͖�3hF��l8 �e	J��Y�u"�;i�Sm;�\�,��;Z��no�O!����)�,��C��.4h��:??�,�6Z�Գ�5`��gx����5�ë�ؘ��/:�ɪ,�\�Zuv��{����y��z�n�ϵz:������֯���-8�5Ũ�J�6��%׌n@!-��|;�6<���Gk��m��]�^k9#��4JU�nD�Q������׎�!�Dl�Z�s��&��e�.S|�B]����}j��� ������Y���;îTpFd��۬�0�6E�Ҫ���`N��X�e�ƹ����ӷ��遙����� ���:�8���VZC:����a�L��a�%N�����e��4Ω��]�w��z��J�8���D�|D�g#'�E�badd�#���q��2�������6U�l����2�O�|���1:��u��R���8?��F��->W3:O_Ţ����ͅQ%�SM��e@;W͉{���e(�K�9	m-��p1?Y�;��T	�����0��I�7���>ހ6�/�h��\�	�E��1,���-<�j7Q	R,���d�O�������D6 uwe���8�����8��[���R�Az�*�,&FȺJ�3���r@�'�	�Kpt*�
�����nڦ!�iW��������f��ǋ�L먜���^�;��\��^h�[;��zS��[���9,%!W0������J)�ո���5����ܳdx�0��vZ���V��Q��b6*�9�+��"@&f��ఱ+�-�w3�W\���@����.ɸ��. bm��A�-����r檅��P��ײ���Oo��V�:~"؍�S���.hd�m�3He�:���D$�Xh]5��L��t^�I�hs��B #챌̆YUW���B��3���[vӎ��I8��"� ���I)�{3R���`H����=P{�� ��r޵;��ߨkq���<�T���y��Gk�i����K �8��}��a"ڤ�7ɤoQ���yZl%���u�s�F_|����<Y�B.V����_�&fF_�{�$^���?-������>���S���P"������v��l����52W�Mj�[[u�\���5�**�f�w��N	;^MV���Ѱ(�tՄ�0�U3�?��&p>0c 6�?K��y
 ���v]��#�W�-Ym��W`�y8"H�WHw+]��M�+^H�
�\�x *>9~!��eȈ�wzzu�t�f\jD9���5wu�����#l_�	�����)�z]�Hg�a�ҕ��8[�KZ�m�B�Za�l�u��)]ͷp�:Z���q�#��4X��P��"k7/9%�|/L@�/Wi&��>kB�� ���ͽ��/ι����IhSۮ)G�֮I�$��!Hvh���J<��[d����K�o��(���"�>�Ϟ^m��n`qR��-[���HFsd�Lt/�&*�a�:�97dB���{�k�x$��q�浮�k��AV���ֺ��(Xa��p�1$�>�v�V �ӳ�@�ƉU@8�%���n)D�����<B�9L�e��;*q�ѻ���_t)u4܅HYC(��ێ��̷]�y��?5�&W~�ԐT�Hc�d7齙bN͢E�����i�Z"���2�w��,mD��h����,B�n��]q(�Hn��wT�kYC3��v��E��i����ϵ%�LC�3�Z�L�a�	O��x��>ݼԂ��l����gz��x�P�u����W5��4�Ƣ��U7�y?4�k3?�T	�h	��ڌ�!���Q���x��=G|暺(G*��]�/ �q���ԃ/���cC�.�D�dm �	A��2@U=&%�������ī�׺�N8Q��j��%�ւ������CR��}	� S�.(,�ba����$Q�8� �ά�4��~}��"�jNz>���bi׵ɲ2��*�i!�9_0N������0u��haJ�Q�4vB>v#���o� #|�&ڑ+\I�����!٭�U�V�&`��8d��b��^�ZUz�ZhP�-��x�����,��ڵ������ˎ$ו�9�|�vؾ����%@G}P�Г��R%�$�$S �z�4�5�&q��{��߿��{R��1�3�ݶ�����x�c��j�_���l$)�tH>��6��h��/�2�)m�!ds�h��7��'ߙ��GՖ�PDN�%G`���5S:���[Bc��K)KJ
�&M��Z2
fݮ^N\'�C/濾��{ie����g��V�i .VE��GHJ���@@�(�yޜ*���F����~��#P��g�j`'!�L�O���e^�DjZ�������l)¢تآqa� jʸ	��R��bvg2���j�F2.{ٟ�=�AY��� Z���R��&�ډ;���p
��hF!Y��^c'�������>{���7��(o���1�(?U��{ʨ�gL_�x�$kYA�VĀ��k������@�NC��Ϩ��Q����om��_�um<� ��@�B��/�>g8������܎s׎p�@��\��;�{�RB�wx1�J)E�턕7���1�5�E'���eM+��[�Ⱦ��WĴ�}�yvyO���Lb�~�.�*��x�dW��%��k��}���9$dc��du�+˧۬�I���E�]6�T�HD.�bؒJ�k����l���I�mG};�`�x��v_퟼�׼�HIPU�,���		�l�
�p�
 �	[t�?U��P��[���Z�nSw��;��3����+g�F�D�#�븃B�:��!�f�$c���e��^Z�_~����|G�*��Q���B��k��l9n��'^t�����	���Fp`�EZ��P%jDQ]%�N���Z?W�7�:)�@l)�u�Юxx��^�ω��VB�;�-A���K����)>;UV���s+j�c��&�<ē��Ɯ���VpI]���?v�s�V�L�2�VS_��.��}�z�^I@p���������?�+���	Yә��-�@<DR���7���m�ͨ`5�%���*�f��>܁�O�˚𪏥GY�ji�P7`��+�4�#4[R^e"b\��4T7C���Z}v0�0V4�_��C����U���{�.�@���lU�A�G��s,9ӵ���VSc��M��b_���8�z��Ec֡Aw��m�Z�,7`ڌC m�"ZrѦ� ��i� �Ѧi9P�x����Cs'b&�>ٽ�%s3�en"ge�u���"w����!J�=ӊΖ?I�'��	ᣬ��E�0��&ք�v�@���p�s7�� ���u��m����&C7�&VT��n�lkH���0*jN����MZ��V��ǿ��ݛ/?[fTɬ����X=�I�kRR̹-�g&���m��9����e����MG�oB�)�J�Q0ͬ%Hxk�0�6�
Ό6���m��F]_RLUC��s�e����z���_��q�a���q�jU߭NF��?]4��F��bm`��閄����H��
�q�|��u��J���k�z9�~z�zM�;��W    �.����ԯ��^pO�AK^��#{�G|��y��&�&б�����7�aK&���.�Z?�k���aX�㕭��g ��1ID`�ݪ�*���
��fO�F)��
M��Ȩ���m��-���T��~�5���������[L�:�'0e�`+v�2$����]ѨjJ١/�:-����������^��«��G��;��1�R�~x�a��j��%��$�đ2�u�hA%� �-E%1!6��7�N�|=KO�Per�ʴ��  �%nz�r���!�:L�`�M�j+��J�*]P�zh�6��~��mK�����YF���K;�_�|\3�hu�YGb͗I�Y0GI/�o��<��_��9f1Ն�V��O~T�������ͼ���
-�5���H�S`	�Ա��Di}����P6{�_��(�ǒPe�!i��O�UAJ�}�����0vMo( ��M��א�mXῩ5���B�� ��؝�%/i,��!K�D�yc��6���9���j	���۶N
�\8@Rw���j�C�)�#��%����tb���$?J	pq�.7)m�ޮ}�)��fH)������i�~�[�]ŵՐ�`�i���|�/��FON��Gt��җ>�oړY�"�<�F�%�Da�r�����^Ԙ	VdM99�Q;��@F���a���C����+&�|^=��>������Og{tXgmN`�0x�X��G���@���S�=������$����)⟲�a3u�\1�t�̕��׾O�l{Xm����wɮgt��6���{���9LĨ�T�:`�<�OR��h����|a�=|3Z:��KVl�
 k !	N@�;����f��.h���"��D��Z��+���j���ǿ1i�� VI����x��AK�)�|�QH��L^}�,�"��5����N��XU\�̖3������d�ń���h3`�:���� -@qO���'�ա]V���RK�o*ߌ�b���8��HA㇠f�b�A��f������Y�SPfKu�?E`R-s��K)��;���p�	N!ܨ/sJ��R�_]�߾������Y�]D[Y�g��#��#&��Q�n�Q]�b7H��\qF��o6u��Յiy��}��PY�E��.��Xr�5/�=�+7�6|8��e�@�J�]�Ǫ�0JH��,+�nASXE.�{w�4�Mq	��qՁ��q�yQ�,s�|o(.B�)7�b��	��F���F>�uLQYBM��h���o?���W�.E��֕��QZ4?=N<���5)�E365�O��k�l|W���äMu@t9���.�X���k����i&����.]1;�8��E�r!�ʪ��k\�F�#��+�y��y3����.韭r.����YY�b���'N�8bN���:��$��������Vη#�O[L�~����*����03�&��^@� )��cx�ڙ�=��������ڨ�[:���	�_ꈩ�Na$��.��@��a���K����!1),X��#�Xj�vPPɊb�É�+='Zjb����9J0�(�i#4ӳ� r:���*j�I>M����}���C�w@���Un+��aV����Ad�w�9}�~����'W)P�$���PP�r��Y
�gjN��Y�v��ؑjޫS!�{S�GV�"V����J�%`���y���p����9��@ 	,�:���#�5*��4�w�P�*�[!ǆ~$ 
�l���K�.׀�HY�(U�����:�`�{,����7�_:F`�\C�@�u}y�~�
��NXsV�H��p�"Wc��S��g��^�v�nD�5��3^�$��BD챿�u�]ϙ(o�SW������ӡ6;=DY����H
^��H�+���,��J����4f�gb��)�+$� D�n�?-��fd��ow�H���Hk2�������/_����߮� |u�'*��*��b9C���C�=d�zL�Q�FU��3^��L<�x�4ۼ�a����".�dkڋ5W�Ѣ���L�̕q���.a�Ր�c���:�z��՞l��ĕz�^�-���`0j��7�_SJ����״�a-���O~q��%]���qY��o�R+y���G ��*x��-.6�*^`��x3����/�I7DOƁrТl�o�rD���)R�%S�1h`�)��qU@L��A����ˮ��$���Uˑ�� B�<��O�u/&�	��2�آ�VH���Z�\����o>젺pC-%/~����P0>!������b��a�dfd,a��4捴��9�	�����~܌���ӻ��?݀-���tT����7X{H߼|D�ؚ�84P^/�bO��]�
vr�VãBG[����u�(��?F>��o�F�Z`w�iS�WI�Z�ݡ`!�!�(쎚�BaS�)K�m;��U���Y����
2�-��ϋ��4UIX�J'�c!e��j���T�M��ߖ �V ��)�2�Ek̭淯W�-2�r���Ys�#(�:���33ٌ�*����V��C5�8e��)�������Ct�٩�,��&�v�@D툦��Me|��n�;���AH�uD~��5������U>�u�-z�����d��d�+8��6S���D�*�b��$�8��m�5o�WB��k-��߼�3PD��s����j�57�j[ER"��h1���(D�Q�n�����ؚ�VF���8�����tp,���!����I�M�`����l��/'���P���t賙�`�ADm��vO �j�?��$���EIK��b�M�����~?O�]إ�r�߭��GzQw_�²I*ǲ���g�ĺ��N�D�1�
Hrt�����zd����s���	A��z��r�)�39h���Q�
����<ܔ��e�%��b��ʇi�(q4#իT�*BX	T�Fb��aEӻG���8��-���R�g�^t���yg8� %G�SR�8�㌎� 	:��`iJB5�F��5�+��s-����O������=���,�M֯h��ZEA����Tb�.0��Tb�TX�z01V�F(��0@18a�N�E�sw��V8HRBlc|��O	]����$���uQ8ٱy��k���>l�s�v�ޔN��|vs����������,d��|��������%2>u̍w�7 e����P���H��>#�1��/����y��?�^�hP^�y�s 'B���&!B)��ܙ��B�\��*I ��o��v�@��%$8;?K�>��R�H^K�u���M5�m
��l�pS�K7��*) ��C����,ԅ��-T���7� ���}n9Iw�П�mww�*2��l}��Խ0�!��/�^@-�J)l�}�����CKkN�uy\`��E_����
k�W濫��z���� �����H�t���P��ed�ptڑdS�Kz<��)t���^�r�C1M�P��Y�3����� MՂ��c�i��W�: ��+ҹ53�A1:��0�!� �r}���+�6�8�}*@l�鏓YMx�j	y�m핒v>uK����R����F����w�q�nb9��������woVs��$^�j� ��,�l�T�
n�jh؛�Wp����'�ږ�2�o�I��knV ��8�2�3�!8��!L����_ A�H�Vn�N�c�S���e�
MX��=�`��\%��&�F)�����ܮA�v�ˠm�a��5�3&������������d�Nu�J��[���,o+)�4_�FD��*�,I��Q2��;�xo�8��)��0��ͱ��.sW�=*I\����@2����*�+��h��+�
Q\�5��S��Ӷ^�e�����.0Ҁ�K�mw�%�4��Lt$�,LxT�&��詧Y+J-|��<c�����W�)�P�۳���D��h��T��A9�&���b�a;ey>�6��Z���jF�\z�yY���������l�W�� �g3�&�����J!tP�ٓԄY��P?k�ةG��V�o$���i���Ҫh�12Œ��*MȢ�a�8M
պB�Z6��۳�    tO�.�f8�.tr��L����R_tb�mh��Y7�����Q�\��u<%�M3���N8�JD}��u��n���?���F�?�틓7�pY����$q�#�.�U�VҰM
G�z�qd��ӪKvrR0QMW���[���)�ܠ`������wC�V��p���
�W��x9I��niC$�;�,�f��x�>K�u�v:�!xB=�R��3��8�˄v��s�O6�.+��>�1�{b���]%�[�!��[��b|�A��5�WT��P���Řړ��oi@f<�F7J{�jI����h%j&@m��(6f,g�'�㪞∦������/���0�����BB�rp|U�8!��UX!q��+N�RkBɬN�E�9Xa�=��j{b�*Ƈb^�8[?�-�&O�2�[�to}���L���o2�L|j��u&5��e/ća"P��S�ٰ�+k�e��d��Q{���D�v��G�@�e�h%&����L�Y����oh�1�m �2�&gp����u՝P��t֝7`����<��3U!@�z��z"Nm8E�m_��O 7�w7˻��u���u����u���� T`�
��_� Hs��t�9�p�]n�z�Op�zM�^)'<���6��	��,�NK�o�&�Sణ��C$� ��Zx�m;�Εe�5����+Pن��n����v/�mɕl͊$U��"��`}i����+�x�~�.j���+��rQ��N���Js0�U�A�Z����+=R\��C^4-��s+e��m$�|L�[�x��
�E9�D��r�3h�iZ,0�t�i��S��q��/�h�k9�����_}�����V���2��.;S�􌨽gb#.`m�VŜ�I/���Kf��d�XVV��s.��B�����Buq���`�C��X=ng��e�>�y+.owP���ˣc�������`���R3qX��i9��?���1��
�F�υ5l�5n���,䒜���^�����dCm�Jyqd����#�!Y�P�i*�_ϮM��-[*�R�g_m��]���(�;L(� =��z��u��L�3gg�OU�F�$��kN`cx 4�{9�O�W���/��Ժ'���U��[6�@b�Pڙ�2h��7 �ީ�V��ݭ�}�t6;遝�7c���ߏ�󴽧,(���&[6o@��8�ZU>Ϙ	���ީ��(�7Փ�|�t��s�<�?�<Lg�^�̏Zt�L 	�g7#	(ZJ���UDai��U�=��w�C�\l�x(b�����)���\ �D9W]rZ���E���>��E��;l��*�(�P���v��:�c������~��eg���	?jj��:a��Ɖ�$aM�1׽iT�kv˥_@ ����vMa��~E0�a���9y�/��]~�:���8Y`Ɩ0R��>�V]ܪ
���yg
�M�&�i�?����|����B�u�k���i��b��4�a�I���dV2�'ł|�fI�K��%��Oǭ���1�"�j9�����A��V�Wꭨ�k�3wZ��j$����9C�KX�tQ���G4���*(�;D�4�j2%�WhZ�,���^��W�.f�¿��hQ��na�W�x�2�r���m�,�'�B���4W��m�w���zgf������.��D���������77���vc�`�6�M��`�<f�$e��#LARg�����"UqV(���L]6+���(�9�cG6;T_�l��_�*YŦ ���K��g�ҙÜwHN::�F�V����t9�WX>���T�o���?[�b�@F�/Z�Ț�z�U�5d$��͈�B �߶����SjJ���	� �L�������z}&�b�ۛ��PtAvA��PSB�+����LS��D��rT��4o@&U��7�Ԛm��D���+ӆ��-�Ӆ�T�Ty�� �àC?�ߔC]b��7O?X��{�����ٌd����g�����V�i{(�U\N�Mt��� :������?}�zd�R�DH���uӶw�0'`�Pn]Ȳ��K:�oB6	|�����]��ӴݔDV)�[;ۣ/�ࡄۢ�����1����2��H��w�YFM"�΀�
q�a�/T#��jG<�`ˁ�{�O���r�Y�b�ں����
�� k����Na��:��$��zj1�~9#鈔������Y���7aO�9�
m,�C7��6'��(Q�����/��Nȓ����>��������ƚ�>`^�{%ڄ�������
վ�G��-؁�p�Lc���#���%����D�L�$)���5@b�#e�w�7�ʤgw{|���)i�[���j��mq��bcP��_~��� ��5@`��}S;�,������ӆYB�l+	��~�	Xq��`Ɛ"���'r<�K�J$R��Ip��������L�0�̓R�nk;�.Y�Ϻ��.��2�	':�4��=��h.+*^}�T2�j���m�z�\���L4t�8����#9:�+6+�k�b*�k+C4�fLe�Lje��/�sZ�t �<�'�r�ڲ�1~(�N�+b�'�jr��{TP�QIE�\�3QF�����*��b
N-����$e�ނ0� �
���	�/%0���������k ��zB��5��:;p�Z����J�9�mq��oG ��iV{��|��~��>��%G��)�2�ނo�7�U
��4��5+�:��Έ*�	��xK^UoF?Y�+=�b�H����F�_|3ǥ4�)-���嚆?c��m��&TSS�9%�$@��0�g����tmbzw���`=[�R�^�%�k}v��,��8O*��<����±�W�����i?M�fz�K;K�}y������퐂�	�����Q���bv�;�u�pZ��u��S�� ���|�'���HF7^(DKR�P��خi�����Aݴ�D�jW;�%$;�P�w�U"-�(j�)wd�k���/�[t �4�=H���P�s�Ԓ�X��aO� 6�O��~��Ն�	
�:�]C���3nj0~���R~��;;�����������go�����O�[��L�e���y�7=1�����O��̰6Y��G�?%t�!���Y⍩�)�1$=��q�ME�,P��ضZ�dv(��/|�$j��9�r'�ᘃ(SF�>dm䣪��%@((��ä�r,N��o+2q��c�3��5ֺ��,qd�}��Z������[ÄH����g�{�.��Y���J:�y�����b��C�#c�ݝ��m(�gNVߤ��رG�[��r�i�R�Y���d���@��4�
�-���"6�X*��!.7�C�+d�f��:��_�Q�����ǀ��:-KX��G |b��a��Vl�'c�%9���bh�Z	���3* 	�	���F9���ʹ|Y+����Q���Z��z�x���7_�i�%-��ޭ.��M�;݊��#��d�ٍ�"n�S;E�ҺP�z���z?�;S7qh��
�?ހ�h/�k*���2����Iݱ�S�(,Yg,���Vݹ$U{�S	�~�j1_X3��.�ݼ��	>�b��V��2�$T��f)�춇ʦi���<Ln+�$^B����q>Ѥ�[���o�x���*X�Q)�L�'!�E�U�h0Ifα�Q���������FLY��
X
L1��:6۷CL��j��8�B���'�y�Rh���C��>��'�SM[�X'c�h���Ƙ������6�sV��"�c�72�V2��ܢ@19�(L ��AO�$YDaT�F/�T"���b�~��5�3N��1���8vOg��T�g��(n+),M��D��ħp{�$)�ƴ٦��>�҅�,3��Û��qy����uC`�
O�ct��Z��4���Gt;� �^+k����5��b�Շբ�Pv��j��Kٲץ�P���Qz���j��H y��ir��^�k�l�b,w	}y�~����K2�F֦ �x<Q�Dw�p��H|k�
i�Jm�vQ>LId�6�3���R��$�>���K�S���Մ(�z!��m����=���IDv    6�*�]�Ȗ@�=!e�	�u Cm�.�J@��0�0a���;�[~�v(��
ZM[<nD�i;^�}�c���_p~�'¢\Q`�t�r�ӿ?}��s[�f�s2�l�N�z�;�o;jIV�3����X��'l	�Ҧ�AB�nM�M��M�R�_��6(�_I]��X
'��T�I���:jsU���[E4�CD\�T��������V=��4V�fz\h��$j���Ֆ�ȳ ��{��$x=s��*b�y"o%s�ݮ�w�x�m��cΪ��Gb��fɜ�������~�L7t���<�����i�JlZ���
�خ�1�|7��j"hUX�ی�.��2*"���n��|�gqB�óM/8f��a��S�[��4	��fq�$�pA�h��@6Ԛ#��:�x��������|������8����s�?��j�%���:Ir\PG+RѴ��J��worŬw ��neB^�����k���%�9��c�Ԧ��k���������!�#/:%��
f@jk�t.������ɷ����r1�V��$��.@Yrc�(?��5�?n�!�'~��\Ǔ!�9��i���ȫ�`:�:|��UD<^-��}< џ��[�ב4�h3�#ml��l �J�:;Շ��נ�hM]&xM������7_.���:�^E��nߤ]%���TPHU&��o`��\��p��U����'�ݒ|
���������� ԴLP��{��ū'i"R�x��|��nơ�8�J;Y��C�$�_�-�/��B�/���i���ϵ���F1_�?`�!�1
�������W�i���ر;e��?>���ׯ??���*�	K��������2��k�W��qp�SZ@u�>+Λ��t�Pg��@6!�y�`����p�-����ڄum���MXVӠ��b6q�b�1���d��: Ŋ6�Z�ܯ�o�i����{yp��CNF��T ��*��q_Q�(&�	�v�ަ�@�XWZ9�7�{����O_޺�6 �-���z~=,���vA�/�Kء.lvۡ�m$���I&$�b����(���:�'9dR������rg��b�=����`��V�B�5p_q&�iɄ���|��\��\�y��I���[{�CA5� �\4m���,m	����	PTe��bΌ����N�����z[\Իa��c����*U���1��]9cy��5=��%�z��8�	�Cu��B���"w�����P+�-M�d،_Z%�ѻ;�h��9
όl��|tn�����*d*YHMi�l4�wG�-�n������~�Z���'�}ll ��*r��Ȭ#>���dm��Wa0.�
���w�/�h��T[K��_�`�2���!�o �8㛟�X��~�%�E��1�qi�����<W[$z���@t���܆y2J��N���'WZ;�hk2�V{�m����"�pw�h����G���_�\c6U�����Ib=)F{�F"�d_�K$W�������w|�n5�Q�QQUv�p*^��i�wE��V|ؔs��
�m؅���+z��k�er��Ab�V�
,�v�@��(��0���4,X�)"��~���\��E�6� �vAҮkv#n�������P���V�"�f��ف@飝U�xP��QF�`����_Qߺ[55ׄ2�ZY�p�u{����IYJs��yD?=t|oZ���v������4	�L�ǯc��&H����4���"�J@/lƒ��u��q�k�~BQ��(�M��W��b�Z�;��0�q�T��q�p,`%XV�ּΎ-�q��u�5l<.@��� rJwm��?�ͪ}�'t 
�q�����ou�M�M�#\��*�#���F��7��uy_�tA0􈰴����7_��i�NZX����L1�K�I��c7Tv�6�т_�nF�-0I��7������zH`]�4��-� ~`���ͦ�&�=�Ȥ	`6��/�j I˚�������Ь\B��܅�λӻ0�h1��Bl���)u�%��c��b>�n�f�=� ��/��P�HE Rɧ���_��~z��۱�d�~BQ
�_�e�����ĳc.�1]
'��P���?���&.MU+~��z{B�q"~�NY���y��PTg���O,�6��) 2�����$�g�贝�HX�ɶ��M�$�/h|�_��G����7��Wl.P�m?֟;�8>_�.��^��q�^d�tT$���l'O=��\7�UT����� �oys�a乲#� ����ѣĄ����giہ�m~騆@�����D>=�Hڡ���*�ɉTkg�E�(�Պd����m��ߣۈ[`�y�����I"����R�!P<zU��6�v�Rd�{\�g�Գk�V����� n�[�q�h4�Q���nj=G�^7�y�`Mv2m,\-C�m��� ��HQ7F�V��R/��w'�ץL���fu^Q,rw�3�����T��,["��	�'�� ��P'P��9�м[*)Q\����|�R��?�0"18���l�S��b	K��^�Hx�X*�9�m��y:�f�sZ�#Z��bW�IΥ�$�O�=�Z��^��c�z>���X�@	v$�G
�����Y��>�xm�z�Z��g7<�R������-�ԩ�_6��h��f�b�g8��9̆"��g�f�>���j���UrHx�X���/䵇}o/̃%���I���&P�{@������4W��8��M����������tpbۢ�X��6�=@��[=�*@fX�ץ�τ+,���#/�$f�ʊQ��W��*)��C�?�Q,��J�[پ����;HO����ɨ2�}b�<�F��c�15zT�܋j<8��X4$� V��F��Vc_����o�����cj~�#Uiʫ~�w��t�Q�!iw��tZ��5~��B7T}eo3 ��@V�:7jbM��(��jjhFt-k�VJ`��n�l��/���i�5/G�f�T  �b�����Dc�j��b7��86��,�E����`5��疲�����i�������]���M�M�����=+��EC�*⢲�T��k���2�YŴj�+�GiRen|Y#
\� <�y�x�UIZ4*P�ZǙ��Q��8�y��Q8���C�(��7sPH�TW������H�Y%Xs?^�d7˟������	Z����^���}�e0���_8�K��H�JYצ���t��W�v��c���׶�;�I���]1�OFJ]�r
��1���AA��ZJ�qo��7�G����"���Hl��)E7��;�k�m3�������K�ZߓDcۧD�@>�P'b��v�\��H�r��`)Qb����-�hJ�����滕�4�ĳ���O�,cP� ��X� �Jo|d_X#3Ys닥��z���'�P��d�o< �{�3mB7��w<�2�S���srLY��Ċ���C�Ar��������ds��V��źa$�c�,a=@7l2�@#r5�td*�h%!��=tR3�A��fÖJ���x���Z�,���o�e�Ƽ{���ظ����y��r�U�K�s���X�EBq4s0��n�����0k�S>,p4Öpp����wO���6*5�4'6�#!�.�t2H]�#���d5W�����녻|� CoB�ۊĖ>���ndB�C"���]�rZS��G����f1��z2��'����f8�+��~ph�ʙ�Ժ���}�mS'ơ��S*�GM���Z��R�=W��|\YW��%+!`��}'�g� �m�և�6zY��;���继�Z��� �,�M�۷l��M$��O�h���JѶ>��o�����n��&���
�w�vl�N;Oq��ӄ=�X_������Q�=�	8 �|�E��Uhʮ^><ZZ�:'�n&O�gk쎿���ԫ4�+�N��yɔ��,��ŭ�.�s��(>����֣R�1]m�t��Vj�������'zYi�9 ���fP��[ǲG�����d��\D����=��ŒX��i#1��C�|�G�
0    �FD�L+��R�+X� �S��rCMe���jT��[��t���c�J������Y�#�NR`6S>pлUnbN���fj�~xY���?��ݢ!j�$�*����U�Ģ,��ԕ��|'��'���P=f�o����b�	^5�y��m�l�7�w�������h=##��2�V;�	,5��Eu��d�u%K���1��')��d��p����+��d������n���<�h�yvv��E4?Rq������5�&P��$Ȫ����V	?tC�س��B�dLI��~�������9�V�j��Ϻ:�wf�.�|E�G����4��<�j��)���)H�bl�p�y`٫4,��j���r�@�fgT�r�`����m���m*7f��M���v�����G��!M��:1wX�0�T!"��*{�S�p��QS�	�N��J�	�W����c�t��Z����~�za�uHi���k&��F���`�-(�Z��b���\��h�P�����#a,=%�bM�z��y�VQK���	ĸ4��!�aE��]��Ka��T�Z��7ދ�@E,H�;K��6w$_����}�s�>NB\P-���e���n]�A��Vp��핚q�bU~����ge�����,/�\G�9z���j~J��k���VM�T>&���f�;!P�nae���x^��U�"�NBy�<��޴Ş��z�������S���$��S�:D�E��II�W1A�1��0l�~v%�8 9�~�1�#�))�e0(a�z[+0BI��+2��|��Z_,׿?���s�T��.*q��ݔ)��Q
�������b���y ������-�X�M-~4�e�><B<Y=zn���f��xN�W�C��PC�{����Fg�	���Ɲ��̏�
ʲ��"2=��V~�ǳ�;�KS((���1/��C|��Ge��r5��E���"b}%+ }���_�>-�wBRg�N����Y�f��Qy��*[e�֧����Db��0���V�x��;L
&ڼV�X"�ɯW�����h��rY��*�w�V	n�]�$�=(��c_U���Aa*����b!�O�O�\���Ҿ��P��{��TIM��\�[ڡ_U��ڜ\��lb,Qc�~����y�و'QF�Fj�o��o?�$ؐ�* X��|X��@Е��աK���4���Z�aZL����%�k7��6��4�cʽ���z(Ւ��G�|^H�S�(V�-+�e�w�iW�������gK�i�D�X	S�%z��u/�aM�;f�k��+���{E�������ʊ�z���_Y]Rw�1SZ���[�`ME�u0`J;	7��E�Y��b�*��È@��?_,��a.���Z�C�m������a��S2/g�#��hp�R|�ְ�h!?�ƅ��y�L�v��	<�+H�o��z������/�N���w� n�L0/
�ȫ"�ۅ;|zQT���4�
%0�"
�
ap�]��uN�@��֣��}P/L�ԠA�,e�t�)�~����B�Q	0(��61�fp�!����b��ʹ�0����}h�$0�Q��*q��ö���KY��)l*��K;�9Ϡ���!�;Q#@��������
hDH�p�T~s*q,�wo��U� vH�:N�n�Q�t��<Ҵ0[�IUve[�Aoj�n4. UH�G)�X.5���9��_� ��/	�u7���f{S��%�Ȕ�&2����;L	O$;>� Guz6`��J� jb���*ZT�9�1�H��#�s�_��!�� \5�}���ia�2��M�4 �gN�W��#>:�W� �ݩ)�����w��oK�`,|�F�C���V��.�j	Kl>��-N8���������8�i�K{��8d$�Y
Vpk���O	G��D޴	����J��:�Ev������o��)Y�~H�	�'c�4^�L � .�TNMk��ƃ�	n���^���X�_i�깫>�{��_o�fOK����ɚV�π(�Q�W�D��́롩�НckZ�����h�k@�uh��W&�f]X��	��E"\�|�t�K�F�Q�����֣?�Gw�T��XQ�:�ŹEOOŤf�x|�|�el��������׿�͇��ᇈgy���n5��ub�e�Q=D;u�P��*,y_rM-���,�H��\ ��ʸ�`QC�ΐ�S��\�e���R�-�v<�UH������n���^��a���Rψ����١|Uv�'��lױ$��A74\�'���ea��.jbȕ�kn�dm���������ޮ�/�$*�]oV�@��F��H�\��K���HP�Z�ܬc,�F\ɖ�v=g��b�_�u�s���%:DS@Y���5�I�P���fP�������m7Ew��	��T����R:6=pb��|��Ô_b?��J������[;Ts̟(m����M�לx(���Vk�$��fw�A��y�R��pa�د}�~���K
�q^��QW�鑟<
�L�/�=5,�dP)��j�5;u��x��n/l�tI�M���~��4W���3:S�&"\܇�d�2�*ͪ����+WQ�֝.,N��Ct�;��c�%�bδ10�@�P)��(�&�gid:b �O3ax��t���
���I��#���*R�o	�EX�
�������D��5-`~�.��r���b�y���� ���x��m�>��bu� `��S�Vr��<.�;7J�;XBr�C�ُ���7o���̮6���!|�uI��lv�ZҫG��&��rӬ��c��ʥ��o����u$W���4�2��nG��li�.��F�y�:�"�����>�Q;ox&���s��e
hW���T��*p�_�L��u��G��w�q�T+�����"��j�u�m�c��t��e��jȉ��,P*��v��P��fz"�΅���cQU�f��ky�F4[��`29T*��M�h
]Q��f�0aŕ�MT��-Ϋ3:?��U�4�:�GJD`���ɚL�x�GP��n��b�"+'7��qIOK�~�$�oi#�q��Gy�g�Ҳ�*���P�Uё:ͻ"�s�Q�R���ƴ^�F�A��ͯ�n�än
g�����=}�ͪl��+X����@R}�� b�&�|dMԚ�$S�#�S�V=n�U�|0��JOd}�j�ujc�V��8�n^�k� d/�8[Ӹo �v��1γ��F���gY2��l[ ��?9�����7��-�\��X&��^#�r[e����bqP^	G�/�ˇ�<}q�,����1���TT\��g��G��L�ƚ���(9�^lH�� I�D{(_���⨝�x--���2���}�}��K5��u-&� э��PV|���}ѡ~v��kZr��B�[B�?��iW�7�U�\�Y���ǫ���{��o��ޣ'�r��Q�(�ry�����S�O�Sr���օA��ϖ��VTc�xJ�ZS�%����x��պ������٪����Q<��ӂ(�S�#�.lYV/A{���t>�^�N�KhH�UŜr�VB�:Hr��i�-C�l=��N���l�l��M�ad7�a�[��(�:����њ�YA�l6�tC]*I�*hV�T0�
2F��Y4�_��������[���iBH�l
ic9o=	����	�ق�y�Ķ8�~��M���{����DrF��q[��ĎmGEGUe�[�4�U廷�?{���E�=�)�$�g;}RNT��6F�b�`⃢J����f��d�tU���O�4�u F������� ��b��5�s. �2��),S~`��{��������ON�.:E=�iM�p)���0�Aρwa-������?���=���/e��e�<<H,P���=��q���si�2�2�څ���LP��6?�6�MRG
e07K��G�N�m3P;L\�%b;'�WP7JĪ�߱-Q�5�L��j(�\(�_��)�\g7�_C|��D���T�L��E���ł
j9�Є�P,�/?���ۧ�+p���    ݠ�"�ӵ5�P7Rt��b�~�� �`pRi�!��y�X+�.�:)�ZIG�+����mʱˍ�V���PC���Pȑ1׍q&�P�?�'�F��1�ϯ���a��.[>&IL�j������$�����Ni�������_~��O˸B�%_UG:�̐@[PP�f�NY�c{F�y��o�"%��� �4Ft�B�q�s{�6U�����bT�l)�#�W����R�m;�'�}2�u�a�ѐf�pU���U�H�������/=���5�n�h��������,��o����b֏���w��=~��F]��\�(3zE�F�ir����S��~���>�Il!H����K��0�*��W��m5�CJ]�4�����$SJ4��J���ψS�,�(�����pkQ+��eE�C�X���[䶔VP��
�[�"�6�b-��	�`��~���g~Xf�������b�cq6��@����Xc���[[���r�t�,��t�&@���;��J�| �PR�x���0�6)R�>�G�i@w�N�x꼲��^���"�V�r~�Z �Zd���kk|�)����Z�Wg�@ �n!�9+<}���>�n/��2�[���:h࠰q)�s����N'ݚ$�W��;?��M4V�ʾte4�7�6	*6k��*6�i�=�b_6m>���QI|�?�'���?�<�͂T^��ii�Hm��۔��{�PSz9����j��_������ �_
P(7򝡮���V#�8
8��(�©�
��1�]�L#ˍ3���/��`��b8=i&#Ut�T��PA����W�/��d�gF���e��D�Z�k�j�
2�?�(9�?��@Ԉg�a26B��)��2�M���sz%����I�����
N�����Wu�uu��h�ކ+^�E����D�b_#�n�8 �'��{{�Rvg�,��fI��w	]�4��.USb
w��6ꆵ�:�)���`쎬�4J~��$���?�	Ѭ?�����B��ݥ����3=�r�bp�[T���n����~,�����~���_�Ӂ��<�q��h�h�<�b ea>�MT y
��Sh_�?��A��
��Sm�hM��}��s���']s�F{�3q�')5ZZJ'�,���'�W���;Y
xܧ��N�h�$���@�1��2'��X#�;��p֫��}W+>u��z%A�����o�������ە���y6e ���TACW+q��Jt�u�dy��t���@���0���!^���qfu�����vF3�ǳ�f@�3�����}��"�Z/g��y�H�+��r�
/Z����c6�G�#��:6ʦ�I�[�Ղ>|՞�O�*?��/T���i ,�
FP�1���#�4��gV�7�@��٬2����R�B�Ce��N��!H�i^I�Zjw`2��I��)���ާ��j��O���˕�i"��~���,�������^e�!�D�B�>t���jʑB?�p�W.�Ѧ*�.p��m�� 3٠��{���[ʉ��E+��wT3�չ[������o��B��%��3��3Ta�g��ঊ�n�d�q-�V��֨��(�i��
����p�2;�k�Ln48��M��k�RK�Ϫ<�x�gG'�!�z��Dk��z�T�8���@��o���S��%m|1m���I����Z����p�9�xW�;�rA,}�פ]�@(����/o�>��������O�S��b�v6�������+U]�s^,�=p���9�>�'Db�=�dȒ��� |�IҜ��^���:l^23n�"��D��2gmsc�k��縌���}�dbD��0<
@�������Fn�D�q[�Sn �����*&��U�(�z����b������t�Z�|�22��Ɍ�a�P��Zx%�-IZI<hN��l����[:��� Hı=7'��Azm�m$���"���͵�y[VV� K<�Z�����c���0ἐ>��?�x�!�rh�rFһ�Eeܯ��K�{�W����G�o^��&[��Ri�6��􍹛��{'+�Ph�@쨛;�0/v4=	��\��T�Ļ8��P�E����Ň��
(���)j���inF-U6K*��|����Ыq)��A�H���^�ϞEy��%_2E�_	�%+�!��H�'����\-8ǔ�J�E_�'�x�ûEs"rcp�\LͪZ�9��ٚ� �~T�Ft�P��ng>�-'�#Rx�9�z<�u=X����&�fs�Oڝ5/��.U�ݒ�L
M<O������0��,�q+!�1����M.��t86ՠ�
L��)E���M�pL��e�N��4�!B��[��*t#�m� �}H,��]�SU����{����X��~���QQ=}���H���s�j�z��V��ޤ.*NC��ěd����"P�F�9�5�y��v1��lt>�� ��n)�̀T�]�[�J�t�Y�x�����>-Ҧ��Y0K��"E�L����=�l�@J8/xT4�����ؔA�xг�AF�ӟ�m<��D�ߪm;�jƕ��g�z�_m1��𤵪�ե���U�4�h�WcU����bAwGV1뫕8��:��]q�[]ٹ�����Ld_�$��jQ�+iL�^7�a�T x�$(K����$0�hQ�y��V��p</�=�%+C�s\��P��^NE�����P}�#���vw����=_�El�èwc���4d	KV7��T���n�hqdӣ7���H�"m����_�~��ُ�bW1i���'��l��g>�=�djф���cI���Z�Uل����\Z5Ha��n+_��D�#��Z��Y��8q�r5ܐ�8���)u���#AL�e��.�7l���c@�cd�;y>�;�p��e�/Y���-��zǱ������c��e��ց��B)��mC�"��Big��U��ӟ��g�D�~��w�H���&OչB�qG�Q��b��W!�GS��֞։�#=*��`�����`��������]Zx"́K@)�ޘ��Ia�2F�G������Q2c�����Xz�*f	��^��X���<܂Se}�:�Eb	�SU/�(7FZ�4x�W��������Nc���,��͢�u���.���#�f�E��:`���;��W������U�E4��7�TL�6�VB���ˁ ��*��c�5��6&0������	bKK����Kz[Ϯ�]�=&!aN\�t�췌D����k��(����5�i���~P<x����ڦ���wfݤ�Ys�ܩ�Xi-!3�p��{�A�R��P����Tء�� �@���1[�KH+���V�\����E�TdؼY^_ү�R	������#54mWM3K�]H(3X���(	jCN�˦�Tl&6��F�aƜ3��(�0љsU�~O���*\�V��OӤ��n�o���Z���eD�_�0���G��f��F��������p�MN�{9~_�RMѳPZ,2����o�zڅfk�P')Rdest9+�x�q�#�����,�ԣ�0�K�����w3p�!�)/v��)����!$� Xt�^�~A�ń����4O�g�	���DOD�m�ঢ��eU�ż�@���~���wo��O��.u���b�}\}<��9*,���K�)T�&z����P.[ m>���ِ��=��Q�ѣ��/L&c��"�h����Z��w�xa�p&���-L�@�4����1��[*,H��ɇ�ˎ�P�������#���Ff�@<������ׇڥ�{|5�j�X��x�����_��G:�p�fש߼��TS���	�I��bjA��d��9��#���l0C)~�Dpܳ�/ΪiT������F%��&�%�S!�|�	��7q�d)����|�������5��{_YF; ���X�) e_��đj�I��%ո���t��X������c��ښ��'�t�!�<�
�GS��#��pch{��n<%vbL6�=Do�h�^�>8^p    ��9[P��w�Z	��P������R�;Z���[��0Kt���/Ç�)�0�rt��R��9=��D���������񮎥������o��Y%W����>-��E�ĺ�˅L�%�0J�r�|�ó��A��P�=����Ԝ&3rGP�cw�3��u�HkZ�]	MY}|�|��9�t3m7�yC��n�N�
/!5������0h���~v�H��$3���a���f��e߼o��r['ʟ�9��=��W�l���[�Z����ӻo�+��?�g�+�|���:/����d�Σ�G(��1 �� �����|n0Je-���	�~�*��CXV� K�[0�94l�M����ڗ �%�v��h��M��9@��0'1���H��s�î$`b)����\-=�T�n:y~�K�����.�?��h���S��l�))?cHE.#&�"^��F�	1��D�A@��|���M�-y�����d����PwBݬ����}�I`2�i�癙9�������X��'COm]����"��+��}m�p��B[�Vm%�◯�}yx�dI>���[��;��
�<�W8?M��<fu:kӚ�6���e������a����X�θzg�Ż����F�q3s����U�,�7>-��������!9�ȏ
�]/�&��7(��5I\����2o�1�]Z\��f;����z���ػ�o��]�u��?��n�_���٩n����.�ci�E�P�dR�X�N�PŅ�U������:��v���T��:��T���VA����=����;�����%̔>���A�JB4m���0Q�����ݭ�:
���_�`��m[��͗_��A�6����=�X�s`�U�$�1��΍���OGS��c�u�����p���2ny�]{���r��2�k:5dI�I�y�4LWħ=�4u�$�a�!3\Wx^(�Z�M�������8������`ދ���
�U�8ԦԎ�+c[��T���-����H��w�j���.Ū����[��P[u���*ȩ�O�i��#^:��xKK��C%ݣ��� Z���Ӝz��r�� ����vq�y�!�#�;=۶�*4��a�tQ���+g�n��ћ�p��ü���$���n�N�?�7sX�����:a�iH�>!�~]s�n���KQ�_~����}����^�~��"�DϾH�}GX_-���6@.Uz����VUCD6D[iTL�-��E��*U�Ij��l_jԠe�ym�ER� aԈ�)��Í������ly��.�1�nw.�K<k�R�	���LU�R��|�(2[��Ȥ�ͻ����f����܊q<r�*F�H�#��m�W:�������=+k3)4R��4et���]�VXҼ�Lu���+�ù#��h���h#�o5�_Z��(mK���#u��YnY��<�z���B�n���K}PT��b=ӯ��|0����#��g��7a���Z+��˦Ym�]	�lw�j�I�72��Xq�/��/?����o���o_���剳�F^C�m��Q���s��Z@��WP��Ya*(�=$�J#�` D�ZC��[v�4��_Rǳ����oS5�[�
OtD�԰B�,Bͮ���A�t�B�{,����6���s�.��p��̍�Ϭ���j����Y5�ӻEZ!E���4:=��J���n���&���bq~�~��dA*�$/��}�i��Lv���s�/NtF�n�b��"�R���lDի�1%�~��(�%[���^M��m���^=g�g�q���k"��(`"�!��i���P��JA��($�/��L�(���i�S�%���	�L,'�,��H=f��mk'� 	���d�X��Rz��S� ����@{1��?����91�A�Y-���ǚ�8J;�g6�Q��`?�����#��[5���i�ᡍ���"�9	���c��/W��@�w�0��+{��aK��Ah�L���%P�����TP��;�+_b�g2����p�`1,E��VR���km��y��(�%?���ю�4�>$IDtm}�_F5ݏ�7��#�������ˇ���~�S��pm��ɵ���7�}���כ�˰$��`jW@��4n1ppW��@W��$�ܠ�hd�8��\cg*8�_s=A� ψ�#��T�k0�N��=�FD��&��%���������`�-(���Z��Rۑո[+�j�QI�����c�N7�F>P	i�k+��P�"T\][��
-կ��N�Pq��؇����7oB3Wu��Ī�eIC��0��nu!�f��6Ř���K��tF�#�.w�-c����-ԭ?+Ԙ"�[8�#�G#�/�u��+�����f�y�uwh��j�d�j�!�}�2��K2�]���l�[%-�SQd�cca{����zô�n[��~��(��D���h��t�=�{�����:X�aW����BYK1�
�r�r��·�ГA �/B���Ἒ�^݇h�G�-���Yg�������:é�x=��O6��k�݂B��"������'d$�x�8b0�hb4U<���[>a?I�88{��o䃖�j#}r�H��Y˃�p�0�7wz~�˼%���F}�pR��DR�h{`(�:+T� Y���¥�"��f� ��+�f�Ix��_@�}$������y�� �!��FG���T�ҦU�jՄHo̲GT�P�5���@v�T
0��� 9��n`,54�6FM/��W�s���سZV��#�1/�%�}�8'A��/r�@9�D�<���?-aB+sC�����%0\�BOwk�ث�z�}A��J�2 �j�N�,4VkŋŽk�'E�Gc�����}�1�A� Z�$���n��O_�����}?q>Ipt�Ut thg��/�`7v�����	�I�xv�b�2Oz��;�]��Z-Q���F �\���������-�9��r��{(�ȟ�|��N�D�6�� O!�S�[�J(��M�0\�B��������-�1jZ�j%[X��i�s�>�M�4���K���`yt���7�(�4��*�j1�z�˫�,�.P�u��,t���c)#���m�L�$^D��g�p$v� ��T6<�8Y�֘K�U&[ug�Z��!���U+�-�s������b�dW_ap��&�dQ<��8 �ȅ���A󋍽�L���^Wc�R�]_���ŻU
��L|
�TE������V.�x�ة�V,�=g<��P*��bQ�Uə9{M֭F�k��C]%�Ӏ��AhkT��2O2>N�\ �A_;v��4�	z1{_���!*G���]�s2�M� ��!E4���q@yTē�Bq���^	���@i~����/ּ�ٔ�3�ב��?'�_k?������}y!� ~B�Z.�{�I���	F��["�B�Gh��J���^�k�%����F�}����pu�wkc첉�L��v7����-٭b� |"���a�b��=�~
h���v����,�F�:����:�J~�rbذ�2d���}�������V�蠋-8N�������O��d_�y;(���7L��]]�Ym����Tݠ�_����`�씕�C�Ȁ(+"v�Y��a��-�^��aqO�����9�5�2j/X���Ah��3O��m�޹=���Յ�Z��^�WBM�˚z���g����i���C�V�h-O�o{N)���$�OE=�`�"�yI�q"4Jn��|�����
|����$�b��~�m],�]�eDL���O���[�o<�Y�c#�LXv�j�>ݖI����Z���*�����2H�|_;�5^�G�}��%k��D	Z�l��p|S��,M�y�*�(�R��fJ�i7���!
:�c*��L�����E�>�Td�G�94��oC��l�ȫw�]���BL��ۣc�0Rҹ7���*h͢a!9�dK�,s�Ы���l�F�}��h�D�$��@��̜�(��8���Da}AĦs�R׻=wGy%�s����M��`R����2���p �  N'9kh@�;�����8CP��Rޞq�����ސ^c���HAeӬ}���� %$��A^��'��j*M���I%NC�08J|��+kP�����L�XX��5!.��V[�Y����.��v;��q�����4�L)������I���FEY�du�0�����nZ��gE%��s�J�C_K������>=V�^��̍��)��i��2�E��&���%Ԋ�@c�"P��@5͊��B�f������Ӱ6bE��;����}Y]���M`+y�(�AQ��V�,����.�&;�Ԭ[��V�Ƭ-%���O]�޽kܑ����e��x(y?�IkVY�#}���4��l" �Z@m�݃�Ĵ�[|Vd��mM����l�9^�c��+��o>��S+�ꐩ�tJ:T�3����	Rù�"g �����) �C@��M>��>p��:)q�ZC�ׁ؀	�E�X���|�����#�҈yN�D�\'[���`6��Dg�)�2@�`�m�o ��e0%��{A����/W�'���GW��IF�c@�6�[�N���R/�5;����݌o��,]�����3q֦"!К|=�2l~���[Oa\(��;�h�:{5�6{�B]��k�/_y t��*�/<Z�0͞k|��Kc�A�hE�W�J�I�nH�I�Sϰ,��⿙*��r��x��W���իW��i�r      �   �   x����!�P�*6��r��q���� �|�4�E.�0���s��`����_9�'Yvθ�,{V9�g�QL:�w1��9�y;�������\N�S��d��|���p�����{PTX�J>�ч�k����(��
  ���J@I ���Z@Y@���o�
֏�s�޿�mb      �   �   x�͕ɍ �&�6�#��?�1^i3h���Cab�%.�2]��l�:�����c�+�3���q�����_k�o�F��r�c�bE��v2j�'��Fb-��=����� �,@�-���6�~@ Q�<$�Aҋ4
�*	C"	G"%	K"5	O"E�I�4�F�H{�F�H�,M��K��/��(�h�[��O-�|���      �   �  x���Y��0E���P�3{����@�MR�����lYG��=p��}A���juK)�{a�)���Pt�����n+!��}yi1۞�=﾿~^j�OE��V	3Tew������V]��Y�n��o��jy��w��C��$O��)�/:B����'WTc���+�^FϾ}\\���zMA�J�E0�m�J�FY9QW���:|*ߖ
f �d��/��5��� �ONh��Y�U�+�m����|U�	~w_<S�� �ʎ���1�b�9��H5LiWԾ1&w/E���ы$Ss��6{ Ɂ���t�,	m����d����m�1ٝ�B�E���[a��_��2h#@��\��Ȟ�V��e�ƞ��me��4-Pٷ��箙xH��W$'���~�[��yt�Q	�E���L�l�`�J	�EfT��r~�r�3
:�H��?�`3�E���Q"(��ʤ��X�Ig�PB ���Ղ��I�3%�AjOk/ ܤ��U�}��"�[j>m(�E�S������EJv�}_%(e��ee]+d1��Q�̖i�ʣ?g�#/^�<�;*eU=������(��H�fϴf%���|PS���Q�?����L�����(Y+��,���
h��ǲ���"6�2�_ .�`�EQ��M'��%�'쟙[�vNaW�?���;��HnY6�ǅ
P�6�9|.[U�ү��'0i�����
�U�s�}�d[����a��������9SLgshc�E��<�a2U���H�:|HoOb��
еxE��;똲'My,T�'!>���ǘ�nƺ0Evt�����L�el@�v����>k�)��\��-+?�C�;��P���z��/E��7�3_��H/��_��*�H���f�E��6ޚ�;2]L_������5�������l�|;ݛ��JFաu:	Gdu�yk(_կ��,p;���L�:0�m��6"��,E�      �   �  x��S[��0�F�Q��.��9���ޱ�c�Y�@�	E�'��:�T���y���yz�Ԭ����Fx^�Y�c��)4��=�X��%O#��s��mr��lAA��2�ǩ�m��ȝE��t�!�8j#�Ve1�*l�����}�E���y�$a�ߍ*ls"ng�ʹ�T���:��ɼ��VT��(ɩ�?@���X�|5�~x��r׫,a@Q��vn�E��$D&�H%�^=�X\	U|`@C�b�֑�R ��Wuf�8��BhĞ�=
�K��W���U�`4����������v�}��E��B`=lg$o�jK�A�/��w�T��ź U� Vi�D��v��ra �<�x��s�P����c��cM ���vȖ��Ƚ�jI2#lӽj���
��c�K�Q��l�r�ΔX�+ӟ�Z���8      �   �   x����� Dѵ)y�7����xN6�F��+�s�~��c�Oν�O�[�x/x�����l�z��\�"7ߝh��E���7�7�Y����mEoW�(z�zWѻ�{��zpɃv*BR$#� )��	�	$P@R ��	�H���@$2 3!1d&$f���zk�:��      �   �  x�]�]҃�
���b�T������1b��;���+��4��5�?�/ٶ�Կe9����1v�^������s����r�b���ް�loIߟ�C��YGoB��'��k�'g����7gƲ��{ܤ"Kl�����6n���H�%�,���*�:�:���[��y2��{4}�䴸)��3>I�;_~l��=	՚Pj~�Jϐ���s��C�p�ܑ�)]���|�QE�ٞ*��i���|�y����L9��? wu�EU4���pr߲v�΀XB(�D�q0ʄEە��[��o��M�8GBյ"�W��CGa[�27�k�܎��[l������	��c7���%OOtO�F*mh�f&�h�!27LTH���Lڃ��y�$��,nZQ.Mm�)�p���R�9g���So��~f�j'7�#����NΌ����t��؍��������YU��vy�TD������JdCf_��poX_��(!>�ܿ��d���Đ�=r�K�x9������^g>Y���CG�,\�4�Z�h[���AV�#m����x���c_A
�}1e�*D��X�BKj�@x��T-:䢫�Tqke vQ$�˒ϖJ��B6c&��bC�r^Y�s����K���=���K�K&��4?$J�Z�v�k���8h��GZ�dm����;K?�7 �9��*�:)��݄����W�[�d&-C�~m����V3�&ҡ�&K0`iY.�?�r�$7u�Rނ`�<=��۔��G�XQhe�D>�|M+�f�+K�N�Bb�|���8�5wZ���]]lǯ������t}�`Y��H���q�l-��u�D4�[Q{�WLYb��W����`Y%[�e�`�[ �Zc����Q?�V�m~��29�g~��-a�r����#��H�m�-�����[n���P7
��
a9�݅K����y.~�,n�Bkt�[W=��{*�n��~�L伭�D��#��B(����Rf�"|RNԍ��M�^-^�M�,&D����/��?SĦ�rϰ�h�r�.v9�E��oӨ4�����mt�dB 4�쁖ڊ���LxU�1Z����ԴJ�џ��Q��g�P
,���Њ*da��𺒖.��� ��X�ׯ�廰�x�^`��%�6�#e��(Xn<��/���1�Q�ò7�"?�6�� 9�r�<G��ͼQ	�o���n�~���.�#�m5_�:!9zmp����'ѿ�|>�� ��"      �   4   x����0����Ll�A�B�u�[�5��U�¨�U�G�D6�j��~۽�      �      x�ŝiz�ʎDˋ����:' ��Lڕ}��}����d C >�����!��#�Ga���h��|Oa���#��H��GL�=r��{����x�Y��E�]��c�ծY�襵�Sk�mڐ�Ϡ| �����}D��aW�a���f��ZC�2j�AZ�7�@x�h�ǐ��Z��Qc돘�)%��K
9����񌟷����4��Z��ծYS���@K��k�th8>u�P������~���Oj-3�<ͷ��Ƹ���n�[gFm�Ʃզ5�ܶ�ң���ư����e<z,�֣�0_�����I���zʦ�=ۨ���a38�n���86�3�9�Y�A���u�3���������{�:<]y�ǰE|�1�w��a�;l~���vZ��)������ϡ�s���a���v�Z�̩F́�ٖl�_g��f�6N����XmY��2���kL���>B�����P�[��ROGI����`ڢ�p���c�ɵ)|�0�7���~���v�2Fc��9�7ӧ�-��w�.��>l�s�.�V&?=��vؠvh�8�[�r2lg�~��k��KӘe��d�Շ݂�/�ӣ���mõ�8��X/YY����d�l���62�۶;�v4lÙ�x��%� <�-eYzG�Kr�y��ɏR����ν-�`C��tN_��e���y���ܾ-�;繉}Ww�w�0�C̏iO}rPm5�ꝳ�Y��o�l� ����2�c;?D;$vZ��G��KN��lSc��_N�ɂ�c�u�1߸+����tF�	��M�e�&&��]��!)�Tx4�3ٌ��$�Q�$�_*G�bװq��	(�v�hO��6�����pe�\����QxHp�J�+���&U
b�h[ʤ���O༥v:@ե_lFP\���M6�T�'�y�m͵/�D��
4�|�3M�v�^d��z��RW5J�\��SmZ���J&s�#�cr��83�Q�Y�\һmw;��ŞMV2ma�Cۘ�-��L���������,�N�s.��G6%o{��ّ�e]�p�h؆�����ԥ
�o�-��s�\�$?�����@D �>��]P�>��4J�9p��ʻ�aNc�h�l���9MnH��
��zZo �@�p�~^��J�.@<��n'����J��lw���X��1�m5�F<��|NϔDm��u�edz��l�蜥ؓ ��һ��a�8٨:v5;�}�&:�i�q  g�Q�Xh(ʣ��E���;�v�\L����|(��Z��e�Ob��$)���د��n�?�m�&��E{�s��'{�3%9L*�U�+a`��cկ��S�}�M�<W�{�_�L���ci���3�n�msX��jb�e~���,�m�l�K�{Xi�1vVڌf3|M�eT�@�������l������S��2yc�f&��E��Є��fvM�a���ޱ���D�@��֙~;��d��d&�n�0.�;�" �Y�"q���o�a���)ъ	���s6�k�`��}��D�9Wy]�k;־٭#{�@&Ai)��S�}p�K���zھ��m��8�&�.n@�sé ���}�+�9���^	��б��0S	�A�EsG�M(��m���<qgs4Llg��ӛ�.�e[x�׌r�(��dL���E9�f�f{�f�9l��E��*�#�u:PJv!gS��uC�v�΁�bk�سfᙙ��V3����1YM��g쯎�4�!�����Bh�K�f���� �����uE�����O���H�m ��!�ѽ��� >�����g��ʬ�<�@�t3��䴞/D�D�ىY����O���:��ÆE�n�������P �,�H����2����a����o�+,c)�a���
�*��|*L��w8���9�Ks(7�_8��|���mW�v�#�Ϧ<���n�Cq27��֌p
���o�6&�t|��~��-�ej�̘�o���0~��n���8&G�2������Tgog��bJ�a�;_�df�b��
j9ʏ�����=�1#�r��a��Ed���i�aV����g눭,�bKf�`���έ��m���6+�9)E��̈́��g�fjsD�t�5�sf�c��3GZar&���fr���0����c(���Lhm��5��3S��C�],���f�3rw4�u�C��YYll�_bO/1������&��n�N��&��2V��Ja]a�� ����B�g�K�J�bl�D�^SP`���"0�1����x��U0}� �)G@������
�q��CP�X��z�����w��`6XҦ���)��������H��e���L�p�5��9��Q������}<���=\2�˂��e�C��kV�FD�#b&y"���Y�#bF�����g�����{9�WGl�h��@.e��(fe��]ĉ�Q3'��X�UD�u"v� �͊	�!�u�����WAߑW  `��-�����-�_3�M`�Tv�2�b�nkr�7�f�,��h�C�Z�UtN:���1��l�;�Τ?�Ξȶ��� w�> ���F�RU������6�Xނ�69c��g{<��A���w��0�FL��>״���I:B4�e�}�ރ3(��r�g!�H�ф��_�=ˤb�w�9�������H�Y���k��6�8CP?�'p5�8O���{����~���'�2�ld��_��s�쏱 �aP��P��k�IdpDp$�b��▛��D��XG�Y��æ�2���H'�@l�^�fd����e����9't�	IolZ�N[3b�j1�~na�����7ȘaK)x���2!B�iξ�D�	�@�(Oa��Lp(�d��Ө�TY{b\����c�p�m�~Lf�U80��H"3�i��I+<���vػͪa{��i�u}ѫ�B383\sگ	�pm2�`���yjm�L#�;x��P�����b��1[�Cnd�_��ଭk��? S�P`j��F�x�IS*�38����f[��FD%cZ׺���������'9$\���
0�k��mL�C,��l�iX/�; ��T. �(T�a�D������؁�p�I
��-0������e�1�93�C���٣�p�\��*�?�Sc��C�%��އ���؈�mX`BzH��%��T_2��L��+r�*�0 �h��`��rR���x
H_+�0b�B$x(�=9E�y���%%�|�k���8���G�4*Y���n#�r�@�e(��"�2)?e���OhA2g.�=F&�`XC'1{��3��'J��l�TE����EnO���e9����q(&��}�U �ᡄ�e�VVה2MdG׮> XY]K��+slw ���T=�fvڌ��/��5��a���2����H�ċD�Y���z`LGn� |��,8��Jb��QDڇ�����Q�6 ��:�`���\�!���N$���G;��D�5PQlF]�+��ݯl���zه���WC`P�F@��|��DQ(��K���=-}Dpƚ�AD+��R-&d�:���%�/��E�6|�2�{+XB��:@"IH��R�BN����;�F�.X5�� T/��A&�]�`X�9?��7}��-I�	��*z8W�ǵ�Iw4R�p'�"e=9�ϯJ�-2ֵeeo �<E���S)��ɭ�k��-CF+�\Ջ`��>���� �
t֞�k�c9[DI�@B�daD3��ar�J&>����No|�YO�XBH�����$�$�E��xH�8��s^K�R�5�$n\���¤|�D�֍���jhJ����:�Z|`
S@�����'��w�%�#j`�p��=���u/?o���~2"�E �Q!�S,w7.��o�Tj(�f8d͞F��x���xݿf�Bd�]Q�=ϖP��]�0����ef䳭��!�C	rz�c����ԔxN:v�f"FY��y��2�`;T���'Y';��-�k�X\�jd ��Aq]�ɫ;��<��z�����V����]�	{*��W[�y�����4�IP��:���p�wJB^ݫQo4+�����C� '#p�7�Åe>����
D��Yy��@��    hǂ0:������y\:'�[GF��P2�1�N{(2�U��Z�A���HH1�-��8�B[�w�P�������(lp5���f�v�rIڌX,���u�x2�]�P�*f�hs�a*(5���L$ժ�$�	�4ý%2��_�ү1�gW��d"%��	V~(eg��3[���p�b��851������T<�O���em�?*�>2��tRX%>o�3א�S�@4�+/�!�K՜���5;��U��=0�{\؎�����g��0�E�?�)�j���5(� Y�[1b�K�w
��(S�Ke������q�i�w���N��A�)܂"�Q�܈f�� WU���Θ[���Q_��5��E�.�^  &�����J��I�z�bċ��E%�e����Z�X%�~-V!�����x��~EL�ʹߩ��� �d��+��Y�Gp{�pЈ-&J5������
��~ӳmA�!�;�H����]%�A�Զ;	^4	�AG����DP�<�6�A��<x�,n�|���1?v�l��Zn-�Ѳ/�.� yQ�����+Ipϸ4b9�Mrx(>��A�}w�,ȣ��;�=(�m�s�&j�r!		�z�����X$���|9�ǋ�U�=(�$�dF8�wv-�u�)?���4��m� ��gor��zTݣ
�dh�v�Bi�	}7J���DŽ|x�Ɨ�;^��Z��Gя؁#�o��귇*���B�����HD좾W6X�Z��|��/��-e�]��!;�DR[�];b�!��Q��2�l��r�z�'x���\�^U1P��\�%Rl��i�7կJ��l�ky�g1��~<�Z�&��M$�cڔ~֩˟���C��I���Ǔp
y���L�� ��`�H�M3��Z��+��ߧ�uB m�~SN�$��L��]�*P쌎.,$|`�jG���v���Z��4ow`H�����B�ټD@�!�r��Ŵd���7}͒§�.���S��h�'Ty��RE\P N�Lz����b�	�#�u���p�}O|<%<���3���/�QBo�C�������;iS�5ǐ\�M>K�|�u}&~�|I,6q鬢���ޒw��0�:H�J$��jJ�P��p���H#4�/N�Y����Kl�P�-�.+V��t�2��@��DcU��Γ򏪗���z~|$M>B�8��d�D��Y.x��$.���I{���A9]z-�@H�J[>a�Q��tN�r��ٞuDo��"����匫��4�|�~(���U�B�}i'�]�[N�H�C�e�B7JW���W�_�e"��KJ\"U��+E����z�3��	��0W���p��g�6R�gY@��]S1b1R�R�����5~�=�d���v!L��Ȓ<3
/Q���F,�k�1�	�����+7�����^L��|����""*��bi���8�H��Ŝ
W�z�4�
���(�'b��S��$�{�r3�C����R�zB��֨
�m+'��j����@�R�.F��m�'�4	�gy��(�������~s6.�����<�SS䢀[d[���Mo&���_���^�Mf[W�@��G75�����}�� SDd��Q���b�'�:��װ�����y��B�@:��7�P��{��t�T�)�h�֮giYh�~��I�r`��?c����X.*�Y}`���-TBe; S�90P�Z펻������X�];T3����7 p��	ڴ�Ϊu:�a�y�8F�`W6���I�5�XZC���Y�;0cE���8wA˥���B�|�L-���G?�A��zZ�M��n�b
���CN	��h+"���<�>�(wM��(�{,���&���$����||�G�t[r�ٿ)F@J���O�w���B� )�`W������I�H�@������@���(RAB��2�ʩ���.@16af��������/�V�W��7�(���G��:�®� ��w��6���v��T
��_-p`�����8A���k�� �4��P��j��e�/���FE$�˓h�L�J����������Nư�z%A⻝�T��&�/��)���S����O|�����F	˴��S Rm�tt����0��+�xbU<��f�*NQ���r��(�%d! �|"]ӳ��u�K׵����YJ�t�IR�HmjCa^���i��E�k�
�*��wk�Z�"?Q�3_0�L"U%�Ԧ 'N�Ռ�rt#�A�x~T�a�̳�K����l�n�_�E	A�ABT�`l�N����:HM��P?�X��3S P�a�w�[��V
���-״�c�M��H��Z=��	Z��r"ѣ������~-��ԃ���*�n�2�Rt����Q<X�`�e�IVHU�C	��$9r\�A��V���i��E�D΢�2���Je)��n��/@�u	/�oIƜ�Dd��A���"�EC6�=ģ+���/��n����2��Zo
��
�?L(�3I�e�������>f�\	���#��w�E"TEF�G�	�CM]Z��l�Ho�k\�6]
^L���vg�*]."b�xR$e�:�$u��ƺ�E�����w����o\!v&y�"^T3���6Ua��R"��c�K�zj����:�bЏ%�m��� 1�X 9R!;��3	��NF8��fv��r�(��#��E局5�	&��*�H�:��?K"?�B��u̝Հ���|*�`f�F�=?�(�V(�.�&<��v$Ր�C5��נVr�KbD-��z(�0�x���G����#ν6�;�x�Ni��Y�KU��
Q�oG�i���#�g�C7��H�?ϟ"20�AC�:d��G�3�'��$�*gx/�@.�8D�xm|<�$a�qb�W��l���i+�s�����˓���;^�ӹ�$%�3Ɲ
s��Y����3Ov Lww̘㰜���P%y5BFT�G�/yH+�1D>I�h�sM�#�9/z*�"��C�[�d�M��4O��BrP�'����#� ��������;0{��<��Jv�O�֎`�[�����.��6S���+��1��wL �d����>&��cs�u�B�+w�c�.Y�Jrj+��	�,'��+�)���4�G�bA��M�,A����@�ƚ-jfg�$��P�5����Q�$@=+!
�!��6��.�n�n�/���}�d�ANK�14�@~1����l�Y�q/'*S�R�k*�UsJ#�MQ.�3s�$h�x�/�]�А���)QlRL��&��:a�*[��7O4�~�@ð"W{�L*� ��`�LX��y�|I��H��d�_!�r:P�N�m�'e�h�kyz��Ԧ�i�PJ���;��ђBq9�%�;k�c C^�3�s%��������&Q�UyB���>�d36!��{����#b��mĠ�!�+�Ή~U��7��,�s� ��;�g�}#z�ɿAÄ��J���_.����DE:������9��h"�E��B�Sv�C/�J8=����ݷ�M�`ZpQ�����<���R�Ӧ����*����C��GOz�>E֫�v��zL'^��`o�
�AɽS=��N�GnN���3_]�����O?(K>Q��8�{�"%U_�٧���x�t�"�~�7z�XԣXV�ț�̓�8��.�hA�A�u�s=4�����$���\UA�f�0Y1A�:�pflvRdb�z�����䥘D�ꄁ�[GoY=�L�����bݫt�&�(ң��G�[_g��o�8���QB�*(RYFPM��Y�hXY����}1A����0�2�-/�O=UO������Ϸ�*ht���쵩�%E��7�>.��x[��)��ב�ʥ_� `piY
�%�gI��]�l��𶮴���F��94��+�G��g'���[����R�οà�pkF���s<|y�
�>�����>���T�W[��9��J���%U{�}�j����/�,��K�#����;�$DjAQQ-�>��m��T���'�t�bXI�U�    ��@F@ܬ/E(�E;��](7�&3����p�
Ϸ1p�š�5��	r����M}��*~��B9x��.�������Q��x��9U��&�*�?"�'�	��\l��:�-�S�C.������H":>��am�r?���E݆ٮo���!fk����w#�I���?T�<W�F�ou?/Pry��/�EdE�������;��+zG܀��C��ma{�1�|ٔ?&�^4�^�:�x$C��,|��I���9;�z�c8�"�*J�h��+j��\��i��2q� |RU1U;�1����7�ax��qt���mmu��W«J��f흜�b����p�yD33��
��N��;��̷.ֽ�{��Tߘf@���uoޚ {Q��ԝV��r���N�7��	����RRʊdW���U�[�$��=�nq�^�ި��@���RsLɷWU�;�uY���Β߷���\<��#�xW���.Q���ߋ����؜�r��V��5��<E�qFB܌&~V4�p�&�\��b��=da�|�Ps�G�DYӳD����038���������1�
f@7J!���h�D�vP�3�^��YM�Y8�ie8��*��PE1���h�ӕ��^�I�c�1�bN/:S�Yc��P9�K�bh�B�/wedja���ߥ�+�-^a����kuWK���l�b5�u���E�"�QM(��1 �Y���N�űv�P�8��H�kJ�/lr�"Ɛa����G�I�n
�Ž�ʈ��Vz)�^������'�s2��bQ,�Y1�u�%.�4�R@��g@���"�o���Q(ߝ%��'�IQ��s�N�nQ6^�?U�j#��\�l�ό"��E5-��#�O�0�.�(�*�^��|d�q�	��É�<�fe�[�M��p�W�u������J~�R&*O{R"%DN.���#�R��m�𢧎dY����W�����*���z�WPR�ب@1S�Ds_�Ij�:���F��f��V���\�1ԓB���5�Is=���2��k�O^Um}7�Ϳ������)��8A�"�B�Ϧ֮}�zR�ܘw1�T�.����r����M0'�+OiБ���2+ӽ�INV��㖰��t�)�����2V��\��b��(~�v���& ��Ha\����`_Viz�'S�F �)��h1*]PJ�*	�t�@���h�o2�:)=��XLΪ�e�J/
��@U���t�
�O��`�z��/M�����2�P_�-��fX[R���b��)e;�:}CgF	�7u�KAE]�uL}{jHE[9!�W<7�j�=�c�Z���"���I���*n(kF��
0FR�7�8^ �u��+���YO���+�߶�{�K�X"'�-E��V��$x=x��'��恍�aG�<\j��f�L�!��3i�m^$���<�$��Z$��5��C�ִk�|���G�R��`a�D�$՜�$�+��{��;�e�\	��8�]����z|��:��_C'�T;���ϔ�nVQ0� �D��c�������9���Y�tlR��zT������K�X�-�{R��j�����Y6�S\*W�����0x�ÂY�k�hIj�;�8� K:�o7���n��_S�+y��h.�������Q�[G�4R��=�/�$*��2R��.]���]&9T�U�4��Y�	r��1����[��;)��G�L�-Tck��9�W�x3�(��&rğDD��U�P�*���_���!����a
AT����|�'��L�m/�v5���lX���.3��g+���QD�I�uqD�����y���m�uLu��*E¶�dE�:�*/��'d�v ��(x�� ��I̷�Lr��r^�Z���- �Rh��'�{-쐯�ti��BC~�Z�*}o?Z$���f2{P�׃P�~_W	���C����Շ�r�����x߄$A}l%]��ǷuuE�z�di�ܜ���S?���ڟ��o�<��W�������BuҎ]����8�L�wbӹy^�y��J�&� 2�o^�&Q���Z����f^��X�3=C�YduB��szk�o_�(���|Yt�RB�3�o_�nK��ll2�Tp���E��ռ�u�gו�&�G<��� ��Iڿ*9jPOZ�U�o_��;O��P����?^�m��J%1�@��淯#v�Y�/�7r���N��u�R%�g<r#���/鮐�rp�B�y+�WH����p#�^�l�����y�A	�G�x9��Rp�C)�Ĳ~�ZGqR�ˤPrZ�?���I�3x1+
*�D��Qج>{�)bRN�V�'����n3ҩiRmk��6�w���.')���܇�1�i�םtD�x��n�)��wnW@_�U<�%��v�.��|؂�sE!���nIE��,M|�)GE���ٿ���`;J��^�;�ކ%�zû�G)ܪ@-��A�c�#�w�!jS�zXL�l�#��o#����a��
�"/�����M�R?�-Ph*B]�ɺ+�x7#@��B�|L�Z�r�3��B��*șE� '}8�;n�[ySY5жlM�Q���*<n8�Lr�]!z)���Xt��:��Z�����ng5�Ϩ�!145R��QŁOx	3��6Ӛ�P$�6IyfQ7��ҐB�9�Q�9�UJ]�D\QtR��bC��c���s�����r�n�R�H)_o�)25���\)�Jr��V~fSX%pި)�j E���$����a<����\������� +*yī)���@V¹�D���<��<[B����B���U�%��9p"rSQe�Ĺ���%������]q�Xڏp�(H�7LӼ]��E���4�NvB���y
b[#�� f���j:�ٓ+���dM�3"��r!��@V<���W�Lir�r�XS-j�Tҕ���%QkؕQ������������6Y��eug�����Ѫ]{¦�Up���V�w�:�*&�Bu�T��}�z�����F>��H�ڲDrHJlDXgS����N*iK!({���!z�;[�=���{��|L���]�Y�b��NW�Ԇ�N�Yf�n9A]��_0M���HFRh��=��nW��c%U#�16M���ב�C��)�1�I������ս(h��3��i'P��ƪ��.J��}8����¬h�F=�u�m7A�w�*�#-M�P�gP����1���r+!k�m�ZD2'�D��K�&qͫ[�uS.�NLX۷��V,ke6#�5Oǭa`�N[���Q���Ĭ��E࿎\�r7^E.����"�����o��jr�F�tMuZ�M����E��x�Ud	*p.r[a抡jz���l��|�y�
��݂,�M��={[��gU|EC���@�h�X����r�g&�oc���{�Т�9��Z�Ue�"�0o
{�J�)�N"�jǺXj3x�##��C�Q��w ,*�x��Q�GK31Ӫ�RTV0ib]��e*e[�r�=$�u��A+{f#�G���D�5�J] �h�E����\�*�n�˅����:��@<�6��S�|�Q�r2�U)����ȭ�K<�W��l��E�܅(���E���G �i�=�(���^P���|��y���9~D-J]�D-�M���	�Q��Т�mТ�g�Dm�����)��l�N2��a�Q>،��}rE."��P$��<eVy
kP�R�6�2J.NL���!��>�$�xH9=���0 �q�i:�f�G�yߢ�z�!t�w �٬�*ő�;��gn!4 �M����O��AU�n�US�3�Ŵ��ȏ�*t^�j8J�A��"�x���b��j���Al�4�Xl�&|փ�T"��ԓ���s�^1�)�ZLP��݂��&�!G����[~D�:\�ne�Ӆf6�k<n��
I1},�*C�s\�+�,���g��@w3��X�Vѡ��)� !\t@w'Be

L.Q�墢i�� /)`��	;�f�V�qڣGNdhE�;a!����9$"�2e�U�Z��-���2��B�ٖ�V �  :V��T�_V-��*��P�MpU�6z3�RU�E-���z���xOd	@�8����u<�z?�-J�(c�OU�5�ݏJI2�Z:�XĹ�_ ���함JJ�ܦ���d^;W��_D�ɑ�xUv/�b:U,�¾4D���T�c/��N0X�� L��t�B���e��R:��t	�}�b;��4�?D#�\���w�]x~��r���'���v���������R`�D���蕮As�<�P�Ɨ[�7�P�Sd,/b��ȉ�VR65�$Ӆ��tl�r�(Cbf�DZ�r��G�Gu�"��_��$8?���
B��� !�s�V��F*�Sa���:�4��&Ћz�ǳD4e�n7G�� ���.@�Z�.*Z�f
h&��=�����BDe���b��⍃�>���C�|����)�bW≴Ƞ(L�Z�^v2��V8��(�?��%�Ջ�� �2�Թ��#.�%�<��W@<��:�;���ț� )`��S�8����9��O���r?�9,Bc�`$xL!�#sV�����N��WSZ%R�1:�T:QkSg�z);SDBҿBk���J�F�y^��Pe�|�[V�y�u�t��$�!����`�@MG\:W�*(�]�Ƣ����`���IDg��Sb��4�����"��.�?��;�F�G;�4��N�թ海h�B!�p���S��8�;�Is�S�Qò,'4)w�{M�	�Pk=��lK���)e1qg�H�S�De.],�x��ο�S��1�\�6����
�1|�1��w�jۊ���F�U����j+)i(<�2���U󾋈��P���V�6��Pڝ��y�������=&$�)�n���u�Q�+ ��J�������@9(��Qx�7�������s�֥$䰽�b�No���@�5��q���	�����F�;P|��T��;�5j�S([�_)'�n��� ��9�S����X����P�_�n�����*&�����<��q�q~��F� ��<upFH����d��%�� ��t-QQ�f3t�^r��!�+j��Q��I�?q��,��x�ztՆ;^�6��J֩K��yKk6��H���S���婚�U��}auJ���x��,��K�_���@�9WT���ja��M����}�BՋ|��5�rh��`;�HM=�ԆM<��u�Hg"I�[��w��jì���,�bT�"�=&�_ ���D�$^Ƭhr��%9���z�*�6
�x!�^�̇�my%í���*]�� �A���3�WU��@���X���T��Ϊ2,(�W]�}Ea5Jl`�KK~D��{=�͘���*����P~����	`��/Rza��$����M�)������Z�Rߦ����u&y9C����<\��v��;��ұ����D��i9i�E;Gv���f�>�)G"��)>+KQ1O����9���Uz��R}�7CȊ�xʄ�sI��f�WQ�,�<5y��W�ш� ~��إ�&aY��l�hU���k�1U�k��BW�i�f @��U�h�5����ӹ�y��D#q!��0N�
�%Yi�zF"��'OeF�xb'u���Mu�WQ���G��z�u�yeYUk�y������*tu���@(7)�K��`�}t/eP�3L��fq��@:C�8jځ|N��[��ƫF�Z��+�g�!ĒvJ�_٨Q�x	����P� �Y�x�@S���d奝}>�oQkֱ^�\�y(��O�6��њ*�ע5!�.��_)��<�V��=�<)�!ߺm$�.�I�HZ�"�r����Bt�P�b��IO�b��ߑ�	�����]|E��V�ŋ�8x ���,�T�trE����1�B��GrF��3U��+���2����+|�eR~��dEdU�,����-BK}]Iq��H.L���%v3 @a^r�f��1�p�Q��B����9�M���Vu�*t����)��}��F<*S8{���ş�&=�h"�S����l�Z}ď@bS���k����V�&ӗ�`9m�=�(�2�A�Ē��#�����'��kqΩn.N����0j�H�M^~P�4��&��KKc%KS���.�=�9�om$�595<�US�+��P�:n�����~=6�lLA��^�9��ȞE�$��+:���dA5
�AQe�����$QS�x�����p�*ސ��L�����<R�T2&��(�\��9�'���wrɢ��m1�2�tMH���|�L%��)='<�4:������@�E�?(rq��i��?�̲��� H��$-����(�@�f�����!y��6�0�Lb�\+Ux�l�V�|r�F�t��dDD)n�Ey�
�W-�q9B4���Zii�����7�3� x���%
oW��N2��I7fz^�[��K�s��qMm��4o��(4���
X��L�Y�,�xu�P�ғ��z\%X�ts���-bl�ʽ�$KԤrPeՂO4b���-�/彿֮�v=���[��C������rQ턃����EB�B�*@�&r7�
��WGYݧ}ͨR��f�����@�w��F�H>��tL��q2���˭U���ٽ�l���1�g�̧uX	�}42���Ӗ�'.Yi���y�w{�kT�Ɲ�c%~��.���)'�A̦� 	�!@E�4�3l��t	�͚����D�xףw�O6;����Z槾��]�+$g'�xQ�j�kZ��2
�(��v8�
���rG ��W��qNI��PNʖ��.4�\?�z"���f�-�E꡼(���rm�,RX�F�TRc���JR�$V���:�;���Y���>z�����:����A�&��L�,e7b���E����2I-�!&��5%�?F���fX����=���Q~��̏��M��<����N.^i 2f�p줟�=�	�nU�F��S� 7
��I�>�3Q~UYSXGi�⎫0��j�e�SUjb���QQT�,Ӿ$�x�D����pz�[��y	,I�j�벭(���zzw?qŉ-8A�^��ND���^�x��"m�yz�l��������Cxn��Mٞ�#��{���=�Jz���nٞ���x̢*����>��0EF%��!�� ��m'ﴅZ8�-�['<ʟ?=CxxIX�NL�ċ����J�H���BT��9�2L�r��:�'�WU������K�o�	�v������$
,�1r]�p�=��Jr�2�z�� g�W�k*���u|�'�Y*�W�(�JGP��ϯ;k����*�f�����Ѕ�IK�%ďE�R�	���)����ĳ�9yC�Z���2=yg��7T8����)�>yCS���	yC���W��j~���M򆪂�ߠ*$�*��T��X�8�2�<�v�5�39����[3-wm[�&�(��1�T��BX�䠼��J+�k�B�!9q�������M@lR�a��/����F�be�0�݌��}~�T���J�oY��>3�I4 ��_�v�7�.���JR�!*����f^�kQϝ���̛?�>�E��� /T����O�x�jG&OQU�G�����y{{�_��c      �   �  x��SMk�@=�~�u$�R��e\mȢ/�������\�KO���evETՁ��ޛy��y�A�b7����5��������D���%B�������e1��05t�s!�f�^a���x(s������0�����>�����Tk��D7E�u�6O�D��@d��jeG���Moè#&@ �wY�QS�l�j[��cEv,�XT��5�%�^�KǛ!:��Ş��O��u���g\
�^�/>2@���L7���_���+%sCu�{��H� 2ы�>��D�d�nT�]r�ƪ�َ�3�}��z�M��^0��>�e���VT5�M7HU;���+ꅭ�aw賦@����W�(�[ܛ�`"�u��΀�G�������3�@�Q��^b�!��k����G�����_�n�6j	����X<c�D+����y%>�r	��ji��<9�¦~�ҹ��8�;��5�      �   �   x���K� C��0#>�w���cC5;wA$ԇ��1����{�����OTe��5VS���ve����	��K���Lii����r�f�,M�h�����H��x �wB�U��*�R��גp|cN$�0?����+����zW&�D�O$;`�1Zw��ٖd����#���D�B���,�zgF�M����ƞ����SJ�zf��      �   �   x�����0��<L!үd��?G��� ���!��ȸ�3�9�{�#��w��g�Y�e땠���FbVb�U�i$v%���*���]��H �q;T�.P8��R
�)�TH*��U8X!�p�B^ဥ��K��#�KG�_���~Zk?�e�      �   �   x��ӻ�0C�ZF�8�]��s�bz6✊F�XQ��rE�2��9�Oe�{�٘>O�Ƈ�����w���O����c���hojPWxm���-or\�Ǖ^#(�JT%x��L�2Q��e��ZX+�#��yo�c�W-�*      �   �   x�mл�@јW�q�:�zq�uX��$$���T��5˵j/��5�N��:m��N��i�tv: ]�NHw�һ�vSS7��r�(�D����X�"#�QlD8���G�9@"!G�$����z���1�C<S/      �   �  x�MTKn�H]W��'�r)��$� �g fӶ�A�4������
�fVމ�׼���6,6�^�zUV�Uh�9����ڋ�K�����2V�-p���o����	���.�bM����>�bG�ޕ���}�51ǧ4�L�-ɳ��y>�e�$
���=��=yҊV�8�#9.���n�-�WT�y��(8VB�K�d�IP�el�SS)�#��@x�A3����G�+OG���RC
��U)ĺ��-�gU�q[�4�2��O�
�_t9���Q Ԧ<@8��-d�? e�ĶF2֖
�>O;`]��J���c3�2N� �����PS��-���)w52��@�m<̧�Hڰ)�t��{��Y6��%6If�ؠ�Z4���v�� ��l�c#�|����~6A;>�\�,�8:��ίoG4�*6� H�I
�	d�2�ܟ�CŦ$�������2Wh�<<�<F�c��.}�v�g[CVl��OY\���ގd=[4}��:._(l=	$4�[䄆��~��\�֫~�u���#�D�2>;E d_�g��\���b�	�t������E�u�����!�Ϙ4�y��w �����ϯc|��a�-��6��p�@�M�0~��]E L��y�i��}A hl�< d{M ��D���! $��/�
p{K~�/	��Q<{���˾�5�aG�T�-pחt)�&��2�}����ĝ��9�"\oR�p:�;k������(���cCܠ��`�Oo���?���9X
�=�&`�p�������M�F�T�����p�m�D섂CI ����i��*4L�����y�e�ZE��`(�ť0�2�w��_����*l��ã\����=���H�k� ��|�/�D&!�2򰚂�E��b���+�A,��KK{�w&��x!�������J���{�ڭT '8�y�b_��@Ow�$�Ua*�y��XK��Uݥ����I�6�|la�������X��%      �   �  x�%Rɵ�@;C0���2��1�b�X
LҤ�%��/4�R�ךҋ�Ғ��D�'={&jud
�WŌO��Q����t�ߧ��Im?��UC�wDO�@j42 67�	�9�A��r����?����,\�������H�1Q룶�,���_�Oj���f�՟��1�|k]�1�8Ku�U����::u2���NO��KƠ�����P��.�ֽ�[���5hm�gA��8"6�9D���1�~�����>a&�D���AL�C,��h�0R�+��O��94M^�ٸ��C8�_�������ů��1Q컨����r�C�a�S�^.�X��L��bZl�*,��t)�c�<�>b�3�9$��ip�ô8��n���N��q�C���h����d}�8���u1Rҏ�M�3̃"Q, X��OU�;��      �   �  x��[Y��8��&�.w����9 n��g5�����TF@X� 2��_.�H�_����~1��_��/����6��(�������.q�%�\
ǖ��/���[��j�-��������T�5hfN���^�gk/���6}�Qߏ(q-RI$_�p��I�1q�]!	�c�9R����ݮ��1�aU=�_�x �/洆�_�� )xG\bIR�#��H9��G�7����1�6��{�f_�تU�df�_,=�Ç�|����"��s���\I�M-��F�\�Rk��E��Z��G=ߝ�/��Q��ٿ���<�2r��Yq��_�|ţ��Ra2S�?e~�Qm0RF�OF���<���e}�ɚ��n6[���ܯ4SU���'5��gD.�B_�s���Ș�-W�=�ќ�zګ�s��Ѵ�Np���-u/�D��-	e��D��؍��XkG���o�B�&���W��#��`�s��[խ��l8)xP-0!Y��a�ca_A�ג%�Ѐ���������ҫ�B��eeߎ�;
2Љ*E(��N�{H�L���SH��9e�ж�]�4��7�-�D�0oAOA���R
�5�X?A2�*�Fθ��+� ���,l��qRF�-�0[�Me+`r�5.��#��CF�%VN)jR$^�Q�Y*�^3�ZǕ��νf	��l��j�1iWj�^����	ku,Tk�̩%���Du9J��K}�{��ގ�yK8���`�؛�C���� ��"_nET��[��5GR Cc�Bx�I{X��BC�*����m蘗f.�ټ���n�w53�
��2Z�%�� 6j���)�|���]H"oټ�Y�_h�@�{f%t�����U/q���X�6��M����u���j�O����}�v���S��y��yT��A<8[E��*X\<��� �P�OH�xl�o�B&��W*pO`r?n-� �d�x':J����.���X!��%�<��q��^��S��	����܊�F��ғ����[�Q�pe�f%vBV��&!t�j!o�[�=��Eѣ�!����FݭD���E}�m�q3���,�%3�e0SX�8&�,f��QQD9+n����<#;�Y�3U�7囂�[�#�J�D��o���&_����f4x���@T"eP�"��2�NF��KtU�f˜�� ���Ex�y�v�w��7Z8)��6��"0�Z�P��A7V�zB�G�I/��hh��J7rx�E$���sb�wl��~q\TMV�|���y_�Zf�F;��K�����ٙ�.��Fڌ�!E{�mE�N����4>���x��Eƍ6�i��N�-VRG�wELZ'蚠C���֧~n��nM����=Q��ڻk� �������k�Dv�7&��A�y#��:(]� �J����:K�&�yt�6��e�L�"�`��c�����wEj��I�g��T�%�p�ͦ\�Vl�D=����Q�����y��nF��K)�Ҡ9���5I����g��P��������e��1տn]�:5e:"l"� &sϤ�	���p��B�&v���%�ƓG�N������,��'@� 2b)�&��;�8�9�$9�j��&��f�S�]M�ZqV�-s��<��fg�J����35��*��vn	�J�pd� 1m󣢻3Mw��NV���c�S*�t�7E���D����$T1��O8�V|��|��i�w�ށ����_��6Q��O.�qBR5
m�	�L��M�[�8)�qh��˩z�:�M��yς�q;C�B�E�X�������HB�$G*j�G�x�6�5�4!�L��Rf���)7GG�R݀�x���@�x�?��� ����Y������Fiq�CQ�oR)��zpm������T���?��9���w�2D�̚s�rm*lφOP����ʰ��*�MHqIF�zHM��><*�x�j��<���Ax͑u��U�
�F����C
�lr��7_�ǵכ]������4 ��s ���kp���F��r��q�a Чz�	I�N��ų)�i�P�SĹ8�����wR�������/Id��@j��͖O]�q_Z���d\�hp��R4���V��p���f�x9��-œB�$�N+ȸ����}����s}lӇ��z�SR�IkY X�yJLA;��y،~!�?��8��.7�b$cp�e�Σ��~�b�H�qr��G:7"6@��ZnTJ;�㏱#7�l5�M�[�殣�Cm�yԒ��M�Rsu-M�� D�8����[��F�q;Q����B�����[��"ݘ���3����N`6�Q�p����w��u�y8����5��Ő$q`��(]�T�RԆ�U�}�?JcSn>mY���� �B^ȋهE�;i�ռ�T驙:!���]���$Ŋ��˗�k�R�I�æA�k�e(�	�?�ߗ�T?TP#mA!���l>��	 p���)�G�=OX��Lv�xH��'?/&��D&)�n���_,�@�~J2�H��pOm>���Y�~�%yN��8�Ϣ���TyM~���*����"�|���	I��7�����N���:E�x���C��7��A�R"��:�IÀN-�J&Ȝz��� �QȘB���u��4EA�g��̘jDH����aW	�,C�F(H�� G���W�n̴Ыm��w���%Z���|;DF
��wNhB["M�`�����R��׵a���۔Ŭ\��g��:�V����>�k�6��hQ���0�p^�_�9�V��=������?zG- u�i��~(@��d���V�y畇�o�ق*$�-�V0l�XI�$>c��8����!�j���x4�J�l�b<m�`����;9�q�y�p��M·��R��J?Q�L�V���X����uB����'JJiC7��9��>��$=��gS<�>�E�����f���ۅ]�{���.������,�v��Y��v�i������NO�m�ٹ�ƚ	��X�����9��҇O�F� �W�,��1mED�d;����,�?h�5���X��{@y8�Ƿ*�'o�3�xJ�X�D�'w�	�4��،��ϑ��˹�i�a�ݨ�%`���t`��������3}Q̆�fe�$6�>�iO\�5e�͈f��`�g��4�'��@P��=�~ ؈ I!�	���߸,Q����^J�.���~����}!kl|z6pcihֱACr��{A(�!����F�N;.�ŗ癭F-��qS�k����u�~BHl��)F L���w`L^�O	�q��nW!3u�_Kwn����vZ���nq*pൠ���(v,��gh���[��<0}��I�î���p�%[-êV�Wy����m���Z8�__D��ᷘZ�w=��_P%�3ھ�Vjkث�����~QG+���E(8�Z��*3�`�CƟ�����k��������cc��,�~�g�䖚tU��E�IA�)��j ���i�5��5������s��q��v �}^��T��^���:�������$���<z����'�0_0&�9�(*>�A~m֞n]+~b�ˡ��^h�$T̸����lͺ�S;���1�֐q�=��53:M:j�Y��ͱ4�3�ۚ7(��dt��|�� ,탦�n*�Z��E+K���N[��-���پ7*6�c��}79��Ƃ����F0(P���L�6O�g���6P��	�y�˩��(�1 ��\ / l������:�@�a�-�(H{n��jM�3���:K��#��'r.���hq|�+i�~	�j;�8M�N��z������Q�5����V:�w��@$$=.ζ����.HL0�T��j���yԐ�X�#�x������D2G���>�#�2��z�wX�������$�LG�mR��x:�v�\Tr�mDq��|��(߻2�W<��ha�V]K�.zf�T���,���XnVpi�"t���-9An�rA��\"/l1[w��|gT�5�|��g���+H�X�љ�H��~�]�#�{u��w]��L��^      �     x���Q�$!D���t*�w���c!I��ߍ����.��ȧ?�>�����5p�W?��?���]���h\��z�5�D�M�g�7��Wv�n1��/cj�����n���y�9bj��1ӌ�G|�O��x}�YCg���<o1.�[~��ZL9q-�K�ݴFk� �ת!q��?��oi��|e�j��j#?º��D|����:L�����e��4:��������qVo��|�s1�C'� ^{�U#w���+��h�)����
VĦ
���!ύ�����{��k\�̘�O��/��r��U�ɇ��Y|���!�4�*8�>2���[�^q9�le\,��č~����8���𜂌���u��m��K�<�K��&D�|L�~�����޵�6!hr���N2�k�b{mA�z�&N�0��uKs3�7|��]�������W�r<�t��=X,, u�L�t-L�K�Z;f��l�hgL�:��g�h'I��)9YG����N�\>���@.+�,�E0�.əi�l��Z���&H�dS��F�	H#$���u�٦�쮣2p�0���:�뇗����xT|'6��t������̶�#i�pW٬�O�f�ĭ�!��*���y2or�F���N��Ypf�)� ����JB�-��W)�b��7���Cɽ0�pr�����{%���U�u5��1��:�E�Q�����'��ボ�UhQ���j���5��>���[��E(��Ӏ
�x�q��pڐ�:-m�Ht����OI���J��|Q/o%.ğP����ƍ��7���g�'��n�~^f],�W(l���N��f�Z��nO�+�yd�}�A�F�s�w�2�UaQ�؁�z"2� uc3�������d����W\�$t��ZoTl�
ǢU�:dg]�6�]<�g4���!���0����=�^����r27_��O�W��Y������ӷͫ3^�T�v�n0m�\m��YA|���- a4��� '*�o�6����ˮ�};��.�*K+Y�$g���n=�u���݁��(o��&Y����zA�ܥHԁp��o�6�W򦃾���lP��x��WS���?ܩ�H��+v���DM+%J��{-3!o*8oQo��3=�>�Fl���z�3� �4E37�SPԄ{ ��M:��v�s@Pt�~<�eC	��ʧ�����L��54��#IB��Dc��h��3u6$�0Y���+�Tҥ�!���^N:Ƿ��oJuS����A?��Y �III�b�`#Y�V�qMt�}��&S����f˄U��n��@�"<J):�̵f�� z�C�mm;4�$`�^�j�F�l�r���P�=�V.U�=�#Yv۔yɤ`yx�a�#=���2����40���Sq��v6��jv�����0��z~����
�0Cu�rV1PB�t*ڬ7s�Ț�c6k�0x�q���2�i�}�5��������C~ڊ�D���:�;�_rp���>l6'u���B���Yt4�D�ɝ}G���jQV6Z�6���\'y>����P5%�U��wc��ݜ�y�-���Y5ha����ز1�Y't�WH;���f;�������lҜ��ݾZ�QV����
JQ&��|�U�C�,'2��1o`���9��uO�cR����}��u@r���zOXp�9Kw<Y�(��H�z�L��A��o#��}:�@��	��:��q��1Y����:W�E Wg�ď��V���ϱ��m�xʺgy&�8�]p�2�aGt�Gj����9-�      �   �   x�Ŕ;!D��0���w���6J�>#@��9\���EC-����[]���}B�~�{��~��^Q����g\.\pCӀ3���<15����A����h�DN	:�%�C_"�1&rO A��DchLd2��D�P��f��5���eN�_д_���R�a�l�     