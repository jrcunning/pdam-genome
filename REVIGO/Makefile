all: pdam_specific_plot.png coral_specific_plot.png


pdam_specific_plot.png: pdam_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< pdam_specific_plot.png

coral_specific_plot.png: coral_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< coral_specific_revigo.png

pdam_specific_revigo.csv:
	python ../python/scrape_revigo.py ../fastOrtho/Pdam_specific/pdam_goterms_counts.txt pdam_specific_revigo.csv

coral_specific_revigo.csv:
	python ../python/scrape_revigo.py ../fastOrtho/Coral_specific/coral_specific_goterms_counts.txt coral_specific_revigo.csv
