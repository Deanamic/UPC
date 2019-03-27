/*
 * A n t l r  T r a n s l a t i o n  H e a d e r
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 *
 *   antlr -gt practica.g
 *
 */

#define ANTLR_VERSION	13333
#include "pcctscfg.h"
#include "pccts_stdio.h"

#include <string>
#include <iostream>
#include <map>
#include <list>
#include <set>
using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
  int type;
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

#define zzSET_SIZE 4
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
void zzcr_attr(Attrib *attr, int type, char *text) {
  if (type == NUM) {
    attr->kind = "intconst";
    attr->text = text;
  } else if (type == ID) {
    attr->kind = "id";
    attr->text = text;
  } else if (type == ASIG) {
    attr->kind = "asig";
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
  } else if (type == NOTEQ) {
    attr->kind = "noteq";
    attr->text = "!=";
  } else {
    attr->kind = text;
    attr->text = "";
  }
}

map<string, list<pair<int,int> > > dps;

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind;
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

AST* createASTstring(AST *child, string s) {
  AST *as=new AST;
  as->kind="list";
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
  
  if (a->text!="") cout << a->text;
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

list<pair<int,int> > evaluate(AST *a, list<pair<int,int> > l){
  if (a == NULL)
  return l;
  else if (a->text == "pair"){
    list<pair<int,int> > l_aux = evaluate(a->right, l);
    pair<int, int> p;
    p.first = atoi(child(a,0)->text.c_str());
    p.second = atoi(child(a,1)->text.c_str());
    l_aux.push_front(p);
    return l_aux;
  } else if (a->text == "literal"){
    list<pair<int,int> > l_aux = evaluate(a->right, l);
    return evaluate(child(a,0), l_aux);
  } else if (a->text == "def") {
    return evaluate(child(a,0), l);
  } else if (a->kind == "id") {
    list<pair<int,int> > l_aux = evaluate(a->right, l);
    list<pair<int,int> > l_aux_2 = dps[a->text];
    for (list<pair<int,int> >::iterator it = l_aux.begin(); it != l_aux.end(); ++it) {
      l_aux_2.push_back(*it);
    }
    return l_aux_2;
  } else if (a->kind == "normalize") {
    list<pair<int,int> > l_aux = evaluate(child(a,0), l);
    int minx = 1e6, miny = 1e6;
    for (list<pair<int,int> >::iterator it = l_aux.begin(); it != l_aux.end(); ++it) {
      if((*it).first < minx) minx = (*it).first;
      if((*it).second < miny) miny = (*it).second;
    }
    list<pair<int,int> > l_aux_2;
    for (list<pair<int,int> >::iterator it = l_aux.begin(); it != l_aux.end(); ++it) {
      pair<int,int> p;
      p.first = (*it).first - minx;
      p.second = (*it).second - miny;
      l_aux_2.push_back(p);
    }
    return l_aux_2;
  } else if (a->kind == "pop") {
    list<pair<int,int> > l_aux = evaluate(child(a,0), l);
    l_aux.pop_back();
    return l_aux;
  } else if (a->kind == "push") {
    list<pair<int,int> > l_aux = evaluate(child(a,0), l);
    pair<int,int> p;
    p.first = atoi(child(child(a,1),0)->text.c_str());
    p.second = atoi(child(child(a,1),1)->text.c_str());
    l_aux.push_back(p);
    return l_aux;
  } else if (a->kind == "amend") {
    list<pair<int,int> > l_aux = evaluate(child(a,0), l);
    set<int> s;
    for (list<pair<int,int> >::iterator it = l_aux.begin(); it != l_aux.end(); ++it) {
      if (s.find((*it).first) != s.end()) {
        l_aux.erase(it);
        --it;
      } else {
        s.insert((*it).first);
      }
    }
    return l_aux;
  }
}

pair<int,int> get_pair(AST *a) {
  if (a->kind=="ith") {
    int i = atoi(child(a,0)->text.c_str());
    list<pair<int,int> > l;
    l = evaluate(child(a,1), l);
    list<pair<int,int> >::iterator it = l.begin();
    advance(it,i);
    return (*it);
  } else if (a->text=="pair"){
    pair<int,int> p;
    p.first = atoi(child(a,0)->text.c_str());
    p.second = atoi(child(a,1)->text.c_str());
    return p;
  }
}

bool evaluate_cond(AST *a) {
  if (a->kind=="not") {
    return not evaluate_cond(child(a,0));
  } else if (a->kind=="empty") {
    list<pair<int,int> > l;
    l = evaluate(child(a,0), l);
    return l.empty();
  } else if (a->kind=="check") {
    list<pair<int,int> > l;
    l = evaluate(child(a,0), l);
    set<int> s;
    for (list<pair<int,int> >::iterator it = l.begin(); it != l.end(); ++it) {
      if (s.find((*it).first) != s.end()) {
        return false;
      } else {
        s.insert((*it).first);
      }
    }
    return true;
  } else if (a->kind=="eq") {
    pair<int,int> p1 = get_pair(child(a,0));
    pair<int,int> p2 = get_pair(child(a,1));
    return (p1.first == p2.first) && (p1.second == p2.second);
  } else if (a->kind=="noteq") {
    pair<int,int> p1 = get_pair(child(a,0));
    pair<int,int> p2 = get_pair(child(a,1));
    return (p1.first != p2.first) || (p1.second != p2.second);
  } else if (a->kind=="lt") {
    pair<int,int> p1 = get_pair(child(a,0));
    pair<int,int> p2 = get_pair(child(a,1));
    return (p1.first < p2.first) && (p1.second < p2.second);
  } else if (a->kind=="gt"){
    pair<int,int> p1 = get_pair(child(a,0));
    pair<int,int> p2 = get_pair(child(a,1));
    return (p1.first > p2.first) && (p1.second > p2.second);
  }
}

void execute(AST *a){
  if (a == NULL)
  return;
  else if (a->kind=="asig"){
    list<pair<int,int> > l;
    dps[child(a,0)->text] = evaluate(child(a,1), l);
  } else if (a->kind=="plot") {
    cout << "PLOT" << ' ';
    list<pair<int,int> > l;
    l = evaluate(child(a,0), l);
    for (list<pair<int,int> >::iterator it = l.begin(); it!=l.end(); ++it) {
      cout << '<' << (*it).first << ',' << (*it).second << '>' << ' ';
    }
    cout << endl;
  } else if (a->kind=="logplot") {
    cout << "LOGPLOT" << ' ';
    list<pair<int,int> > l;
    l = evaluate(child(a,0), l);
    for (list<pair<int,int> >::iterator it = l.begin(); it!=l.end(); ++it) {
      cout << '<' << (*it).first << ',' << (*it).second << '>' << ' ';
    }
    cout << endl;
  } else if (a->kind=="while") {
    while(evaluate_cond(child(a,0))){
      execute(child(child(a,1),0));
    }
  } else if (a->kind=="if") {
    if(evaluate_cond(child(a,0))){
      execute(child(child(a,1),0));
    }
  }
  execute(a->right);
}

int main() {
  AST *root = NULL;
  ANTLR(plots(&root), stdin);
  ASTPrint(root);
  execute(child(child(root,0),0));
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
  (*_root)=createASTstring(_sibling,"DataPlotsProgram");
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
  lista(zzSTR); zzlink(_root, &_sibling, &_tail);
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
lista(AST**_root)
#else
lista(_root)
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
    while ( (setwd1[LA(1)]&0x4) ) {
      line(zzSTR); zzlink(_root, &_sibling, &_tail);
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
  zzresynch(setwd1, 0x8);
  }
}

void
#ifdef __USE_PROTOS
line(AST**_root)
#else
line(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==ID) ) {
    asignacion(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (setwd1[LA(1)]&0x10) ) {
      plot(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (setwd1[LA(1)]&0x20) ) {
        flow_control(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr1,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
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
asignacion(AST**_root)
#else
asignacion(_root)
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
    zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(ASIG); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x80);
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
  if ( (LA(1)==PLOT) ) {
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      zzmatch(PLOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LPAR);  zzCONSUME;
      rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(RPAR);  zzCONSUME;
      zzEXIT(zztasp2);
      }
    }
  }
  else {
    if ( (LA(1)==LOGPLOT) ) {
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        zzmatch(LOGPLOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(LPAR);  zzCONSUME;
        rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzmatch(RPAR);  zzCONSUME;
        zzEXIT(zztasp2);
        }
      }
    }
    else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x1);
  }
}

void
#ifdef __USE_PROTOS
flow_control(AST**_root)
#else
flow_control(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==WHILE) ) {
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      zzmatch(WHILE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LPAR);  zzCONSUME;
      cond(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(RPAR);  zzCONSUME;
      lista(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(ENDWHILE);  zzCONSUME;
      zzEXIT(zztasp2);
      }
    }
  }
  else {
    if ( (LA(1)==IF) ) {
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        zzmatch(IF); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(LPAR);  zzCONSUME;
        cond(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzmatch(RPAR);  zzCONSUME;
        lista(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzmatch(ENDIF);  zzCONSUME;
        zzEXIT(zztasp2);
        }
      }
    }
    else {zzFAIL(1,zzerr3,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
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
rasig(AST**_root)
#else
rasig(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (setwd2[LA(1)]&0x4) ) {
    def(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (LA(1)==NORMALIZE) ) {
      normalize(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==POP) ) {
        pop(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {
        if ( (LA(1)==PUSH) ) {
          push(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {
          if ( (LA(1)==AMEND) ) {
            amend(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
      }
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x8);
  }
}

void
#ifdef __USE_PROTOS
def(AST**_root)
#else
def(_root)
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
    if ( (LA(1)==LSB) ) {
      literal(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==ID) ) {
        zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
      }
      else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==CONC) ) {
      def_conc(zzSTR); zzlink(_root, &_sibling, &_tail);
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
  zzresynch(setwd2, 0x10);
  }
}

void
#ifdef __USE_PROTOS
literal(AST**_root)
#else
literal(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(LSB);  zzCONSUME;
  paira(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==COMMA) ) {
      zzmatch(COMMA);  zzCONSUME;
      paira(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  zzmatch(RSB); 
  (*_root)=createASTstring(_sibling,"literal");
 zzCONSUME;

  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x20);
  }
}

void
#ifdef __USE_PROTOS
paira(AST**_root)
#else
paira(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(LT);  zzCONSUME;
  num(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(COMMA); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  num(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(GT); 
  (*_root)=createASTstring(_sibling,"pair");
 zzCONSUME;

  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x40);
  }
}

void
#ifdef __USE_PROTOS
num(AST**_root)
#else
num(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(NUM); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
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
def_conc(AST**_root)
#else
def_conc(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(CONC);  zzCONSUME;
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (LA(1)==ID) ) {
      zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {
      if ( (LA(1)==LSB) ) {
        literal(zzSTR); zzlink(_root, &_sibling, &_tail);
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
  zzresynch(setwd3, 0x1);
  }
}

void
#ifdef __USE_PROTOS
normalize(AST**_root)
#else
normalize(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(NORMALIZE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(LPAR);  zzCONSUME;
  rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x2);
  }
}

void
#ifdef __USE_PROTOS
pop(AST**_root)
#else
pop(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(POP); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(LPAR);  zzCONSUME;
  rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x4);
  }
}

void
#ifdef __USE_PROTOS
push(AST**_root)
#else
push(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(PUSH); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(LPAR);  zzCONSUME;
  rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(COMMA);  zzCONSUME;
  paira(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x8);
  }
}

void
#ifdef __USE_PROTOS
amend(AST**_root)
#else
amend(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(AMEND); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(LPAR);  zzCONSUME;
  rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x10);
  }
}

void
#ifdef __USE_PROTOS
cond(AST**_root)
#else
cond(_root)
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
    while ( (LA(1)==NOT) ) {
      zzmatch(NOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  rcond(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x20);
  }
}

void
#ifdef __USE_PROTOS
rcond(AST**_root)
#else
rcond(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==EMPTY) ) {
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      zzmatch(EMPTY); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(LPAR);  zzCONSUME;
      rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzmatch(RPAR);  zzCONSUME;
      zzEXIT(zztasp2);
      }
    }
  }
  else {
    if ( (LA(1)==CHECK) ) {
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        zzmatch(CHECK); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(LPAR);  zzCONSUME;
        rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
        zzmatch(RPAR);  zzCONSUME;
        zzEXIT(zztasp2);
        }
      }
    }
    else {
      if ( (setwd3[LA(1)]&0x40) ) {
        {
          zzBLOCK(zztasp2);
          zzMake0;
          {
          comp(zzSTR); zzlink(_root, &_sibling, &_tail);
          zzEXIT(zztasp2);
          }
        }
      }
      else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x80);
  }
}

void
#ifdef __USE_PROTOS
comp(AST**_root)
#else
comp(_root)
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
    if ( (LA(1)==LT) ) {
      paira(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==ITH) ) {
        ith(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr8,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
    }
  }
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (LA(1)==LT) ) {
      zzmatch(LT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {
      if ( (LA(1)==GT) ) {
        zzmatch(GT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      }
      else {
        if ( (LA(1)==EQ) ) {
          zzmatch(EQ); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        }
        else {
          if ( (LA(1)==NOTEQ) ) {
            zzmatch(NOTEQ); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {zzFAIL(1,zzerr9,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
      }
    }
    zzEXIT(zztasp2);
    }
  }
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    if ( (LA(1)==LT) ) {
      paira(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==ITH) ) {
        ith(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr10,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
    zzEXIT(zztasp2);
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
ith(AST**_root)
#else
ith(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(ITH); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(LPAR);  zzCONSUME;
  num(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(COMMA);  zzCONSUME;
  rasig(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd4, 0x2);
  }
}
