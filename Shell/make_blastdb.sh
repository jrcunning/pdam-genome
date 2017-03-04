#!/bin/bash

# First argument is the combined database name
outdb=$1
# Second through nth arguments are input fasta files to combine into database
infiles="${@:2}"

# Make a blastdb for each input file
for i in $infiles; do
  makeblastdb -dbtype nucl -in "$i" -out "$i"_blastdb
done

# Get names of all the new blast databases
dbs=$(eval echo {${infiles// /,}\}_blastdb)

# Create combined blast database
blastdb_aliastool -dblist "$dbs" -dbtype nucl -out $outdb -title "Cnidarians"