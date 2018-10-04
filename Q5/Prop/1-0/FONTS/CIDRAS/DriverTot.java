import java.util.Scanner; 
 
public class DriverTot {
    private static Scanner prompt;
    
    public CtrlDomini testConstructora() {
        CtrlDomini ctrldomini = new CtrlDomini();
        return ctrldomini;
    }
    
    public static void main(String[] args) {
        DriverTot driver = new DriverTot();
        Scanner teclado = new Scanner(System.in);
        System.out.println("Prova de Joc");
        System.out.println("Voleu jugar? S/N");
        String opcio1 = teclado.nextLine();
        while (opcio1.equalsIgnoreCase("S")) {
                      
            //Inicialicem
            CtrlDomini ctrldomini = driver.testConstructora();
            System.out.println("Comencem!");
            System.out.println("Com us dieu?");
            String nom = teclado.nextLine();
            System.out.println("Amb quin rol? Codebreaker/Codemaker");
            String rol = teclado.nextLine();
            while (!rol.equalsIgnoreCase("Codebreaker") && !rol.equalsIgnoreCase("Codemaker")) {
                System.out.println("Aixo no es un rol, proveu-ho una altra vegada!");
                rol = teclado.nextLine();
            }
            System.out.println("I amb quina dificultat? Facil/Mitja/Dificil/Personalitzada");
            String dificultat = teclado.nextLine();
            while (!dificultat.equalsIgnoreCase("Facil") && !dificultat.equalsIgnoreCase("Mitja")
            && !dificultat.equalsIgnoreCase("Dificil") && !dificultat.equalsIgnoreCase("Personalitzada")) {
                System.out.println("Aixo no es una dificultat, proveu-ho una altra vegada!");
                dificultat = teclado.nextLine();    
            }
            if (dificultat.equalsIgnoreCase("Personalitzada")) {
                System.out.println("Quants forats voleu? (Haura de ser positiu)");
                int nForats = teclado.nextInt();
                System.out.println("Quants colors voleu? (Haura de ser positiu)");
                int nColors = teclado.nextInt();
                System.out.println("Quantes boles per color voleu? (Haura de ser positiu)");
                int nBolesColor = teclado.nextInt();
                System.out.println("Quants torns voleu? (Haura de ser positiu)");
                int nTorns = teclado.nextInt();
                ctrldomini.creaPartida(nom, rol, nForats, nColors, nBolesColor, nTorns);
            }
            else ctrldomini.creaPartida(nom, rol, dificultat);
            
            System.out.println("Juguem!");
            //Huma es Codebreaker
            if (rol.equalsIgnoreCase("Codebreaker")) {
                demana codiIni
                set codiIni
                while (!ctrldomini.codiEncertat() && !ctrldomini.tornsEsgotats()) {
                    while {
                        demana Avalua
                        comprova
                    }
                }
            }
            //Huma es Codemaker
            else if (rol.equalsIgnoreCase("Codemaker") {
                while (!ctrldomini.codiEncertat() && !ctrldomini.tornsEsgotats()) {
                    demana Candidat
                    set Candidat
                }
            }
            
            //Analitzem resultats
            if (ctrldomini.codiEncertat()) {
                if (rol.equalsIgnoreCase("Codebreaker")) {
                    ranquing                    
                }
                else System.out.println("He encertat el vostre codi, " + nom + "!");
            }
            else {
                if (rol.equalsIgnoreCase("Codebreaker")) System.out.println("Quin codi mes rebuscat, oi? Us he guanyat " + nom + "!");
                else System.out.println("Quin codi mes rebuscat! M'heu guanyat " + nom + "!");
            }
            if (tornsEsgotats y rol) missatge
            if (codiEncertat y rol) actualizaRanquing + missatge
            
            //Seguent partida
            System.out.println("Voleu jugar mes? S/N");
            String opcio1 = teclado.nextLine();
        }
        System.out.println("Adeu!");
    }
}
