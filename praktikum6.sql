create database praktikum6;
use praktikum6;
drop database praktikum6;

create table Perusahan(
id_p varchar(10) primary key,
nama varchar(45) not null,
alamat varchar(45) default null
);

create table Departemen (
id_dept varchar(10) primary key,
nama varchar(45) not null,
id_p varchar(10) not null,
manajer_nik varchar(10) default null
);

create table Karyawan (
nik varchar(10) primary key,
nama varchar(45) not null,
id_dept varchar(10) not null,
sup_nik varchar(10) default null
);

create table Project_detail(
id_proj varchar(10) not null,
nik varchar(10) not null
);

create table Project(
id_proj varchar(10) primary key,
nama varchar(45) not null,
tgl_mulai datetime,
tgl_selesai datetime,
status tinyint(1)
);

insert into Perusahan (id_p, nama, alamat)
values ('P01', 'Kantor Pusat', NULL),
	   ('P02', 'Cabang Bekasi', NULL);
select * from Perusahan;
       
insert into Departemen (id_dept, nama, id_p, manajer_nik)
values ('D01', 'Produksi', 'P02', 'N01'),
	   ('D02', 'Marketing', 'P01', 'N03'),
       ('D03', 'RnD', 'P02', NULL),
       ('D04', 'Logistik', 'P02', NULL);
select * from Departemen;

insert into Karyawan (nik, nama, id_dept, sup_nik)
values ('N01', 'Ari', 'D01', NULL),
	   ('N02', 'Dina', 'D01', NULL),
       ('N03', 'Rika', 'D03', NULL),
       ('N04', 'Ratih', 'D01', 'N01'),
       ('N05', 'Riko', 'D01', 'N01'),
       ('N06', 'Dani', 'D02', NULL),
       ('N07', 'Anis', 'D02', 'N06'),
       ('N08', 'Dika', 'D02', 'N06');
select * from Karyawan;    
   
insert into Project_detail (id_proj, nik)
values ('PJ01', 'N01'),
       ('PJ01', 'N02'),
	   ('PJ01', 'N03'),
	   ('PJ01', 'N04'),
	   ('PJ01', 'N05'),
	   ('PJ01', 'N07'),
	   ('PJ01', 'N08'),
	   ('PJ02', 'N01'),
	   ('PJ02', 'N03'),
	   ('PJ02', 'N05'),
	   ('PJ03', 'N03'),
	   ('PJ03', 'N07'),
	   ('PJ03', 'N08');
select * from Project_detail;
           
insert into Project (id_proj,nama,tgl_mulai,tgl_selesai,status)
values ('PJ01', 'A', '2019-01-10', '2019-03-10', '1'),
	   ('PJ02', 'B', '2019-02-15', '2019-04-10', '1'),
	   ('PJ03', 'C', '2019-03-21', '2019-05-10', '1');
select * from Project;
           
alter table Project_detail
add constraint fk_project_detail_id_proj foreign key (id_proj) references Project (id_proj);

select Departemen.nama AS Departemen, Karyawan.nama AS Manajer
from Departemen
left join Karyawan ON Karyawan.nik = Departemen.manajer_nik;

select Karyawan.nik, Karyawan.nama, Departemen.nama AS Departemen, Supervisor.nama AS Supervisor
from Karyawan
left join Karyawan AS Supervisor ON Supervisor.nik = Karyawan.sup_nik
left join Departemen ON Departemen.id_dept = Karyawan.id_dept;

select Karyawan.nik, Karyawan.nama
from Karyawan
join Project_detail ON Project_detail.nik = Karyawan.nik
join Project ON Project.id_proj = Project_detail.id_proj
where Project.nama = 'A';

select Project.nama AS Project, GROUP_CONCAT(Departemen.nama) AS Departemen
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
group by Project.id_proj;

select Project.nama AS Project, Departemen.nama AS Departemen, COUNT(*) AS 'Jumlah Karyawan'
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
group by Project.id_proj, Departemen.id_dept;
 
select COUNT(*) AS 'Jumlah Project'
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
where Departemen.nama = 'RnD' AND Project.status = 1;

select COUNT(*) AS 'Jumlah Project'
from Project_detail
inner join Karyawan ON Project_detail.nik = Karyawan.nik
where Karyawan.nama = 'Ari' AND Project_detail.id_proj IN (select id_proj from Project where status = 1);

select Karyawan.nama
from Project_detail
inner join Karyawan ON Project_detail.nik = Karyawan.nik
where Project_detail.id_proj IN (select id_proj from Project where nama = 'B');
