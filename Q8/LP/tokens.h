#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: PracticaEricDean.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * ANTLR Version 1.33MR33
 */
#define zzEOF_TOKEN 1
#define NUM 2
#define SPACE 3
#define ENDL 4
#define PLOT 5
#define NORMALIZE 6
#define LOGPLOT 7
#define WHILE 8
#define ENDWHILE 9
#define IF 10
#define ENDIF 11
#define PUSH 12
#define POP 13
#define NOT 14
#define CHECK 15
#define AMEND 16
#define EMPTY 17
#define ITH 18
#define EQ 19
#define DIF 20
#define ASSIG 21
#define LC 22
#define RC 23
#define LT 24
#define GT 25
#define COMA 26
#define LP 27
#define RP 28
#define AND 29
#define OR 30
#define CONCAT 31
#define ID 32

#ifdef __USE_PROTOS
void plots(AST**_root);
#else
extern void plots();
#endif

#ifdef __USE_PROTOS
void linterpretation(AST**_root);
#else
extern void linterpretation();
#endif

#ifdef __USE_PROTOS
void expr(AST**_root);
#else
extern void expr();
#endif

#ifdef __USE_PROTOS
void control(AST**_root);
#else
extern void control();
#endif

#ifdef __USE_PROTOS
void bul(AST**_root);
#else
extern void bul();
#endif

#ifdef __USE_PROTOS
void bulfoonc(AST**_root);
#else
extern void bulfoonc();
#endif

#ifdef __USE_PROTOS
void assig(AST**_root);
#else
extern void assig();
#endif

#ifdef __USE_PROTOS
void funcio(AST**_root);
#else
extern void funcio();
#endif

#ifdef __USE_PROTOS
void plot(AST**_root);
#else
extern void plot();
#endif

#ifdef __USE_PROTOS
void list(AST**_root);
#else
extern void list();
#endif

#ifdef __USE_PROTOS
void membre(AST**_root);
#else
extern void membre();
#endif

#ifdef __USE_PROTOS
void punt(AST**_root);
#else
extern void punt();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType setwd1[];
extern SetWordType zzerr2[];
extern SetWordType zzerr3[];
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType setwd2[];
extern SetWordType zzerr7[];
extern SetWordType zzerr8[];
extern SetWordType zzerr9[];
extern SetWordType zzerr10[];
extern SetWordType zzerr11[];
extern SetWordType setwd3[];
extern SetWordType zzerr12[];
extern SetWordType zzerr13[];
extern SetWordType zzerr14[];
extern SetWordType zzerr15[];
extern SetWordType zzerr16[];
extern SetWordType setwd4[];
extern SetWordType setwd5[];
