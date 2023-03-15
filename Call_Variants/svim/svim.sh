#!/bin/bash

# Print the options needed to run SVIM.
echo "Below are the parameters needed to run SVIM with long-read sequencing data."
echo "SVIM does not support multi-threading."
echo "-t   Name of BAM file for tumor cells."
echo "-r   Name of FASTA file for the reference genome."


# Options are saved as variables for running SVIM. 
while getopts ":t:r:" opt; do
        case "$opt" in
                t) NAME=$OPTARG ;;

                r) REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$OPTARG.fasta" ;;
        esac
done

TUMOR="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$NAME.bam"
DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/svim/$NAME"
QUAL=10

# Command to run SVIM using the human reference genome (REF) and a BAM file from tumor cells (TUMOR).
svim alignment $DIR $TUMOR $REF

# Filter VCF of structural variants by quality score.
bcftools view -i "QUAL >= $QUAL" $DIR/variants.vcf > $DIR/variants.filtered$QUAL.vcf
