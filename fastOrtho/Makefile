all: ortho.table


CoralDiversified/CoralDiversified_all.fasta: CoralDiversified/CoralDiversified.txt
        cd CoralDiversified && rm -f *.fasta && \
        tail -n +2 CoralDiversified.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub("\\([^\\)]+\\)", ""); ; gsub(" ", "\n"); print > f}'
        cd ../data/ref && cat AcroporaDigitifera.pep AiptasiaPallida.pep AmphimedonQueenslandica.pep AmplexidiscusFenestrafer.pep DiscosomaSp.pep HydraVulgaris.pep MnemiopsisLeidyi.pep NematostellaVectensis.pep OrbicellaFaveolata.pep PocilloporaDamicornis.pep > all.pep
        for ORTHO in CoralDiversified/ORTHOMCL* ; \
        do \
        filter_fasta.py \
        -f ../data/ref/all.pep \
        -o $$ORTHO.fasta \
        -s $$ORTHO ; \
        done
	# Concatenate all sequences
	cat CoralDiversified/*.fasta > CoralDiversified_all.fasta

Pdam_specific/Pdam_specific_all.fasta: Pdam_specific/Pdam_specific.txt
        # Get 4th field of each line, write to file named by 1st field, convert each to one protein name per line
        cd Pdam_specific && rm -f *.fasta && \
        tail -n +2 Pdam_specific.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub(" ", "\n"); gsub(".PocilloporaDamicornis.", ""); print > f}'
        # For each file (ortho group), extract protein sequences of all members and write to fasta
        for ORTHO in Pdam_specific/ORTHOMCL* ; \
        do \
        filter_fasta.py \
        -f ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
        -o $$ORTHO.fasta \
        -s $$ORTHO ; \
        done
        # Concatenate all sequences for GO enrichment analysis
        cat Pdam_specific/*.fasta > Pdam_specific/Pdam_specific_all.fasta

Pdam_specific/Pdam_specific.txt: ortho.table Diversification.R
	R --vanilla < Diversification.R

CoralDiversified/CoralDiversified.txt: ortho.table Diversification.R
	R --vanilla < Diversification.R

ortho.table: fastortho.sh
	bash fastortho.sh
