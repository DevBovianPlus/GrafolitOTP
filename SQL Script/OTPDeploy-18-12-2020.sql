Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('250kg','250kg (1/2 pall)',50, 250,GETDATE(), 13);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('500kg ','500kg (1 pall)',50, 250,GETDATE(), 12);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('1000kg  ','1000kg (2 pall)',50, 250,GETDATE(), 11);
Insert into ZbirnikTon(Koda, Naziv, OdTeza, DoTeza, ts, SortIdx) values ('Vlak','Vlak',24501, 300000,GETDATE(), 15);

update ZbirnikTon set SortIdx=14 where Koda = 'Ladja';



