
create table ZbirnikTon (
	ZbirnikTonID int not null identity(1,1) primary key,
	Koda varchar(50) not null,
	Naziv varchar(500),
	OdTeza decimal,
	DoTeza decimal,
	SortIdx decimal,
	ts datetime null,	
);

Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('1.5t','do 1.5t', 0, 1500,GETDATE(),10);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('2t','do 2t',1501, 2000, GETDATE(),9);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('3t','do 3t',2001, 3000,GETDATE(),8);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('3.5t','do 3.5t',3001, 3500,GETDATE(),7);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('5t','do 5t',3501, 5000,GETDATE(),6);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('7t','do 7t',5001, 7000,GETDATE(),5);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('9t','do 9t',7001, 9000,GETDATE(),4);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('12t','do 12t',9001, 12000,GETDATE(), 3);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('14.5t','do 14.5t',12001, 14500,GETDATE(), 2);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('24t','do 24t',14501, 26000,GETDATE(), 1);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('nad 24t','nad 24t',26001, 926000,GETDATE(), 1);

select * from ZbirnikTon
delete from ZbirnikTon where ZbirnikTonID = 11

update Odpoklic set ZbirnikTonID = 10 where ZbirnikTonID = 11



alter table RazpisPozicija add ZbirnikTonID int null, constraint FK_ZbirnikTonID foreign key(ZbirnikTonID) references ZbirnikTon(ZbirnikTonID);
alter table Odpoklic add ZbirnikTonID int null, constraint FK_Odpoklic_ZbirnikTonID foreign key(ZbirnikTonID) references ZbirnikTon(ZbirnikTonID);
alter table Razpis add PodatkiZaExcell_JSon varchar(max);
alter table Razpis add GeneriranTender bit;
alter table Razpis add CiljnaCena decimal;
alter table Razpis add IsCiljnaCena bit;
alter table Razpis add IsNajcenejsiPrevoznik bit;

update Odpoklic set ZbirnikTonID = 10;
update RazpisPozicija set ZbirnikTonID = 10;
update Odpoklic set LastenPrevoz = 0, Opis = Opis + ' - Update zaradi lastnega prevoza '  where LastenPrevoz=1 and DobaviteljID not in (73, 20);
delete from RazpisPozicija where  RelacijaID=1060;




