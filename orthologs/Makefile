# orthologs/Makefile

# Run fastOrtho analysis on proteins from 11 genomes
fastOrtho/CoralDiversified/CoralDiversified_all.txt: pdam.maker.output/pdam.all.gff
	cd fastOrtho && make
	
# Run coral core ortholog analysis
coral_core/coral_core_enrichment_GO_pvals.txt:
	cd coral_core && make
	
# Run coral-specific ortholog analysis
coral_specific/coral_specific_enrichment_GO_pvals.txt:
	cd coral_specific && make

# Run coral-diversified ortholog analysis
coral_diversified/cd_longest_sp_blastout:
	cd coral_diversified && make


# Run species-specific diversification ortholog analysis
species_diversified/species_specific_expansions_tophits.txt:
 cd species_diversified && make
	
# Run pdam-specific ortholog analysis
pdam_specific/pdam_specific_enrichment_GO_pvals.txt:
	cd pdam_specific && make
	
