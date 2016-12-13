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

		
		create function nuevoIDBoleto() returns int as
		begin
			DECLARE @id_boleto int

			if exists (Select id_boleto from Boletos)
			begin
			
				set @id_boleto= (select top 1 id_boleto from Boletos order by id_boleto desc)+1
			
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

		
					***PROCEDIMIENTO PSEUDO-TERMINADO***
					ERRORES OBSERVADOS :  si se le introduce un numero apostado fuera de rago permitido (1-49) si salta
											el error y no llega a introducir los numeros apostados pero si que introduce un boleto apostado
		*/

Create Procedure GrabaSencilla @Sorteo int, @numero1 tinyint,@numero2 tinyint,@numero3 tinyint,@numero4 tinyint,@numero5 tinyint,@numero6 tinyint
AS
	begin
		
		declare @boletoCorrecto bit
		declare @boletoenrango bit= 1
		EXEC @boletoCorrecto =  dbo.NumerosIguales @numero1,@numero2,@numero3,@numero5,@numero6 ;

		--Tenemos que consultar que no los numeros no esten repetidos
		if @boletoCorrecto = 1
		begin
				Declare @id_boleto int
				set @id_boleto=dbo.nuevoIDBoleto() 
				Begin Transaction
					--Insertamos un nuevo registro en la tabla boletos
					Insert into Boletos (id_boleto,id_sorteo,fecha_compra,reintegro,numeros_jugados)
						values (@id_boleto,@Sorteo,CURRENT_TIMESTAMP,ABS(Checksum(NewID()) % 9)+1,6)

					--Declara la variable tipo tabla y la llenamos con los datos de los numeros apostados
					Declare @varTabla table(id_sorteo int ,id_boleto int,num_apostado tinyint CONSTRAINT num_novalido check(num_apostado between 1 and 49))
					
					begin try
					insert into @varTabla values (@Sorteo,@id_boleto,@numero1),
									(@Sorteo,@id_boleto,@numero2),
									(@Sorteo,@id_boleto,@numero3),
									(@Sorteo,@id_boleto,@numero4),
									(@Sorteo,@id_boleto,@numero5),
									(@Sorteo,@id_boleto,@numero6)
					end try
					begin catch
						set @boletoenrango=0
					end catch
					if(@boletoenrango=1)begin 
						commit Transaction
					end
					else begin
						rollback
					end

					--Volcamos la variable con los numero apostados en la tabla Numeros	
					Insert into Numeros (id_sorteo,id_boleto,num_apostado)
									Select * From @varTabla		
		end

		else begin
			raisError('No puede haber números repetidos en el boleto',1,1)
		
		end
		
	end
go

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

	/*

	**********************************ME HE QUEDADO AQUI REVSANDO TODO LO ANTERIOR ESTA CORREGIO Y CHECEADO****************************

	*/
	/*•	Implementa un procedimiento almacenado GrabaMultiple que grabe una apuesta simple. 
	Datos de entrada: El sorteo y entre 5 y 11 números*/
	go



	Create procedure GrabaMultiple @sorteo int,@numero1 tinyint,@numero2 tinyint,@numero3 tinyint,@numero4 tinyint
				,@numero5 tinyint,@numero6 tinyint = Null,@numero7 tinyint = Null,@numero8 tinyint = Null,
				@numero9 tinyint = Null,@numero10 tinyint = Null,@numero11 tinyint = Null
				as
				begin
					if dbo.NumerosIguales(@numero1,@numero2,@numero3,@numero4,@numero5,@numero6,@numero7,@numero8,@numero9,@numero10,@numero11)=1 begin

						Declare @id_boleto int
						Declare @numerosJugados int =dbo.NumerosJugados(@numero6,@numero7,@numero8,@numero9,@numero10,@numero11)
						if(@numerosJugados != 6)begin

							set @id_boleto=dbo.nuevoIDBoleto() 
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
							raisError('No puede haber números repetidos en el boleto',1,1)
					
						end
					end 
					else
					begin
						raisError('Estás intentando grabar un boleto múltiple, no puede tener 6 numeros',1,1)
					end

				end--FIN PROCEDURE
		go

		

/*Premios

Modifica la base de datos para que, una vez realizado el sorteo, se pueda asignar a cada boleto la cantidad ganada.
 Para ello, crea un procedimiento AsignarPremios que calcule los premios de cada boleto y lo guarde en la base de datos.
 Para saber cómo se asignan los premios, debes seguir las instrucciones de este documento,
 en especial el Capítulo V del Título I (págs 7, 8, 9 y 10) y la tabla de la instrucción 21.4 (pág 14).*/

--ALTER TABLE Boletos ADD  Premio money NULL;
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
		from Boletos
		
	return @DineroGenerado
end

go
/*Para Saber el dinero que se reparte*/
create function RepartoDinero (@dinero_generado money) returns @reparto table (tipo_premio tinyint, premio money)
as begin
	Declare @contador tinyint =1
	Declare @totalSorteo money = @dinero_generado-(@dinero_generado*0.45)

	while @contador<6
	begin
		insert into @reparto (tipo_premio) values (@contador)
		set @contador = @contador+1
	end

	insert into @reparto(premio) 
					select premio = case
						when tipo_premio=1 then 0.20*@totalSorteo
						when tipo_premio=2 then 0.40*@totalSorteo
						when tipo_premio=3 then	0.06*@totalSorteo
						when tipo_premio=4 then	0.13*@totalSorteo
						when tipo_premio=5 then 0.21*@totalSorteo
						end

						from @reparto
	
	
	 

	 return 
end