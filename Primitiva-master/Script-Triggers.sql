USE Loteria

GO

/*
*	TRIGGER para la base de datos Loteria --> ComprobarHoraBoleto
	Descripcion: cuando se realize un insert en la tabla Boletos se comprobara que el boleto introducido
				este dentro del horario correcto , es decir, que debe de faltar mas de una hora para que se realize el sorteo
		Pseudocodigo:
		Inicio
			Si (existe una hora invalida del boleto insertado)
				No realizar insert
				
		Fin
*/
GO

create trigger	ComprobadorHoraBoleto
  on dbo.Boletos
  after Insert
 as 
  Begin
	--Si existe una hora invalida del boleto insertado
	IF EXISTS (SELECT fecha_compra
					FROM inserted AS I Inner join Sorteos AS S ON I.id_sorteo=S.id_sorteo
					WHERE DATEDIFF(MINUTE,CURRENT_TIMESTAMP,S.fecha_sorteo) <= 60) --Buscamos las fechas insertadas que sean invalidas
		Begin																	--Invalidas = queda menos( o igual) de una hora para el sorteo
			--No realizar insert
			ROLLBACK TRANSACTION
			raisError('No se puede añadir un boleto a menos de una hora del sorteo',1,1)
		End
		
  End

GO


/*
*	TRIGGER para la base de datos Loteria --> inpedirModificarBoletos
	Descripcion: Este trigger impedira que se actualizen los datos de la tabla boletos
		Pseudocodigo:
		Inicio
				No realizar insert	
		Fin
*/
GO

create trigger	impedirModificarBoletos
  on dbo.Numeros
  instead of Update
  as begin
	raisError('No se puede modificar la Tabla',1,1)
  end