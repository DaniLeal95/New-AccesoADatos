/*EXAMEN AÑO PASADO*/

/*Escribe una función que nos devuelva el número de horas de vuelo de un avión en un rango de fechas.
 Los parámetros de entrada serán la matrícula del avión y las fechas de inicio y fin del cálculo.
 Si se omite la fecha de inicio se tomará la fecha en que el avión entró en servicio. 
 Si se omite la fecha de fin se tomará la actual.*/
 go
 Create Function HorasVoladasEntreFechas (@matricula char(10),@horainicio smalldatetime=null,@horafin smalldatetime=null) returns int as
 begin
	Declare @horas int

	--si la fecha inicio esta null quiere decir que la omitido
	if(@horainicio=null)
	begin
		--entonces recogemos la fecha de servicio del avion
		set @horainicio = (select Fecha_Entrada 
							from AL_Aviones as a
							where a.Matricula=@matricula)
	end

	--si la fecha fin es nula quiere decir que no ha introducido ninguna
	if(@horafin=null)
	begin
		--entonces le damos la actual
		set @horafin = CURRENT_TIMESTAMP
	end

	--si la fecha inicial introducida es mayor a la final
	--cambiamos las fechas entre sí
	if(@horainicio>@horafin)begin
		Declare @horasupl smalldatetime= @horainicio
		set @horainicio=@horafin
		set @horafin=@horasupl
	end

	--si las fechas no son iguales haremos la consultas
	if(@horainicio!=@horafin)
	begin
		
		--Solo hay una pega si la fecha de llegada es posterior a la hora fin no recoge las horas voladas en ese vuelo
	set  @horas = (select sum(DATEDIFF(MINUTE,Salida,Llegada))*60 as Diferenciaxminutos from AL_Vuelos
						where Salida>=@horainicio and Llegada<=@horafin and Matricula_Avion=@matricula)
	end

	--Si las fechas son iguales no hace falta ejecutar nada
	else
	begin 
	set @horas=0
	end

	return @horas
 end

 go

/*Escribe un trigger que impida que entre el fin de un vuelo de un avión y el comienzo del siguiente transcurra menos de 1 hora.
En todos los triggers se valorará que funcionen cuando la modificación afecte a múltiples filas. Si no encuentras el modo, hazlo para una sola.
*/
go
Create Trigger ViajeEnMenosDe1Hora
	on dbo.AL_Vuelos
  after Insert
 as 
  Begin
	
	IF EXISTS (SELECT *
					FROM inserted AS I 
						Inner join AL_Vuelos AS a 
							ON a.Codigo=I.Codigo
					WHERE DATEDIFF(MINUTE,i.Llegada,a.Salida) <= 60) --Buscamos las fechas insertadas que sean invalidas
		Begin																	--Invalidas = queda menos( o igual) de una hora para el siguiente vuelo
			--No realizar insert
			ROLLBACK TRANSACTION
			raisError('No se puede añadir un vuelo a menos de una hora del comienzo de otro',1,1)
		End
		
  End
  go

  /*Escribe una función a la que se pase como parámetro un año (entero) 
  y nos devuelva una tabla con ID, nombre, apellidos, edad, nacionalidad, número de vuelos realizados ese año y número de aeropuertos diferentes visitados.
  Se entiende que un pasajero ha visitado un aeropuerto si ha tomado algún vuelo que saliera o llegara a ese aeropuerto.*/
  go
  Create function ViajesdePersonasxAño(@anio int) returns @tabla table (ID char(9),Nombre varchar(20),Apellidos varchar(50),Edad int,Nacionalidad varchar(30),NumVuelos int,Aeropuertosdistintos int) as
  begin 

	Insert into @tabla (ID,Nombre,Apellidos,Edad,Nacionalidad,NumVuelos,Aeropuertosdistintos)
		select ID,Nombre,Apellidos,cast(datediff(DAY,Fecha_Nacimiento,GETDATE()) / 365.25 as int) as Edad,Nacionalidad,NumVuelos.NumVuelos,AeroPuertosDistintos.NumAeropuertosDistintos
			from AL_Pasajeros as p
				join 
				--DE ESTA SUBCONSULTA RECOOGEMOS EL NUMERO DE VUELO QUE HA HECHO UN CLIENTE
					(Select ID_Pasajero, count( ID_Pasajero ) as NumVuelos
						from AL_Pasajes as p
							join AL_Tarjetas as t
								on p.Numero=t.Numero_Pasaje
							join AL_Vuelos as v
								on t.Codigo_Vuelo=v.Codigo
							where  DATEPART(YEAR,Llegada)=@anio  OR  DATEPART(YEAR,Salida)=@anio 
								  
						group by ID_Pasajero
								) as NumVuelos
					on p.ID=NumVuelos.ID_Pasajero
					--FIN SUBCONSULTA NUMERO DE VUELOS
					--DE ESTA SUBCONSULTA RECOJEMOS EL NUMERO
				join (Select p.ID_Pasajero, COUNT(Distinct AeroPuertosDistintos.Aeropuerto_Llegada) as NumAeropuertosDistintos
						from AL_Pasajes as p
							join AL_Tarjetas as t
								on p.Numero=t.Numero_Pasaje
							join AL_Vuelos as v
								on t.Codigo_Vuelo=v.Codigo

							join (select p.ID_Pasajero,Aeropuerto_Llegada
									from AL_Pasajes as p
										join AL_Tarjetas as t
											on p.Numero=t.Numero_Pasaje
										join AL_Vuelos as v
											on t.Codigo_Vuelo=v.Codigo
										where  DATEPART(YEAR,Llegada)=@anio  OR  DATEPART(YEAR,Salida)=@anio

										 union 
									select p.ID_Pasajero,Aeropuerto_Salida
									from AL_Pasajes as p
										join AL_Tarjetas as t
											on p.Numero=t.Numero_Pasaje
										join AL_Vuelos as v
											on t.Codigo_Vuelo=v.Codigo
										where  DATEPART(YEAR,Llegada)=@anio  OR  DATEPART(YEAR,Salida)=@anio ) as AeroPuertosDistintos
								

							on AeroPuertosDistintos.ID_Pasajero=p.ID_Pasajero


						where DATEPART(YEAR,Llegada)=@anio or DATEPART(YEAR,Salida)=@anio
						group by p.ID_Pasajero
								) as AeroPuertosDistintos
								--FIN SUBCONSULTA AEROPUERTOS DISTINTOS

					on p.ID=AeroPuertosDistintos.ID_Pasajero
	
	return
  end
  go


  select * from dbo.ViajesdePersonasxAño (2012)