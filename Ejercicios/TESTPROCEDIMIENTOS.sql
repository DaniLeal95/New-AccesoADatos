
insert into Sorteos (fecha_sorteo,complementario,reintegro) values ('09/10/2016',9,9)
select * from Sorteos

		execute dbo.GrabaSencilla 1,1,2,3,4,5,6
		
		execute dbo.GrabaMultiple 1,1,2,3,4,5
		execute dbo.GrabaMultiple 1,1,2,3,4,5,6,7
		execute dbo.GrabaMultiple 1,1,2,3,4,5,6,7,8
		execute dbo.GrabaMultiple 1,1,2,3,4,5,6,7,8,9
		execute dbo.GrabaMultiple 1,1,2,3,4,5,6,7,8,9,10
		execute dbo.GrabaMultiple 1,1,2,3,4,5,6,7,8,9,10,11

		select * from boletos where id_sorteo=4
		print dbo.DineroGenerado (4)