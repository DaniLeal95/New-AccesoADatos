package modelloteria;

import javax.persistence.*;

@Entity
@Table(name ="NumerosSorteos")
public class NumerosSorteos {
	@Column(name="numero")
	@Id
	private short numero;
	
	@ManyToOne
    @JoinColumn(name = "id_sorteo",
            foreignKey = @ForeignKey(name = "id_sorteo_FK_numerosSorteos")
    )
	private Sorteo sorteo;
	
	public NumerosSorteos(){
		
	}

	public short getNumero() {
		return numero;
	}


	
	

}
