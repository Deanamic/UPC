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

AST* createASTstring(AST* as, char* text);
>>

<<
#include <cstdlib>
#include <cmath>
#include <map>
#include <list>
#include <set>

typedef list<pair<int,int> > Pairlist;

map<string, Pairlist> dps;

// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
  if (type == COMMA) {
    attr->kind = "pair";
    attr->text = "";
  } else if (type == LBRACK) {
    attr->kind = "literal";
    attr->text = "";
  } else {
    attr->kind = text;
    attr->text = "";
  }
}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind;
  as->text = attr->text;
  as->right = NULL;
  as->down = NULL;
  return as;
}

AST* createASTstring(AST* as, char* text) {
  AST* as1 = new AST;
  as1->kind = text;
  as1->text = "";
  AST* as2 = new AST;
  as2->kind = "list";
  as2->text = "";
  if (text == "WHILE" || text == "IF") {
    as1->down = as;
    as2->down = as->right;
    as->right = as2;
  } else {
    as2->down = as;
    as1->down = as2;
  }
  return as1;
}

AST* groupASTarguments(AST* as, char* groupname) {
  AST* as1 = new AST;
  as1->kind = groupname;
  as1->text = "";
  as1->down = as;
  return as1;
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

  cout<<a->kind;
  if (a->text!="") cout<<"("<<a->text<<")";
  cout<<endl;

  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
    i=i->right;
  }

  if (i!=NULL) {
      cout<<s+"  \\__";
      ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
      i=i->right;
  }
}



pair<int,int> evaluate_pair(AST* a) {
    return make_pair(stoi(a->down->kind), stoi(a->down->right->kind));
}

Pairlist evaluate_literal(AST* a) {
    Pairlist pl = {};
    AST* current = a->down;
    while (current != NULL) {
        pl.push_back(evaluate_pair(current));
        current = current -> right;
    }
    return pl;
}

Pairlist evaluate_def(AST* a) {
    Pairlist pl = {};
    AST* current = a->down;
    while (current != NULL) {
        Pairlist l;
        if (current->kind == "literal") {
            l = evaluate_literal(current);
        } else {
            l = Pairlist(dps[current->kind]);
        }
        pl.insert(pl.end(), l.begin(), l.end());
        current = current -> right;
    }
    return pl;
}

Pairlist normalize(Pairlist pl) {
    Pairlist npl;
    if (pl.size() == 0) return npl;
    int minx = pl.front().first;
    int miny = pl.front().second;
    for (pair<int,int> p : pl) {
        minx = min(minx, p.first);
        miny = min(miny, p.second);
    }
    for (pair<int,int> p : pl) {
        npl.push_back(make_pair(p.first-minx,p.second-miny));
    }
    return npl;
}

bool check(Pairlist pl) {
    set<int> def;
    Pairlist::iterator it = pl.begin();
    while (it != pl.end()) {
        if (def.find((*it).first) != def.end()) {
            return false;
        } else {
            def.insert((*it).first);
            it = next(it);
        }
    }
    return true;
}

Pairlist amend(Pairlist pl) {
    set<int> def;
    Pairlist::iterator it = pl.begin();
    Pairlist apl;
    while (it != pl.end()) {
        if (def.find((*it).first) == def.end()) {
            def.insert((*it).first);
            apl.push_back(*it);
        }
        it = next(it);
    }
    return apl;
}

Pairlist evaluate_expression(AST* a) {
    if (a->kind == "def") {
        return evaluate_def(a);
    } else if (a->kind == "NORMALIZE") {
        return normalize(evaluate_expression(a->down));
    } else if (a->kind == "POP") {
        Pairlist pl = evaluate_expression(a->down);
        pl.pop_back();
        return pl;
    } else if (a->kind == "PUSH") {
        Pairlist pl = evaluate_expression(a->down);
        pl.push_back(evaluate_pair(a->down->right));
        return pl;
    } else if (a->kind == "NORMALIZE") {
        return normalize(evaluate_expression(a->down));
    } else if (a->kind == "AMEND") {
        return amend(evaluate_expression(a->down));
    } else {
        cerr << "Undefined command: " << a->kind << endl;
    }
}

bool evaluate_condition(AST* a) {
    if (a->kind == "==" || a->kind == "!=" || a->kind == ">" || a->kind == "<") {
        Pairlist l1 = evaluate_expression(a->down->down->right);
        Pairlist l2 = evaluate_expression(a->down->right->down->right);
        Pairlist::iterator it1 = next(l1.begin(), stoi(a->down->down->kind));
        Pairlist::iterator it2 = next(l2.begin(), stoi(a->down->right->down->kind));
        if (a->kind == "==") {
            return (it1->first == it2->first && it1->second == it2->second);
        } else if (a->kind == "!=") {
            return (it1->first != it2->first || it1->second != it2->second);
        } else if (a->kind == ">") {
            if (it1->first == it2->first) {
                return (it1->second > it2->second);
            }
            return (it1->first > it2->first);
        } else if (a->kind == "<") {
            if (it1->first == it2->first) {
                return (it1->second < it2->second);
            }
            return (it1->first < it2->first);
        }
    } else if (a->kind == "NOT") {
        return !evaluate_condition(a->down);
    } else if (a->kind == "AND") {
        return evaluate_condition(a->down) && evaluate_condition(a->down->right);
    } else if (a->kind == "OR") {
        return evaluate_condition(a->down) || evaluate_condition(a->down->right);
    } else if (a->kind == "EMPTY") {
        return evaluate_expression(a->down).empty();
    } else if (a->kind == "CHECK") {
        return check(evaluate_expression(a->down));
    } else {
        cerr << "Undefined command: " << a->kind << endl;
    }
}

void plot(Pairlist pl) {
    cout << "PLOT ";
    for (pair<int,int> p : pl) {
        cout << "<" << p.first << "," << p.second << "> ";
    }
    cout << endl;
}

void logplot(Pairlist pl) {
    cout << "LOGPLOT ";
    for (pair<int,int> p : pl) {
        cout << "<" << p.first << "," << log(p.second) << "> ";
    }
    cout << endl;
}

void execute_list(AST* a) {
    AST* current = a->down;
    while (current != NULL) {
        string kind = current->kind;
        if (kind == "=")  {
            string target = current->down->kind;
            dps[target] = evaluate_expression(current->down->right);
        } else if (kind == "PLOT") {
            plot(evaluate_expression(current->down));
        } else if (kind == "LOGPLOT") {
            logplot(evaluate_expression(current->down));
        } else if (kind == "IF") {
            if (evaluate_condition(current->down)) {
                execute_list(current->down->right);
            }
        } else if (kind == "WHILE") {
            while (evaluate_condition(current->down)) {
                execute_list(current->down->right);
            }
        } else {
            cerr << "Undefined command: " << current->kind << endl;
        }
        current = current -> right;
    }
}

void execute(AST *a) {
    if (a == NULL)
        return;
    else if (a->kind == "DataPlotsProgram" && a->down->kind == "list" ) {
        execute_list(a->down);
    }
}

int main() {
  AST *root = NULL;
  ANTLR(plots(&root), stdin);
  ASTPrint(root);
  execute(root);
}
>>


#lexclass START

#token PLOT "PLOT"
#token LOGPLOT "LOGPLOT"
#token IF "IF"
#token ENDIF "ENDIF"
#token WHILE "WHILE"
#token ENDWHILE "ENDWHILE"

#token FUNCTION "(NORMALIZE|POP|AMEND)"
#token BOOLFUNCTION "(EMPTY|CHECK)"
#token PUSH "PUSH"
#token ITH "ITH"
#token OR "OR"
#token AND "AND"
#token NOT "NOT"

#token LCPS "\<"
#token RCPS "\>"
#token COMPOP "(==|\!=)"
#token EQUALS "="
#token LPAREN "\("
#token RPAREN "\)"
#token LBRACK "\["
#token RBRACK "\]"
#token COMMA ","

#token NUM "[0-9]+"
#token ID "DP[0-9]*"

#token SPACE "\ " << zzskip();>>
#token NONL "~[\n@]"
#token NOEOF "~[\n]"

plots: linterpretation "@"! <<#0=createASTstring(_sibling,"DataPlotsProgram");>>;
linterpretation: (command|"\n"!)*;

command: (assign | plotcom | whileblk | ifblk);
assign: ID EQUALS^ pexpr "\n"! ;
plotcom: (LOGPLOT^|PLOT^) LPAREN! pexpr RPAREN! "\n"!;
ifblk: IF^ LPAREN! condition RPAREN! "\n"! linterpretation ENDIF! "\n"! <<#0=createASTstring(_sibling,"IF");>>;
whileblk: WHILE^ LPAREN! condition RPAREN! "\n"! linterpretation ENDWHILE! "\n"! <<#0=createASTstring(_sibling,"WHILE");>>;

pexpr: def | pushexpr | funexpr;
funexpr: FUNCTION^ LPAREN! pexpr RPAREN! ;
pushexpr: PUSH^ LPAREN! pexpr ","! point RPAREN! ;
def: ( (literal|ID) ("·"! (literal|ID))* ) <<#0=groupASTarguments(_sibling,"def");>>;
literal: LBRACK^ point (","! point)* RBRACK! ;
point: LCPS! NUM COMMA^ NUM RCPS! ;

condition: (andblock) (OR^ (andblock))*;
andblock: basicblock (AND^ basicblock)*;
notblock: (NOT^) basicblock ;
comparison: ithexpr (LCPS^|RCPS^|COMPOP^) ithexpr ;
boolfunction: BOOLFUNCTION^ LPAREN! pexpr RPAREN! ;
parenblock: LPAREN! condition RPAREN! ;
basicblock: (notblock|boolfunction|comparison|parenblock) ;
ithexpr: ITH^ LPAREN! NUM ","! pexpr RPAREN! ;
