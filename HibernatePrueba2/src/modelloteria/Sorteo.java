package modelloteria;

import java.sql.Timestamp;

import javax.persistence.*;



@Entity
@Table(name = "Sorteos")
public class Sorteo {
	
	@Column(name="id_sorteo")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_sorteo;
	@Column(name="fecha_sorteo")
	private Timestamp fecha_sorteo;
	@Column(name="reintegro")
	private short reintegro;
	@Column(name="complementario")
	private short complementario;
	
	public Sorteo (Timestamp fecha_sorteo,short reintegro,short complementario){
		this.fecha_sorteo=fecha_sorteo;
		this.reintegro=reintegro;
		this.complementario=complementario;
	}
	public Sorteo (){
		fecha_sorteo = null ;
		reintegro=-1;
		complementario=-1;
	}

	public int getId_sorteo() {
		return id_sorteo;
	}


	public Timestamp getFecha_sorteo() {
		return fecha_sorteo;
	}

	public void setFecha_sorteo(Timestamp fecha_sorteo) {
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
