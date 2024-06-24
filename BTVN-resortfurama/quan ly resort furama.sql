create database resortFurama;
use resortFurama;

create table vi_tri(
ma_vi_tri int primary key auto_increment,
ten_vi_tri varchar(45)
);

create table trinh_do (
ma_trinh_do int primary key auto_increment,
ten_trinh_do varchar(45)
);

create table bo_phan(
ma_bo_phan int primary key auto_increment,
ten_bo_phan varchar(45)
);

create table nhan_vien(
ma_nhan_vien int primary key auto_increment,
ma_vi_tri int,
ma_trinh_do int,
ma_bo_phan int,
ho_ten varchar(45),
ngay_sinh date,
so_cmnd varchar(45),
luong double,
so_dien_thoai varchar(45),
email varchar(45),
dia_chi varchar(45),
foreign key(ma_vi_tri) references vi_tri(ma_vi_tri),
foreign key(ma_trinh_do) references trinh_do(ma_trinh_do),
foreign key(ma_bo_phan) references bo_phan(ma_bo_phan)
);

create table loai_khach(
ma_loai_khach int primary key auto_increment,
ten_loai_khach varchar(45)
);

create table khach_hang(
ma_khach_hang int primary key auto_increment,
ma_loai_khach int,
ho_ten varchar(45),
ngay_sinh date,
gioi_tinh bit(1),
so_cmnd varchar(45),
so_dien_thoai varchar(45),
email varchar(45),
dia_chi varchar(45)
);
create table kieu_thue(
ma_kieu_thue int primary key auto_increment,
ten_kieu_thue varchar(45)
);

create table loai_dich_vu(
ma_loai_dich_vu int primary key auto_increment,
ten_loai_dich_vu varchar(45)
);

create table dich_vu(
ma_dich_vu int primary key auto_increment,
ten_dich_vu varchar(45),
dien_tich int,
chi_phi_thue double,
so_nguoi_toi_da int,
ma_kieu_thue int,
ma_loai_dich_vu int,
tieu_chuan_phong varchar(45),
mo_ta_tien_nghi_khac varchar(45),
dien_tich_ho_boi double,
so_tang int,
foreign key (ma_kieu_thue) references kieu_thue(ma_kieu_thue),
foreign key (ma_loai_dich_vu) references loai_dich_vu(ma_loai_dich_vu)
);

create table hop_dong(
ma_hop_dong int primary key auto_increment,
ngay_lam_hop_dong datetime,
ngay_ket_thuc datetime,
tien_dat_coc double,
ma_nhan_vien int,
ma_khach_hang int,
ma_dich_vu int,
foreign key(ma_nhan_vien) references nhan_vien(ma_nhan_vien),
foreign key(ma_khach_hang) references khach_hang(ma_khach_hang),
foreign key(ma_dich_vu) references dich_vu(ma_dich_vu)
);

create table dich_vu_di_kem(
ma_dich_vu_di_kem int primary key auto_increment,
ten_dich_vu_di_kem varchar(45),
gia double,
don_vi varchar(45),
trang_thai varchar(45)
);

create table hop_dong_chi_tiet(
ma_hop_dong_chi_tiet int primary key auto_increment,
ma_hop_dong int,
ma_dich_vu_di_kem int,
so_luong int,
foreign key(ma_hop_dong) references hop_dong(ma_hop_dong),
foreign key(ma_dich_vu_di_kem) references dich_vu_di_kem(ma_dich_vu_di_kem)
);

alter table khach_hang
add constraint fk_loai_khach
foreign key(ma_loai_khach) references loai_khach(ma_loai_khach);


use resortfurama;
-- Cau 1:
select * from nhan_vien
 where  ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%'
 and length(ho_ten) <= 15;

-- Cau 2:
 select * from khach_hang
 where  year(curdate()) - year(ngay_sinh) between 18 and 50
AND (dia_chi LIKE '%Đà Nẵng%' OR dia_chi LIKE '%Quảng Trị%');

-- Cau 3:
select KH.ho_ten, count(HD.ma_khach_hang) as so_lan_dat from khach_hang KH
join hop_dong HD on HD.ma_khach_hang = KH.ma_khach_hang
group by KH.ho_ten
having COUNT(HD.ma_khach_hang) = (SELECT COUNT(*) FROM hop_dong); 

-- Cau 4: CHƯA OK 
 select KH.ma_khach_hang,KH.ho_ten,LK.ten_loai_khach,HD.ma_hop_dong,DV.ten_dich_vu,HD.ngay_lam_hop_dong,HD.ngay_ket_thuc, 
		(COALESCE(DV.chi_phi_thue, 0) + COALESCE(SUM(HDCT.so_luong * DVDK.gia), 0)) AS TongTien
 from khach_hang KH
 left join loai_khach LK 	      on  LK.ma_loai_khach = KH.ma_loai_khach
 left join hop_dong   HD 		  on  HD.ma_khach_hang = KH.ma_khach_hang
 left join dich_vu    DV 		  on  DV.ma_dich_vu    = HD.ma_dich_vu
 left join hop_dong_chi_tiet HDCT on  HDCT.ma_hop_dong = HD.ma_hop_dong
 left join dich_vu_di_kem DVDK    on  DVDK.ma_dich_vu_di_kem = HDCT.ma_dich_vu_di_kem 
 group by KH.ma_khach_hang,KH.ho_ten,LK.ten_loai_khach,HD.ma_hop_dong,DV.ten_dich_vu,HD.ngay_lam_hop_dong,HD.ngay_ket_thuc ; 

 -- Cau 5:
 select DV.ma_dich_vu,DV.ten_dich_vu,DV.dien_tich,DV.chi_phi_thue,LDV.ten_loai_dich_vu 
 from dich_vu DV
 join loai_dich_vu LDV on LDV.ma_loai_dich_vu = DV.ma_loai_dich_vu
 join hop_dong HD      on HD.ma_dich_vu = DV.ma_dich_vu
 where 
	DV.ma_dich_vu not in	
    ( select HD.ma_dich_vu from hop_dong HD where
	 (  Year(HD.ngay_lam_hop_dong) = 2021 
		AND Month(HD.ngay_lam_hop_dong) IN (1, 2, 3))
	)
group by DV.ma_dich_vu,DV.ten_dich_vu,DV.dien_tich,DV.chi_phi_thue,LDV.ten_loai_dich_vu;

  -- Cau 6: 
select DV.ma_dich_vu,DV.ten_dich_vu,DV.dien_tich,DV.so_nguoi_toi_da,DV.chi_phi_thue,LDV.ten_loai_dich_vu 
from dich_vu DV 
join loai_dich_vu LDV on LDV.ma_loai_dich_vu = DV.ma_loai_dich_vu
join hop_dong HD      on HD.ma_dich_vu = DV.ma_dich_vu
where 
 DV.ma_dich_vu IN (
        SELECT DISTINCT HD.ma_dich_vu
        FROM hop_dong HD
        WHERE YEAR(HD.ngay_lam_hop_dong) = 2020
    )
    AND DV.ma_dich_vu NOT IN (
        SELECT DISTINCT HD.ma_dich_vu
        FROM hop_dong HD
        WHERE YEAR(HD.ngay_lam_hop_dong) = 2021
    )
    group by DV.ma_dich_vu;
    
-- Cau 7:
-- C1: 
select ho_ten from khach_hang
group by ho_ten;  
-- C2:
 select distinct ho_ten from khach_hang;
-- C3:
create temporary table temp ( hoTen varchar(45));
insert into temp(hoTen) select distinct ho_ten from khach_hang;
select hoTen from temp;
drop temporary table temp;

-- Cau 8:
select  month(ngay_lam_hop_dong) as 'Thang (nam 2021)', count(ma_khach_hang) as 'So khach dat phong' from hop_dong
where 
year(ngay_lam_hop_dong) = 2021 
group by month(ngay_lam_hop_dong)
order by month(ngay_lam_hop_dong) ;

-- Cau 9:
select HD.ma_hop_dong,ngay_lam_hop_dong,ngay_ket_thuc,tien_dat_coc,  coalesce(sum(HDCT.so_luong),0) as 'so luong dich vu di kem'
from hop_dong HD
left join hop_dong_chi_tiet HDCT on HDCT.ma_hop_dong = HD.ma_hop_dong
group by HD.ma_hop_dong;

-- Cau 10:
 select DVDK.ma_dich_vu_di_kem , DVDK.ten_dich_vu_di_kem from dich_vu_di_kem DVDK
 join hop_dong_chi_tiet HDCT on HDCT.ma_dich_vu_di_kem = DVDK.ma_dich_vu_di_kem
 join hop_dong HD on HDCT.ma_hop_dong = HD.ma_hop_dong
 join khach_hang KH on Kh.ma_khach_hang = HD.ma_khach_hang
 join loai_khach LK on LK.ma_loai_khach = KH.ma_loai_khach
 where 
 LK.ten_loai_khach = 'Diamond' 
 and KH.dia_chi like '%Vinh%' or '%Quang ngai%';
 
 -- Cau 11:
 select HD.ma_hop_dong, NV.ho_ten as 'ten nhan vien', KH.ho_ten as 'ten khach hang', KH.so_dien_thoai as 'SDT khach hang', DV.ten_dich_vu, coalesce(sum(HDCT.so_luong),0) as 'so luong dich vu di kem',HD.tien_dat_coc
 from hop_dong HD
 left join nhan_vien NV on NV.ma_nhan_vien = HD.ma_nhan_vien 
 left join khach_hang KH on KH.ma_khach_hang = HD.ma_khach_hang
 left join dich_vu DV on DV.ma_dich_vu = HD.ma_dich_vu
 left join hop_dong_chi_tiet HDCT on HD.ma_hop_dong = HDCT.ma_hop_dong
 where
 year(HD.ngay_lam_hop_dong) = 2020 
 and month(HD.ngay_lam_hop_dong) in (10,11,12)
 and HD.ma_dich_vu not in 
 (select HD.ma_dich_vu 
   from hop_dong HD
   where  year(HD.ngay_lam_hop_dong) = 2020 
   and month(HD.ngay_lam_hop_dong) between 1 and 6)
 group by HD.ma_hop_dong;
 
 -- Cau 12:
 select DVDK.ma_dich_vu_di_kem, DVDK.ten_dich_vu_di_kem, coalesce(sum(HDCT.so_luong),0) as so_lan_su_dung
 from dich_vu_di_kem DVDK
 join hop_dong_chi_tiet HDCT on HDCT.ma_dich_vu_di_kem = DVDK.ma_dich_vu_di_kem
 group by DVDK.ma_dich_vu_di_kem, DVDK.ten_dich_vu_di_kem
 having so_lan_su_dung = ( select max(max_so_lan_su_dung) 						
							from ( select sum(HDCT_1.so_luong) as max_so_lan_su_dung
									from hop_dong_chi_tiet HDCT_1
                                    group by HDCT_1.ma_dich_vu_di_kem) as subquery
						  );
                 
 -- Cau 13: chua ok
  select HD.ma_hop_dong, LDV.ten_loai_dich_vu, DVDK.ten_dich_vu_di_kem, count(HDCT.ma_dich_vu_di_kem) as so_lan_su_dung
 from hop_dong HD
 join hop_dong_chi_tiet HDCT on HDCT.ma_hop_dong = HD.ma_hop_dong
 join dich_vu_di_kem DVDK on DVDK.ma_dich_vu_di_kem = HDCT.ma_dich_vu_di_kem
 join dich_vu DV on DV.ma_dich_vu = HD.ma_dich_vu
 join loai_dich_vu LDV on LDV.ma_loai_dich_vu = DV.ma_loai_dich_vu
 group by HD.ma_hop_dong, LDV.ten_loai_dich_vu, DVDK.ten_dich_vu_di_kem
 having count(HDCT.ma_dich_vu_di_kem) = 1;
 
 -- Cau 14:
 select NV.ma_nhan_vien, NV.ho_ten, TD.ten_trinh_do, BP.ten_bo_phan, NV.so_dien_thoai, NV.dia_chi from nhan_vien NV
 join trinh_do TD on TD.ma_trinh_do = NV.ma_trinh_do
 join bo_phan BP on BP.ma_bo_phan = NV.ma_bo_phan
 join hop_dong HD on HD.ma_nhan_vien = NV.ma_nhan_vien
 where year(HD.ngay_lam_hop_dong) between 2020 and 2021
 group by NV.ma_nhan_vien ,NV.ho_ten, TD.ten_trinh_do, BP.ten_bo_phan, NV.so_dien_thoai, NV.dia_chi
 having count(HD.ma_nhan_vien) <=3;
 
 -- Cau 15: 
 SET SQL_SAFE_UPDATES = 0;
    DELETE FROM nhan_vien NV WHERE NOT EXISTS (
    SELECT 1
    FROM hop_dong HD
    WHERE HD.ma_nhan_vien = NV.ma_nhan_vien
    AND YEAR(HD.ngay_lam_hop_dong) BETWEEN 2020 AND 2021
     );
SET SQL_SAFE_UPDATES = 1;
 
-- Cau 16:
UPDATE khach_hang KH
SET KH.ma_loai_khach = 1
WHERE EXISTS (
    SELECT 1
    FROM hop_dong HD
    JOIN loai_khach LK ON LK.ma_loai_khach = KH.ma_loai_khach
    WHERE HD.ma_khach_hang = KH.ma_khach_hang
    AND HD.tien_dat_coc > 10000000
    AND LK.ma_loai_khach > 1
);     

-- Cau 17: fail 
delete from hop_dong_chi_tiet HDCT
where exists 
(select 1 from hop_dong HD
where HDCT.ma_hop_dong = HD.ma_hop_dong
and year(HD.ngay_lam_hop_dong) < 2021
);

delete from hop_dong HD
where year(HD.ngay_lam_hop_dong) < 2021;

delete from khach_hang KH
where exists
( select 1 from hop_dong HD
  where 
  HD.ma_khach_hang = KH.ma_khach_hang 
  and year(HD.ngay_lam_hop_dong) < 2021
);
use resortfurama;

-- Cau 18:
SET SQL_SAFE_UPDATES = 0;
WITH SoLuongHD AS (
    SELECT 
        hop_dong_chi_tiet.ma_dich_vu_di_kem,
        SUM(hop_dong_chi_tiet.so_luong) AS SoLuong
    FROM 
        hop_dong_chi_tiet
    GROUP BY 
        hop_dong_chi_tiet.ma_dich_vu_di_kem
)

UPDATE dich_vu_di_kem DVDK
JOIN SoLuongHD ON SoLuongHD.ma_dich_vu_di_kem = DVDK.ma_dich_vu_di_kem
JOIN hop_dong_chi_tiet HDCT ON DVDK.ma_dich_vu_di_kem = HDCT.ma_dich_vu_di_kem
JOIN hop_dong HD ON HDCT.ma_hop_dong = HD.ma_hop_dong
SET DVDK.gia = DVDK.gia * 2
WHERE SoLuongHD.SoLuong > 10 AND YEAR(HD.ngay_lam_hop_dong) = 2020;
 SET SQL_SAFE_UPDATES = 1;
 