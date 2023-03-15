#!/bin/bash
source /app/lmod/lmod/init/profile

# Print the options needed to run Sniffles.
echo "Below are the parameters needed to run Sniffles with long-read sequencing data."
echo "-t   Name of BAM file for tumor cells."
echo "-c   Number of cores."
echo "-r   Name of FASTA file for the reference genome."

# Options are saved as variables for running Sniffles.
while getopts ":t:c:r:" opt; do
        case "$opt" in
                t) NAME=$OPTARG ;;

		c) CORES="$OPTARG" ;;

		r) REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$OPTARG.fasta" ;;
        esac
done

TUMOR="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$NAME.bam"
G_VCF="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/sniffles/$NAME/${NAME}_germline.vcf"
NG_VCF="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/sniffles/$NAME/${NAME}_non_germline.vcf"

# Load module for running Sniffles.
module load Sniffles/1.0.8-foss-2018b

# Command to run Sniffles using the human reference genome (REF) and a BAM file from tumor cells (TUMOR).
# Create VCF for germline structural variants.
sniffles -i $TUMOR -v $G_VCF --reference $REF --threads $CORES

# Create VCF for somatic/mosaic structural variants.
sniffles -i $TUMOR -v $NG_VCF --reference $REF --threads $CORES --non-germline

# Unload module for running Sniffles.
module unload Sniffles/1.0.8-foss-2018b
