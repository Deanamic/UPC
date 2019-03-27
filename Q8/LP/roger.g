#header
<<
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
>>

<<
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
>>

#lexclass START
#token COMMA "\,"
#token LSB "\["
#token RSB "\]"
#token LT "\<"
#token GT "\>"
#token CONC "\·"
#token LPAR "\("
#token RPAR "\)"

#token PLOT "PLOT"
#token LOGPLOT "LOGPLOT"
#token NORMALIZE "NORMALIZE"
#token POP "POP"
#token PUSH "PUSH"
#token AMEND "AMEND"

#token WHILE "WHILE"
#token ENDWHILE "ENDWHILE"
#token IF "IF"
#token ENDIF "ENDIF"

#token NOT "NOT"
#token EMPTY "EMPTY"
#token CHECK "CHECK"
#token ITH "ITH"

#token EQ "=="
#token NOTEQ "!="

#token NUM "[0-9]+"
#token ID "[a-zA-Z][a-zA-Z0-9]*"
#token ASIG "\="
#token SPACE "[\ \n]" << zzskip();>>

plots: linterpretation "@"! <<#0=createASTstring(_sibling,"DataPlotsProgram");>>;
linterpretation: lista;

lista: (line)* <<#0=createASTstring(_sibling,"list");>>;
line: asignacion | plot | flow_control;

asignacion: (ID ASIG^ rasig);
plot: (PLOT^ LPAR! rasig RPAR!) | (LOGPLOT^ LPAR! rasig RPAR!);
flow_control: (WHILE^ LPAR! cond RPAR! lista ENDWHILE!) | (IF^ LPAR! cond RPAR! lista ENDIF!);

rasig: def | normalize | pop | push | amend;

def: ( literal | ID ) (def_conc)* <<#0=createASTstring(_sibling,"def");>>;
literal: LSB! paira (COMMA! paira)* RSB! <<#0=createASTstring(_sibling,"literal");>>;
paira: LT! num COMMA^ num GT! <<#0=createASTstring(_sibling,"pair");>>;
num: NUM;
def_conc: CONC! (ID | literal);

normalize: NORMALIZE^ LPAR! rasig RPAR!;
pop: POP^ LPAR! rasig RPAR!;
push: PUSH^ LPAR! rasig COMMA! paira RPAR!;
amend: AMEND^ LPAR! rasig RPAR!;

cond: (NOT^)* rcond;
rcond: (EMPTY^ LPAR! rasig RPAR!) | (CHECK^ LPAR! rasig RPAR!) | (comp);

comp: (paira | ith) (LT^ | GT^ | EQ^ | NOTEQ^) (paira | ith);
ith: ITH^ LPAR! num COMMA! rasig RPAR!;