package Principal;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import modelloteria.Boletos;
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

	               /* Calendar c = GregorianCalendar.getInstance();;
	                c.set(2016, 12-1, 20);
	                Timestamp fecha = new Timestamp(c.getTimeInMillis());
	                
	                short reintegro=3;
	                short complementario = 9;
	                Sorteo s=new Sorteo(fecha,reintegro,complementario);*/
	                
	                Sorteo s= (Sorteo)session.get(Sorteo.class,1);
	                s.numeroDeBoletos();
	                
	                Boletos b= (Boletos)session.get(Boletos.class, 1);
	                
	                for(int i = 0;i<b.getnumBoletos().size();i++){
	                	System.out.println(b.getnumBoletos().get(i).getNumero());
	                }
	                
	                //Boletos b = (Boletos) session.get(Boletos.class, 1);
	                //System.out.println(b.getSorteo().getReintegro());
	                //Query query = session.createNativeQuery("select * from Sorteos where id_sorteo=?").setParameter(1, 1);
	                //Sorteo s = (Sorteo)query.Ge();
	                
	               // System.out.println(s.numeroDeBoletos());
	                //CREO UN BOLETO
	              //Creamos boletos
	              /*  Calendar c2 = GregorianCalendar.getInstance();
	                c2.set(2016, 12-1, 20);
	                Timestamp fecha2 = new Timestamp(c2.getTimeInMillis());
	                short a=6;
	                short b=7;
	                
                	Boletos boleto = new Boletos(s.getId_sorteo(),fecha2,a,b,0.0);*/
	                
	                
	                //Guardando
	               
	                //session.save(s);
	                
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
