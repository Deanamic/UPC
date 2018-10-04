import java.util.Scanner; 

public class DriverRanquing { 
  
  public Ranquing testConstructora() {
	  Ranquing ranquing = new Ranquing();
	  return ranquing;
  }
  
  public void testGetRanquing(Ranquing ranquing, String dificultat) {
	  String[][] lliste = ranquing.getRanquing(dificultat);
	  System.out.println("Ranquing amb la dificultat " + dificultat);
	  for (int i = 0; i < lliste[0].length; i++) {
		  if (!lliste[1][i].equals("-1")) System.out.println(lliste[0][i] + " " + lliste[1][i]);
	  }
  }
  
  public void testAfegeixNom(Ranquing ranquing, String nom, int torn, String dificultat) {
	  boolean fet = ranquing.afegeixNom(nom, torn, dificultat);
	  if (fet) System.out.println("Felicidades! Te has clasificado");
	  else System.out.println("... Ya ira mejor " + nom);
  }
  
  public static void main(String[] args) {
	  DriverRanquing driver = new DriverRanquing();
	  System.out.println("Prova: Constructora");
	  Ranquing ranquing = driver.testConstructora();
	  driver.testGetRanquing(ranquing, "Facil");
	  driver.testGetRanquing(ranquing, "Mitja");
	  driver.testGetRanquing(ranquing, "Dificil");
	  
	  String Opcion = "S";
	  Scanner teclado = new Scanner(System.in);
	  while (Opcion.equals("S")) {
		  System.out.println("Introducir nom");
		  String nom = teclado.nextLine();
		  	  
		  System.out.println("Introducir torn");
		  int torn = Integer.parseInt(teclado.nextLine());
		  
		  System.out.println("Introducir dificultat");
		  String dificultat = teclado.nextLine();
		  
		  driver.testAfegeixNom(ranquing, nom, torn, dificultat);		  
		  driver.testGetRanquing(ranquing, dificultat);
		  System.out.println("Introducir otro ganador? S/N");
		  Opcion = teclado.nextLine();
	  }
  }
}
