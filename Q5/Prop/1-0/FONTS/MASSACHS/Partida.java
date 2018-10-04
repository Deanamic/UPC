package MASSACHS;

import java.util.Random;
import java.util.Set;
import java.util.HashSet;
import CIDRAS.Codi;

public class Partida {
  private String nom_;
  private String rol_;
  private String dificultat_;
  private int nForats_;
  private int nColors_;
  private int nBolesColor_;
  private int nTorns_;
  private int[] codiInicial_;
  private boolean esDesada_;
  private int tornActual_;
  private Codi[] candidats_;
  private Set <int[]> codisPossibles_;
  private Set <int[]> codisInicialsPossibles_;

  public Partida(String nom, String rol, String dificultat) {
    nom_ = nom;
    rol_ = rol;
    dificultat_ = dificultat;
    converteixDificultat();
    esDesada_ = false;
    tornActual_ = 0;
    candidats_ = new Codi[nTorns_];
    codisPossibles_ = new HashSet <int[]>();
    codisInicialsPossibles_ = new HashSet <int[]>();
  }

  public Partida(String nom, String rol, int nForats, int nColors,
                 int nBolesColor, int nTorns) {
    nom_ = nom;
    rol_ = rol;
    nForats_ = nForats;
    nColors_ = nColors;
    nBolesColor_ = nBolesColor;
    nTorns_ = nTorns;
    esDesada_ = false;
    tornActual_ = 0;
    candidats_ = new Codi[nTorns_];
    codisPossibles_ = new HashSet <int[]>();
    codisInicialsPossibles_ = new HashSet <int[]>();
  }

  private void converteixDificultat() {
    boolean facil =  (rol_ == "codebreaker" && dificultat_ == "facil"  );
    facil = facil || (rol_ == "codemaker"   && dificultat_ == "dificil");

    if (facil) {
      nForats_     =  3;
      nColors_     =  5;
      nBolesColor_ =  1; 
      nTorns_      = 12;
    } else if (dificultat_ == "mitjana") {
      nForats_     =  4;
      nColors_     =  6;
      nBolesColor_ =  4;
      nTorns_      = 12;
    } else {
      nForats_     =  5;
      nColors_     = 10;
      nBolesColor_ =  5;
      nTorns_      = 12;
    }
  }

  public String getNom() {
    return nom_;
  }

  public String getRol() {
    return rol_;
  }

  public String getDificultat() {
    return dificultat_;
  }

  public int getNForats() {
    return nForats_;
  }

  public int getNColors() {
    return nColors_;
  }

  public int getNBolesColor() {
    return nBolesColor_;
  }

  public int getNTorns() {
    return nTorns_;
  }

  public boolean esDesada() {
    return esDesada_;
  }

  public int getTornActual() {
    return tornActual_;
  }

  public int[] getCandidat(int torn) {
    return candidats_[torn].getCandidat();
  }

  public int getB(int torn) {
    return candidats_[torn].getB();
  }

  public int getN(int torn) {
    return candidats_[torn].getN();
  }

  public void setDesada(boolean esDesada) {
    esDesada_ = esDesada;
  }

  public void setCodiInicial(int[] codiInicial) {
    codiInicial_ = codiInicial;
  }

  public void triaCodiInicialMaquina() {
    int colorsDisponibles = nColors_;
    int[] bolesDisponibles = new int[nColors_];
    for (int i = 0; i < nColors_; i++)
      bolesDisponibles[i] = nBolesColor_;

    for (int i = 0; i < nForats_; i++) {
      int colorNo = colorRandom(colorsDisponibles, bolesDisponibles);
      codiInicial_[i] = colorNo;

      bolesDisponibles[colorNo]--;
      if (bolesDisponibles[colorNo] == 0)
        colorsDisponibles--;
    }
  }

  private int colorRandom(int colorsDisponibles, int[] bolesDisponibles) {
    Random generador = new Random();

    int colorNo = generador.nextInt(colorsDisponibles);

    for (int i = 0; i <= colorNo; i++)
      if (bolesDisponibles[i] == 0)
        colorNo++;

    return colorNo;
  }

  public void creaCandidat(int[] candidat) {
    tornActual_++;
    candidats_[tornActual_] = new Codi(candidat);
  }

  public void triaCandidatMaquina() {
    if (tornActual_ == 0) 
      creaCodisPossibles();
    else 
      actualitzaCodisInicialsPossibles();

    if (tornActual_ == 0 && dificultat_ == "mitjana") {
      int[] primerCandidat = new int[nForats_];
      primerCandidat[0] = primerCandidat[1] = 0;
      primerCandidat[2] = primerCandidat[3] = 1;
      candidats_[tornActual_] = new Codi(primerCandidat);
    } else 
      minimaxCandidat();

    tornActual_++;
  }

  private void creaCodisPossibles() {
    int[] bolesDisponibles = new int[nColors_];
    for (int i = 0; i < nColors_; i++)
      bolesDisponibles[i] = nBolesColor_;

    int[] codi = new int[nForats_];

    backtrackingCreaCodisPossibles(codi, 0, bolesDisponibles);
  }

  private void backtrackingCreaCodisPossibles(int[] codi, int i,
                                              int[] bolesDisponibles) {
    if (i == nForats_) {
      codisPossibles_.add(codi);
      codisInicialsPossibles_.add(codi);
      return;
    }

    for (int j = 0; j < nColors_; j++) {
      if (bolesDisponibles[j] > 0) {
        codi[i] = j;
        bolesDisponibles[j]--;
        backtrackingCreaCodisPossibles(codi, i+1, bolesDisponibles);
        bolesDisponibles[j]++;
      }
    }
  }

  private void actualitzaCodisInicialsPossibles() {
    int N = candidats_[tornActual_-1].getN();
    int B = candidats_[tornActual_-1].getB();
    Codi ultimCandidat = new Codi(candidats_[tornActual_-1].getCandidat());

    for (int[] codiInicial : codisInicialsPossibles_) {
      ultimCandidat.avalua(codiInicial);
      if (N != ultimCandidat.getN() || B != ultimCandidat.getB())
        codisInicialsPossibles_.remove(codiInicial);
    }
  }

  private void minimaxCandidat() {
    Codi millorCandidat = new Codi(candidats_[tornActual_-1].getCandidat());
    int millorPuntuacio = 0;

    for (int[] i : codisPossibles_) {
      Codi candidatActual = new Codi(i);
      int puntuacioCandidat = codisInicialsPossibles_.size();

      for (int N = 0; N <= nForats_; N++) {
        for (int B = 0; B+N <= nForats_; B++) {
          int puntuacioAvaluacio = 0;

          for (int[] codiInicial : codisInicialsPossibles_) {
            candidatActual.avalua(codiInicial);
            if (N != candidatActual.getN() || B != candidatActual.getB())
              ++puntuacioAvaluacio;
          }

          if (puntuacioAvaluacio < puntuacioCandidat)
            puntuacioCandidat = puntuacioAvaluacio;
        }
      }

      if (puntuacioCandidat > millorPuntuacio) {
        millorCandidat = candidatActual;
        millorPuntuacio = puntuacioCandidat;
      }
    }

    candidats_[tornActual_] = new Codi(millorCandidat.getCandidat());
  }

  public void avaluaCandidat() {
    candidats_[tornActual_].avalua(codiInicial_);
  }
}
