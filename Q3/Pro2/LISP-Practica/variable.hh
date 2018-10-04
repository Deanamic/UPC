#ifndef INC_VARIABLE_HH
#define INC_VARIABLE_HH

#include "resultat.hh"

#ifndef NO_DIAGRAM
#include <iostream>
#include <list>
#include <map>
#endif

using namespace std;

/** @brief Conté les variables que s’han definit
*/

class variable{
    private:


    public:
        /** @brief Constructora per defecte
            \pre Cert
            \post el p.i està buit.
        */
        variable();

        /** @brief Serveix per guardar una nova variable
        \pre  Cert
        \post retorna <em>true</em> si ha aconseguit guardar el resultat <em>R</em> amb el nom <em>nom</em> i treu per pantalla la sortida que indica el enunciat, altrament retorna <em>false</em>
        */

        bool guardar_variable (string nom, const resultat& r);


        /** @brief Serveix per consultar si existeix una variable amb el nom <em>nom</em>
        \pre cert
        \post retorna <em>true</em> si existeix una variable amb el nom <em>nom</em>, altrament retorna <em>false</em>
        */

        bool consultar_var(const list <string> & op, list <string>::iterator it) const;

        /** @brief Retorna el resultat que representa una variable
            \pre Cert,
            \post Retorna el resultat que representa la variable apuntada per <em>it</em>
        */

        resultat buscar(const list <string> & op, list <string>::iterator it) const;
};

#endif
