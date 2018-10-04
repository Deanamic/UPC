#include "CacheSim.h"
#include <string.h>
/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
int Cache[1<<6][2];
int Used[1<<6][2];
int LRU[1<<6];


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
	/* Escriu aqui el teu codi */
    memset(Used, 0, sizeof(Used));
    memset(LRU, 0, sizeof(LRU));
}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
  unsigned int byte;
  unsigned int bloque_m; 
  unsigned int conj_mc;
  unsigned int via_mc;
  unsigned int tag;
  unsigned int miss;	   // boolea que ens indica si es miss
  unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
  unsigned int tag_out;	   // TAG de la linia reemplaçada
  float t1,t2;		// Variables per mesurar el temps (NO modificar)
  
  t1=GetTime();
  /* Escriu aqui el teu codi */
  unsigned int AuxAddress = address;
  byte = AuxAddress & 0x1f;
  conj_mc = (AuxAddress >> 5) & 0x3f;
  tag = AuxAddress >> 11;
  bloque_m = AuxAddress >> 5;
  
  miss = (!Used[conj_mc][0] || Cache[conj_mc][0] != tag)
    && (!Used[conj_mc][1] || Cache[conj_mc][1] != tag);

  replacement = (miss && Used[conj_mc][1]); 

  if(replacement) {
    via_mc = LRU[conj_mc];
    LRU[conj_mc] = !LRU[conj_mc];
    tag_out = Cache[conj_mc][via_mc];
  }
  else {
    if(!Used[conj_mc][0] || Cache[conj_mc][0] == tag) {
      via_mc = 0;
      LRU[conj_mc] = 1;
    }
    else {
      via_mc = 1;
      LRU[conj_mc] = 0;
    }
  }
  Cache[conj_mc][via_mc] = tag;
  Used[conj_mc][via_mc] = 1;

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. També mesurem el temps d'execució
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print2 (address, byte, bloque_m, conj_mc, via_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
  
  
}
