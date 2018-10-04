#include "CacheSim.h"
#include <string.h>

const int L = 0;
const int E = 1;
/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
int Cache[1<<7];
int Used[1<<7];



/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
  /* Escriu aqui el teu codi */
  memset(Used, 0, sizeof(Used));

}

/* La rutina reference es cridada per cada referencia a simular */
void reference (unsigned int address, unsigned int LE)
{
  unsigned int byte;
  unsigned int bloque_m;
  unsigned int linea_mc;
  unsigned int tag;
  unsigned int miss;
  unsigned int lec_mp;
  unsigned int mida_lec_mp;
  unsigned int esc_mp;
  unsigned int mida_esc_mp;
  unsigned int replacement;
  unsigned int tag_out;

  /* Escriu aqui el teu codi */
  unsigned int AuxAddress = address;
  byte = AuxAddress & 0x1f;
  linea_mc = (AuxAddress >> 5) & 0x7f;
  tag = AuxAddress >> 12;
  bloque_m = AuxAddress >> 5;
  miss = (!Used[linea_mc] || Cache[linea_mc] != tag);
  replacement = (miss && Used[linea_mc] && LE == L);

  if(LE == L) {
    esc_mp = 0;
    if(miss) mida_lec_mp = 32, lec_mp = 1;
    else lec_mp = 0;

    if(replacement) tag_out = Cache[linea_mc];
    Cache[linea_mc] = tag;
    Used[linea_mc] = 1;
  }
  else {
    esc_mp = 1;
    mida_esc_mp = 1;
    lec_mp = 0;
  }


  /* La funcio test_and_print escriu el resultat de la teva simulacio
   * per pantalla (si s'escau) i comproba si hi ha algun error
   * per la referencia actual
   * */
  test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
                  miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
                  replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */
void final ()
{
  /* Escriu aqui el teu codi */


}
