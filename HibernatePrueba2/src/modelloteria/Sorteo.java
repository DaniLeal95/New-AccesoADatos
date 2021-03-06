package modelloteria;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
	
	@OneToMany(mappedBy="num_sorteo",cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Boletos> boletos;
	
	@OneToMany(mappedBy="sorteo",cascade = CascadeType.ALL, orphanRemoval = true)
	private List<NumerosSorteos> numerosSorteos;
	
	public List<Boletos> getBoletos() {
		return boletos;
	}
	public void setBoletos(List<Boletos> boletos) {
		this.boletos = boletos;
	}
	public void setId_sorteo(int id_sorteo) {
		this.id_sorteo = id_sorteo;
	}
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
	
	public List<NumerosSorteos> getNumerosSorteos(){
		return this.getNumerosSorteos();
	}
	
	public long numeroDeBoletos(){
		long totalBoletos = 0;
		
		for (int i =0;i<boletos.size();i++){
			System.out.println(boletos.get(i).toString());
		}
		return totalBoletos;
	}
	@Override
	public String toString() {
		return "Sorteo [id_sorteo=" + id_sorteo + ", fecha_sorteo=" + fecha_sorteo + "]";
	}
	
	
	
}
