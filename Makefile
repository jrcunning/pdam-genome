# Makefile

# Filter P. damicornis assembly
data/filter/pdam.fasta:
	cd data && make
	
# Run annotation pipeline
annotation/gag_out/genome.stats:
  cd annotation && make
  
# Run ortholog analysis pipeline
cd orthologs && make
  
# Run supplement.Rmd




















