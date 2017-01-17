package modelloteria;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

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
		@Column(name="id_sorteo")
		private int id_sorteo;
	//Fin Propiedades
	
		
	//Constructor
		
		public Boletos(){
			
		}
		public Boletos(int idsorteo, Timestamp fecha_compra, short reintegro, short numeros_jugados, double premio) {
			this.id_sorteo=idsorteo;
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
            
            //Query query = session.createQuery("select id_boleto from Boletos where id_sorteo=:idsorteo order by id_boleto desc").setParameter("idsorteo",1);
            //Query query = session.createNativeQuery("execute dbo.nuevoIDBoleto (?)").setParameter(1, 1);
            Query query = session.createNativeQuery("select dbo.nuevoIDBoleto (?)").setParameter(1, 1);
            //System.out.println(query.getSingleResult());
            //set @id_boleto=dbo.nuevoIDBoleto(@Sorteo) 
            
            //System.out.println(query.toString());
            id_boleto = (int)query.getSingleResult();
            //System.out.println();
            
            //List<?> resultado = query.getResultList();
            
            
          
            session.close();
			

		}
	
	
}
