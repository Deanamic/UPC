package ROMERO;

import java.util.Arrays;

public class StubRanquing {
	
	/** Atributs **/
	
	private String[][] ranquingFacil = new String[2][10];
	private String[][] ranquingMitja = new String[2][10];	
	private String[][] ranquingDificil = new String[2][10];
	private int ocupatFacil;
	private int ocupatMitja;
	private int ocupatDificil;
		
	/** Constructora **/
	
	public StubRanquing() {
		ocupatFacil = ocupatMitja = ocupatDificil = 0;
		Arrays.fill(ranquingFacil[0], "NA");
		Arrays.fill(ranquingMitja[0], "NA");
		Arrays.fill(ranquingDificil[0], "NA");
		Arrays.fill(ranquingFacil[1], "NA");
		Arrays.fill(ranquingMitja[1], "NA");
		Arrays.fill(ranquingDificil[1], "NA");
	}
	
	/** Metodos publicos **/
	
	public String[][] getRanquing(String dificultat) {
		if (dificultat.equals("Facil")) 
			return ranquingFacil;
		else if (dificultat.equals("Mitja")) 
			return ranquingMitja;
		else return ranquingDificil;
	}
	
	public boolean afegeixNom(String nom, int torns, String dificultat) {
		if (dificultat.equals("Facil")) {
			ranquingFacil[0][0] = nom;
			ranquingFacil[1][0] = Integer.toString(torns);

		}
		else if (dificultat.equals("Mitja")) {
			ranquingMitja[0][0] = nom;
			ranquingMitja[1][0] = Integer.toString(torns);
		}
		else {
			ranquingDificil[0][0] = nom;
			ranquingDificil[1][0] = Integer.toString(torns);
		}
		return false;
	}	
}
