use Loteria
go


		/*Cabecera : nuevoIDBoleto()
			Descripcion : Funcion Para recoger una nueva Id
			Precondiciones:Nada
			Entrada:Nada
			Salidas:Nuevo ID como int
			PostCondiciones: devolvera un Nuevo id tipo int asociado al nombre

		
					***FUNCION TERMINADA***
		*/

		
		create function nuevoIDBoleto(@idsorteo int) returns int as
		begin
			DECLARE @id_boleto int

			if exists (Select id_boleto from Boletos where id_sorteo=@idsorteo)
			begin
			
				set @id_boleto= (select top 1 id_boleto from Boletos where id_sorteo=@idsorteo order by id_boleto desc)+1
			
			end
				else begin
				
					set @id_boleto=1
				
				end

			return @id_boleto
		
		end
		go



			/*Cabecera : NumerosJugados()
			Descripcion : funcion para calcular la cantidad de numeros jugados
			Precondiciones:Nada
			Entrada:pueden ser desde 0  a 6 int 
			Salidas: la cantidad de numeros jugados int
			PostCondiciones: devolvera la cantidad de numeros jugados tipo int asociado al nombre

		
					***FUNCION TERMINADA***
		*/
	go
	Create function NumerosJugados (@numero6 tinyint = Null,@numero7 tinyint = Null,@numero8 tinyint = Null,
									@numero9 tinyint = Null,@numero10 tinyint = Null,@numero11 tinyint = Null) 
									returns int
					as
					begin

						Declare @numerosJugados int=5
						
						if @numero11 is not NULL 
								begin
								set	@numerosJugados =11
								end--fin if var6

								else  
								begin
									
									if @numero10 is not null begin
										set	@numerosJugados =10

									end--fin if var7

										else
										begin

											if @numero9 is not null begin

												set	@numerosJugados =9

											end--fin if var8
													
												else
												begin
													if @numero8 is not null begin
													 
														set	@numerosJugados =8

													end--fin if var9

													else
														begin
															
															if @numero7 is not null begin
																	
																	set	@numerosJugados =7

															end --fin if var10

															else
															begin
																if @numero6 is not null begin
																		
																		set	@numerosJugados =6

																end --Fin if var11

															end --FIN ELSE var10
														end--FIN ELSE var9
												end--FIN ELSE var8
										end --FIN ELSE var7
								end --FIN ELSE var6

						return @numerosJugados
					 
					end
	
	
	
	go


			/*Cabecera : NumerosIguales()
			Descripcion : Funcion Para averiguar si existen numeros repetidos en los numeros jugados
			Precondiciones:Nada
			Entrada:5 int obligatorios y hasta 11 opcionales
			Salidas: devolvera un tipo bit 
			PostCondiciones: devolvera un 1 si no existen numeros repetidos y 0 si alguno se repite

		
					***FUNCION TERMINADA***
		*/

create Function NumerosIguales (@numero1 tinyint,@numero2 tinyint,@numero3 tinyint,@numero4 tinyint
					,@numero5 tinyint,@numero6 tinyint = Null,@numero7 tinyint = Null,@numero8 tinyint = Null,
					@numero9 tinyint = Null,@numero10 tinyint = Null,@numero11 tinyint = Null) returns bit


		
as begin

	declare @posible bit=0

	declare @tablaNumeros table(numero int);

	insert into @tablaNumeros values (@numero1);
	insert into @tablaNumeros values (@numero2);
	insert into @tablaNumeros values (@numero3);
	insert into @tablaNumeros values (@numero4);
	insert into @tablaNumeros values (@numero5);
	insert into @tablaNumeros values (@numero6);
	insert into @tablaNumeros values (@numero7);
	insert into @tablaNumeros values (@numero8);
	insert into @tablaNumeros values (@numero9);
	insert into @tablaNumeros values (@numero10);
	insert into @tablaNumeros values (@numero11);
	
	if exists(select numero from @tablaNumeros where numero is not null group by numero having count(*) > 1)
	begin
		set @posible = 0
	end
	else
	begin
		set @posible = 1
	end


return @posible

end

go


		/*Cabecera : GrabaSencilla()
			Descripcion : Procedimiento para grabar una apuesta simple
			Precondiciones:Nada
			Entrada:1 int del id del sorteo a jugar y 6 int de los numeros jugados 
			Salidas: no tiene 
			PostCondiciones: grabara en la base de datos la apuesta de esos numeros para el sorteo elegido 
			Exepciones : Lanzara un RAISERROR si hay numeros repetidos 

		
					***PROCEDIMIENTO TERMINADO***
					
		*/

create Procedure GrabaSencilla @Sorteo int, @numero1 tinyint,@numero2 tinyint,@numero3 tinyint,@numero4 tinyint,@numero5 tinyint,@numero6 tinyint
AS
	begin
		
		declare @boletoCorrecto bit
		declare @boletoenrango bit= 1
		EXEC @boletoCorrecto =  dbo.NumerosIguales @numero1,@numero2,@numero3,@numero5,@numero6 ;

		--Tenemos que consultar que no los numeros no esten repetidos
		if @boletoCorrecto = 1
		begin
				Declare @id_boleto int
				set @id_boleto=dbo.nuevoIDBoleto(@Sorteo) 
				Begin Transaction
					--Insertamos un nuevo registro en la tabla boletos
					Insert into Boletos (id_boleto,id_sorteo,fecha_compra,reintegro,numeros_jugados)
						values (@id_boleto,@Sorteo,CURRENT_TIMESTAMP,ABS(Checksum(NewID()) % 9)+1,6)

					--Declara la variable tipo tabla y la llenamos con los datos de los numeros apostados
					Declare @varTabla table(id_sorteo int ,id_boleto int,num_apostado tinyint)
					
					
					insert into @varTabla values (@Sorteo,@id_boleto,@numero1),
									(@Sorteo,@id_boleto,@numero2),
									(@Sorteo,@id_boleto,@numero3),
									(@Sorteo,@id_boleto,@numero4),
									(@Sorteo,@id_boleto,@numero5),
									(@Sorteo,@id_boleto,@numero6)
					begin try
						Insert into Numeros (id_sorteo,id_boleto,num_apostado)
						Select * From @varTabla
					end try

					begin catch
						set @boletoenrango=0
					end catch

					if(@boletoenrango=1)begin 
						commit Transaction

					end
					else begin
						raisError('Numeros Fuera de Rango',1,1)
						rollback
					end
					
		end

		else begin
			raisError('No puede haber números repetidos en el boleto',1,1)
		
		end
		
	end


GO
/*Cabecera : GrabaMuchasSencillas()
			Descripcion : Procedimiento para n apuestas sencillas con numeros generados aleatoriamente
			Precondiciones:Nada
			Entrada:1 int del sorteo y 1 int de la cantidad de boletos a apostar 
			Salidas: no tiene 
			PostCondiciones: grabara la cantidad de numeros introducidos en el sorteo elegido

								***PROCEDIMIENTO TERMINADA***

		*/

create procedure GrabaMuchasSencillas @Sorteo int, @n int
as
	begin
		Declare @i int=0
		Declare @numero1 tinyint
		Declare @numero2 tinyint
		Declare @numero3 tinyint
		Declare @numero4 tinyint
		Declare @numero5 tinyint
		Declare @numero6 tinyint

		
		while(@i<@n)
			begin
				--Generamos los numeros aleatorios del 1 al 49
				set @numero1= ABS(Checksum(NewID()) % 49)+1
				
				--para que genere un numero aleatorio diferente
				set @numero2= ABS(Checksum(NewID()) % 49)+1
				while(@numero1=@numero2)
					begin
						set @numero2= ABS(Checksum(NewID()) % 49)+1
					end

				--Introducimos el numero 3
				set @numero3= ABS(Checksum(NewID()) % 49)+1
				while( @numero3=@numero1 or @numero3=@numero2)
					begin
						set @numero3= ABS(Checksum(NewID()) % 49)+1
					end

				--Introducimos el numero 4
				set @numero4= ABS(Checksum(NewID()) % 49)+1
				while( @numero4=@numero1 or @numero4=@numero2 or @numero4=@numero3)
					begin
						set @numero4= ABS(Checksum(NewID()) % 49)+1
					end

				--Introducimos el numero 5
				set @numero5= ABS(Checksum(NewID()) % 49)+1
				while (@numero5=@numero1 or @numero5=@numero2 or @numero5=@numero3 or @numero5=@numero4)
					begin
						set @numero5= ABS(Checksum(NewID()) % 49)+1
					end 

				--Introducimos el numero 6
				set @numero6= ABS(Checksum(NewID()) % 49)+1
				while (@numero6=@numero1 or @numero6=@numero2 or @numero6=@numero3 or @numero6=@numero4 or @numero6=@numero5)
					begin
						set @numero6= ABS(Checksum(NewID()) % 49)+1
					end 


				--Ejecutamos el procedimiento anterior
				Execute dbo.GrabaSencilla @Sorteo,@numero1,@numero2,@numero3,@numero4,@numero5,@numero6

				--sumamos 1 al contador
				set @i=@i+1
			end

	end

	

	/*Cabecera : GrabaMultiple()
			Descripcion : Procedimiento para grabar una apuesta multiple
			Precondiciones:Nada
			Entrada:El numero del sorteo (int) y 4int obligatorios y entre 5 y 11 int opcionales 
			Salidas: no tiene 
			PostCondiciones: grabara la apuesta multiple

								***PROCEDIMIENTO TERMINADA***
							
		*/

	go



	CREATE procedure GrabaMultiple @sorteo int,@numero1 tinyint,@numero2 tinyint,@numero3 tinyint,@numero4 tinyint
				,@numero5 tinyint,@numero6 tinyint = Null,@numero7 tinyint = Null,@numero8 tinyint = Null,
				@numero9 tinyint = Null,@numero10 tinyint = Null,@numero11 tinyint = Null
				as
				begin
					if dbo.NumerosIguales(@numero1,@numero2,@numero3,@numero4,@numero5,@numero6,@numero7,@numero8,@numero9,@numero10,@numero11)=1 begin

						Declare @id_boleto int
						Declare @numerosJugados int =dbo.NumerosJugados(@numero6,@numero7,@numero8,@numero9,@numero10,@numero11)
						if(@numerosJugados != 6)begin

							set @id_boleto=dbo.nuevoIDBoleto(@sorteo) 
							--Insertamos un nuevo registro en la tabla boletos
							Insert into Boletos (id_boleto,id_sorteo,fecha_compra,reintegro,numeros_jugados)
							values (@id_boleto,@Sorteo,CURRENT_TIMESTAMP,ABS(Checksum(NewID()) % 9)+1,@numerosJugados)

						
						

								--Ahora insertamos todos los numeros, si no le da valor a todas las variables
								--nos da igual porque la tabla tiene una restriccion PK.
							insert into Numeros(id_sorteo,id_boleto,num_apostado)
								values(@Sorteo,@id_boleto,@numero1) 
							insert into Numeros(id_sorteo,id_boleto,num_apostado)
								values(@Sorteo,@id_boleto,@numero2)
							insert into Numeros(id_sorteo,id_boleto,num_apostado)
								values(@Sorteo,@id_boleto,@numero3)
							insert into Numeros(id_sorteo,id_boleto,num_apostado)
								values(@Sorteo,@id_boleto,@numero4) 
							insert into Numeros(id_sorteo,id_boleto,num_apostado)
								values(@Sorteo,@id_boleto,@numero5)
							
								if @numero6 is not NULL 
									begin
										insert into Numeros(id_sorteo,id_boleto,num_apostado)
											values(@Sorteo,@id_boleto,@numero6)
								
									
										if @numero7 is not null begin
											insert into Numeros(id_sorteo,id_boleto,num_apostado)
											values(@Sorteo,@id_boleto,@numero7)

												if @numero8 is not null begin
													insert into Numeros(id_sorteo,id_boleto,num_apostado)
													values(@Sorteo,@id_boleto,@numero8)

											
														if @numero9 is not null begin
															insert into Numeros(id_sorteo,id_boleto,num_apostado)
																values(@Sorteo,@id_boleto,@numero9)
													
																if @numero10 is not null begin
																	insert into Numeros(id_sorteo,id_boleto,num_apostado)
																		values(@Sorteo,@id_boleto,@numero10)
															
																	if @numero11 is not null begin
																		insert into Numeros(id_sorteo,id_boleto,num_apostado)
																			values(@Sorteo,@id_boleto,@numero11)
																	end --Fin if var11

																end --FIN ELSE var10
															end--FIN ELSE var9
													end--FIN ELSE var8
											end --FIN ELSE var7
									end --FIN ELSE var6
						end--FIN if

						else begin
							raisError('Estás intentando grabar un boleto múltiple, no puede tener 6 numeros',1,1)
					
						end
					end 
					else
					begin
						raisError('No puede haber números repetidos en el boleto',1,1)
					end

				end--FIN PROCEDURE
		go


/*Premios

Modifica la base de datos para que, una vez realizado el sorteo, se pueda asignar a cada boleto la cantidad ganada.
 Para ello, crea un procedimiento AsignarPremios que calcule los premios de cada boleto y lo guarde en la base de datos.
 Para saber cómo se asignan los premios, debes seguir las instrucciones de este documento,
 en especial el Capítulo V del Título I (págs 7, 8, 9 y 10) y la tabla de la instrucción 21.4 (pág 14).*/

--ALTER TABLE Boletos ADD  Premio money NULL;

/*Cabecera : DineroGenerado
			Descripcion : Funcion para calcular la cantidad de dinero generado por los pagos de los boletos 
							segun su apuesta y numeros jugados
			Precondiciones:Nada
			Entrada:el numero de sorteo 
			Salidas: cantidad de dinero generado money
			PostCondiciones: devolvera un tipo money asociado al nombre

								***PROCEDIMIENTO TERMINADA***								
							
		*/
go
create function DineroGenerado (@id_sorteo int) returns money as
begin
	Declare @DineroGenerado money=0.0
	

	select  @DineroGenerado = case 
						when numeros_jugados= 5 then @DineroGenerado+CAST (44 as money)
						when numeros_jugados= 6 then @DineroGenerado+CAST (1 as money)
						when numeros_jugados= 7 then @DineroGenerado+CAST (7 as money)
						when numeros_jugados= 8 then @DineroGenerado+CAST (28 as money)
						when numeros_jugados= 9 then @DineroGenerado+CAST (84 as money)
						when numeros_jugados= 10 then @DineroGenerado+CAST (210 as money)
						when numeros_jugados= 11 then @DineroGenerado+CAST (462 as money)
		end
		from Boletos where id_sorteo=@id_sorteo
		
	return @DineroGenerado
end



go


/*Repartir dinero PRobar*/
Create Procedure RepartoDinero (@dinero_generado money,@id_sorteo int)
as begin
	
	Declare @totalSorteo money = @dinero_generado-(@dinero_generado*0.45)
	Declare @tipo3 int Declare @tipo4 int Declare @tipo5 int Declare @tipo7 int Declare @tipo6 int Declare @tipo8 int
	Declare @dinerotipo4 money Declare @dinerotipo5 money Declare @dinerotipo6 money Declare @dinerotipo7 money Declare @dinerotipo8 money
	
	
	Declare @Premiosxboleto table (idboleto tinyint,tipo8 tinyint , tipo6 tinyint, tipo7 tinyint,
										 tipo5 tinyint, tipo4 tinyint, tipo3 tinyint)
	
	--REVISAR
	insert into @Premiosxboleto (idboleto ,tipo8  , tipo6 , tipo7 ,
										 tipo5 , tipo4 , tipo3) select * from dbo.TienePremio(@id_sorteo)
	
	
	
	
	 return 
end
go


/*Funcion para saber si un boleto tiene un numero complementario de un sorteo*/
create function tieneComplementario(@idboleto int, @idsorteo int) returns int as 
begin
	Declare @tieneComplementario tinyint=0


	if(
	   (select count(*) 
			from Numeros as n
				join Sorteos as s
					on n.id_sorteo=s.id_sorteo
			where n.num_apostado=s.complementario and (n.id_sorteo=@idsorteo and n.id_boleto=@idboleto))		
		>0)
		begin
		set @tieneComplementario = 1
	end
	
	return @tieneComplementario
end
go

/*Funcion para saber si un boleto tiene el reintegro de un sorteo*/
Create function tieneReintegro(@idboleto int, @idsorteo int) returns int as 
begin
	Declare @tieneComplementario tinyint=0

	if((select reintegro from Boletos where id_boleto=@idboleto)= (select reintegro from Sorteos where id_sorteo=@idsorteo))begin
		set @tieneComplementario=1
	end

	return @tieneComplementario
end
go

go
Create Procedure RepartirPremios (@id_sorteo int,@dinero_generado money) as
begin
		
	Declare @totalSorteo money = @dinero_generado-(@dinero_generado*0.45)
	Declare @tipo3 int=0, @tipo4 int=0, @tipo5 int=0, @tipo7 int=0, @tipo6 int=0, @tipo8 int=0
	Declare @dinerotipo4 money=0.0, @dinerotipo5 money=0.0, @dinerotipo6 money=0.0, @dinerotipo7 money=0.0, @dinerotipo8 money=0.0 , @dinerotipo3 money=0.0
		
		
		Declare @premios table( numjugados int,numaciertos int,complementario int, reintegro int , tipo8 int , tipo6 int, tipo7 int,
										 tipo5 int, tipo4 int, tipo3 int)
		Declare @repartirpremios table (idboleto int,tipo8 int , tipo6 int, tipo7 int,
										 tipo5 int, tipo4 int, tipo3 int)
		
		--RELLENAMOS LA TABLA DE PREMIOS 
		--5 APUESTAS
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,2,0,0,0,0,0,0,0,4)
		
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,3,0,0,0,0,0,0,3,41)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,4,0,0,0,0,0,2,42,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,4,1,0,0,0,2,0,42,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,5,0,0,0,1,1,42,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (5,5,0,1,1,1,1,42,0,0)
		
		--6 APUESTAS
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,3,0,0,0,0,0,0,0,1)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,4,0,0,0,0,0,0,1,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,5,0,0,0,0,0,1,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,5,1,0,0,0,1,0,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,6,0,0,0,1,0,0,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (6,6,0,1,1,0,0,0,0,0)

		--7 APUESTAS

		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,3,0,0,0,0,0,0,0,4)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,4,0,0,0,0,0,0,3,4)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,5,0,0,0,0,0,2,5,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,5,1,0,0,0,1,1,5,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,6,0,0,0,1,0,6,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,6,1,0,0,1,6,0,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,6,0,1,1,1,0,6,0,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (7,6,1,1,1,1,6,0,0,0)

		--8 APUESTAS

		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,3,0,0,0,0,0,0,0,10)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,4,0,0,0,0,0,0,6,16)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,5,0,0,0,0,0,3,15,10)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,5,1,0,0,0,1,2,15,10)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,6,0,0,0,1,0,12,15,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,6,1,0,0,1,6,6,15,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,6,0,1,1,1,0,12,15,0)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (8,3,1,1,1,1,6,6,15,0)

		--9 APUESTAS

		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,3,0,0,0,0,0,0,0,20)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,4,0,0,0,0,0,0,10,40)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,5,0,0,0,0,0,4,30,40)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,5,1,0,0,0,1,3,30,40)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,6,0,0,0,1,0,18,45,20)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,6,1,0,0,1,6,12,45,20)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,6,0,1,1,1,0,18,45,20)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (9,6,1,1,1,1,6,12,45,20)
		
		--10 APUESTAS

		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,3,0,0,0,0,0,0,0,35)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,4,0,0,0,0,0,0,15,80)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,5,0,0,0,0,0,5,50,100)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,5,1,0,0,0,1,4,50,100)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,6,0,0,0,1,0,24,90,80)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,6,1,0,0,1,6,18,90,80)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,6,0,1,1,1,0,24,90,80)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (10,6,1,1,1,1,6,18,90,80)

		--11 APUESTAS

		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,3,0,0,0,0,0,0,0,56)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,4,0,0,0,0,0,0,21,140)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,5,0,0,0,0,0,6,75,200)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,5,1,0,0,0,1,5,75,200)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,6,0,0,0,1,0,30,150,200)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,6,1,0,0,1,6,24,150,200)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,6,0,1,1,1,0,30,150,200)
		insert into @premios ( numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
			values (11,3,1,1,1,1,6,24,150,200)



		--AHORA RELLENAMOS LA TABLA CON CADA BOLETO PREMIADO
		insert @repartirpremios(idboleto,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3)
		select boletos.id_boleto,premios.tipo8,premios.tipo7,premios.tipo6,premios.tipo5,premios.tipo4,premios.tipo3
			from( 
			select subaciertos.id_boleto,subaciertos.Aciertos,subaciertos.jugados,complementario.tieneComplementario,reintegro.tieneReintegro
	
	from
		--INICIO SUBCONSULTA COMPLEMENTARIO
		(select dbo.tieneComplementario(Aciertos.id_boleto,@id_sorteo) as tieneComplementario,Aciertos.id_boleto
		
		from

		(select count(*) AS Aciertos,n.id_boleto,b.numeros_jugados as jugados
			from Numeros as n
				join NumerosSorteos as nm
					on n.id_sorteo=nm.id_sorteo and n.num_apostado=nm.numero
				join Boletos as b
					on n.id_boleto=b.id_boleto
			where n.id_sorteo=@id_sorteo
							
			group by n.id_boleto,b.numeros_jugados) as Aciertos
			where (Aciertos.Aciertos>2 and Aciertos.jugados=5) or (Aciertos.jugados>5 and Aciertos.Aciertos>2)
			group by Aciertos.id_boleto
			) as complementario
			--FIN SUBCONSULTA COMPLEMENTARIO

			--INICIO SUBCONSULTA ACIERTOS
			join (select count(*) AS Aciertos,n.id_boleto,b.numeros_jugados as jugados
			from Numeros as n
				join NumerosSorteos as nm
					on n.id_sorteo=nm.id_sorteo and n.num_apostado=nm.numero
				join Boletos as b
					on n.id_boleto=b.id_boleto
			where n.id_sorteo=@id_sorteo
							
			group by n.id_boleto,b.numeros_jugados) as subaciertos
			--FIN INICIO SUBCONSULTA ACIERTOS
			on complementario.id_boleto=subaciertos.id_boleto


			--INICIO SUBCONSULTA REINTEGRO
			join (select dbo.tieneReintegro(Aciertos.id_boleto,@id_sorteo) as tieneReintegro,Aciertos.id_boleto
		
					from

						(select count(*) AS Aciertos,n.id_boleto,b.numeros_jugados as jugados
							from Numeros as n
								join NumerosSorteos as nm
									on n.id_sorteo=nm.id_sorteo and n.num_apostado=nm.numero
								join Boletos as b
									on n.id_boleto=b.id_boleto
							where n.id_sorteo=@id_sorteo
							
							group by n.id_boleto,b.numeros_jugados) as Aciertos
							where (Aciertos.Aciertos>2 and Aciertos.jugados=5) or (Aciertos.jugados>5 and Aciertos.Aciertos>2)
							group by Aciertos.id_boleto
				
				) as reintegro
					on reintegro.id_boleto=subaciertos.id_boleto
			--FIN SUBCONSULTA REINTEGRO
		) as boletos
				 
				 --subconsulta 1.2
		inner join ( select numjugados,numaciertos,complementario,reintegro,tipo8,tipo7,tipo6,tipo5,tipo4,tipo3
							from @premios
					) as premios
					--fin subconsulta 1.2
				on boletos.Aciertos = premios.numaciertos and boletos.jugados=premios.numjugados 
				and boletos.tieneComplementario=premios.complementario and boletos.tieneReintegro=premios.reintegro
		
		
			--COGEMOS EL TOTAL DE PREMIOS DE CADA TIPO
			set @tipo3 = (select sum(tipo3) from @repartirpremios)
			set @tipo4 = (select sum(tipo4) from @repartirpremios)
			set @tipo5 = (select sum(tipo5) from @repartirpremios)
			set @tipo6 = (select sum(tipo6) from @repartirpremios)
			set @tipo7 = (select sum(tipo7) from @repartirpremios)
			set @tipo8 = (select sum(tipo8) from @repartirpremios)

			--Cogemos el total de dinero que se va a llevar el tipo 3
	if(@tipo3!=0)begin
		set @dinerotipo3 = @tipo3*8
	end

	if(@tipo4!=0)begin
		set @dinerotipo4 =  (0.21*(@totalSorteo-@dinerotipo3))/@tipo4
	end
	if(@tipo5!=0)begin
		set @dinerotipo5 =  (0.13*(@totalSorteo-@dinerotipo3))/@tipo5
	end
	if(@tipo7!=0)begin
		set @dinerotipo7 =	(0.06*(@totalSorteo-@dinerotipo3))/@tipo7
	end

	if(@tipo6!=0)begin
		set @dinerotipo6 =	(0.40*(@totalSorteo-@dinerotipo3))/@tipo6
	end

	if(@tipo8!=0)begin
		set @dinerotipo8 =  (0.20*(@totalSorteo-@dinerotipo3))/@tipo8
	end
							
						

	--Le asignamos a cada boleto el dinero recogido

	update Boletos set premio = (rp.tipo8 * @dinerotipo8)+
								(rp.tipo7 * @dinerotipo7)+
								(rp.tipo6 * @dinerotipo6)+
								(rp.tipo5 * @dinerotipo5)+
								(rp.tipo4 * @dinerotipo4)+
								(rp.tipo3 * 8)
								from @repartirpremios as rp

								where id_boleto=rp.idboleto
						
	end
			go

Create procedure CalcularyRepartir(@idsorteo int) as 
begin
Declare @dineroGenerado money 
set @dineroGenerado =  dbo.DineroGenerado(@idsorteo)

execute RepartirPremios @idsorteo,@dineroGenerado

end