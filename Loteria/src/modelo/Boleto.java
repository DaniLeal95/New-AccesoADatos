package modelo;

import java.sql.Date;


public class Boleto {
	/*
	 * Clase Boletos
	 * 	 Propiedades: id_boleto int
	 * 				  id_sorteo int
	 * 				  fecha_compra smallDateTime
	 * 				  reintegro tinyint
	 * 				  numeros_jugados tinyint
	 * 				  Premio money
	 * 		
	 * */
	
	private int id_boleto;
	private int id_sorteo;
	private Date fecha_compra;
	private short reintegro;
	private short numeros_jugados;
	private double Premio;
	
	//Constructores
	public Boleto(int id_boleto, int id_sorteo, Date fecha_compra, short reintegro, short numeros_jugados,
			double premio) {
		
		this.id_boleto = id_boleto;
		this.id_sorteo = id_sorteo;
		this.fecha_compra = fecha_compra;
		this.reintegro = reintegro;
		this.numeros_jugados = numeros_jugados;
		this.Premio = premio;
	}
	
	public Boleto(){
		id_boleto=0;
		id_sorteo=0;
		fecha_compra=null;
		reintegro=0;
		numeros_jugados=0;
		Premio=0.0;
			
	}

	public int getId_boleto() {
		return id_boleto;
	}

	public void setId_boleto(int id_boleto) {
		this.id_boleto = id_boleto;
	}

	public int getId_sorteo() {
		return id_sorteo;
	}

	public void setId_sorteo(int id_sorteo) {
		this.id_sorteo = id_sorteo;
	}

	public Date getFecha_compra() {
		return fecha_compra;
	}

	public void setFecha_compra(Date date) {
		this.fecha_compra = date;
	}

	public short getReintegro() {
		return reintegro;
	}

	public void setReintegro(short reintegro) {
		this.reintegro = reintegro;
	}

	public short getNumeros_jugados() {
		return numeros_jugados;
	}

	public void setNumeros_jugados(short numeros_jugados) {
		this.numeros_jugados = numeros_jugados;
	}

	public double getPremio() {
		return Premio;
	}

	public void setPremio(double premio) {
		Premio = premio;
	}
	
	
	
	
	
}
