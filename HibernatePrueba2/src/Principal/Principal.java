package Principal;

import java.awt.image.RescaleOp;
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
		List<Sorteo> sorteos =null;
		Sorteo s=null;
		Boletos b= null;
	    
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
	    	         //CASO DE QUE DESEE COMPROBAR UN BOLETO
					case 1:
						
						sorteos = f.getSorteosAntiguos();
						
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
						boolean idboletovalido = false;
						
						do{
							
							System.out.println("Introduce el id del boleto que quiere comprobar");
							
							idboleto = Integer.parseInt(sc.nextLine());
							for(int i = 0;i<s.getBoletos().size();i++){
								if(s.getBoletos().get(i).getIdBoleto() == idboleto){
									idboletovalido=true;
									b = s.getBoletos().get(i);
								}
							}
							
							
						}while (!idboletovalido );
						System.out.println(b.toString());
						
						break;

						
						//CASO DE QUE DESEE INSERTAR UN NUVO BOLETO
					case 2:
						
						sorteos = f.getSorteosDisponibles();
						
						
						boolean idsorteovalidodisp=false;
						
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
									idsorteovalidodisp=true;
									s = session.get(Sorteo.class, idsorteo);
									
								}
							}
						}while(!idsorteovalidodisp);
						
						char respuesta;
						//Preguntamos si quiere un boleto multiple o uno simple
						do{
							System.out.println("De que tipo desea el boleto?");
							System.out.println("Introduzca M si lo desea multiple,");
							System.out.println("Introduzca S si lo desea simple,");
							respuesta =Character.toUpperCase(sc.nextLine().charAt(0));
						}while(respuesta != 'M' && respuesta!= 'S');
						
						//Si el usuario quiere insertar un boleto simple
						if(respuesta == 'S'){
							int numero1=0,numero2=0,numero3=0,numero4=0,numero5=0,numero6=0;
							
							for (int i = 0; i<6;i++){
								int numero;
								//Pedimos el numero
								do{
									System.out.println("Introduce el numero"+i+1+" .Recuerda que debe estar entre 1 y 49");
									numero=Integer.parseInt(sc.nextLine());
								}while(numero<1 && numero>49);
								
								//Segun el numero por el que vayamos
								switch (i) {
								case 0:	
									numero1 = numero;
									break;
								case 1:
									numero2=numero;
									break;
								case 2:
									numero3=numero;
									break;
								case 3:
									numero4=numero;
									break;
								case 4:
									numero5=numero;
									break;
								case 5:
									numero6=numero;
									break;
								}
								
							}
							
							f.insertBoletoSimple(s.getId_sorteo(), numero1, numero2, numero3, numero4, numero5, numero6);							
							
						}
						//Si el usuario quiere insertar un boleto multiple
						else{
							
							//primero preguntamos de cuantos numeros quiere el boleto
							int numainsertar;
							do{
								
								System.out.println("De cuantos numeros quieres el boleto?");
								System.out.println("Recuerda solo :5,7,8,9,10 o 11");
								numainsertar=Integer.parseInt(sc.nextLine());
							}while(numainsertar<5 || numainsertar==6 || numainsertar>11);
							
							int numero1=0,numero2=0,numero3=0,numero4=0,numero5=0,numero6=0,numero7=0,numero8=0,numero9=0;
							int numero10=0,numero11=0;
							
							
							//Para pedir los numeros segun la cantidad que quiera el usuario
							for (int i = 0; i<numainsertar;i++){
								int numero;
								//Pedimos el numero
								do{
									System.out.println("Introduce el numero"+(i+1)+" .Recuerda que debe estar entre 1 y 49");
									numero=Integer.parseInt(sc.nextLine());
								}while(numero<1 && numero>49);
								
								//Segun el numero por el que vayamos
								switch (i) {
								case 0:	
									numero1 = numero;
									break;
								case 1:
									numero2=numero;
									break;
								case 2:
									numero3=numero;
									break;
								case 3:
									numero4=numero;
									break;
								case 4:
									numero5=numero;
									break;
								case 5:
									numero6=numero;
									break;
								case 6:
									numero7=numero;
									break;
								case 7:
									numero8=numero;
									break;
								case 8:
									numero9=numero;
									break;
								case 9:
									numero10=numero;
									break;
								case 10:
									numero11=numero;
									break;
								case 11:
									numero6=numero;
									break;
								
								
								}
							}
							
							switch (numainsertar) {
							case 5:	
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5);
								break;
							case 7:
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5,numero6,numero7);
								break;
							case 8:
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8);
								break;
							case 9:
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8,numero9);
								break;
							case 10:
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8,numero9,numero10);
								break;
							case 11:
								f.insertBoletoMultiple(s.getId_sorteo(), numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8,numero9,numero10,numero11);
								break;
							}
							
						}
						
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
		System.out.println("Opcion 3: Mostrar la combinacion ganadora de un sorteo");
		System.out.println("Opcion 0: Salir			   ");
		System.out.println("---------------------------");
		System.out.println("---introduzca una opcion---");
	}
	
	
	
	 

}
