padre(juan,pedro).
padre(maria,pedro).
hermano(pedro,vicente).
hermano(pedro,alberto).
tio(X,Y):- padre(X,Z), hermano(Z,Y).

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).


fact(0,1):-!.
fact(X,F):-  X1 is X - 1, fact(X1,F1), F is X * F1.

nat(0).
nat(N):- nat(N1), N is N1 + 1.

%mul(X,Y,M):- nat(M), 0 is M mod X, 0 is M mod Y.
mul(X,Y,M):- nat(N), M is N * X,   0 is M mod Y.

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

% Alternativa una mica més eficient.
%pert_r(X,[X|L],L).
%pert_r(X,[Y|L],[Y|R]):- pert_r(X,L,R).

long([],0).
long([_|L],M):- long(L,N),M is N+1.







%factores_primos(1,[]) :- !.
%factores_primos(N,[F|L]):- nat(F), F>1, 0 is N mod F, N1 is N // F,
%                factores_primos(N1,L),!.

f(1,[]).
f(N,[F|L]):- N > 1, nat(F), write(F), nl, F>1, 0 is N mod F, N1 is N // F,
             f(N1,L), !.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).









subcjto([],[]).  %subcjto(L,S) significa "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).

cifras(L,N):- subcjto(L,S), permutacion(S,P), expresion(P,E),
              N is E, write(E),nl,fail.

expresion([X],X).
expresion(L,E1+E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).
expresion(L,E1-E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).
expresion(L,E1*E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).

% expresion(L,E1//E2):- concat(L1,L2,L),  L1\=[],L2\=[],
%                      expresion(L1,E1), expresion(L2,E2),
%          X is E2, X \= 0, 0 is E1 mod E2.


der(X, X, 1):-!.
der(C, _, 0) :- number(C).
der(A+B, X, A1+B1) :- der(A, X, A1), der(B, X, B1).
der(A-B, X, A1-B1) :- der(A, X, A1), der(B, X, B1).
der(A*B, X, A*B1+B*A1) :- der(A, X, A1), der(B, X, B1).
der(sin(A), X, cos(A)*B) :- der(A, X, B).
der(cos(A), X, -sin(A)*B) :- der(A, X, B).
der(e^A, X, B*e^A) :- der(A, X, B).
der(ln(A), X, B*1/A) :- der(A, X, B).


simplifica(E,E1):- unpaso(E,E2),!, simplifica(E2,E1).
simplifica(E,E).

unpaso(A+B,A+C):- unpaso(B,C),!.
unpaso(B+A,C+A):- unpaso(B,C),!.
unpaso(A*B,A*C):- unpaso(B,C),!.
unpaso(B*A,C*A):- unpaso(B,C),!.
unpaso(0*_,0):-!.
unpaso(_*0,0):-!.
unpaso(1*X,X):-!.
unpaso(X*1,X):-!.
unpaso(0+X,X):-!.
unpaso(X+0,X):-!.
unpaso(N1+N2,N3):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*N2,N3):- number(N1), number(N2), N3 is N1*N2,!.
unpaso(N1*X+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*X+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.


pescalar([X1|L1],[X2|L2],P) :- prescalar(L1, L2, P1), P is X1*X2 + P1.
pescalar([],[],0).

interseccion([],_,[]).
interseccion([X|L1],L2,[X|L3]):-
	  pert(X,L2),!,
	  interseccion(L1,L2,L3).
interseccion([_|L1],L2,L3):-
	  interseccion(L1,L2,L3).

union([],L,L).
union([X|L1],L2,L3):-
	  pert(X,L2),!,
	  union(L1,L2,L3).
union([X|L1],L2,[X|L3]):-
	  union(L1,L2,L3).

lastlist([X], X) :- !.
lastlist([_|L], X) :- last(L, X).

reversel([],[]).
reversel(L,[X|L1]):- concat(L2,[X],L), reverse(L2,L1).

prod([X|L], P) :- prod(L, P1), P is P1*X.
prod([], 1).

fib(1,1):-!.
fib(0,0):-!.
fib(N,P):-
    N > 2,
    N2 is N - 2,
    N1 is N - 1,
    fib(N2,P2),
    fib(N1,P1),
    P is P1 + P2.

dados(0, 0, []):-!.
dados(P,N,[X|L]) :-
    N > 0,
    pert(X, [1,2,3,4,5,6]),
    P1 is P - X,
    N1 is N - 1,
    dados(P1, N1, L).


%% pert_con_resto(X,L,R) :- concat(L1,[X|L2],L), concat(L1,L2,R).

%% permutacion([],[]).
%% permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

%% long([],0).
%% long([_|L],M) :- long(L,N), M is N+1.

%% subcjto([],[]).
%% subcjto([_|C],S) :- subcjto(C,S).
%% subcjto([X|C],[X|S]) :- subcjto(C,S).

suma([], 0).
suma([Y|L], X) :- suma(L, Z), X is Y + Z.

suma_demas(L) :- pert_con_resto(X,L,R), suma(R,X), !.

suma_ants(L) :- concat(L1, [X|_], L), suma(L1,X), !.

natural(0).
natural(X) :- natural(X1), X is X1 + 1.
card(L) :- natural(X), getpair(L,X,Y), write([X,Y]), nl.
getpair([],_,0).
getpair([X|L],X,Y) :- getpair(L,X,Z), Y is Z + 1.
getpair([Z|L],X,Y) :- Z \= X, getpair(L,X,Y).
