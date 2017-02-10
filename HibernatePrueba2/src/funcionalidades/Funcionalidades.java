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
                		procedureCall.registerParameter(8,Integer.class, ParameterMode.IN).bindValue(numero7);
            	
            	
            	break;
            case 8:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];
            	procedureCall=
                        session.createStoredProcedureCall("dbo.GrabaMultiple");
                    	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
                		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
                		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
                		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
                		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
                		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
                		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
                		procedureCall.registerParameter(8,Integer.class, ParameterMode.IN).bindValue(numero7);
                		procedureCall.registerParameter(9,Integer.class, ParameterMode.IN).bindValue(numero8);

            	break;
            case 9:
            	
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];
            	procedureCall=
                        session.createStoredProcedureCall("dbo.GrabaMultiple");
                    	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
                		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
                		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
                		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
                		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
                		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
                		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
                		procedureCall.registerParameter(8,Integer.class, ParameterMode.IN).bindValue(numero7);
                		procedureCall.registerParameter(9,Integer.class, ParameterMode.IN).bindValue(numero8);
                		procedureCall.registerParameter(10,Integer.class, ParameterMode.IN).bindValue(numero9);
            	break;
            case 10:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];numero10=numeros[9];
               	procedureCall=
                        session.createStoredProcedureCall("dbo.GrabaMultiple");
                    	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
                		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
                		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
                		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
                		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
                		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
                		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
                		procedureCall.registerParameter(8,Integer.class, ParameterMode.IN).bindValue(numero7);
                		procedureCall.registerParameter(9,Integer.class, ParameterMode.IN).bindValue(numero8);
                		procedureCall.registerParameter(10,Integer.class, ParameterMode.IN).bindValue(numero9);
                		procedureCall.registerParameter(11,Integer.class, ParameterMode.IN).bindValue(numero10);
            	
            	break;
            case 11:
            	numero6=numeros[5];numero7=numeros[6];numero8=numeros[7];numero9=numeros[8];numero10=numeros[9];numero11=numeros[10];
            	procedureCall=
                        session.createStoredProcedureCall("dbo.GrabaMultiple");
                    	procedureCall.registerParameter(1,Integer.class, ParameterMode.IN).bindValue(idsorteo);
                		procedureCall.registerParameter(2,Integer.class, ParameterMode.IN).bindValue(numero1);
                		procedureCall.registerParameter(3,Integer.class, ParameterMode.IN).bindValue(numero2);
                		procedureCall.registerParameter(4,Integer.class, ParameterMode.IN).bindValue(numero3);
                		procedureCall.registerParameter(5,Integer.class, ParameterMode.IN).bindValue(numero4);
                		procedureCall.registerParameter(6,Integer.class, ParameterMode.IN).bindValue(numero5);
                		procedureCall.registerParameter(7,Integer.class, ParameterMode.IN).bindValue(numero6);
                		procedureCall.registerParameter(8,Integer.class, ParameterMode.IN).bindValue(numero7);
                		procedureCall.registerParameter(9,Integer.class, ParameterMode.IN).bindValue(numero8);
                		procedureCall.registerParameter(10,Integer.class, ParameterMode.IN).bindValue(numero9);
                		procedureCall.registerParameter(11,Integer.class, ParameterMode.IN).bindValue(numero10);
                		procedureCall.registerParameter(12,Integer.class, ParameterMode.IN).bindValue(numero11);
            	
            	break;
            }
            
            


		}catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
	
}
