#ifndef INC_RESULTAT_HH
#define INC_RESULTAT_HH

#ifndef NO_DIAGRAM
#include <iostream>
#include <list>
#endif
using namespace std;
/** @brief Objecte que representa el resultat d'una operació
*/


class resultat{
    private:

    public:
        /** @brief Constructora per defecte
            \pre Cert
            \post el p.i és indefinit.
        */
        resultat();


        /** @brief Consultora 1.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa un bool definit i <em>false</em> si no.
        */

        bool es_bool() const;

        /** @brief Consultora 2.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa una llista definida i <em>false</em> si no.
        */

        bool es_llista() const;


        /** @brief Consultora 3.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa un enter definit i <em>false</em> si no.
        */

        bool es_enter() const;


        /** @brief Consultora 4.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. es indefinit i <em>false</em> si no.
        */

        bool es_indefinit() const;


        /** @brief Consultora 5.
            \pre El p.i. no és indefinit
            \post Retorna el resultat
        */

        list<int> c_resultat() const;

        /** @brief treu per pantalla la informacio del resultat tal i com explicita l'enunciat
            \pre Cert
            \post En el canal estandar de sortida es troba la informacio del resultat tal i com explicita l'enunciat
        */
        void print() const;


};

#endif
