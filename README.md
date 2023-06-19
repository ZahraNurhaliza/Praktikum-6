# Praktikum-6

## SCRIPT SQL 

### Perusahaan
```python
create table Perusahan(
id_p varchar(10) primary key,
nama varchar(45) not null,
alamat varchar(45) default null
);
insert into Perusahan (id_p, nama, alamat)
values ('P01', 'Kantor Pusat', NULL),
	   ('P02', 'Cabang Bekasi', NULL);
select * from Perusahan;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/perusahaan.png)


### Departemen
```python
create table Departemen (
id_dept varchar(10) primary key,
nama varchar(45) not null,
id_p varchar(10) not null,
manajer_nik varchar(10) default null
);
insert into Departemen (id_dept, nama, id_p, manajer_nik)
values ('D01', 'Produksi', 'P02', 'N01'),
	   ('D02', 'Marketing', 'P01', 'N03'),
       ('D03', 'RnD', 'P02', NULL),
       ('D04', 'Logistik', 'P02', NULL);
select * from Departemen;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/departemen.png)


### Karyawan
```python
create table Karyawan (
nik varchar(10) primary key,
nama varchar(45) not null,
id_dept varchar(10) not null,
sup_nik varchar(10) default null
);
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
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/karyawan.png)


### Project
```python
create table Project(
id_proj varchar(10) primary key,
nama varchar(45) not null,
tgl_mulai datetime,
tgl_selesai datetime,
status tinyint(1)
);
insert into Project (id_proj,nama,tgl_mulai,tgl_selesai,status)
values ('PJ01', 'A', '2019-01-10', '2019-03-10', '1'),
	   ('PJ02', 'B', '2019-02-15', '2019-04-10', '1'),
	   ('PJ03', 'C', '2019-03-21', '2019-05-10', '1');
select * from Project;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/project.png)


### Project_detail
```python
create table Project_detail(
id_proj varchar(10) not null,
nik varchar(10) not null
);
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
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/project_detail.png)

### Menampilkan nama Manajer tiap Departemen
```python
select Departemen.nama AS Departemen, Karyawan.nama AS Manajer
from Departemen
left join Karyawan ON Karyawan.nik = Departemen.manajer_nik;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/1.png)


### Menampilkan nama Supervisor tiap Karyawan
```python
select Karyawan.nik, Karyawan.nama, Departemen.nama AS Departemen, Supervisor.nama AS Supervisor
from Karyawan
left join Karyawan AS Supervisor ON Supervisor.nik = Karyawan.sup_nik
left join Departemen ON Departemen.id_dept = Karyawan.id_dept;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/2.png)


### Menampilkan daftar Karyawan yang bekerja pada Project A
```python
select Karyawan.nik, Karyawan.nama
from Karyawan
join Project_detail ON Project_detail.nik = Karyawan.nik
join Project ON Project.id_proj = Project_detail.id_proj
where Project.nama = 'A';
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/3.png)

## LATIHAN PRAKTIKUM
Buat query untuk menampilkan:

1. Departemen apa saja yang terlibat dalam tiap-tiap project
```python
select Project.nama AS Project, GROUP_CONCAT(Departemen.nama) AS Departemen
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
group by Project.id_proj;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/4.png)


2. Jumlah karyawan tiap departemen yang bekerja pada tiap-tiap project
```python
select Project.nama AS Project, Departemen.nama AS Departemen, COUNT(*) AS 'Jumlah Karyawan'
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
group by Project.id_proj, Departemen.id_dept;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/5.png)


3. Ada berapa project yang sedang dikerjakan oleh departemen RnD?
```python
(ket: project berjalan adalah yang statusnya 1)
select COUNT(*) AS 'Jumlah Project'
from Project
inner join Project_detail ON Project.id_proj = Project_detail.id_proj
inner join Karyawan ON Project_detail.nik = Karyawan.nik
inner join Departemen ON Karyawan.id_dept = Departemen.id_dept
where Departemen.nama = 'RnD' AND Project.status = 1;
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/6.png)


4. Berapa banyak project yang sedang dikerjakan oleh Ari?
```python
select COUNT(*) AS 'Jumlah Project'
from Project_detail
inner join Karyawan ON Project_detail.nik = Karyawan.nik
where Karyawan.nama = 'Ari' AND Project_detail.id_proj IN (select id_proj from Project where status = 1);
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/7.png)


5. Siapa saja yang mengerjakan projcet B?
```python
select Karyawan.nama
from Project_detail
inner join Karyawan ON Project_detail.nik = Karyawan.nik
where Project_detail.id_proj IN (select id_proj from Project where nama = 'B');
```
![image](https://github.com/ZahraNurhaliza/Praktikum-6/blob/master/screenshot/8.png)
