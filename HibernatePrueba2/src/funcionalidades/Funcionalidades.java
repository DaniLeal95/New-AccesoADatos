package funcionalidades;

import java.util.List;
import javax.persistence.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import modelloteria.Sorteo;
import modelloteria.SorteoFactory;


public class Funcionalidades {
	private static SessionFactory sessionFactory = null;
	/*Clase de Funcionalidades*/
	
	
	//Recoge Todos los sorteos
	public List<Sorteo> getSorteosDisponibles(){
		Session session = null;
		List<Sorteo> sorteos = null;
		try{
			sessionFactory = SorteoFactory.getSessionFactory();
            session = sessionFactory.openSession();
			
            Query query = session.createNativeQuery("select * from Sorteos where fecha_sorteo>GETDATE()",Sorteo.class);
            
            sorteos = query.getResultList();
		}catch (Exception e) {
			
		}
		
		return sorteos;
	}
	public List<Sorteo> getSorteosAntiguos(){
		Session session = null;
		List<Sorteo> sorteos = null;
		try{
			sessionFactory = SorteoFactory.getSessionFactory();
            session = sessionFactory.openSession();
			
            Query query = session.createNativeQuery("select * from Sorteos where fecha_sorteo<GETDATE()",Sorteo.class);
            
            sorteos = query.getResultList();
		}catch (Exception e) {
			
		}
		
		return sorteos;
	}
	
	
	public void insertBoletoSimple(int idsorteo,int numero1,int numero2,int numero3,int numero4,int numero5,int numero6){
		
		Session session = null;
		List<Sorteo> sorteos = null;
		try{
			sessionFactory = SorteoFactory.getSessionFactory();
            session = sessionFactory.openSession();
			
            session.createNativeQuery("execute dbo.GrabaSencilla ?,?,?,?,?,?,?")
            		.setParameter(1, idsorteo)
            		.setParameter(2, numero1)
            		.setParameter(3, numero2)
            		.setParameter(4, numero3)
            		.setParameter(5, numero4)
            		.setParameter(6, numero5)
            		.setParameter(7, numero6);


		}catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
	}
}
