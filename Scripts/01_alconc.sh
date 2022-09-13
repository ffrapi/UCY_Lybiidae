#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J 02_alconc.job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/UCY/Trial2/02_alconc.out
#SBATCH -e /data/projects/gaya_lab/Frances/UCY/Trial2/02_alconc.err

#1: Align each gene assembly using MAFFT

module load mafft

mafft 00a_TGF_52seq_550bp_Sep12.fasta > 01_TGF_UCY_aln.fa
mafft 00b_TGF_52seq_550bp_Sep12_RENAMED.fasta > 01_TGF_UCY_RENAMED_aln.fa

#2: Concat alignments for each gene
module load  python/3.7.9
module load amas

python AMAS.py concat -f fasta -d dna -i 01_TGF_UCY_aln.fa -p 02_TGF_concat_partition.txt -t 02_TGF_concat_all.phy -u phylip
sed -i 's/^/GTR+G, /' 02_TGF_concat_partition.txt

python AMAS.py concat -f fasta -d dna -i 01_TGF_UCY_RENAMED_aln.fa -p 02_TGF_RENAMED_concat_partition.txt -t 02_TGF_RENAMED_concat_all.phy -u phylip
sed -i 's/^/GTR+G, /' 02_TGF_RENAMED_concat_partition.txt
