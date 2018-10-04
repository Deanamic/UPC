#include "CacheSim.h"
#include <string.h>
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
    totaltime=0.0;
	/* Escriu aqui el teu codi */
    memset(Used, 0, sizeof(Used));
}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
  unsigned int byte;
  unsigned int bloque_m; 
  unsigned int linea_mc;
  unsigned int tag;
  unsigned int miss;	   // boolea que ens indica si es miss
  unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
  unsigned int tag_out;	   // TAG de la linia reemplaçada
  float t1,t2;		// Variables per mesurar el temps (NO modificar)
  
  t1=GetTime();
  /* Escriu aqui el teu codi */
  unsigned int AuxAddress = address;
  byte = AuxAddress & 0x1f;
  linea_mc = (AuxAddress >> 5) & 0x7f;
  tag = AuxAddress >> 12;
  bloque_m = AuxAddress >> 5;

  miss = (!Used[linea_mc] || Cache[linea_mc] != tag);
  replacement = (miss && Used[linea_mc]); 
  if(replacement) tag_out = Cache[linea_mc];

  Cache[linea_mc] = tag;
  Used[linea_mc] = 1;

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. També mesurem el temps d'execució
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print (address, byte, bloque_m, linea_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
  
  
}
