--Pruebas
USE [Loteria]
GO
/*
INSERT INTO [dbo].[Sorteos]
           ([fecha_sorteo]
           ,[reintegro]
           ,[complementario])
     VALUES
           ('30/09/2016'
           ,5
           ,9)

INSERT INTO [dbo].[Sorteos]
           ([fecha_sorteo]
           ,[reintegro]
           ,[complementario])
     VALUES
           ('28/09/2016'
           ,5
           ,9)*/

/*INSERT INTO [dbo].[Sorteos]
           ([fecha_sorteo]
           ,[reintegro]
           ,[complementario])
     VALUES
           ('29/09/2016 13:30:00'
           ,5
           ,9)*/
go
--execute dbo.GrabaSencilla 1,1,2,3,4,5,6
--execute dbo.GrabaSencilla 1,1,2,3,4,5,5
--execute dbo.GrabaSencilla 2,1,2,3,4,5,6
--execute dbo.GrabaSencilla 3,1,2,3,4,5,6

--PRUEBAS DE RENDIMIENTO En Clase
--execute dbo.GrabaMuchasSencillas 1,10000  ---> 8 segundos
--execute dbo.GrabaMuchasSencillas 1,100000 ---> 1'35 minutos
--execute dbo.GrabaMuchasSencillas 1,500000	---> 8'06 minutos
execute dbo.GrabaMuchasSencillas 1,1000000	---> minutos




GO

