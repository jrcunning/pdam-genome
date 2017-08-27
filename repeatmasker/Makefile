all: consensi.fa.classified

consensi.fa.classified:
	$$REPEAT_MODELER_DIR/RepeatModeler -engine ncbi -pa 64 -database pdamdb >& pdam.out
	cp RM_*/consensi.fa.classified .
