					-- PRUEBAS

--INSERT

USE [laPrimitiva2]
GO

INSERT INTO [dbo].[SORTEOS]
           ([fechaSorteo]
           ,[num1]
           ,[num2]
           ,[num3]
           ,[num4]
           ,[num5]
           ,[num6]
           ,[complementario]
           ,[reintegroSorteo])
     VALUES
           ('2017-01-10 00:00:00'	--HH MM SS
           ,2
           ,5
           ,20
           ,24
           ,30
           ,35
           ,40
           ,5)
GO


select * from Sorteos order by fechaSorteo desc
--GrabaMultiple @idSorteo int, @tipoApuesta int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int=0,@num7 int =0,@num8 int =0,@num9 int =0,@num10 int=0,@num11 int=0
EXECUTE GrabaMultiple 0,6,	2,6,4,5,9,12
EXECUTE GrabaMultiple 0,8,	5,6,11,13,16,19,30,31
EXECUTE GrabaMultiple 0,11,	2,6,4,5,9,12,21,22,30,36,45
	select * from Boletos
	select * from NumerosBoletos

-- delete from NumerosBoletos	delete from Boletos		delete  from Sorteos



--  @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
EXECUTE GrabaSencilla 0,3,7,10,12,15,33
--EXECUTE PR_NumeroRepetido 3,7,10,12,12,33 procedimiento eliminado

DECLARE @salida as int
EXECUTE dbo.generaNumeroAleatorio @salida output
print @salida


go --@idSorteo int, @cantidad int
EXECUTE GrabaMuchasSencillas 1, 1
go

select * from NUMEROSBOLETOS
select * from BOLETOS 
select * from SORTEOS

-- DELETE FROM NUMEROSBOLETOS
-- DELETE FROM BOLETOS


DECLARE @salida as int		-- @idSorteo int,@idBoleto int
EXECUTE @salida= fn_numAciertos @idSorteo=0, @idBoleto=4
print @salida

select * from NUMEROSBOLETOS where idBoleto=2

--fn_numAciertos @idSorteo int,@idBoleto int,@aciertos int OUTPUT,@compl int OUTPUT 
DECLARE @aciertos int, @compl int 
EXECUTE fn_numAciertos @idSorteo = 0, @idBoleto=1, @aciertos= @aciertos OUTPUT, @compl = @compl OUTPUT
print @aciertos
print @compl















-- PROCEDIMIENTO PARA DEVOLVER MULTIPLES PARAMETROS

Create PROCEDURE MultipleOutParameter
    @Input int,
    @Out1 int OUTPUT, 
    @Out2 int OUTPUT 
AS
BEGIN
    Select @Out1 = @Input + 1
    Select @Out2 = @Input + 2   
 --   Select 'this returns your normal Select-Statement' as Foo
 --         , 'amazing is it not?' as Bar

    -- Return can be used to get even more (afaik only int) values 
    Return(@Out1+@Out2+@Input)
END

DECLARE @GetReturnResult int, @GetOut1 int, @GetOut2 int 
EXEC @GetReturnResult = MultipleOutParameter  
    @Input = 1,
    @Out1 = @GetOut1 OUTPUT,
    @Out2 = @GetOut2 OUTPUT

DECLARE @GetOut1 int, @GetOut2 int 
EXECUTE MultipleOutParameter @Input = 1, @Out1 = @GetOut1 OUTPUT, @Out2 = @GetOut2 OUTPUT
print @GetOut1
print @GetOut2

-- drop procedure MultipleOutParameter