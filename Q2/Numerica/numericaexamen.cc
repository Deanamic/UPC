#include <bits/stdc++.h>
using namespace std;

typedef vector<long double > VD;
int n,m; long double t;
vector<VD> inversa;


void invertir(){
    for (int i = 0; i < n; i++) {
      int pivot = i+1;
      while((t = inversa[i][i]) == 0) swap(inversa[i], inversa[pivot++]);
      for (int j = i; j < 2*n; j++) inversa[i][j]=inversa[i][j]/t;
      for (int j = 0; j < n; j++) {
         if (i != j){
            t = inversa[j][i];
            for (int k = 0; k < 2*n; k++) inversa[j][k]=inversa[j][k]-t*inversa[i][k];
          }
      }
   }
}


int lu(vector<VD>& a, int& n, vector<int>& perm, long double tol){
    int contperm = 1; //mirem la paritat de les permutacions
    for (int i = 0; i < n; ++i) { //i indica la diagonal
        long double actumax = -1;
        int posmax = i;
        for (int j = i; j < n; ++j) { //mirem el maxim de les files per cada columna
            long double maxfila = -1;
            for (int k = i; k < n; ++k) {
                if (maxfila < abs(a[j][k])) maxfila = abs(a[j][k]); //mirem el maxim de la fila
                //guardem a max fila el valor
            }
            if (actumax < abs(a[j][i])/maxfila) {
                actumax = abs(a[j][i])/maxfila;
                posmax = j;
            } //guardem la posicio maxima per fer el swap
        }
        swap(a[i],a[posmax]);
        swap(perm[i],perm[posmax]);
        if (i != posmax) contperm *= -1; //hem fet una permutacio
        for (int j = i+1; j < n; ++j) {
            long double m = a[j][i]/a[i][i];
            for (int k = i; k < n; ++k) a[j][k] -= m*a[i][k];
            a[j][i] = m;
        } //dividim totes pel maxim
    }
    //tenemos el sistema resuelto, miramos que la diagonal sea mayor que la tolerancia
    for (int i = 0; i < n; ++i){
        if (abs(a[i][i]) < tol) return 0;
    }
    return contperm;
}

void resol (vector<VD>& a, VD& x, VD& b, int& n, vector<int>& perm){
    for (int i = 0; i < n; ++i) {
        x[i] = b[perm[i]];
    }
    for (int i = 1; i < n; ++i) {
        for (int j = i-1; j >= 0; --j) x[i]-=a[i][j]*x[j];
    }
    for (int i = n-1; i >= 0; --i) {
        for (int j = i+1; j < n; ++j) x[i]-=a[i][j]*x[j];
        x[i] /= a[i][i];
    }
}

int sistema(vector<VD>& a, VD& x, VD& b, int& n, long double tol, vector<int>& perm){
    int i = lu(a, n, perm, tol);
    if (i == 0) return 0;
    resol(a,x,b,n,perm);
    return i;
}

int main(){
    cout.precision(14);
    //CAMBIA EL NOMBRE ES ESTE ARCHIVO!!!!!!!!!!!
    freopen("M00.DAT","r",stdin);
    freopen("Sortida.txt","w",stdout);

    cin >> n >> m;
    vector <vector<long double> >a(n,vector<long double> (n,0));
    inversa = vector<vector<long double> >(n,VD (2*n,0));
    for(int i = 0; i < n ; ++i) inversa[i][i+n] = 1;
    for (int i = 0; i < m; ++i) {
        int x, y;
        cin >> x >> y;
        long double num;
        cin >> num;
        a[x][y] = inversa[x][y] = num;
    }
    cout << "Estas son las normas de la matriz" <<endl;
    long double Asub1 = 0, Asubinf = 0;
    for (int i = 0; i < n; ++i){
        long double msub1 = 0;
        for (int j = 0; j < n; ++j){
            msub1 += abs(a[j][i]);
        }
        Asub1 = max(Asub1,msub1);
    }
    cout << "la norma sub1 de la matriz A es: " << scientific << Asub1 << endl;

    for (int i = 0; i < n; ++i){
        long double msubinf = 0;
        for (int j = 0; j < n; ++j){
            msubinf += abs(a[i][j]);
        }
        Asubinf = max(Asubinf,msubinf);
    }
    cout << "la norma subinf de la matriz A es: " << scientific << Asubinf << endl;
    cout << endl;
    vector <long double> b(n,0);
    int k;
    cin >> k;
    for (int i = 0; i < k; ++i) {
        int x,y;
        cin >> x;
        cin >> b[x];
    }
    vector<int> perm(n);
    for (int i = 0; i < n; ++i) perm[i]=i;

    vector<long double> x(n,0);
    if (sistema(a ,x ,b ,n ,1e-13, perm) == 0) {
        cout << "Singular\n";
        return 0;
    }
    cout << "la matriu LU es: " << endl;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << a[i][j] << ' ';
        }
        cout << endl;
    }
    cout << endl;
    invertir();


    cout << endl;
    cout << endl <<"Estas son las normas del vector x: \n";

    //norma sub 1
    long double sub1 = 0,sub2 = 0, subinf = 0, det = 1, traza = 0;
    for (int i = 0; i < n; ++i) {
        sub1 += abs(x[i]);
    }
    cout << "la norma sub1 es: " << scientific << sub1 <<endl;
    //

    //norma sub 2
    for (int i = 0; i < n; ++i) {
        sub2 += x[i]*x[i];
    }
    cout << "la norma sub2 es: " << scientific << sqrt(sub2) <<endl;
    //

    //norma sub infinito
    for (int i = 0; i < n; ++i) {
        subinf = max(abs(x[i]),subinf);
    }
    cout << "la norma subinf es: " << scientific << subinf <<endl;
    //
    cout << endl;
    cout << "Aquí estan los determinantes y trazas: \n";
    for(int i = 0; i < n; ++i){
        traza += a[i][i];
        det *= a[i][i];
    }
    cout << "El determinante de A es: " << det <<'\n' << "la traza de A es: " << traza << endl;

    //inversa
    cout <<"-----------------------------------------------\n";
    cout << "matriz inversa\n";
    cout << "aixo es la matriu inversa" << endl;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
          cout << inversa[i][j+n] << ' ';
      }
      cout << endl;
    }
    cout << endl;
    cout << "Estas son las normas de la matriz inversa" <<endl;
    long double Ainvsub1 = 0, Ainvsubinf = 0, Ainvtraza = 0;
    for (int i = 0; i < n; ++i){
        long double msub1 = 0;
        for (int j = 0; j < n; ++j){
            msub1 += abs(inversa[j][i+n]);
        }
        Ainvsub1 = max(Ainvsub1,msub1);
    }
    cout << "la norma sub1 de la matriz A-1 es: " << scientific << Ainvsub1 << endl;

    for (int i = 0; i < n; ++i){
        long double msubinf = 0;
        for (int j = n; j < 2*n; ++j){
            msubinf += abs(inversa[i][j]);
        }
        Ainvsubinf = max(Ainvsubinf,msubinf);
    }
    cout << "la norma subinf de la matriz A-1 es: " << scientific << Ainvsubinf << endl;
    cout << endl;

    //traza de a-1
    for(int i = 0; i < n; ++i){
        Ainvtraza += inversa[i][i+n];
    }
    cout << "la traza de la matriz A-1 es: " << Ainvtraza << endl;

    //mu sub 1
    cout << "el nombre de condicio sub 1 es: " << Ainvsub1*Asub1 <<endl;
    cout << "el nombre de condicio sub infinit es: " << Ainvsubinf*Asubinf <<endl;

    //solucio sistema
    cout << "\n------------------------------------------------\n\nla solucio del sistema es: ";
    for (int i = 0; i < n; ++i) {
        cout << scientific <<"el valor x" << i << " es: " << x[i] << endl;
    }
    cout << endl;
    cout << "el vector de permutacion es: ";
    for (int i = 0; i < n; ++i) {
        cout << perm[i] + 1 << ' ';
    }

}
