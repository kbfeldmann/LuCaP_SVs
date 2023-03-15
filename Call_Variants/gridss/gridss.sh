#!/bin/bash
source /app/lmod/lmod/init/profile

# Print the options needed to run GRIDSS.
echo "IMPORTANT: The gridss command cannot be run concurrently because of issues generating files from the reference genome."
echo "GRIDSS defaults to 8 cores."
echo "Below are the parameters needed to run GRIDSS with short-read sequencing data."
echo "-t   Name of BAM file for tumor cells."
echo "-n   Name of BAM file for normal cells."
echo "-r   Name of FASTA file for the reference genome."


# Options are saved as variables for running GRIDSS. 
while getopts ":t:n:r:" opt; do
        case "$opt" in
                t) TUM_NAME=$OPTARG ;;

                n) NORMAL="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$OPTARG.bam" ;;

                r) REF_NAME=$OPTARG ;;
        esac
done

REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$REF_NAME.fasta"
TUMOR="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$TUM_NAME.bam"
DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/gridss/$TUM_NAME/working/"
VCF="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/gridss/$TUM_NAME/$TUM_NAME.vcf"

# Load module for running GRIDSS.
module load GRIDSS/2.12.0-foss-2020b

# Only run command to set up the reference genome once.
if [ ! -d "/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$REF_NAME.fasta.tmp.gridsslock" ]; then
	gridss -r $REF -w $DIR -s setupreference
fi

# Command to run GRIDSS using the human reference genome (REF), a BAM file from normal cells (NORMAL) and a BAM file from tumor cells (TUMOR).
gridss -r $REF -w $DIR -o $VCF -s preprocess,assemble,call $NORMAL $TUMOR

# Unload module for running GRIDSS.
module unload GRIDSS/2.12.0-foss-2020b
