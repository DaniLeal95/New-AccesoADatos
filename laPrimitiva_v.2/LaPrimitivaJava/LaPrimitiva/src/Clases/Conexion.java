/*
 	Una vez activado TCP/IP en Sql Server Configuration Manager y desactivado Firewall			
 	Por defecto se intenta conectar al puerto 1433, que es donde SQL escucha por defecto
 	Para saber el puerto de escucha de tu SQL ejecuta en master: Xp_readerrorlog
 	Y busca:	Server is listening on [ 127.0.0.1 <ipv4> 1434]. Para saber el puerto, que en mi casa es 1434
 	Ademas: he activado la autenticacion por SQL y Windows, en vez de solo Windows (propiedades de mi servidor)
 			y he a�adido el puerto 1434 a las propiedades de TCP/IP  y Deshabilitada Shared memory
 */

package Clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexion {
	private String sourceURL = "";
	private String usuario = "";
	private String password="";
	
	//CONSTRUCTORES
	public Conexion(){}
	
	public Conexion(String usuario,String password){
		this.sourceURL = "jdbc:sqlserver://localhost"; 
		//this.sourceURL="jdbc:sqlserver://localhost:1434;databaseName=laPrimitiva2";
		this.usuario = usuario;
		this.password= password;
	}
	
	public Conexion(String sourceURL, String usuario, String password){
		this.sourceURL= sourceURL;
		this.usuario = usuario;
		this.password= password;
	}
	
	// GET Y SET
	public String getSourceURL() {
		return sourceURL;
	}

	public void setSourceURL(String sourceURL) {
		this.sourceURL = sourceURL;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	//METODOS A�ADIDOS
	/*
	 Conectar con la BS y devolver un Statement
	 Luego solo habra que escribir el statementX.exequteQuery(orden), o statementX.execute(orden)
	 */
	public Statement conectarBD(){
		Connection conexionBD = null;
		Statement sentencia = null;
		
		try{
			conexionBD = DriverManager.getConnection(this.getSourceURL(), this.getUsuario(),this.getPassword());
			sentencia = conexionBD.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); //para podernos desplazar por el resultset y hacer update
			// https://msdn.microsoft.com/es-es/library/ms378405(v=sql.110).aspx	COMBINACIONES DE CURSOR POSIBLES
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return sentencia;
	}
	
	/*
	 Desconecta la base de datos
	 */
	public void desConectarBD(){
		try{
			this.conectarBD().close(); //cierro Statement
			this.conectarBD().getConnection().close();//cierro Conexion
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
