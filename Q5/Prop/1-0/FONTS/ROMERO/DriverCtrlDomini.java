package ROMERO;

import java.util.Scanner; 
import ROMERO.CtrlDomini;

public class DriverCtrlDomini {
    private Scanner teclat;
  
    public CtrlDomini testConstructora() {
        CtrlDomini controlador = new CtrlDomini();
        return controlador;
    }
    
    public CtrlDomini testcreaPartida(String nom, String rol, String dificultat, CtrlDomini controlador) {
        controlador.creaPartida(nom,rol,dificultat);
        System.out.println("creaPartida correcte");
        return controlador;
    }

	public void testesDesada(CtrlDomini controlador) {
		if (controlador.esDesada() == false) System.out.println("esDesada correcte");
        else System.out.println("esDesada incorrecte");
	}

	public void testdesaPartida() {
		/** Baixa al controlador de persistencia per desar
		 * la partida
		 */
         System.out.println("desaPartida de moment no fa res");
	}
	
	public void testsetCodiInicial(int[] codi, CtrlDomini controlador) {
		controlador.setCodiInicial(codi);
        System.out.println("setCodiInicial correcte");
	}
	
	public void testcomprovaBN(CtrlDomini controlador) {       
        if (controlador.comprovaBN(0,1)) System.out.println("ComprovaBN correcte");
        else System.out.println("ComprovaBN incorrecte");
	}
	
	public void testcreaCandidat(int[] candidat, CtrlDomini controlador) {
		controlador.creaCandidat(candidat);
        System.out.println("creaCandidat correcte");
	}
  
    public void testGetRanquing(CtrlDomini controlador) {
        teclat = new Scanner(System.in);
        System.out.println("Introdueix la dificultat: ");
        String dificultat = teclat.nextLine();
        String[][] ranquing = controlador.getRanquing(dificultat);
        System.out.println("Ranquing de la dificultat " + dificultat);
        for (int i = 0; i < 10; ++i) {
            System.out.println(ranquing[0][i] + " " + ranquing[1][i]);
        }
    } 
  
    public CtrlDomini testAfegeixNom(CtrlDomini controlador) {
        teclat = new Scanner(System.in);
        System.out.println("Introdueix el nom: ");
        String nom = teclat.nextLine();
        System.out.println("Introdueix els torns: ");
        int torns = Integer.parseInt(teclat.nextLine());
        System.out.println("Introdueix la dificultat: ");
        String dificultat = teclat.nextLine();
        controlador.afegeixNom(nom,torns,dificultat);
        return controlador;
    }
  
    public static void main(String[] args) {
        Scanner teclat2;
        teclat2 = new Scanner(System.in);
      
        System.out.println("Prova: Constructora");
        CtrlDomini controlador = new DriverCtrlDomini().testConstructora();
      
        while(true){
            System.out.println("1: creaPartida\n2: esDesada\n3: desaPartida\n4: setCodiInicial\n5: comprovaBN\n6: creaCandidat\n7: getRanquing\n8 afegeixNom");
            int a = teclat2.nextInt();
        
            switch(a) {
                case 1:
                    System.out.println("Prova creaPartida: ");
                    controlador = new DriverCtrlDomini().testcreaPartida("Roger","CB","Facil",controlador);
                    break;
                case 2:
                    System.out.println("Prova esDesada: ");
                    new DriverCtrlDomini().testesDesada(controlador);
                    break;
                case 3:
                    System.out.println("Prova desaPartida: ");
                    new DriverCtrlDomini().testdesaPartida();
                    break;
                case 4:
                    System.out.println("Prova setCodiInicial: ");
                    new DriverCtrlDomini().testsetCodiInicial(new int[5],controlador);
                    break;
                case 5:
                    System.out.println("Prova comprovaBN: ");
                    new DriverCtrlDomini().testcomprovaBN(controlador);
                    break;
                case 6:
                    System.out.println("Prova creaCandidat: ");
                    new DriverCtrlDomini().testcreaCandidat(new int[5],controlador);
                    break;
                case 7:
                    System.out.println("Prova getRanquing: ");
                    new DriverCtrlDomini().testGetRanquing(controlador);
                    break;
                case 8:
                    System.out.println("Prova afegeixNom: ");
                    controlador = new DriverCtrlDomini().testAfegeixNom(controlador);
                    break;
            }
        }
    } 
}
