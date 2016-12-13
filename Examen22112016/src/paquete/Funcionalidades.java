package paquete;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;



public class Funcionalidades {

	/*
	 * Clase de funcionalidades
	 */
	/*
	 * Carga en un ResultSet  el contenido de la tabla BI_Actualizaciones Recorrer 
	 * el ResultSet insertando las visitas y las mascotas y enfermedades (cuando proceda)
	 * en la base de datos de la siguiente forma: 
	 *  • Las inserciones en la tabla BI_Mascotas han de hacerse mediante un ResultSet 
	 *  	actualizable. 
	 *  • Las inserciones en BI_MascotasEnfermedades deben hacerse con 
	 *  	una sentencia preparada (Prepared Statement o CallableStatement). 
	 *  	Esta sentencia debe ejecutar el procedimiento almacenado del ejercicio 1.
	 *  • Las inserciones en BI_Visitas las puedes hacer como mejor te parezca. 
	 * */
	
	
	public void Actualiza(){
		
		Conexion conexion=new Conexion();
		Statement sentencia;
		ResultSet resultado;
		

		
		String select = "Select Fecha,Temperatura,Peso,CodigoPropietario,Mascota,Raza,Especie,FechaNacimiento,FechaFallecimiento,Alias,CodigoPropietario,Enfermedad From BI_Actualizaciones";
		String select2="select * from BI_Actualizaciones";
		try{
			conexion.iniConexion();
			sentencia=conexion.getConexion().createStatement();
			resultado=sentencia.executeQuery(select2);
			String insertMascota = "Insert into BI_Mascotas (Codigo,Raza,Especie,FechaNacimiento,FechaFallecimiento,Alias,CodigoPropietario) values (?,?,?,?,?,?,?)";
			
			PreparedStatement sentenciapreparada = conexion.getConexion().prepareStatement(insertMascota);

			
			while(resultado.next()){
				
			
				
				//Si la raza es nulla quiere decir que ese perro ya lo tenemos
				if(resultado.getString("Raza")!=null){
					//LA E ECHO CON SENTENCIAS PREPARADAS POR ERRROR EN LA SIGUIENTE LO HAGO
					//CON RESULSET
					//añadimos los parametros 
					
					sentenciapreparada.setString(1,resultado.getString("CodigoMascota") );
					sentenciapreparada.setString(2,resultado.getString("Raza"));
					sentenciapreparada.setString(3,resultado.getString("Especie"));
					sentenciapreparada.setDate(4,resultado.getDate("FechaNacimiento"));
					sentenciapreparada.setDate(5,resultado.getDate("FechaFallecimiento"));
					sentenciapreparada.setString(6,resultado.getString("Alias"));
					sentenciapreparada.setInt(7,resultado.getShort("CodigoPropietario"));
					
					//ejecutamos la sentencia preparada
					sentenciapreparada.executeUpdate();
				}
				
			if(resultado.getString("Enfermedad")!=null){
				//No me da tiempo el resulset lo hago directamente ... LO SIENTO
				String sql = "execute dbo.insert_Mascotas_Enfermedades ?,?,?";
				CallableStatement senll=conexion.getConexion().prepareCall (sql);
				senll.setString (1,resultado.getString("Enfermedad"));
				senll.setDate (2,resultado.getDate("Fecha"));
				senll.setString (3,resultado.getString("CodigoMascota"));
				
		
				senll.executeUpdate();

			}
				
			
			//Insertamos Visita
			//String insertVisita = "Insert into BI_Visitas (Fecha,Temperatura,Peso,Mascota) values ("+resultado.getDate("Fecha")+","+resultado.getShort("Temperatura")+","+resultado.getInt("Peso")+","+resultado.getString("CodigoMascota")+")";
			//sentencia.executeUpdate(insertVisita);
			
			}
			
		}catch(SQLException sqle){
			System.out.println(sqle);
		}finally{
			conexion.closeConexion();
			
			
		}
		
		
	}
	
	
	
	

}
