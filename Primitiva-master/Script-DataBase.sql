Create Database Loteria
go
use Loteria
go
Create table Sorteos(
	id_sorteo int not null Constraint id_sorteo_PK Primary key identity(1,1) ,
	fecha_sorteo smalldatetime not null,
	reintegro tinyint null check(reintegro between 1 and 49),
	complementario tinyint null check(complementario between 1 and 49)
)

Create table NumerosSorteos(
	id_sorteo int not null Constraint id_sorteo_FK_numerosSorteos Foreign key references Sorteos(id_sorteo),
	numero tinyint not null check(numero between 1 and 49),
	constraint PK_NumerosSorteos Primary key (id_sorteo,numero)
)

Create table Boletos(
	
	id_boleto int not null ,
	id_sorteo int not null constraint id_sorteo_FK_Sorteos Foreign key references Sorteos(id_sorteo),
	fecha_compra smalldatetime not null,
	reintegro tinyint not null constraint reintegroDe0a9 check (reintegro between 0 and 9),
	numeros_jugados tinyint not null check (numeros_jugados between 5 and 11),
	Premio money not null Default 0
	constraint id_sorteo_id_boleto_PK Primary key (id_boleto,id_sorteo)
)

Create table Numeros(
	id_sorteo int not null,
	id_boleto int not null,
	num_apostado tinyint not null constraint boletoDe1a49 check (Num_apostado between 1 and 49),
	constraint id_sorteo_id_boleto_FK Foreign key (id_boleto, id_sorteo) references Boletos(id_boleto,id_sorteo),
	constraint PKNUMEROS primary key (id_sorteo,id_boleto,num_apostado)

)



--DROP DATABASE Loteria