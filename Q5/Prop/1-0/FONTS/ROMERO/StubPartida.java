package ROMERO;

import java.util.Random;

public class StubPartida {
  public StubPartida(String nom, String rol, String dificultat){
      
  }

  public String getNom() {
    return "Roger";
  }

  public String getRol() {
    return "CodeMaker";
  }

  public String getDificultat() {
    return "Facil";
  }

  public int getNForats() {
    return 5;
  }

  public int getNColors() {
    return 5;
  }

  public int getNBolesColor() {
    return 5;
  }

  public int getNTorns() {
    return 5;
  }

  public int[] getCodiInicial() {
    int i[] = new int[5];
    for (int j = 0; j < 5; ++j) i[j] = j;
    return i;
  }

  public boolean esDesada() {
    return false;
  }

  public int getTornActual() {
    return 2;
  }

  public int[] getCandidat(int torn) {
    int i[] = new int[5];
    for (int j = 0; j < 5; ++j) i[j] = 1;
    return i;
  }

  public int getB(int torn) {
    return 2;
  }

  public int getN(int torn) {
    return 1;
  }

  public void setDesada(boolean esDesada) {
    
  }

  public void setCodiInicial(int[] codiInicial) {
    
  }

  public void triaCodiInicialMaquina() {
    
  }

  public void creaCandidat(int[] candidat) {

  }

  public void triaCandidatMaquina() {

  }

  public void avaluaCandidat() {

  }
}
