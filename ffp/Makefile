# ffp/Makefile

all:
  ffpaa -l 8 ../data/ref/*.pep | ffpcol -a | ffprwn | ffpjsd -p species.txt | ffptree > tree
  nw_reroot tree Mnemiopsis