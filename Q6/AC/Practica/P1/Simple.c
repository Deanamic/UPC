#include<stdio.h>

main()
{
  long long i, resultado=0;
  float t1,t2;
  t1 = GetTime();
  for ( i=0; i<3000000; i++)
    resultado=resultado+i;
  t2 = GetTime();
  printf("Resultado = %lld\n",resultado);
  printf("Milisegundos = %9f\n", t2-t1);
}
