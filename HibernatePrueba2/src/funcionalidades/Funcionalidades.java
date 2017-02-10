package funcionalidades;

import java.util.List;
import javax.persistence.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.hibernate.result.ResultSetOutput;

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
		
		try{
			sessionFactory = SorteoFactory.getSessionFactory();
            session = sessionFactory.openSession();
            
           ProcedureCall procedureCall=
           session.createStoredProcedureCall("dbo.GrabaSencilla");
            		procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
            		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
            		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
            		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
            		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
            		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
            		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
            		
            		/*2procedureCall.getParameterRegistration("idsorteo");
            		procedureCall.getParameterRegistration("num1");
            		procedureCall.getParameterRegistration("num2");
            		procedureCall.getParameterRegistration("num3");
            		procedureCall.getParameterRegistration("num4");
            		procedureCall.getParameterRegistration("num5");
            		procedureCall.getParameterRegistration("num6");*/
            		
            		
            
		}catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
public void insertBoletoMultiple(int idsorteo,int... numeros){
		
		Session session = null;
		
		try{
			sessionFactory = SorteoFactory.getSessionFactory();
            session = sessionFactory.openSession();
			
            int cantidadDenumeros= numeros.length;
            ProcedureCall procedureCall;
            
           int numero6,numero7,numero8,numero9,numero10,numero11;
            int numero1=numeros[0],numero2=numeros[1],numero3=numeros[2],numero4=numeros[3],numero5=numeros[4];
            
            switch(cantidadDenumeros){
            case 5:

            	procedureCall=
                session.createStoredProcedureCall("dbo.GrabaMultiple");
            	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
        		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
        		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
        		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
        		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
        		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
            	break;
            case 7:
            	numero6=numeros[5];numero7=numeros[6];
            	procedureCall=
                        session.createStoredProcedureCall("dbo.GrabaMultiple");
                    	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
                		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
                		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
                		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
                		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
                		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
                		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
            	
            	
            	break;
            case 8:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];
            	session.createNativeQuery("execute dbo.GrabaMultiple ?,?,?,?,?,?,?,?,?")
        		.setParameter(1, idsorteo)
        		.setParameter(2, numero1)
        		.setParameter(3, numero2)
        		.setParameter(4, numero3)
        		.setParameter(5, numero4)
        		.setParameter(6, numero5)
        		.setParameter(7, numero6)
            	.setParameter(8, numero7)
            	.setParameter(9, numero8);

            	break;
            case 9:
            	
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];
            	session.createNativeQuery("execute dbo.GrabaMultiple ?,?,?,?,?,?,?,?,?,?")
        		.setParameter(1, idsorteo)
        		.setParameter(2, numero1)
        		.setParameter(3, numero2)
        		.setParameter(4, numero3)
        		.setParameter(5, numero4)
        		.setParameter(6, numero5)
        		.setParameter(7, numero6)
            	.setParameter(8, numero7)
            	.setParameter(9, numero8)
            	.setParameter(10, numero9);
            	break;
            case 10:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];numero10=numeros[9];
            	session.createNativeQuery("execute dbo.GrabaMultiple ?,?,?,?,?,?,?,?,?,?,?")
        		.setParameter(1, idsorteo)
        		.setParameter(2, numero1)
        		.setParameter(3, numero2)
        		.setParameter(4, numero3)
        		.setParameter(5, numero4)
        		.setParameter(6, numero5)
        		.setParameter(7, numero6)
            	.setParameter(8, numero7)
            	.setParameter(9, numero8)
            	.setParameter(10, numero9)
            	.setParameter(11, numero10);
            	
            	break;
            case 11:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];numero10=numeros[9];numero11=numeros[10];
            	session.createNativeQuery("execute dbo.GrabaMultiple ?,?,?,?,?,?,?,?,?,?,?,?")
        		.setParameter(1, idsorteo)
        		.setParameter(2, numero1)
        		.setParameter(3, numero2)
        		.setParameter(4, numero3)
        		.setParameter(5, numero4)
        		.setParameter(6, numero5)
        		.setParameter(7, numero6)
            	.setParameter(8, numero7)
            	.setParameter(9, numero8)
            	.setParameter(10, numero9)
            	.setParameter(11, numero10)
            	.setParameter(12, numero11);
            	
            	break;
            }
            
            


		}catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
	
}
