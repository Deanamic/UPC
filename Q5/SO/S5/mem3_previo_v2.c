#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#define REGION_SIZE		4096

int *p;

void SegFault(int signal)
{
    if(signal == SIGSEGV) {
	char buf[256];
	sprintf(buf,"Recibido SIGSEGV \n");
	write(1, buf, strlen(buf));
	exit(0);
    }
}

int main(int argc, char *argv[])
{
    struct sigaction sa;
    sa.sa_handler = &SegFault;
    sa.sa_flags = SA_RESTART;
    sigfillset(&sa.sa_mask);
    if (sigaction(SIGSEGV, &sa, NULL) < 0) exit(1);
    
    char buff[256];					
  
    sprintf( buff, "Addresses:\n");
    write(1, buff, strlen(buff));	
    sprintf( buff, "\tp: %p\n", &p);
    write(1, buff, strlen(buff));	

    *p = 5;

    sprintf( buff, "\tp Address: %p, p value: %p, *p: %d\n", &p, p, *p);
    write(1, buff, strlen(buff));	

    exit(0);

}
