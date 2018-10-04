import java.util.Arrays;

public class Ranquing {
	
	/** Atributs **/
	
	private String[][] ranquingFacil = new String[2][10];
	private String[][] ranquingMitja = new String[2][10];	
	private String[][] ranquingDificil = new String[2][10];
	private int ocupatFacil;
	private int ocupatMitja;
	private int ocupatDificil;
		
	/** Constructora **/
	
	public Ranquing() {
		ocupatFacil = ocupatMitja = ocupatDificil = 10;
		Arrays.fill(ranquingFacil[0], "NA");
		Arrays.fill(ranquingMitja[0], "NA");
		Arrays.fill(ranquingDificil[0], "NA");
		Arrays.fill(ranquingFacil[1], "-1");
		Arrays.fill(ranquingMitja[1], "-1");
		Arrays.fill(ranquingDificil[1], "-1");
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
			int pos = 0;
			boolean trobat = false;
			
			for (int i = 0; i < 10 && !trobat; i++) {
				int auxInt = Integer.parseInt(ranquingFacil[1][i]);
				if (auxInt > torns || auxInt == -1) {
					pos = i;
					trobat = true;
					ocupatFacil = (ocupatFacil+1)%ranquingFacil[1].length;
				} 
			}
			if (!trobat) return false;
			String auxStr = String.valueOf(torns);
			//Nom
			String[] auxNom = new String[ranquingFacil[0].length];
			for (int i = 0; i < ranquingFacil[0].length; i++) {
				if (i < pos) auxNom[i] = ranquingFacil[0][i];
				else if (i == pos) {
					auxNom[i] = nom;
					if (i+1 < ranquingFacil[0].length) auxNom[i+1] = ranquingFacil[0][i];
				}
				else if (i > pos && i-1 > 0) auxNom[i] = ranquingFacil[0][i-1];
			}
			ranquingFacil[0] = auxNom;
			//Torn
			String[] auxNum = new String[ranquingFacil[1].length];
			for (int i = 0; i < ranquingFacil[1].length; i++) {
				if (i < pos) auxNum[i] = ranquingFacil[1][i];
				else if (i == pos) {
					auxNum[i] = Integer.toString(torns);;
					if (i+1 < ranquingFacil[0].length) auxNum[i+1] = ranquingFacil[1][i];
				}
				else if (i > pos && i-1 > 0) auxNum[i] = ranquingFacil[1][i-1];
			}
			ranquingFacil[1] = auxNum;
			
			return true;
		}
		else if (dificultat.equals("Mitja")) {
			int pos = 0;
			boolean trobat = false;
			
			for (int i = 0; i < 10 && !trobat; i++) {
				int auxInt = Integer.parseInt(ranquingMitja[1][i]);
				if (auxInt > torns || auxInt == -1) {
					pos = i;
					trobat = true;
					ocupatMitja = (ocupatMitja+1)%ranquingMitja[1].length;
				} 
			}
			if (!trobat) return false;
			String auxStr = String.valueOf(torns);
			//Nom
			String[] auxNom = new String[ranquingMitja[0].length];
			for (int i = 0; i < ranquingMitja[0].length; i++) {
				if (i < pos) auxNom[i] = ranquingMitja[0][i];
				else if (i == pos) {
					auxNom[i] = nom;
					if (i+1 < ranquingMitja[0].length) auxNom[i+1] = ranquingMitja[0][i];
				}
				else if (i > pos && i-1 > 0) auxNom[i] = ranquingMitja[0][i-1];
			}
			ranquingMitja[0] = auxNom;
			//Torn
			String[] auxNum = new String[ranquingMitja[1].length];
			for (int i = 0; i < ranquingMitja[1].length; i++) {
				if (i < pos) auxNum[i] = ranquingMitja[1][i];
				else if (i == pos) {
					auxNum[i] = Integer.toString(torns);;
					if (i+1 < ranquingMitja[0].length) auxNum[i+1] = ranquingMitja[1][i];
				}
				else if (i > pos && i-1 > 0) auxNum[i] = ranquingMitja[1][i-1];
			}
			ranquingMitja[1] = auxNum;
			
			return true;
		}
		else {
			int pos = 0;
			boolean trobat = false;
			
			for (int i = 0; i < 10 && !trobat; i++) {
				int auxInt = Integer.parseInt(ranquingDificil[1][i]);
				if (auxInt > torns || auxInt == -1) {
					pos = i;
					trobat = true;
					ocupatDificil = (ocupatDificil+1)%ranquingDificil[1].length;
				} 
			}
			if (!trobat) return false;
			String auxStr = String.valueOf(torns);
			//Nom
			String[] auxNom = new String[ranquingDificil[0].length];
			for (int i = 0; i < ranquingDificil[0].length; i++) {
				if (i < pos) auxNom[i] = ranquingDificil[0][i];
				else if (i == pos) {
					auxNom[i] = nom;
					if (i+1 < ranquingDificil[0].length) auxNom[i+1] = ranquingDificil[0][i];
				}
				else if (i > pos && i-1 > 0) auxNom[i] = ranquingDificil[0][i-1];
			}
			ranquingDificil[0] = auxNom;
			//Torn
			String[] auxNum = new String[ranquingDificil[1].length];
			for (int i = 0; i < ranquingDificil[1].length; i++) {
				if (i < pos) auxNum[i] = ranquingDificil[1][i];
				else if (i == pos) {
					auxNum[i] = Integer.toString(torns);;
					if (i+1 < ranquingDificil[0].length) auxNum[i+1] = ranquingDificil[1][i];
				}
				else if (i > pos && i-1 > 0) auxNum[i] = ranquingDificil[1][i-1];
			}
			ranquingDificil[1] = auxNum;
			
			return true;
		}
	}	
}
