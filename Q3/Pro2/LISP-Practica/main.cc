#ifndef NO_DIAGRAM
#include <list>
#endif
#include "operacio.hh"
#include "variable.hh"
#include "resultat_lectura.hh"
#include "resultat.hh"
using namespace std;

/**
 * @mainpage Pràctica Programació 2: Calculadora d’expressions aritmètiques

En aquesta pràctica hem implementat una calculadora d’expressions aritmètiques que, a més a més, permet definir noves operacions a partir d’operacions ja existents.


Hem fet servir les classes operacio.hh, variable.hh, resultat_lectura.hh, resultat.hh.
*/

/** @file main.cc
    @brief Programa principal para la practica <em>Calculadora d’expressions aritmetiques</em>.
*/

/** @brief Avalua una expressió
\pre it = IT
\post Retorna el resultat que representa l’expressió que comença a IT.
*/

resultat avaluar(list <string> & op, list<string>::iterator & it);


/** @brief Programa principial de la pràctica.
    \pre L’entrada és tal i com s’indica a l’enunciat.
    \post Al canal estàndard de sortida hi ha resoltes les diferents operacions i definicions.
*/
int main(){
    operacio o;
    variable v;
    while(true){
        resultat_lectura rl;
        if(rl.fi_entrada()) return 0;
        list<string> l = rl.entrada();
        if(rl.es_def_var()){
            resultat r;
            list<string>::iterator it = l.begin();
            string nom = *it;
            ++it;
            r = avaluar(l,it);
            v.guardar_variable(nom ,r);
        }
        else if(rl.es_def_op()){
            o.guardar_operacio(l);
        }
        else if (rl.es_expressio()){
            list<string>::iterator it = l.begin();
            resultat r = avaluar(l, it);
            r.print();
        }

    }

}
