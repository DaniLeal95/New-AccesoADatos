package modelloteria;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Numeros")
public class NumerosBoletos {
	@Column(name="num_apostado")
	@Id
	private short numero;
	
	@ManyToOne
    @JoinColumn(name = "id_boleto",
            foreignKey = @ForeignKey(name = "id_sorteo_id_boleto_FK")
    )
	private Boletos num_boleto;
	
	@ManyToOne
    @JoinColumn(name = "id_sorteo",
            foreignKey = @ForeignKey(name = "id_sorteo_id_boleto_FK")
    )
	private Sorteo sorteo;
	
	
	public NumerosBoletos(){
	
	}
	
	public short getNumero() {
		return numero;
	}
	public Boletos getBoleto() {
		return num_boleto;
	}


	public Sorteo getSorteo() {
		return sorteo;
	}






	
	
}
