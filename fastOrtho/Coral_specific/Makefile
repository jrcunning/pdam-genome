
coral_specific_goterms_counts.txt: coral_specific_ips.gff3
	grep -o "GO:......." coral_specific_ips.gff3 > coral_specific_goterms.txt
	cat coral_specific_goterms.txt | sort | uniq -c | awk '{ print $$2 " " $$1}' > coral_specific_goterms_counts.txt


coral_specific_ips.gff3: Coral_specific_all.fasta
	sed -i 's/\*//g' $<
	interproscan.sh -i $< -b coral_specific_ips --goterms

