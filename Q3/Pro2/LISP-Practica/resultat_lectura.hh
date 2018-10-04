#ifndef INC_RESULTAT_LECTURA_HH
#define INC_RESULTAT_LECTURA_HH

#ifndef NO_DIAGRAM
#include <iostream>
#include <list>
#endif

using namespace std;

/** @brief Guarda la informació necessària per entendre i tractar l’entrada de la pràctica.
*/

class resultat_lectura{
    private:

    public:
        /** @brief Constructora. L’objecte creat conté l’entrada i informació sobre aquesta.
            \pre Al canal estàndard d’entrada hi ha una expressió o definició tal i com especifica l’enunciat
            \post L’objecte resultat_lectura creat conté l’entrada i informació sobre quin tipus d’entrada és: una expressió, una definició d’operació o una definició de variable.
        */

        resultat_lectura();


        /** @brief Consultora 1.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa una entrada que defineix una variable i <em>false</em> si no.
        */

        bool es_def_var() const;


        /** @brief Consultora 2.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa una entrada que defineix una operació i <em>false</em> si no.
        */

        bool es_def_op() const;


        /** @brief Consultora 3.
            \pre Cert
            \post Retorna <em>true</em> si el p.i. representa una entrada que es una expressio i <em>false</em> si no.
        */

        bool es_expressio() const;


        /** @brief Consultora 4.
            \pre el p.i no esta buit
            \post Retorna l’entrada en el format més adient segons el tipus.
        */
        list<string> entrada() const;

        /** @brief Consultora 5.
            \pre el p.i no esta buit
            \post Retorna <em>true</em> si el p.i. representa una entrada que senyalitza el final de l'entrada i <em>false</em> si no.
        */
        bool fi_entrada() const;
};


#endif
