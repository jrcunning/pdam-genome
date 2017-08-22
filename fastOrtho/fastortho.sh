#!/bin/bash

###Run FastOrtho
FastOrtho \
	$(printf "!!single_genome_fasta %s " ../data/ref/*.pep | tr "!" -) \
	--working_directory . \
	--project_name version1

##Format output file	
sed -E "s/\s+\((\S+)\s+genes,(\S+)\s+taxa\)\:\s+/ \1 \2 /" version1.end > ortho.table
