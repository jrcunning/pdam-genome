all: spis.genedens.RData adig.genedens.RData ofav.genedens.RData pdam.genedens.RData

spis.genedens.RData:
	bash ../Shell/get_genedens.sh ../data/ref/spis/Spis.genome.annotation.gff3.tar.gz ../data/ref/spis/Spis.genome.scaffold.final.fa.tar.gz spis

adig.genedens.RData:
	bash ../Shell/get_genedens.sh ../data/ref/adig/aug_repeatmask_pasa_input.gff3.tar.gz ../data/ref/adig/adi_v0.9.scaffold.fa.tar.gz adig

ofav.genedens.RData:
	bash ../Shell/get_genedens.sh ../data/ref/ofav/ofav.all.gff.tar.gz ../data/ref/ofav/ofav_genome.fa.tar.gz ofav

pdam.genedens.RData:
	bash ../Shell/get_genedens.sh ../annotation/pdam.all.renamed.function.domain.gff.tar.gz ../data/filter/pdam.fasta.tar.gz pdam
