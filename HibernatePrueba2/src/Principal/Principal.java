package Principal;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import modelloteria.Sorteo;
import modelloteria.SorteoFactory;

public class Principal {

	private static SessionFactory sessionFactory = null;

	public static void main(String[] args) {
		
		 Session session = null;
	        try {
	            try {
	                sessionFactory = SorteoFactory.getSessionFactory();
	                session = sessionFactory.openSession();
	 
	                System.out.println("Insertando registro");
	                Transaction tx = session.beginTransaction();
	                //Creando un Objeto
//	                Empleado employe = new Empleado();
//	                employe.setNombre("Juanito");
//	                employe.setApellido("De la Vega");
	                Calendar c = GregorianCalendar.getInstance();;
	                c.set(2016, 12-1, 20);
	                Timestamp fecha = new Timestamp(c.getTimeInMillis());
	                
	                short reintegro=3;
	                short complementario = 9;
	                Sorteo s=new Sorteo(fecha,reintegro,complementario);
	                
	                //Guardando
	                //session.save(employe);
	                session.save(s);
	                
	                tx.commit();
	                System.out.println("Finalizado...");
	            } catch (Exception e) {
	                System.out.println(e.getMessage());
	            }
	        } finally {
	            session.close();
	        }
	}

}
