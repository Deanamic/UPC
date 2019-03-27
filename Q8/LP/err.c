/*
 * A n t l r  S e t s / E r r o r  F i l e  H e a d e r
 *
 * Generated from: PracticaEricDean.g
 *
 * Terence Parr, Russell Quong, Will Cohen, and Hank Dietz: 1989-2001
 * Parr Research Corporation
 * with Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 */

#define ANTLR_VERSION	13333
#include "pcctscfg.h"
#include "pccts_stdio.h"

#include <string>
#include <iostream>
using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
} Attrib;

// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
#define zzSET_SIZE 8
#include "antlr.h"
#include "ast.h"
#include "tokens.h"
#include "dlgdef.h"
#include "err.h"

ANTLRChar *zztokens[33]={
	/* 00 */	"Invalid",
	/* 01 */	"@",
	/* 02 */	"NUM",
	/* 03 */	"SPACE",
	/* 04 */	"ENDL",
	/* 05 */	"PLOT",
	/* 06 */	"NORMALIZE",
	/* 07 */	"LOGPLOT",
	/* 08 */	"WHILE",
	/* 09 */	"ENDWHILE",
	/* 10 */	"IF",
	/* 11 */	"ENDIF",
	/* 12 */	"PUSH",
	/* 13 */	"POP",
	/* 14 */	"NOT",
	/* 15 */	"CHECK",
	/* 16 */	"AMEND",
	/* 17 */	"EMPTY",
	/* 18 */	"ITH",
	/* 19 */	"EQ",
	/* 20 */	"DIF",
	/* 21 */	"ASSIG",
	/* 22 */	"LC",
	/* 23 */	"RC",
	/* 24 */	"LT",
	/* 25 */	"GT",
	/* 26 */	"COMA",
	/* 27 */	"LP",
	/* 28 */	"RP",
	/* 29 */	"AND",
	/* 30 */	"OR",
	/* 31 */	"CONCAT",
	/* 32 */	"ID"
};
SetWordType zzerr1[8] = {0x0,0x5,0x0,0x0, 0x0,0x0,0x0,0x0};
SetWordType setwd1[33] = {0x0,0x63,0x0,0x0,0x0,0x4c,0x0,
	0x4c,0x54,0x60,0x54,0x60,0x0,0x0,0x0,
	0x80,0x0,0x80,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
	0x0,0x44};
SetWordType zzerr2[8] = {0x0,0x0,0x18,0x3, 0x0,0x0,0x0,0x0};
SetWordType zzerr3[8] = {0x0,0xc0,0x6,0x1, 0x0,0x0,0x0,0x0};
SetWordType zzerr4[8] = {0x0,0x80,0x2,0x0, 0x0,0x0,0x0,0x0};
SetWordType zzerr5[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr6[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType setwd2[33] = {0x0,0x80,0x0,0x0,0x0,0x80,0x48,
	0x80,0x80,0x80,0x80,0x80,0x48,0x48,0x0,
	0x0,0x48,0x0,0x1,0x0,0x0,0x0,0x24,
	0x0,0x1,0x0,0x0,0x0,0x12,0x0,0x0,
	0x0,0xa4};
SetWordType zzerr7[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr8[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr9[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr10[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr11[8] = {0x40,0x30,0x1,0x0, 0x0,0x0,0x0,0x0};
SetWordType setwd3[33] = {0x0,0x0,0x0,0x0,0x0,0x0,0xaa,
	0x0,0x0,0x0,0x0,0x0,0xaa,0xaa,0x0,
	0x0,0xaa,0x0,0x0,0x0,0x0,0x0,0x55,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
	0x0,0x55};
SetWordType zzerr12[8] = {0xa0,0x0,0x0,0x0, 0x0,0x0,0x0,0x0};
SetWordType zzerr13[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr14[8] = {0x0,0x0,0x40,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr15[8] = {0x40,0x30,0x41,0x0, 0x1,0x0,0x0,0x0};
SetWordType zzerr16[8] = {0x0,0x0,0x4,0x1, 0x0,0x0,0x0,0x0};
SetWordType setwd4[33] = {0x0,0x39,0x0,0x0,0x0,0x39,0x84,
	0x39,0x39,0x39,0x39,0x39,0x84,0x84,0x0,
	0x0,0x84,0x0,0x0,0x0,0x0,0x0,0x42,
	0x0,0x0,0x0,0x31,0x0,0x31,0x0,0x0,
	0x20,0x7b};
SetWordType setwd5[33] = {0x0,0x0,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x1,0x1,0x0,0x0,
	0x1,0x1,0x1,0x1,0x0,0x1,0x0,0x0,
	0x0,0x0};
