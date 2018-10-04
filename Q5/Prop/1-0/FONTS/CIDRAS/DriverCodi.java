import java.util.Scanner; 

public class DriverCodi {
  private static Scanner teclado;
  
  
  public Codi testConstructoraBuida() {
	  Codi codi = new Codi();
	  return codi;
  }
  
  public Codi testConstructora(int[] candidat) {	    
	  Codi codi = new Codi(candidat);
	  return codi;
  }
  
  public void testSetCandidat(Codi codi, int[] candidat) {
	  codi.setCandidat(candidat);
  }
 
  
  public void testAvalua(Codi codiIni, Codi codi2) {
	  codi2.avalua(codiIni.getCandidat());
  }
  
  public void testGetB(Codi codi) {
	  System.out.println("B es " + codi.getB());
  }
  
  public void testGetN(Codi codi) {
	  System.out.println("N es " + codi.getN());
  }
  
  public void testGetCandidat(Codi codi) {
	  int[] candidat = codi.getCandidat();
	  if (candidat.length == 0) System.out.println("No te candidat");
	  else {
		  String comb = "";
		  for (int i = 0; i < candidat.length; i++) {
			 comb = comb + Integer.toString(candidat[i]);
		  }
		  System.out.println("El candidat es " + comb);
	  }
  }
  
  public static void main(String[] args) {
	  DriverCodi driver = new DriverCodi();
	  teclado = new Scanner(System.in); 
	  System.out.println("Prova: Constructora buida");
	  Codi codi0 = driver.testConstructoraBuida();
	  driver.testGetCandidat(codi0);
	  
	  System.out.println("Prova: Constructora");
	  System.out.println("Dades per codi inicial");
	  System.out.println("Introdueix nForats");
	  int nForats = Integer.parseInt(teclado.nextLine());
	  int[] candidat = new int[nForats];
	  System.out.println("Introdueix combinació");
	  for (int i = 0; i < candidat.length; i++) {
		  candidat[i] = teclado.nextInt();
	  }  
	  Codi codi1 = driver.testConstructora(candidat);
	  driver.testGetCandidat(codi1);
	  
	  System.out.println("Prova: Avaluar candidat");
	  System.out.println("Introdueix quants candidats vols avaluar");
	  int N = teclado.nextInt();
	  while (N > 0) {
		  N--;
		  System.out.println("Dades per possibles candidats");
		  int[] candidatNou = new int[nForats];
		  System.out.println("Introdueix una nova combinació");
		  for (int i = 0; i < candidatNou.length; i++) {
			  candidatNou[i] = teclado.nextInt();
		  }  
		  Codi codiNou = driver.testConstructora(candidatNou);
		  driver.testGetCandidat(codiNou);
		  driver.testAvalua(codi1, codiNou);
		  driver.testGetB(codiNou);
		  driver.testGetN(codiNou);
	  }
  }
}
