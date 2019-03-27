antlr -gt PracticaEricDean.g
dlg -ci parser.dlg scan.c
g++ -o PracticaEricDean PracticaEricDean.c scan.c err.c -I ../pccts/h 2>err.txt
