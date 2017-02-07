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
	
	
}
