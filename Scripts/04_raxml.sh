#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J 04_TGF_raxml.job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/UCY/Trial2/04_TGF_raxml.out
#SBATCH -e /data/projects/gaya_lab/Frances/UCY/Trial2/04_TGF_raxml.err



module load anaconda
module load raxml-ng

#Convert file for RAxML-NG

raxml-ng --parse \
--msa 02_TGF_concat_all.phy \
--model 02_TGF_concat_partition.txt \
--prefix 04_TGF

#Run ML tree search and bootstrapping for 1000 iterations

raxml-ng --all \
--msa 02_TGF_concat_all.phy \
--model 02_TGF_concat_partition.txt \
--prefix 04_TGF \
--seed 2 \
--threads auto \
--bs-trees 1000

#Check convergence

raxml-ng --bsconverge \
--bs-trees 04_TGF.raxml.bootstraps \
--prefix 04_TGF_convergence_test \
--seed 2
