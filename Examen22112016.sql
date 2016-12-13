/*
Cuidando nuestras mascotas
Una consulta veterinaria utiliza la base de datos “Bichos” ® para registrar los datos de las
mascotas que atienden,
Algunos días, el veterinario se desplaza a una localidad remota donde no puede conectarse
al servidor central. Entonces graba los datos de visitas en una tabla BI_Actualizaciones para
luego volcarlos en las tablas principales.
Dicha tabla se ha incorporado ya a la base de datos y ahora debemos actualizar las tablas
principales a partir de los datos que contiene.
La tabla contiene datos de visitas. Cuando la visita se ha hecho a una mascota que no
figuraba en la base de datos se incluyen todos sus datos. Si se ha realizado a una mascota
ya registrada solo se incluyen los datos de la visita.
Si en la visita se ha diagnosticado alguna enfermedad, se incluye también este dato.
Se pide:
*/
/*
Ejercicio 1
Crear un procedimiento almacenado que inserte una nueva fila en
BI_MascotasEnfermedades, tomando como datos de entrada el nombre de la enfermedad,
la fecha en que se diagnosticó y el código de la mascota.
*/
use Bichos
go


/*
	Interfaz :
		Breve comentario : 
			El procedimiento inserta un nuevo registro en la tabla BI_Mascotas_Enfermedades , Con
				los parametros que nos envien 
		Precondiciones:
			Los parametros deberan ser validos, deberan existir en la bbdd
		Entradas:
			nombre_Enfermedad un varchar (30) -> nombre de la enfermedad
			fecha_diagnostico smalldatetime  -> la fecha en la que se le diagnostico la enfermedad
			cod_mascota char(5) -> el codigo de la mascota
*/
Create Procedure insert_Mascotas_Enfermedades (@nombre_Enfermerdad nvarchar(30),@fechaDiagnostico smalldatetime,@cod_mascota char(5)) as begin

	Insert into BI_Mascotas_Enfermedades (IDEnfermedad,Mascota,FechaInicio,FechaCura)
	select ID,@cod_mascota,@fechaDiagnostico,null
		from BI_Enfermedades
			where Nombre=@nombre_Enfermerdad
end


select * from BI_Mascotas_Enfermedades
delete from BI_Mascotas_Enfermedades where IDEnfermedad=6