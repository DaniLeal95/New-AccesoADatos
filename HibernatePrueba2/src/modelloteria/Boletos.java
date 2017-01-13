package modelloteria;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;

import javax.persistence.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.jdbc.Work;




@Entity
@Table(name = "Boletos")
public class Boletos {

	//Propiedades
		@Column(name="id_boleto")
		@Id
		private int id_boleto;
		@Column(name="fecha_compra")
		private Timestamp fecha_compra;
		@Column(name="reintegro")
		private short reintegro;
		@Column(name="numeros_jugados")
		private short numeros_jugados;
		@Column(name="Premio")
		private double premio;
	//Fin Propiedades
	
		
	//Constructor
		
		public Boletos(){
			
		}
		public Boletos(int idsorteo, Timestamp fecha_compra, short reintegro, short numeros_jugados, double premio) {
			this.obtenerID(idsorteo);
			this.fecha_compra = fecha_compra;
			this.reintegro = reintegro;
			this.numeros_jugados = numeros_jugados;
			this.premio = premio;
		}
	//Fin Constructor
	
		
	//Getters&Setters

		public Timestamp getFecha_compra() {
			return fecha_compra;
		}
	
		public void setFecha_compra(Timestamp fecha_compra) {
			this.fecha_compra = fecha_compra;
		}
	
		public short getReintegro() {
			return reintegro;
		}
	
		public void setReintegro(short reintegro) {
			this.reintegro = reintegro;
		}
	
		public short getNumeros_jugados() {
			return numeros_jugados;
		}
	
		public void setNumeros_jugados(short numeros_jugados) {
			this.numeros_jugados = numeros_jugados;
		}
	
		public double getPremio() {
			return premio;
		}
	
		public void setPremio(double premio) {
			this.premio = premio;
		}
		
	//Fin Getters&Setters

		//Metodos
		private void obtenerID(int idsorteo){
			
		
			SessionFactory sessionFactory = SorteoFactory.getSessionFactory();
            Session session = sessionFactory.openSession();
			
            //StoredProcedureQuery query = session.("nuevoIDBoleto")
            
            session.doWork( new Work() {
				
				@Override
				public void execute(Connection arg0) throws SQLException {
					CallableStatement callable = arg0.prepareCall("{? = call dbo.nuevoIDBoleto(?)}");
					callable.registerOutParameter( 1, Types.INTEGER );
			        callable.setInt(2,idsorteo);
			        callable.execute();
			        id_boleto = callable.getInt(1);
				}
			});
			

		}
	
	
}
