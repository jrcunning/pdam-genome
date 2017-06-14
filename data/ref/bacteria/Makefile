all: all_complete_Gb_bac.fasta

all_complete_Gb_bac.fasta: assembly_summary_complete_genomes.txt
	# 3. Make a dir for data
	mkdir GbBac
	# 4. Fetch data
	for next in $$(cat assembly_summary_complete_genomes.txt); do wget -P GbBac "$$next"/*[^m]_genomic.fna.gz; done
	# 5. Extract data
	gunzip GbBac/*.gz
	# 6. Concatenate data
	cat GbBac/*.fna > all_complete_Gb_bac.fasta

assembly_summary_complete_genomes.txt: assembly_summary.txt
	# 2. Parse the addresses of complete genomes from it (right now n = 4,804):
	awk -F '\t' '{if($$12=="Complete Genome") print $$20}' assembly_summary.txt > assembly_summary_complete_genomes.txt

assembly_summary.txt:
	# 1. Get the list of assemblies:
	wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt"
	





