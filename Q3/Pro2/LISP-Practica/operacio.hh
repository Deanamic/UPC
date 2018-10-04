#ifndef INC_OPERACIO_HH
#define INC_OPERACIO_HH

#include "resultat.hh"

#ifndef NO_DIAGRAM
#include <iostream>
#include <map>
#endif

using namespace std;

/** @brief Conté les operacions que s’han definit i les opera quan apareixen a una expressió
*/

class operacio{
    private:

    public:
        /** @brief Constructora per defecte
            \pre Cert
            \post el p.i està buit.
        */

        operacio();


        /** @brief Serveix per guardar una nova operació
            \pre  <em>expressio</em> és una expressió vàlida tal i com s’explicita a l’enunciat de la pràctica.
            \post <em>true</em> si ha aconseguit guardar l'operacio <em>expressio</em> amb el nom corresponent i treu per pantalla la sortida que indica el enunciat, altrament retorna <em>false</em>
        */

        bool guardar_operacio (const list<string>& expressio);

        /** @brief Opera una expressio
            \pre it = IT, cert
            \post Retorna el resultat de l’operació que comença a on apunta IT
        */

        resultat operar(list <string>& op, list <string>::iterator it);
};

#endif
