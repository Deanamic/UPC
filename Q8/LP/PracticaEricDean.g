#header
<<
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
>>

<<
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
>>

#lexclass START
#token NUM "[0-9]+"

#token SPACE "\ " << zzskip();>>
#token ENDL "\n" << zzskip();>>

#token PLOT "PLOT"
#token NORMALIZE "NORMALIZE"
#token LOGPLOT "LOGPLOT"
#token WHILE "WHILE"
#token ENDWHILE "ENDWHILE"
#token IF "IF"
#token ENDIF "ENDIF"
#token PUSH "PUSH"
#token POP "POP"
#token NOT "NOT"
#token CHECK "CHECK"
#token AMEND "AMEND"
#token EMPTY "EMPTY"
#token ITH "ITH"

#token EQ "\=\="
#token DIF "\!\="


#token ASSIG "\="
#token LC "\["
#token RC "\]"
#token LT "\<"
#token GT "\>"
#token COMA "\,"
#token LP "\("
#token RP "\)"
#token AND "\&\&"
#token OR "\|\|"
#token CONCAT "\·"

#token ID "[A-Za-z][A-Za-z0-9]*"

plots: linterpretation "@"! <<#0=createASTstring(_sibling, "DataPlotsProgram"); >>;
linterpretation: expr;
expr: (assig | plot | control)* <<#0=createASTstring(_sibling,"list");>>;

control: WHILE^ LP! bul RP! (expr) ENDWHILE! | IF^ LP! bul RP! (expr) ENDIF!;
bul: NOT^ bul | bulfoonc| punt (GT^ | LT^ | EQ^ | DIF^) punt;
bulfoonc: (EMPTY^ | CHECK^) LP! (list|funcio) RP!;
assig: ID ASSIG^ (list | funcio);


funcio: POP^ LP! (list | funcio) RP!
        |PUSH^ LP! (list | funcio) COMA! punt RP!
        |AMEND^ LP! (list | funcio) RP!
        |NORMALIZE^ LP! (list | funcio) RP!;

plot: (PLOT^ | LOGPLOT^) LP! (list | funcio) RP!;
list: membre (CONCAT! membre)* <<#0=createASTstring(_sibling,"def");>>;
membre:  LC! punt (COMA! punt)* RC! <<#0=createASTstring(_sibling,"literal");>>
        |ID;
punt: LT! NUM COMA! NUM GT!  <<#0=createASTstring(_sibling,"pair");>>| ITH^ LP! NUM COMA! (list | funcio) RP!;
//list: LC punt (CO punt)*|ID|POP LP ID RP|;
