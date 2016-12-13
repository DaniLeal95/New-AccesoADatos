

import java.sql.Statement;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import modelo.Boleto;

/*
 * Clase Funcionalidades
 * 	Esta clase sirve para utilizar funcionalidades de la base de datos.
 * */
public class Funcionalidades {
	
	/*
	 * ObtenerBoletos.
	 * 	BreveComentario:
	 * 		Este metodo devolvera un vector de Boletos, de todos los boletos que esten registrados
	 * 			en nuestra base de datos.
	 * 
	 * 	
	 * 
	 * */
	
	public void obtenerBoletos(){
		Vector<Actualizacion> columnas = new Vector<>(0,1);
		Conexion conexion=new Conexion();
		Statement sentencia;
		ResultSet resultado;
		
		String select = "Select "+Columnas.idBoleto_bol+","+Columnas.idSorteo_bol+","+Columnas.fechaCompra_bol+
				","+Columnas.numeros_jugados_bol+","+Columnas.reintegro_bol+","+Columnas.premio_bol+" From"
						+ " Boletos";
		try{
			conexion.iniConexion();
			sentencia=conexion.getConexion().createStatement();
			resultado=sentencia.executeQuery(select);
			
			while(resultado.next()){
				
				Boleto boleto = new Boleto();
				boleto.setId_boleto(resultado.getInt(Columnas.idBoleto_bol));
				boleto.setId_sorteo(resultado.getInt(Columnas.idSorteo_bol));
				boleto.setFecha_compra(resultado.getDate(Columnas.fechaCompra_bol));
				boleto.setReintegro(resultado.getShort(Columnas.reintegro_bol));
				boleto.setNumeros_jugados(resultado.getShort(Columnas.numeros_jugados_bol));
				boleto.setPremio(resultado.getDouble(Columnas.premio_bol));
				
				boletos.add(boleto);
			}
			
		}catch(SQLException sqle){
			System.out.println(sqle);
		}finally{
			conexion.closeConexion();
		}
		
		
		
		return boletos;
	}
	
	/*
	 * 
	 * 
	 * */
	public int crearSorteo(Date fechaDeSorteo,short reintegro,short complementario,short numero1,short numero2,short numero3,short numero4,short numero5,short numero6){
		int r=1;
		Conexion conexion=new Conexion();
		Statement sentencia;
		ResultSet resultado;
		
		short idSorteo=-1;
		
		String insertSorteo = "Insert into Sorteos ("+Columnas.fecha_Sorteo+","+Columnas.reintegro_Sorteo+","+Columnas.complementario_Sorteo+") values ("+fechaDeSorteo+","+reintegro+","+complementario+")";
		String selectBoleto = "Select top 1 "+Columnas.idSorteo_NumSorteo+ " from Sorteos order by "+Columnas.idSorteo_NumSorteo+" desc";

		
		
		try{
			conexion.iniConexion();
			sentencia=conexion.getConexion().createStatement();
			if(sentencia.executeUpdate(insertSorteo)>0){
				resultado=sentencia.executeQuery(selectBoleto);
				
				if(resultado.next()){
					idSorteo= resultado.getShort(Columnas.idSorteo_NumSorteo);
					
					if(idSorteo!=-1){
						String insertNumerosSorteos1 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero1+")";
						String insertNumerosSorteos2 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero2+")";
						String insertNumerosSorteos3 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero3+")";
						String insertNumerosSorteos4 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero4+")";
						String insertNumerosSorteos5 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero5+")";
						String insertNumerosSorteos6 = "Insert into NumerosSorteos ("+Columnas.idSorteo_NumSorteo+","+Columnas.numero_NumSorteo+") values ("+idSorteo+","+numero6+")";
						sentencia.executeUpdate(insertNumerosSorteos1);
						sentencia.executeUpdate(insertNumerosSorteos2);
						sentencia.executeUpdate(insertNumerosSorteos3);
						sentencia.executeUpdate(insertNumerosSorteos4);
						sentencia.executeUpdate(insertNumerosSorteos5);
						sentencia.executeUpdate(insertNumerosSorteos6);
					}	
				}else{
					r=-1;
				}
				
				
			}else{
				r=-1;
			}
			
			
			
			
		}catch(SQLException sqle){
			System.out.println(sqle);
		}finally{
			conexion.closeConexion();
		}
		
		
		return r;
	}
}
