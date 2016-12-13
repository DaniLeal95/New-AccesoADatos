---DROP DATABASE laPrimitiva2 
CREATE DATABASE laPrimitiva2
GO
USE laPrimitiva2
GO

CREATE TABLE SORTEOS(
			idSorteo int identity(0,1) primary key,
			fechaSorteo smalldatetime not null,
			num1 int,
			num2 int,
			num3 int,
			num4 int,
			num5 int,
			num6 int,
			complementario int,
			reintegroSorteo int,
			constraint CK_reintegroSorteo check(reintegroSorteo between 1 and 9),
			constraint CK_num1Sorteo check(num1 between 1 and 49),
			constraint CK_num2Sorteo check(num2 between 1 and 49),
			constraint CK_num3Sorteo check(num3 between 1 and 49),
			constraint CK_num4Sorteo check(num4 between 1 and 49),
			constraint CK_num5Sorteo check(num5 between 1 and 49),
			constraint CK_num6Sorteo check(num6 between 1 and 49),
			constraint CK_complementarioSorteo check(complementario between 1 and 49)			
)

CREATE TABLE BOLETOS(
			idBoleto int identity(0,1),
			idSorteo int,
			reintegro int not null,
			tipoApuesta int not null,
			CONSTRAINT PK_BOLETOS PRIMARY KEY (idBoleto),
			CONSTRAINT FK_BOLETOS_SORTEOS FOREIGN KEY (idSorteo) REFERENCES SORTEOS(idSorteo)
)
CREATE TABLE NUMEROSBOLETOS(	
			idBoleto int,
			numero int,
			CONSTRAINT PK_NUMEROSBOLETOS PRIMARY KEY (idBoleto,numero),
			CONSTRAINT FK_NUMEROSBOLETOS_BOLETOS FOREIGN KEY (idBoleto) REFERENCES BOLETOS(idBoleto)
)


-- 2nd PARTE

CREATE TABLE PREMIOS (
					idPremio int identity(0,1) primary key,
					idSorteo int not null,
					categoria varchar not null,
					cantidad money not null default 0,
					constraint FK_sorteo_premios FOREIGN key (idSorteo) references SORTEOS(idSorteo),	
					constraint CK_categoriasPermitidasPremios check(categoria IN ('ESPECIAL', 'PRIMERA','SEGUNDA','TERCERA','CUARTA','QUINTA','SEXTA')),
					constraint CK_cantidadPremios check(cantidad >=0)
						)

-- drop table PREMIOS

CREATE TABLE BOLETO_PREMIO_SORTEO (
									idPremio int not null,
									idSorteo int not null,
									idBoleto int not null,
									CONSTRAINT PK_Bol_Prem_Sort PRIMARY KEY (idSorteo,idBoleto,idPremio),
									CONSTRAINT FK_BPS_Prem FOREIGN KEY (idPremio) REFERENCES PREMIOS(idPremio),
									CONSTRAINT FK_BPS_Bol FOREIGN KEY (idBoleto) REFERENCES BOLETOS(idBoleto),
									CONSTRAINT FK_BPS_Sort FOREIGN KEY (idSorteo) REFERENCES SORTEOS(idSorteo)
									)