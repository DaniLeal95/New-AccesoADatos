/*
 METODOS
 insertarBoleto
 generarBoleto
 comprobarAciertosBoleto
 insertarSorteo usar ResultSet
 */

package Gestion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.microsoft.sqlserver.jdbc.SQLServerStatement; //esto lo he a�adido xq dice Source not found con el jdbc
//a�adido xq no me va el resultset x falta de un .class ??
import java.sql.Connection;
import java.sql.DriverManager;

public class gestLaPrimitiva {

	public gestLaPrimitiva(){}
	/* void insertarBoleto(Statement sentencia,java.sql.Timestamp fechaHora)
	 
	  usa GrabaMuchasSencillas (smalldatetime fecha,int cantidad)
	  Procedimiento: utiliza el procedimiento almacenado GrabaMuchasSencillas pasandole como parametro una fecha de sorteo
	   				y el numero 1, ya que solo vamos a generar un boleto
	  Entrada: Statement con la conexion abierta / fecha y hora del sorteo (el sorteo debe estar creado)
	  Salida: numero de filas afectadas
	  Precondicion: el sorteo debe estar creado, ya que se cogera el idSorteo del que tenga la fecha posterior o igual a la insercion del boleto
	 */
	 public void insertarBoleto(Statement sentencia, java.sql.Timestamp fechaHora) throws SQLException, ParseException{
		 int filasAfectadas = 0;
		 ResultSet idSorteo;
		 String ordenSelect = "select top 1 idSorteo from SORTEOS where fechaSorteo>="+fechaHora.getDate()+" order by fechaSorteo desc";//cogemos el sorteo mas cercano al boleto
		 idSorteo = sentencia.executeQuery(ordenSelect);
		 
		 idSorteo.next();//me coloco en la fila que he recogido
		 String ordenInsertar = "EXECUTE GrabaMuchasSencillas "+idSorteo.getInt("idSorteo")+", 1";
		 filasAfectadas=sentencia.executeUpdate(ordenInsertar); //puede esto devolver algo que no sea resulset para verificar que se inserto??
		 
		 System.out.println("Filas afectadas: "+filasAfectadas); //quitar esto y poner un return con filas afectadas
	 }
	/* void insertarSorteo(Statement sentencia, java.sql.Timestamp fechaHora, int num1, int num2, int num3, int num4, int num5,int num6, int complementario, int reintegro)
	 
	  Procedimiento: inserta un Sorteo en la BD utilizando Resultset
	  Entrada: Statement con la conexion abierta / fecha y hora del sorteo / numeros del sorteo
	  Salida: nueva fila en la BD
	 */
	 public void insertarSorteo(Statement sentencia, java.sql.Timestamp fechaHora, int num1, int num2, int num3, int num4, int num5,int num6, int complementario, int reintegro) throws SQLException{
		 
		 ResultSet rsSorteos;
		 String ordenSelect = "select * from SORTEOS";
		 rsSorteos = sentencia.executeQuery(ordenSelect);
		 
/* while(rsSorteos.next()){
			 System.out.println(rsSorteos.getInt("idSorteo"));
		 }*/

		 
		 	rsSorteos.moveToInsertRow(); //no he puesto id xq es identity, seria la colum 0 o la 1??
		 	rsSorteos.updateTimestamp("fechaSorteo", fechaHora);
			rsSorteos.updateInt("num1", num1);
			rsSorteos.updateInt("num2", num2);
			rsSorteos.updateInt("num3", num3);
			rsSorteos.updateInt("num4", num4);
			rsSorteos.updateInt("num5", num5);
			rsSorteos.updateInt("num6", num6);
			rsSorteos.updateInt("complementario", complementario);
			rsSorteos.updateInt("reintegroSorteo", reintegro);
			rsSorteos.insertRow();
	 }
	 
}
