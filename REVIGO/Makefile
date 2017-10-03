all: ofav_specific_revigo.png adig_specific_revigo.png spis_specific_revigo.png coral_diversified_revigo.png pdam_specific_revigo.png coral_specific_revigo.png

coral_diversified_revigo.png: coral_diversified_revigo.csv
	R --vanilla < ../R/revigo.R --args $< coral_diversified_revigo.png

coral_diversified_revigo.csv:
	python ../python/scrape_revigo.py ../fastOrtho/CoralDiversified/coral_diversified_goterms_counts.txt coral_diversified_revigo.csv

pdam_specific_revigo.png: pdam_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< pdam_specific_revigo.png

coral_specific_revigo.png: coral_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< coral_specific_revigo.png

pdam_specific_revigo.csv:
	python ../python/scrape_revigo.py 0.50 ../fastOrtho/Pdam_specific/pdam_goterms_counts.txt pdam_specific_revigo.csv

coral_specific_revigo.csv:
	python ../python/scrape_revigo.py ../fastOrtho/Coral_specific/coral_specific_goterms_counts.txt coral_specific_revigo.csv

spis_specific_revigo.png: spis_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< spis_specific_revigo.png

spis_specific_revigo.csv:
	python ../python/scrape_revigo.py 0.50 ../fastOrtho/Spis_specific/Spis_specific_goterms_counts.txt spis_specific_revigo.csv

adig_specific_revigo.png: adig_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< adig_specific_revigo.png

adig_specific_revigo.csv:
	python ../python/scrape_revigo.py 0.50 ../fastOrtho/Adig_specific/Adig_specific_goterms_counts.txt adig_specific_revigo.csv

ofav_specific_revigo.png: ofav_specific_revigo.csv
	R --vanilla < ../R/revigo.R --args $< ofav_specific_revigo.png

ofav_specific_revigo.csv:
	python ../python/scrape_revigo.py 0.50 ../fastOrtho/Ofav_specific/Ofav_specific_goterms_counts.txt ofav_specific_revigo.csv
