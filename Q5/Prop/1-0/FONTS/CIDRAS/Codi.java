package CIDRAS;

import java.util.Arrays;

public class Codi {
	
	/** Atributs **/
	
	private int[] candidat;
	private int B;
	private int N;
	
	/** Constructora **/
	
	public Codi() {}
	
	public Codi(int[] combinacio) {
		int nForats = combinacio.length;
		candidat = new int[nForats];
		System.arraycopy(combinacio, 0, candidat, 0, nForats);
		B = N = 0;
	}
	
	/** Metodos publicos **/
	
	public int[] getCandidat() {
		return candidat;
	}
	
	public int getB() {
		return B;
	}
	
	public int getN() {
		return N;
	}

	public void avalua(int[] codiIni) {
		int nForats = codiIni.length;
		boolean[] vistIni = new boolean[nForats];
		Arrays.fill(vistIni, false);
		boolean[] vistAct = new boolean[nForats];
		Arrays.fill(vistAct, false);
		B = N = 0;
		
		for (int i = 0; i < nForats; ++i) {
			if (codiIni[i] == candidat[i]) {
				N++;
				vistIni[i] = vistAct[i] = true;
			}
		}
		
		for (int i = 0; i < nForats; ++i)
			for (int j = 0; j < nForats; ++j)
				if (!vistIni[i] && !vistAct[j])
					if (codiIni[i] == candidat[j]) {
						B++;
						vistIni[i] = vistAct[j] = true;
					}
	}
}
