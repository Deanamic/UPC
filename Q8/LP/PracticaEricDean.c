/*
 * A n t l r  T r a n s l a t i o n  H e a d e r
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 *
 *   antlr -gt PracticaEricDean.g
 *
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
#define GENAST

#include "ast.h"

#define zzSET_SIZE 8
#include "antlr.h"
#include "tokens.h"
#include "dlgdef.h"
#include "mode.h"

/* MR23 In order to remove calls to PURIFY use the antlr -nopurify option */

#ifndef PCCTS_PURIFY
#define PCCTS_PURIFY(r,s) memset((char *) &(r),'\0',(s));
#endif

#include "ast.c"
zzASTgvars

ANTLR_INFO

#include <cstdlib>
#include <cmath>
// function to fill token information


// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind; 
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

void zzcr_attr(Attrib *attr, int type, char *text) {
  if (type == NUM) {
    attr->kind = "intconst";
    attr->text = text;
  } else if (type == ID) {
    attr->kind = "id";
    attr->text = text;
  } else if (type == ASSIG) {
    attr->kind = "assig";
    attr->text = "=";
  } else if (type == PLOT) {
    attr->kind = "plot";
    attr->text = "PLOT";
  } else if (type == LOGPLOT) {
    attr->kind = "logplot";
    attr->text = "LOGPLOT";
  } else if (type == NORMALIZE) {
    attr->kind = "normalize";
    attr->text = "NORMALIZE";
  } else if (type == POP) {
    attr->kind = "pop";
    attr->text = "POP";
  } else if (type == PUSH) {
    attr->kind = "push";
    attr->text = "PUSH";
  } else if (type == AMEND) {
    attr->kind = "amend";
    attr->text = "AMEND";
  } else if (type == WHILE) {
    attr->kind = "while";
    attr->text = "WHILE";
  } else if (type == IF) {
    attr->kind = "if";
    attr->text = "IF";
  } else if (type == NOT) {
    attr->kind = "not";
    attr->text = "NOT";
  } else if (type == EMPTY) {
    attr->kind = "empty";
    attr->text = "EMPTY";
  } else if (type == CHECK) {
    attr->kind = "check";
    attr->text = "CHECK";
  } else if (type == ITH) {
    attr->kind = "ith";
    attr->text = "ITH";
  } else if (type == LT) {
    attr->kind = "lt";
    attr->text = "<";
  } else if (type == GT) {
    attr->kind = "gt";
    attr->text = ">";
  } else if (type == EQ) {
    attr->kind = "eq";
    attr->text = "==";
  } else if (type == DIF) {
    attr->kind = "noteq";
    attr->text = "!=";
  } else {
    attr->kind = text;
    attr->text = "";
  }
}


AST* createASTstring(AST *child, string s) {
  AST *as=new AST;
  as->kind="";
  as->text = s;
  as->right=NULL;
  as->down=child;
  return as;
}


/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a,int n) {
  AST *c=a->down;
  for (int i=0; c!=NULL && i<n; i++) c=c->right;
  return c;
} 

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
  if (a==NULL) return;
  
  //~ cout<<a->kind;
  if (a->text!="") cout<<a->text;
  cout<<endl;
  
  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->text.size(),' '));
    i=i->right;
  }
  
  if (i!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"   "+string(i->text.size(),' '));
    i=i->right;
  }
}

/// print AST 
void ASTPrint(AST *a)
{
  while (a!=NULL) {
    cout<<" ";
    ASTPrintIndent(a,"");
    a=a->right;
  }
}

int main() {
  AST *root = NULL;
  ANTLR(plots(&root), stdin);
  ASTPrint(root);
}

void
#ifdef __USE_PROTOS
plots(AST**_root)
#else
plots(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  linterpretation(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(1); 
  (*_root)=createASTstring(_sibling, "DataPlotsProgram");
 zzCONSUME;

  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x1);
  }
}

void
#ifdef __USE_PROTOS
linterpretation(AST**_root)
#else
linterpretation(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  expr(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x2);
  }
}

void
#ifdef __USE_PROTOS
expr(AST**_root)
#else
expr(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    for (;;) {
      if ( !((setwd1[LA(1)]&0x4))) break;
      if ( (LA(1)==ID) ) {
        assig(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {
        if ( (setwd1[LA(1)]&0x8) ) {
          plot(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {
          if ( (setwd1[LA(1)]&0x10) ) {
            control(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else break; /* MR6 code for exiting loop "for sure" */
        }
      }
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  (*_root)=createASTstring(_sibling,"list");
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x20);
  }
}

void
#ifdef __USE_PROTOS
control(AST**_root)
#else
control(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==WHILE) ) {
    zzmatch(WHILE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(LP);  zzCONSUME;
    bul(zzSTR); zzlink(_root, &_sibling, &_tail);
    zzmatch(RP);  zzCONSUME;
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      expr(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzEXIT(zztasp2);
      }
    }
    zzmatch(ENDWHILE);  zzCONSUME;
  }
  else {
    if ( (LA(1)==IF) ) {
      zzmatch(IF); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LP);  zzCONSUME;
      bul(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(RP);  zzCONSUME;
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        expr(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzEXIT(zztasp2);
        }
      }
      zzmatch(ENDIF);  zzCONSUME;
    }
    else {zzFAIL(1,zzerr1,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x40);
  }
}

void
#ifdef __USE_PROTOS
bul(AST**_root)
#else
bul(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==NOT) ) {
    zzmatch(NOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    bul(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (setwd1[LA(1)]&0x80) ) {
      bulfoonc(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (setwd2[LA(1)]&0x1) ) {
        punt(zzSTR); zzlink(_root, &_sibling, &_tail);
        {
          zzBLOCK(zztasp2);
          zzMake0;
          {
          if ( (LA(1)==GT) ) {
            zzmatch(GT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {
            if ( (LA(1)==LT) ) {
              zzmatch(LT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
            }
            else {
              if ( (LA(1)==EQ) ) {
                zzmatch(EQ); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
              }
              else {
                if ( (LA(1)==DIF) ) {
                  zzmatch(DIF); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
                }
                else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
              }
            }
          }
          zzEXIT(zztasp2);
          }
        }
        punt(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr3,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x2);
  }
}

void
#ifdef __USE_PROTOS
bulfoonc(AST**_root)
#else
bulfoonc(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (LA(1)==EMPTY) ) {
      zzmatch(EMPTY); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {
      if ( (LA(1)==CHECK) ) {
        zzmatch(CHECK); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      }
      else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  zzmatch(LP);  zzCONSUME;
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (setwd2[LA(1)]&0x4) ) {
      list(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (setwd2[LA(1)]&0x8) ) {
        funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  zzmatch(RP);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x10);
  }
}

void
#ifdef __USE_PROTOS
assig(AST**_root)
#else
assig(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(ASSIG); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (setwd2[LA(1)]&0x20) ) {
      list(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (setwd2[LA(1)]&0x40) ) {
        funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr6,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x80);
  }
}

void
#ifdef __USE_PROTOS
funcio(AST**_root)
#else
funcio(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==POP) ) {
    zzmatch(POP); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(LP);  zzCONSUME;
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      if ( (setwd3[LA(1)]&0x1) ) {
        list(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {
        if ( (setwd3[LA(1)]&0x2) ) {
          funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
      }
      zzEXIT(zztasp2);
      }
    }
    zzmatch(RP);  zzCONSUME;
  }
  else {
    if ( (LA(1)==PUSH) ) {
      zzmatch(PUSH); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LP);  zzCONSUME;
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        if ( (setwd3[LA(1)]&0x4) ) {
          list(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {
          if ( (setwd3[LA(1)]&0x8) ) {
            funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else {zzFAIL(1,zzerr8,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
        zzEXIT(zztasp2);
        }
      }
      zzmatch(COMA);  zzCONSUME;
      punt(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(RP);  zzCONSUME;
    }
    else {
      if ( (LA(1)==AMEND) ) {
        zzmatch(AMEND); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(LP);  zzCONSUME;
        {
          zzBLOCK(zztasp2);
          zzMake0;
          {
          if ( (setwd3[LA(1)]&0x10) ) {
            list(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else {
            if ( (setwd3[LA(1)]&0x20) ) {
              funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
            }
            else {zzFAIL(1,zzerr9,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
          }
          zzEXIT(zztasp2);
          }
        }
        zzmatch(RP);  zzCONSUME;
      }
      else {
        if ( (LA(1)==NORMALIZE) ) {
          zzmatch(NORMALIZE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          zzmatch(LP);  zzCONSUME;
          {
            zzBLOCK(zztasp2);
            zzMake0;
            {
            if ( (setwd3[LA(1)]&0x40) ) {
              list(zzSTR); zzlink(_root, &_sibling, &_tail);
            }
            else {
              if ( (setwd3[LA(1)]&0x80) ) {
                funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
              }
              else {zzFAIL(1,zzerr10,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
            }
            zzEXIT(zztasp2);
            }
          }
          zzmatch(RP);  zzCONSUME;
        }
        else {zzFAIL(1,zzerr11,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
      }
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd4, 0x1);
  }
}

void
#ifdef __USE_PROTOS
plot(AST**_root)
#else
plot(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (LA(1)==PLOT) ) {
      zzmatch(PLOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {
      if ( (LA(1)==LOGPLOT) ) {
        zzmatch(LOGPLOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      }
      else {zzFAIL(1,zzerr12,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  zzmatch(LP);  zzCONSUME;
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (setwd4[LA(1)]&0x2) ) {
      list(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (setwd4[LA(1)]&0x4) ) {
        funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr13,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  zzmatch(RP);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd4, 0x8);
  }
}

void
#ifdef __USE_PROTOS
list(AST**_root)
#else
list(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  membre(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==CONCAT) ) {
      zzmatch(CONCAT);  zzCONSUME;
      membre(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  (*_root)=createASTstring(_sibling,"def");
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd4, 0x10);
  }
}

void
#ifdef __USE_PROTOS
membre(AST**_root)
#else
membre(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==LC) ) {
    zzmatch(LC);  zzCONSUME;
    punt(zzSTR); zzlink(_root, &_sibling, &_tail);
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      while ( (LA(1)==COMA) ) {
        zzmatch(COMA);  zzCONSUME;
        punt(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzLOOP(zztasp2);
      }
      zzEXIT(zztasp2);
      }
    }
    zzmatch(RC); 
    (*_root)=createASTstring(_sibling,"literal");
 zzCONSUME;

  }
  else {
    if ( (LA(1)==ID) ) {
      zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {zzFAIL(1,zzerr14,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd4, 0x20);
  }
}

void
#ifdef __USE_PROTOS
punt(AST**_root)
#else
punt(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==LT) ) {
    zzmatch(LT);  zzCONSUME;
    zzmatch(NUM); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(COMA);  zzCONSUME;
    zzmatch(NUM); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(GT); 
    (*_root)=createASTstring(_sibling,"pair");
 zzCONSUME;

  }
  else {
    if ( (LA(1)==ITH) ) {
      zzmatch(ITH); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LP);  zzCONSUME;
      zzmatch(NUM); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(COMA);  zzCONSUME;
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        if ( (setwd4[LA(1)]&0x40) ) {
          list(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {
          if ( (setwd4[LA(1)]&0x80) ) {
            funcio(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else {zzFAIL(1,zzerr15,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
        zzEXIT(zztasp2);
        }
      }
      zzmatch(RP);  zzCONSUME;
    }
    else {zzFAIL(1,zzerr16,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd5, 0x1);
  }
}
