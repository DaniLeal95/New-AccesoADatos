go
--1º
CREATE LOGIN Gerente with password='Gerente',
DEFAULT_DATABASE=laPrimitiva2

--2º
USE laPrimitiva2
CREATE USER Gerente FOR LOGIN Gerente
GRANT EXECUTE, INSERT, UPDATE, DELETE, SELECT TO Gerente
go

go
--1º
CREATE LOGIN Empleado with password='Empleado',
DEFAULT_DATABASE=laPrimitiva2

--2º
USE laPrimitiva2
CREATE USER Empleado FOR LOGIN Empleado
GRANT EXECUTE TO Empleado
go


-- SIN EJECUTAR lo que sigue!!! preguntar a Leo si está bien!!!

CREATE TABLE USUARIOS(
idUsuario int identity(0,1) Primary key,
usuario varchar(15) not null,
clave varchar(15) not null, -- o password
tipoEmpleado varchar(10) not null, -- Gerente o Empleado
hashcode varchar Default null	-- por si lo imlemento (luego sobraria la columna clave)
)
-- como ya he creado los USER o tipo de usuario (y sus permisos), ahora creo un LOGIN por cada empleado nuevo

CREATE LOGIN Mercedes with password='Mercedes',
DEFAULT_DATABASE=laPrimitiva2

INSERT INTO USUARIOS
			([usuario]
           ,[clave]
           ,[tipoEmpleado])
           --,[hashcode])
     VALUES
           ('Mercedes'	--HH MM SS
           ,'Mercedes'
           ,'Gerente')
          -- ,'')

CREATE LOGIN David with password='David',
DEFAULT_DATABASE=laPrimitiva2

INSERT INTO USUARIOS
			([usuario]
           ,[clave]
           ,[tipoEmpleado])
           --,[hashcode])
     VALUES
           ('David'	--HH MM SS
           ,'David'
           ,'Empleado')
          -- ,'')