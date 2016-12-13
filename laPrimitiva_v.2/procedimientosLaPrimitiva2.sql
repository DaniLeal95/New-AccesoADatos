--GRABA SENCILLA
GO
CREATE PROCEDURE GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
AS
BEGIN
	DECLARE @reintegro AS INT = ABS(Checksum(NewID())% 9) + 1


	INSERT INTO BOLETOS (idSorteo, reintegro, tipoApuesta )
	VALUES (@idSorteo, @reintegro, 6)

	DECLARE @idBoleto as int = (select top 1 idBoleto  from BOLETOS where idSorteo=@idSorteo ORDER BY idBoleto DESC )

	INSERT INTO NUMEROSBOLETOS(idBoleto,numero)
	VALUES (@idBoleto, @num1),
	(@idBoleto, @num2),
	(@idBoleto, @num3),
	(@idBoleto, @num4),
	(@idBoleto, @num5),
	(@idBoleto, @num6)
END
GO
-- drop procedure GrabaMultiple
-- GRABA MULTIPLE  PASANDO EL TIPO DE APUESTA, REPETITIVA
GO
CREATE PROCEDURE GrabaMultiple @idSorteo int, @tipoApuesta int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int=0,@num7 int =0,@num8 int =0,@num9 int =0,@num10 int=0,@num11 int=0
AS
BEGIN
	DECLARE @reintegro AS INT = ABS(Checksum(NewID())% 9) + 1

	INSERT INTO BOLETOS (idSorteo, reintegro, tipoApuesta )
	VALUES (@idSorteo, @reintegro, @tipoApuesta)

	DECLARE @idBoleto as int = (select top 1 idBoleto  from BOLETOS where idSorteo=@idSorteo ORDER BY idBoleto DESC )
	INSERT INTO NUMEROSBOLETOS(idBoleto,numero)
	VALUES (@idBoleto, @num1),
			(@idBoleto, @num2),
			(@idBoleto, @num3),
			(@idBoleto, @num4),
			(@idBoleto, @num5)

	
	IF (@tipoApuesta=6) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero) 
		VALUES (@idBoleto, @num6)
	END
	ELSE
	IF (@tipoApuesta=7) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero)
		
		VALUES (@idBoleto, @num6),(@idBoleto, @num7)
	END
	ELSE
	IF (@tipoApuesta= 8) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero) 
		VALUES (@idBoleto, @num6),(@idBoleto, @num7),
				(@idBoleto, @num8)

	END
	ELSE
	IF (@tipoApuesta= 9) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero) 
		VALUES (@idBoleto, @num6),(@idBoleto, @num7),
				(@idBoleto, @num8),
				(@idBoleto, @num9)
	END
	ELSE
	IF (@tipoApuesta= 10) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero) 
		VALUES (@idBoleto, @num6),(@idBoleto, @num7),
				(@idBoleto, @num8),
				(@idBoleto, @num9) ,
				(@idBoleto, @num10)
	END
	ELSE
	IF (@tipoApuesta= 11) BEGIN
		INSERT INTO NUMEROSBOLETOS(idBoleto,numero) 
		VALUES (@idBoleto, @num6),(@idBoleto, @num7),
				(@idBoleto,  @num8),
				(@idBoleto,  @num9) ,
				(@idBoleto,  @num10),
				(@idBoleto,  @num11)
	END
END
GO


---GENERAR NUMERO ALEATORIO
GO
CREATE PROCEDURE generaNumeroAleatorio
	@numeroAleatorio int output
AS
	BEGIN
		DECLARE @valorMaximo int = 49, @valorMinimo int = 1
		SELECT @numeroAleatorio = floor((@valorMaximo - @valorMinimo +1) * rand() + @valorMinimo)
		RETURN @numeroAleatorio
	END
GO

--- GRABA MUCHAS SENCILLAS
-- drop procedure GrabaMuchasSencillas

GO
CREATE PROCEDURE GrabaMuchasSencillas @idSorteo int, @cantidad int
AS
BEGIN
	DECLARE @cont as int =0
	
	DECLARE @uno as int 
	DECLARE @dos as int 
	DECLARE @tres as int 
	DECLARE @cuatro as int 
	DECLARE @cinco as int 
	DECLARE @seis as int 


	WHILE @cont<@cantidad --Repetir Procedimiento GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
		BEGIN

				--generar numeros aleatorios
						EXECUTE  dbo.generaNumeroAleatorio @uno out
						EXECUTE  dbo.generaNumeroAleatorio @dos out

							WHILE(@uno = @dos)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @dos out
								end
						EXECUTE  dbo.generaNumeroAleatorio @tres out
					WHILE(@tres=@uno or @tres=@dos)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @tres out
								end
						EXECUTE  dbo.generaNumeroAleatorio @cuatro out

					WHILE(@cuatro=@tres or @cuatro=@tres or @cuatro=@tres or @cuatro=@dos or @cuatro=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @cuatro out
								end
						EXECUTE dbo.generaNumeroAleatorio @cinco out

					WHILE(@cinco=@cuatro or @cinco=@tres or @cinco=@tres or @cinco=@tres or @cinco=@dos or @cinco=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @cinco out
								end
						EXECUTE dbo.generaNumeroAleatorio @seis out

					WHILE(@seis=@cinco or @seis=@cuatro or @seis=@tres or @seis=@tres or @seis=@tres or @seis=@dos or @seis=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @seis out
								end


				EXECUTE GrabaSencilla @idSorteo,@uno,@dos,@tres,@cuatro,@cinco,@seis
				

				SET @cont = @cont + 1;

		END --primer while
END --fin procedure
GO



-- EJECUTAR HASTA AQUI!!!!



-- FN NumeroRepetido devuelve 0 si no hay ningun numero repetido, 1 si sí los hay.
GO
CREATE FUNCTION FN_NumeroRepetido (@num1 int, @num2 int,@num3 int,@num4 int,@num5 int,@num6 int) RETURNS int 
AS
BEGIN

		DECLARE @repetido int = 0


		IF((@num1=@num2) or (@num1=@num3) or (@num1=@num4) or (@num1=@num5) or (@num1=@num6) or
			(@num2=@num3) or (@num2=@num4) or (@num2=@num5) or (@num2=@num6) or
			(@num3=@num4) or (@num3=@num5) or (@num3=@num6) or 
			(@num4=@num5) or (@num4=@num6) or
			(@num5=@num6))
			BEGIN
				SELECT @repetido=1
			END

			RETURN @repetido
END
GO




-- drop function fn_ParejaNumeroRepetido
GO
CREATE FUNCTION fn_ParejaNumeroRepetido (@numA int, @numB int) RETURNS int
begin
-- iguales =1   // diferentes=0
	DECLARE @iguales as int = 1

	IF(@numA!=@numB)
	begin
		SET @iguales = 0
	end

	return @iguales
end
GO

							-- drop function fn_numAciertos
-- funcion numAciertos
-- devuelve el numero de aciertos PRECONDICION: los numeros del Sorteo deben estar ordenados
-- CALCULO DEL NUMERO DE ACIERTOS DE UN BOLETO
-- Entradas: idSorte y idBoleto
-- Salida: aciertos (cantidad de aciertos), compl (1 si uno de los aciertos es el complementario, 0 si no tiene)
go
CREATE PROCEDURE fn_numAciertos @idSorteo int,@idBoleto int,@aciertos int OUTPUT,@compl int OUTPUT 
as
begin
	SET @aciertos = 0
	SET @compl= 0
	Declare @numApostados as int = 5
	-- Numeros del sorteo
	Declare @num1 as int = (select num1 from SORTEOS where idSorteo=@idSorteo)
	Declare @num2 as int = (select num2 from SORTEOS where idSorteo=@idSorteo)
	Declare @num3 as int = (select num3 from SORTEOS where idSorteo=@idSorteo)
	Declare @num4 as int = (select num4 from SORTEOS where idSorteo=@idSorteo)
	Declare @num5 as int = (select num5 from SORTEOS where idSorteo=@idSorteo)
	Declare @num6 as int = (select num6 from SORTEOS where idSorteo=@idSorteo)
	Declare @complementario as int = (select complementario from SORTEOS where idSorteo=@idSorteo)

	-- Creo una tabla temporal con los numeros del boleto a valorar 
	DECLARE  @TablaTemporalNumeros TABLE (Numero int)

	INSERT INTO @TablaTemporalNumeros 
	SELECT numero FROM NUMEROSBOLETOS WHERE idBoleto=@idBoleto 

	-- Asigno los Numeros del boleto
	Declare @one as int = (SELECT min(Numero) FROM @TablaTemporalNumeros)
	Declare @two as int= (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@one )
	Declare @three as int= (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@two )
	Declare @four as int= (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@three )
	Declare @five as int= (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@four )
	Declare @six as int = 0
	Declare @seven as int = 0
	Declare @eight as int = 0
	Declare @nine as int = 0
	Declare @ten as int = 0
	Declare @eleven as int = 0

	if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@five)
	begin
	set @six = (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@five )
	Set @numApostados = 6	
		if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@six )
		begin
		Set @seven = (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@six )
		Set @numApostados = 7		
			if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@seven )
			begin
			Set @eight= (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@seven )
			Set @numApostados = 8		
				if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@eight )
				begin
				Set @nine = (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@eight )
				Set @numApostados = 9		
					if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@nine)
					begin
					set @ten = (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@nine )
					Set @numApostados = 10			
						if exists(SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@ten)
						begin
						set @eleven = (SELECT min(Numero) FROM @TablaTemporalNumeros WHERE Numero>@ten )
						Set @numApostados = 11
						end --eleven
					end --ten
				end--nine
			end--eight
		end--seven
	end--six

	-- Comparo los numeros ganadores del sorteo con los numeros del boleto(ordenados)
	if(@one=@num1 or @one=@num2 or @one=@num3 or @one=@num4 or @one=@num5 or @one=@num6)
		begin
		SET @aciertos = @aciertos+1
		end
	if(@two=@num1 or @two=@num2 or @two=@num3 or @two=@num4 or @two=@num5 or @two=@num6)
		begin
		SET @aciertos = @aciertos+1
		end
	if(@three=@num1 or @three=@num2 or @three=@num3 or @three=@num4 or @three=@num5 or @three=@num6)
		begin
		SET @aciertos = @aciertos+1
		end
	if(@four=@num1 or @four=@num2 or @four=@num3 or @four=@num4 or @four=@num5 or @four=@num6)
		begin
		SET @aciertos = @aciertos+1
		end
	if(@five=@num1 or @five=@num2 or @five=@num3 or @five=@num4 or @five=@num5 or @five=@num6)
		begin
		SET @aciertos = @aciertos+1
		end

	if(@numApostados>=6 and (@six=@num1 or @six=@num2 or @six=@num3 or @six=@num4 or @six=@num5 or @six=@num6))
		begin
		SET @aciertos = @aciertos+1
		end

	if(@numApostados>=7 and (@seven=@num1 or @seven=@num2 or @seven=@num3 or @seven=@num4 or @seven=@num5 or @seven=@num6))
		begin
		SET @aciertos = @aciertos+1
		end
	if(@numApostados>=8 and (@eight=@num1 or @eight=@num2 or @eight=@num3 or @eight=@num4 or @eight=@num5 or @eight=@num6))
		begin
		SET @aciertos = @aciertos+1
		end
	if(@numApostados>=9 and (@nine=@num1 or @nine=@num2 or @nine=@num3 or @nine=@num4 or @nine=@num5 or @nine=@num6))
		begin
		SET @aciertos = @aciertos+1
		end
	if(@numApostados>=10 and (@ten=@num1 or @ten=@num2 or @ten=@num3 or @ten=@num4 or @ten=@num5 or @ten=@num6))
		begin
		SET @aciertos = @aciertos+1
		end
	if(@numApostados=11 and (@eleven=@num1 or @eleven=@num2 or @eleven=@num3 or @eleven=@num4 or @eleven=@num5 or @eleven=@num6))
		begin
		SET @aciertos = @aciertos+1
		end
	-- Comparo el numero complementario con los numeros del boleto
	if(@complementario=@one or @complementario=@two or @complementario=@three or @complementario=@four or @complementario=@five or @complementario=@six
	or @complementario=@seven or @complementario=@eight or @complementario=@nine or @complementario=@ten or @complementario=@eleven)
	begin
	set @aciertos= @aciertos+1
	set @compl=1
	end
	

	return (@aciertos+@compl)
end
go





-- REPARTO PREMIOS
GO
CREATE PROCEDURE pr_RepartirPremios @idSorteo int
as

-- 'ESPECIAL', 'PRIMERA','SEGUNDA','TERCERA','CUARTA','QUINTA','SEXTA'
DECLARE @RecaudacionTotal as money
DECLARE @RecaudacionPremios as money

DECLARE @AcertantesQuinta as int
DECLARE @AcertantesCuarta as int
DECLARE @AcertantesTercera as int
DECLARE @AcerantesSegunda as int
DECLARE @AcertantesPrimera as int
DECLARE @AcertantesEspecial as int

DECLARE @PremioQuinta as money
DECLARE @PremioCuarta as money
DECLARE @PremioTercera as money
DECLARE @PremioSegunda as money
DECLARE @PremioPrimera as money
DECLARE @PremioEspecial as money

--calculamos la Recaudacion asignada a premios
SET @RecaudacionTotal = (SELECT count(idBoleto) FROM BOLETOS)
SET @RecaudacionPremios = @RecaudacionTotal*0.55

-- asignamos el premio SEXTA que es 1€ (PONER UN BOOLEANO PARA SABER SI YA TIENE PREMIO, ESTO VA AL FINAL)
DECLARE @reintegro as int = (SELECT reintegroSorteo FROM SORTEOS WHERE idSorteo=@idSorteo)
INSERT INTO [dbo].[PREMIOS]
           ([idSorteo]
           ,[categoria]
           ,[cantidad])
     VALUES
           (@idSorteo
           ,'SEXTA'
           ,1)

INSERT INTO [dbo].[BOLETO_PREMIO_SORTEO]
           ([idPremio]
           ,[idSorteo]
           ,[idBoleto])
     VALUES
           ((select top 1 idPremio from PREMIOS order by idPremio desc) 
           ,@idSorteo
           ,(select idBoleto from BOLETOS where reintegro=@reintegro))

-- calculamos el numero de acertantes de QUINTA (y les asignamos 8€ de premio, ESTO AL FINAL)
-- restamos el dinero repartido a RecaudacionesPremios
-- calculamos acertantes de cada categoria con la funcion numAciertos
-- calculamos premio por cada categoria
-- insertamos en PREMIOS 
-- insertamos en BOLETO_PREMIO_SORTEO
		-- buscamos BOLETOS acertantes de categoria X
		-- insertamos en BOLETO PREMIO SORTEO asociado a PREMIOS


INSERT INTO [dbo].[PREMIOS]
           ([idSorteo]
           ,[categoria]
           ,[cantidad])
     VALUES
           (@idSorteo
           ,<categoria, varchar(1),>
           ,<cantidad, money,>)

INSERT INTO [dbo].[BOLETO_PREMIO_SORTEO]
           ([idPremio]
           ,[idSorteo]
           ,[idBoleto])
     VALUES
           (<idPremio, int,>
           ,<idSorteo, int,>
           ,<idBoleto, int,>)


GO









GO
CREATE PROCEDURE GrabaMuchasSencillasB @idSorteo int, @cantidad int
AS
BEGIN
	DECLARE @cont as int =0
	
	DECLARE @uno as int 
	DECLARE @dos as int 
	DECLARE @tres as int 
	DECLARE @cuatro as int 
	DECLARE @cinco as int 
	DECLARE @seis as int 



	DECLARE @repetido as int =0
	DECLARE @repetido1 as int=0
	DECLARE @repetido2 as int=0
	DECLARE @repetido3 as int=0
	DECLARE @repetido4 as int=0
	DECLARE @repetido5 as int=0

	WHILE @cont<@cantidad --Repetir Procedimiento GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
		BEGIN

			--	SET @repetido=1
				--mientras (haya repetidos)
			--	WHILE @repetido=1
				--	begin
				--generar numeros aleatorios
						EXECUTE  dbo.generaNumeroAleatorio @uno out
						EXECUTE  dbo.generaNumeroAleatorio @dos out
					--	EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@dos
					--		WHILE(@repetido1=1)
							WHILE(@uno = @dos)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @dos out
									--EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@dos
								end
						EXECUTE  dbo.generaNumeroAleatorio @tres out
					--	EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@tres
					--	EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@tres
					--		WHILE(@repetido1=1 or @repetido2=1)
					WHILE(@tres=@uno or @tres=@dos)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @tres out
					--				EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@tres
					--				EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@tres
								end
						EXECUTE  dbo.generaNumeroAleatorio @cuatro out
					--	EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@cuatro
					--	EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@cuatro
					--	EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@cuatro
					--		WHILE(@repetido1=1 or @repetido2=1 or @repetido3=1)
					WHILE(@cuatro=@tres or @cuatro=@tres or @cuatro=@tres or @cuatro=@dos or @cuatro=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @cuatro out
					--				EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@cuatro
					--				EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@cuatro
					--				EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@cuatro
								end
						EXECUTE dbo.generaNumeroAleatorio @cinco out
					--	EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@cuatro,@numB=@cinco
					--	EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@cinco
					--	EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@cinco
					--	EXECUTE @repetido4 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@cinco
					--		WHILE(@repetido1=1 or @repetido2=1 or @repetido3=1 or @repetido4=1)
					WHILE(@cinco=@cuatro or @cinco=@tres or @cinco=@tres or @cinco=@tres or @cinco=@dos or @cinco=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @cinco out
						--			EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@cuatro,@numB=@cinco
						--			EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@cinco
						--			EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@cinco
						--			EXECUTE @repetido4 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@cinco
								end
						EXECUTE dbo.generaNumeroAleatorio @seis out
					--	EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@cinco,@numB=@seis
					--	EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@cuatro,@numB=@seis
					--	EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@seis
					--	EXECUTE @repetido4 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@seis
					--	EXECUTE @repetido5 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@seis
					--		WHILE(@repetido1=1 or @repetido2=1 or @repetido3=1 or @repetido4=1 or @repetido4=1)
					WHILE(@seis=@cinco or @seis=@cuatro or @seis=@tres or @seis=@tres or @seis=@tres or @seis=@dos or @seis=@uno)
								begin
									EXECUTE  dbo.generaNumeroAleatorio @seis out
							--		EXECUTE @repetido1 = fn_ParejaNumeroRepetido @numA=@cinco,@numB=@seis
							--		EXECUTE @repetido2 = fn_ParejaNumeroRepetido @numA=@cuatro,@numB=@seis
							--		EXECUTE @repetido3 = fn_ParejaNumeroRepetido @numA=@tres,@numB=@seis
							--		EXECUTE @repetido4 = fn_ParejaNumeroRepetido @numA=@dos,@numB=@seis
							--		EXECUTE @repetido5 = fn_ParejaNumeroRepetido @numA=@uno,@numB=@seis
								end
				--comprobamos que no estan repetidos
								EXECUTE @repetido= FN_NumeroRepetido @num1=@uno, @num2=@dos,@num3=@tres,@num4=@cuatro,@num5=@cinco,@num6=@seis
								
			--		end--segundo while


				EXECUTE GrabaSencilla @idSorteo,@uno,@dos,@tres,@cuatro,@cinco,@seis
				

				SET @cont = @cont + 1;

		END --primer while
END --fin procedure
GO

---- MANEJO DE EXCEPCIONES
--DECLARE
--   pe_ratio NUMBER(3,1);
--BEGIN
--   SELECT price / earnings INTO pe_ratio FROM stocks
--      WHERE symbol = 'XYZ';  -- might cause division-by-zero error
--   INSERT INTO stats (symbol, ratio) VALUES ('XYZ', pe_ratio);
--   COMMIT;
--EXCEPTION  -- exception handlers begin
--   WHEN ZERO_DIVIDE THEN  -- handles 'division by zero' error
--      INSERT INTO stats (symbol, ratio) VALUES ('XYZ', NULL);
--      COMMIT;
--   ...
--   WHEN OTHERS THEN  -- handles all other errors
--      ROLLBACK;
--END;  -- exception handlers and block end her

-- OPCION B, para manipular
--- GRABA MUCHAS SENCILLAS

--CREATE PROCEDURE GrabaMuchasSencillasBBBBB @idSorteo int, @cantidad int
--AS
--BEGIN
--	DECLARE @cont as int =0
	
--	DECLARE @uno as int 
--	DECLARE @dos as int 
--	DECLARE @tres as int 
--	DECLARE @cuatro as int 
--	DECLARE @cinco as int 
--	DECLARE @seis as int 

--	DECLARE @repetido as int = 0 --NO repetido, =1 SI repetido


--	WHILE @cont<@cantidad --Repetir Procedimiento GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
--		BEGIN

--				--generar numeros aleatorios
--						EXECUTE  dbo.generaNumeroAleatorio @uno out
--						EXECUTE  dbo.generaNumeroAleatorio @dos out
--						EXECUTE  dbo.generaNumeroAleatorio @tres out
--						EXECUTE  dbo.generaNumeroAleatorio @cuatro out
--						EXECUTE dbo.generaNumeroAleatorio @cinco out
--						EXECUTE dbo.generaNumeroAleatorio @seis out
--			-- comprobamos mediate salto de excepcion de id repetido que no lo estan

--			--falta un while
--			begin TRY
--					EXECUTE GrabaSencilla @idSorteo,@uno,@dos,@tres,@cuatro,@cinco,@seis
--					SET @repetido=0
--			end try
--			begin CATCH
--					SET @repetido=1
--			end catch

--				SET @cont = @cont + 1;

--		END 
--END --fin procedure
--GO




--EJEMPLO LEO PARA USAR @@identity

--create Procedure InsertarBoleto @num1 TinyInt,@num2..., @IDBoleto BigInt OUTPUT AS
--begin
--insert into BOLETO ....
--set @IdBoleto = @@Identity LLAMA LA IDE DEL BOLETO INSERTADO
--end