all: coral_diversified_enriched_revigo.png pdam_specific_enriched_revigo.png coral_specific_enriched_revigo.png

pdam_specific_enriched_revigo.png: pdam_specific_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args pdam_specific_enriched_revigo.csv ../GOterms/pdam_specific_enrichment_data.csv pdam_specific_enriched_revigo.png

pdam_specific_enriched_revigo.csv: ../GOterms/pdam_specific_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	
coral_specific_enriched_revigo.png: coral_specific_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args coral_specific_enriched_revigo.csv ../GOterms/coral_specific_enrichment_data.csv coral_specific_enriched_revigo.png

coral_specific_enriched_revigo.csv: ../GOterms/coral_specific_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	
coral_diversified_enriched_revigo.png: coral_diversified_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args coral_diversified_enriched_revigo.csv ../GOterms/coral_diversified_enrichment_data.csv coral_diversified_enriched_revigo.png

coral_diversified_enriched_revigo.csv: ../GOterms/coral_diversified_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@