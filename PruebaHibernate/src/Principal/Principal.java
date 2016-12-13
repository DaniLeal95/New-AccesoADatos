package Principal;

import java.util.Calendar;
import java.util.GregorianCalendar;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import model.Sorteo;
import model.SorteoFactory;

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
	                Calendar c = new GregorianCalendar();
	                c.getTime();
	                short reintegro=3;
	                short complementario = 9;
	                Sorteo s=new Sorteo(c,reintegro,complementario);
	                
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
