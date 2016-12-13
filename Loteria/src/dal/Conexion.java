package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

	private String url;
	private String usuario;
	private String password;
	private Connection conexion;
	
	//Constructores
	public Conexion (){
		this.url="jdbc:sqlserver://localhost";
		this.usuario="userLoteria";
		this.password="passw";
		
	}
	
	public Conexion (String url,String usuario, String password){
		super();
		this.url=url;
		this.usuario=usuario;
		this.password=password;
		this.iniConexion();
		
		
	}
	
	//Getters && Setters
	
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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
	
	public Connection getConexion(){
		return this.conexion;
	}
	public void setConexion(Connection conexion){
		this.conexion=conexion;
	}
	
	
	
	//Metodos
	


	//Inicia una conexion
	/*	Interfaz:
	 * 		Breve comentario:
	 * 			Este metodo intenta iniciar una conexion con las propiedades de la clase.
	 * 				si hay algun problema saltara una excepcion.
	 * 		Cabecera:
	 * 			public void iniConexion()
	 * 		Precondiciones:
	 * 			Las propiedades de clase deben ser correctas
	 * 		Entradas:
	 * 			Nada
	 * 		Salida:
	 * 			Inicia una conexion.
	 * 		Postcondiciones:
	 * 			Nada
	 * */
	public void iniConexion(){
		try {
			this.conexion=DriverManager.getConnection(url, usuario, password);
		} catch (SQLException e) {
			System.out.println("Error de la conexion");		}
	}
	
	//Cerrar Conexion
	public void closeConexion(){
		try {
			this.conexion.close();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
	}
	
}
