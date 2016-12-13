package model;

import java.sql.Date;
import java.util.Calendar;

import javax.persistence.*;



@Entity
@Table(name = "Sorteos")
public class Sorteo {
	
	@Column(name="id_sorteo")
	@Id
	@GeneratedValue
	private int id_sorteo;
	@Column(name="fecha_sorteo")
	private Calendar fecha_sorteo;
	@Column(name="reintegro")
	private short reintegro;
	@Column(name="complementario")
	private short complementario;
	
	public Sorteo (Calendar fecha_sorteo,short reintegro,short complementario){
		this.fecha_sorteo=fecha_sorteo;
		this.reintegro=reintegro;
		this.complementario=complementario;
	}

	public int getId_sorteo() {
		return id_sorteo;
	}


	public Calendar getFecha_sorteo() {
		return fecha_sorteo;
	}

	public void setFecha_sorteo(Calendar fecha_sorteo) {
		this.fecha_sorteo = fecha_sorteo;
	}

	public short getReintegro() {
		return reintegro;
	}

	public void setReintegro(short reintegro) {
		this.reintegro = reintegro;
	}

	public short getComplementario() {
		return complementario;
	}

	public void setComplementario(short complementario) {
		this.complementario = complementario;
	}
	
	
}
