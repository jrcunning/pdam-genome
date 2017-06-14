all: phantome_db.fasta

phantome_db.fasta: 
	wget "http://www.phantome.org/Downloads/genomes/genbank/2017-03-01.tgz"
	tar xvzf 2017-03-01.tgz
	for next in $$(ls 2017-03-01); do perl gb2fasta2.pl -gbk 2017-03-01/"$$next" -fasta 2017-03-01/"$$next".fasta; done
	cat 2017-03-01/*.fasta > phantome_db.fasta


