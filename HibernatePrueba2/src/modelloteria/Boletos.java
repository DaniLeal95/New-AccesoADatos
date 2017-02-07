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
		
		@ManyToOne
	    @JoinColumn(name = "id_sorteo",
	            foreignKey = @ForeignKey(name = "id_sorteo_FK_Sorteos")
	    )
		private Sorteo num_sorteo;
		
		@OneToMany(mappedBy="num_boleto",cascade = CascadeType.ALL, orphanRemoval = true)
		private List<NumerosBoletos> numerosboletos;
		
		
		

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

		public Sorteo getSorteo(){
			return this.num_sorteo;
		}
		public void setSorteo(Sorteo sorteo){
			this.num_sorteo=sorteo;
		}
		
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
		
		public List<NumerosBoletos> getnumBoletos(){
			return this.numerosboletos;
		}
		
		
		public int getIdBoleto(){
			return this.id_boleto;
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


            id_boleto = (int)query.getSingleResult();
            //System.out.println();
            
            //List<?> resultado = query.getResultList();
            
            
          
            session.close();
			

		}
		@Override
		public String toString() {
			return "Boletos [id_boleto=" + id_boleto + ", fecha_compra=" + fecha_compra + ", reintegro=" + reintegro
					+ ", premio=" + premio + ", num_sorteo=" + num_sorteo + "]";
		}
	
	
}
