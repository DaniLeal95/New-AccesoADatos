--Pruebas
USE [Loteria]
GO
/*
INSERT INTO [dbo].[Sorteos]
           ([fecha_sorteo]
           ,[reintegro]
           ,[complementario])
     VALUES
           ('5/12/2016'
           ,5
           ,9)
		  insert into NumerosSorteos (id_sorteo,numero) values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6)

*/

go
--execute dbo.GrabaSencilla 1,1,2,3,4,5,6
--execute dbo.GrabaSencilla 1,1,2,3,4,5,5
--execute dbo.GrabaSencilla 2,1,2,3,4,5,6
--execute dbo.GrabaSencilla 3,1,2,3,4,5,6

--PRUEBAS DE RENDIMIENTO En Clase
--execute dbo.GrabaMuchasSencillas 1,10000  ---> 8 segundos
--execute dbo.GrabaMuchasSencillas 1,100000 ---> 1'35 minutos
--execute dbo.GrabaMuchasSencillas 1,500000	---> 8'06 minutos
--execute dbo.GrabaMuchasSencillas 1,1000000	---> minutos

--execute dbo.GrabaMultiple 1,1,2,3,4,5

/*
declare @dinero money = 0
execute @dinero =  dbo.DineroGenerado 8
Print @dinero

*/
execute dbo.CalcularyRepartir 1
select * from Sorteos
select * from Boletos where Premio>0.0

