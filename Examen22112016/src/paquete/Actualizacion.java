package paquete;

public class Actualizacion {

	private short temperatura;
	private int peso,codPropietario;
	private String codMascota,raza,especie,fnac,ffall,alias,enfermedad,fecha;
	
	public Actualizacion() {
		
	}

	public Actualizacion(short temperatura, int peso, int codPropietario, String codMascota, String raza,
			String especie, String fnac, String ffall, String alias, String enfermedad) {
		
		this.temperatura = temperatura;
		this.peso = peso;
		this.codPropietario = codPropietario;
		this.codMascota = codMascota;
		this.raza = raza;
		this.especie = especie;
		this.fnac = fnac;
		this.ffall = ffall;
		this.alias = alias;
		this.enfermedad = enfermedad;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public short getTemperatura() {
		return temperatura;
	}

	public void setTemperatura(short temperatura) {
		this.temperatura = temperatura;
	}

	public int getPeso() {
		return peso;
	}

	public void setPeso(int peso) {
		this.peso = peso;
	}

	public int getCodPropietario() {
		return codPropietario;
	}

	public void setCodPropietario(int codPropietario) {
		this.codPropietario = codPropietario;
	}

	public String getCodMascota() {
		return codMascota;
	}

	public void setCodMascota(String codMascota) {
		this.codMascota = codMascota;
	}

	public String getRaza() {
		return raza;
	}

	public void setRaza(String raza) {
		this.raza = raza;
	}

	public String getEspecie() {
		return especie;
	}

	public void setEspecie(String especie) {
		this.especie = especie;
	}

	public String getFnac() {
		return fnac;
	}

	public void setFnac(String fnac) {
		this.fnac = fnac;
	}

	public String getFfall() {
		return ffall;
	}

	public void setFfall(String ffall) {
		this.ffall = ffall;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getEnfermedad() {
		return enfermedad;
	}

	public void setEnfermedad(String enfermedad) {
		this.enfermedad = enfermedad;
	}

	@Override
	public String toString() {
		return "Actualizacion [temperatura=" + temperatura + ", peso=" + peso + ", codPropietario=" + codPropietario
				+ ", codMascota=" + codMascota + ", raza=" + raza + ", especie=" + especie + ", fnac=" + fnac
				+ ", ffall=" + ffall + ", alias=" + alias + ", enfermedad=" + enfermedad + ", fecha=" + fecha + "]";
	}
	
	
	
	
}
