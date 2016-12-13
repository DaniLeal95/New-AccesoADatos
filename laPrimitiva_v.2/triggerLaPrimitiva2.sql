--NO PODER INSERTAR DESPUES DE LA FECHA DEL SORTEO O UNA HORA ANTES DE LA HORA DEL SORTEO
GO
CREATE TRIGGER InsertarBoletoFecha ON BOLETOS AFTER INSERT AS
BEGIN
	DECLARE @fechaSorteo as smalldatetime = (select fechaSorteo from SORTEOS as S 
											inner join inserted as B on S.idSorteo = B.idSorteo)
							 

	IF (DATEDIFF(hour,CURRENT_TIMESTAMP,@fechaSorteo )<=1 OR (CURRENT_TIMESTAMP>@fechaSorteo))
	begin
		ROLLBACK
		Print 'No se pueden insertar boletos con menos de una hora de antelacion o para sorteos ya realizados'
	end		
END
GO
--drop trigger InsertarBoletoFecha
--•	Una vez insertado un boleto, no se pueden modificar sus números

GO
CREATE TRIGGER ModificarBoleto ON BOLETOS AFTER UPDATE AS
BEGIN
		ROLLBACK
		Print 'No se pueden modificar los boletos ya insertados'
		
END
GO
