all: pdam.fasta.tbl

pdam.fasta.tbl: consensi.fa.classified
	RepeatMasker -lib consensi.fa.classified -parallel 64 -dir . ../data/filter/pdam.fasta

consensi.fa.classified:
	$$REPEAT_MODELER_DIR/BuildDatabase -name pdamdb -engine ncbi ../data/filter/pdam.fasta
	$$REPEAT_MODELER_DIR/RepeatModeler -engine ncbi -pa 64 -database pdamdb >& pdam.out
	cp RM_*/consensi.fa.classified .
