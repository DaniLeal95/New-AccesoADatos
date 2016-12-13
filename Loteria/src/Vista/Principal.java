package Vista;

import java.sql.Date;
import java.util.Calendar;
import java.util.Scanner;
import java.util.Vector;

import dal.Funcionalidades;
import modelo.Boleto;

public class Principal {

	public static void main(String[] args) {
		int opcion;
		Vector<Boleto> boletos=new Vector<Boleto>(0,1);
		Funcionalidades f=new Funcionalidades();
		Scanner sc = new Scanner(System.in);
		
		do{
			System.out.println("Introduzca Opcion");
			opcion=sc.nextInt();	
		
		}while (opcion<0 || opcion>2);
		while(opcion!=0){
			switch(opcion){
			
			case 1:
				boletos=f.obtenerBoletos();
				System.out.println("IbBoleto \tIdSorteo \tFechade Compra \t\tReintegro \tNum Jugados \tPremio");
				for(int i=0;i<boletos.size();i++){
					if(boletos.elementAt(i).getPremio()>0){
						System.out.print(boletos.elementAt(i).getId_boleto());
						System.out.print("\t\t"+boletos.elementAt(i).getId_sorteo());
						System.out.print("\t\t"+boletos.elementAt(i).getFecha_compra());
						System.out.print("\t\t"+boletos.elementAt(i).getReintegro());
						System.out.print("\t\t"+boletos.elementAt(i).getNumeros_jugados());
						System.out.print("\t\t"+boletos.elementAt(i).getPremio());
						System.out.println();
					}
				}
				do{
					System.out.println("Introduzca Opcion");
					opcion=sc.nextInt();	
				
				}while (opcion<0 || opcion>2);
			
				break;
			case 2:
				
				short reintegro,complementario,num1,num2,num3,num4,num5,num6;
				Date fecha;
				System.out.println("OPCION NUEVO SORTEO");
				
				System.out.println("Introduzca el numero del reintegro del sorteo");
				reintegro=sc.nextShort();
				System.out.println("Introduzca el numero complementario del sorteo");
				complementario = sc.nextShort();
				System.out.println("Introduzca el numero 1");
				num1= sc.nextShort();
				System.out.println("Introduzca el numero 2");
				num2= sc.nextShort();
				System.out.println("Introduzca el numero 3");
				num3= sc.nextShort();
				System.out.println("Introduzca el numero 4");
				num4= sc.nextShort();
				System.out.println("Introduzca el numero 5");
				num5= sc.nextShort();
				System.out.println("Introduzca el numero 6");
				num6= sc.nextShort();
				
				/*Creacion De la Fecha*/
				   Calendar cal = Calendar.getInstance();
				    
				    // set Date portion to January 1, 1970
				    cal.set( cal.YEAR, 2016 );
				    cal.set( cal.MONTH, cal.DECEMBER );
				    cal.set( cal.DATE, 20 );
				    
				    cal.set( cal.HOUR_OF_DAY, 0 );
				    cal.set( cal.MINUTE, 0 );
				    cal.set( cal.SECOND, 0 );
				    cal.set( cal.MILLISECOND, 0 );
				fecha=new Date(cal.getTime().getTime());
				
				if(f.crearSorteo(fecha, reintegro, complementario, num1, num2, num3, num4, num5, num6)==1)
					System.out.println("Sorteo Creado Correctamente");
				
			
			}
			
			
			do{
				System.out.println("Introduzca Opcion");
				opcion=sc.nextInt();	
			
			}while (opcion<0 || opcion>2);
		break;
		}
	}

}
