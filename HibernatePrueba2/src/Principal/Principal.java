package Principal;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Scanner;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import funcionalidades.Funcionalidades;
import modelloteria.Boletos;
import modelloteria.Sorteo;
import modelloteria.SorteoFactory;

public class Principal {

	private static SessionFactory sessionFactory = null;

	public static void main(String[] args) {
		int opcionmenu,idsorteo,idboleto;
		Session session = null;
		Funcionalidades f = new Funcionalidades();
		Scanner sc = new Scanner(System.in); 
	    
	    
	         //Pintamos menu y leemos opcion de menu
	         do{
	        	 pintaMenuPrincipal();
	        	 opcionmenu = Integer.parseInt(sc.nextLine());
	         }while(opcionmenu<0||opcionmenu>2);
	         
	         //Mientras no quiera salir
	         while(opcionmenu!=0){
	        	 //Creamos La session
	        	 try {
	    	    	 sessionFactory = SorteoFactory.getSessionFactory();
	    	         session = sessionFactory.openSession();
	    	         
	    	         //Segun Opcion
	    	         switch (opcionmenu) {
					case 1:
						Sorteo s=null;
						Boletos b= null;
						List<Sorteo> sorteos = f.getSorteosAntiguos();
						
						boolean idsorteovalido=false;
						
						do{
							
							//Imprimimos los sorteos
							for(int i = 0;i<sorteos.size();i++) {
								System.out.println(sorteos.get(i).toString());
							}
						
						
							
							System.out.println("Introduzca el id del sorteo que quiere comprobar el boleto");
							//Recogemos el idsorteo de teclado
							idsorteo = Integer.parseInt(sc.nextLine());
							
							//Comprobamos que el id introducido sea correcto
							for(int i = 0;i<sorteos.size();i++) {
								if(idsorteo == sorteos.get(i).getId_sorteo()){
									idsorteovalido=true;
									s = session.get(Sorteo.class, idsorteo);
									
								}
							}
							
						}while (!idsorteovalido);
						
						
						do{
							boolean idboletovalido = false;
							System.out.println("Introduce el id del boleto que quiere comprobar");
							
							idboleto = Integer.parseInt(sc.nextLine());
							for(int i = 0;i<s.getBoletos().size();i++){
								if(s.getBoletos().get(i).getIdBoleto() == idboleto){
									idboletovalido=true;
									b = s.getBoletos().get(i);
								}
							}
							
							
						}while (!idsorteovalido);
						System.out.println(b.toString());
						
						break;

					case 2:
						
						break;
					}
	    	         
	    	         
	    	         
	        	 } catch (Exception e) {
	    	    	 System.out.println(e.getMessage());
	    	            
	    	     } finally {
	    	        session.close();
	    	     }
	        	 
	        	//Pintamos menu y leemos opcion de menu
		         do{
		        	 pintaMenuPrincipal();
		        	 opcionmenu = Integer.parseInt(sc.nextLine());
		         }while(opcionmenu<0||opcionmenu>2);
	         }
	         
	         
	         
	    
	}
	
	
	
	/**
	 *	Metodo PintaMenuPrincipal 
	 * 
	 * 	breve comentario: Pinta en pantalla un menu.
	 * */
	public static void pintaMenuPrincipal(){
		
		System.out.println("---------------------------");
		System.out.println("----------Loteria----------");
		System.out.println("---------------------------");
		System.out.println("------------Menu-----------");
		System.out.println("---------------------------");
		System.out.println("Opcion 1: Comprobar boletos");
		System.out.println("Opcion 2: Comprar boleto   ");
		System.out.println("Opcion 0: Salir			   ");
		System.out.println("---------------------------");
		System.out.println("---introduzca una opcion---");
	}
	
	
	
	 

}
